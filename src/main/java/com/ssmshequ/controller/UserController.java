package com.ssmshequ.controller;

import com.ssmshequ.entity.*;
import com.ssmshequ.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired private UserMapper userMapper;
    @Autowired private DoctorMapper doctorMapper;
    @Autowired private AppointmentMapper appointmentMapper;
    @Autowired private MedicalCaseMapper medicalCaseMapper;
    @Autowired private DrugMapper drugMapper;
    @Autowired private NoticeMapper noticeMapper;
    @Autowired private HealthRecordMapper healthRecordMapper;
    @Autowired private EvaluationMapper evaluationMapper;
    @Autowired private DrugFavoriteMapper drugFavoriteMapper;
    @Autowired private BaseDataMapper baseDataMapper;
    @Autowired private BannerMapper bannerMapper;

    private User getLoginUser(HttpSession session) {
        if (!"user".equals(session.getAttribute("role"))) return null;
        return (User) session.getAttribute("loginUser");
    }

    @GetMapping("/index")
    public String index(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) return "redirect:/login";
        model.addAttribute("myAppointCount",  appointmentMapper.listByUser(user.getId()).size());
        model.addAttribute("myCaseCount",     medicalCaseMapper.listByUser(user.getId()).size());
        model.addAttribute("noticeCount",     noticeMapper.countPublished());
        model.addAttribute("banners", bannerMapper.listAll());
        return "user/index";
    }

    @GetMapping("/appointment")
    public String appointmentPage(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) return "redirect:/login";

        // 进页面前自动清理超时挂号
        appointmentMapper.cleanExpiredAppointments();

        model.addAttribute("myList", appointmentMapper.listByUser(user.getId()));

        // 修改点：只把“正在出诊”的医生传给前端页面
        model.addAttribute("doctors", doctorMapper.listWorkingDoctors());
        return "user/appointment";
    }

    @PostMapping("/appointment/add")
    public String appointmentAdd(Appointment appointment, HttpSession session, org.springframework.web.servlet.mvc.support.RedirectAttributes ra) {
        User user = getLoginUser(session);
        if (user == null) return "redirect:/login";

        // 提交前再次清理超时数据，确保判定准确
        appointmentMapper.cleanExpiredAppointments();

        // 检查医生是否空闲
        int busyCount = appointmentMapper.checkDoctorBusy(appointment.getDoctorId());
        if (busyCount > 0) {
            ra.addFlashAttribute("errorMsg", "当前医生正忙（已有接诊或排队），请稍后再试");
            return "redirect:/user/appointment";
        }

        // 直接插入即时挂号数据
        appointment.setUserId(user.getId());
        appointmentMapper.insertInstant(appointment);

        return "redirect:/user/appointment";
    }

    @GetMapping("/appointment/cancel")
    public String appointmentCancel(@RequestParam Integer id, HttpSession session) {
        User user = getLoginUser(session);
        if (user == null) return "redirect:/login";
        appointmentMapper.updateStatus(id, 2);
        return "redirect:/user/appointment";
    }

    @GetMapping("/doctors")
    public String doctorsPage(HttpSession session, Model model) {
        if (getLoginUser(session) == null) return "redirect:/login";
        List<Doctor> doctors = doctorMapper.listAll();
        for (Doctor d : doctors) {
            d.setAvgScore(evaluationMapper.getAvgScore(d.getId()));
            d.setEvalCount(evaluationMapper.getCountByDoctor(d.getId()));
        }
        model.addAttribute("list", doctors);
        model.addAttribute("evalMapper", evaluationMapper);
        return "user/doctors";
    }

    @PostMapping("/evaluate/add")
    public String addEvaluation(Evaluation eval, HttpSession session) {
        User user = getLoginUser(session);
        if (user == null) return "redirect:/login";
        eval.setUserId(user.getId());
        evaluationMapper.insert(eval);
        return "redirect:/user/doctors";
    }

    @GetMapping("/cases")
    public String casesPage(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) return "redirect:/login";
        model.addAttribute("list", medicalCaseMapper.listByUser(user.getId()));
        return "user/cases";
    }

    @GetMapping("/drug")
    public String drugPage(HttpSession session, Model model,
                           @RequestParam(required = false) String keyword,
                           @RequestParam(required = false) String category) {
        User user = getLoginUser(session);
        if (user == null) return "redirect:/login";

        List<Drug> list;
        if (category != null && !category.isEmpty()) {
            list = drugMapper.search(category);
        } else if (keyword != null && !keyword.isEmpty()) {
            list = drugMapper.search(keyword);
        } else {
            list = drugMapper.listAll();
        }

        model.addAttribute("list", list);
        model.addAttribute("favMapper", drugFavoriteMapper);
        model.addAttribute("currentCategory", category);
        model.addAttribute("categories", baseDataMapper.listByType("drug_category"));
        return "user/drug";
    }

    @PostMapping("/drug/toggleFav")
    @ResponseBody
    public String toggleFav(Integer drugId, HttpSession session) {
        User user = getLoginUser(session);
        if (user == null) return "error";
        if (drugFavoriteMapper.isFavorite(user.getId(), drugId) > 0) {
            drugFavoriteMapper.remove(user.getId(), drugId);
            return "unfav";
        } else {
            drugFavoriteMapper.add(user.getId(), drugId);
            return "fav";
        }
    }

    @GetMapping("/favorites")
    public String favorites(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) return "redirect:/login";
        model.addAttribute("list", drugMapper.listFavorites(user.getId()));
        model.addAttribute("favMapper", drugFavoriteMapper);
        return "user/favorites";
    }

    @GetMapping("/notice")
    public String noticePage(HttpSession session, Model model) {
        if (getLoginUser(session) == null) return "redirect:/login";
        model.addAttribute("list", noticeMapper.listAll());
        return "user/notice";
    }

    @GetMapping("/profile")
    public String profilePage(HttpSession session) {
        if (getLoginUser(session) == null) return "redirect:/login";
        return "user/profile";
    }

    @PostMapping("/profile/save")
    public String profileSave(User user, HttpSession session) {
        if (getLoginUser(session) == null) return "redirect:/login";
        userMapper.update(user);
        User updated = userMapper.getById(user.getId());
        session.setAttribute("loginUser", updated);
        return "redirect:/user/profile";
    }

    @PostMapping("/profile/pwd")
    public String changePwd(@RequestParam Integer id, @RequestParam String oldPwd, @RequestParam String newPwd, HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) return "redirect:/login";
        if (!oldPwd.equals(user.getPassword())) {
            model.addAttribute("pwdError", "原密码错误");
            return "user/profile";
        }
        userMapper.updatePassword(id, newPwd);
        session.setAttribute("loginUser", userMapper.getById(id));
        return "redirect:/user/profile";
    }

    @GetMapping("/health")
    public String healthPage(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) return "redirect:/login";
        model.addAttribute("list", healthRecordMapper.listByUser(user.getId()));
        return "user/health";
    }

    @PostMapping("/health/add")
    public String healthAdd(HealthRecord record, HttpSession session, org.springframework.web.servlet.mvc.support.RedirectAttributes ra) {
        User user = getLoginUser(session);
        if (user == null) return "redirect:/login";

        // 修改此处逻辑：只要有一项没填，就提示必须全填
        if (record.getSystolicBp() == null || record.getDiastolicBp() == null ||
                record.getBloodSugar() == null || record.getHeartRate() == null) {
            ra.addFlashAttribute("errorMsg", "为了确保评估准确，请完整填写所有体征指标（血压、血糖、心率）");
            return "redirect:/user/health";
        }

        record.setUserId(user.getId());

        // 自动记录当前日期
        if (record.getRecordDate() == null) {
            record.setRecordDate(new java.util.Date());
        }

        // 评估逻辑：任何一项不在范围内即为异常 (status=1)
        int status = 0;
        if (record.getSystolicBp() > 140 || record.getSystolicBp() < 90) status = 1;
        if (record.getDiastolicBp() > 90 || record.getDiastolicBp() < 60) status = 1;
        if (record.getBloodSugar().doubleValue() > 7.0 || record.getBloodSugar().doubleValue() < 3.9) status = 1;
        if (record.getHeartRate() > 100 || record.getHeartRate() < 60) status = 1;

        record.setStatus(status);
        healthRecordMapper.insert(record);
        return "redirect:/user/health";
    }
}