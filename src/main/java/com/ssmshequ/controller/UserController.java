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
    private User getLoginUser(HttpSession session) {
        if (!"user".equals(session.getAttribute("role"))) return null;
        return (User) session.getAttribute("loginUser");
    }

    // ==================== 首页 ====================
    @GetMapping("/index")
    public String index(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) return "redirect:/login";
        model.addAttribute("myAppointCount",  appointmentMapper.listByUser(user.getId()).size());
        model.addAttribute("myCaseCount",     medicalCaseMapper.listByUser(user.getId()).size());
        model.addAttribute("noticeCount",     noticeMapper.countPublished());
        return "user/index";
    }

    // ==================== 医生预约 ====================
    @GetMapping("/appointment")
    public String appointmentPage(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) return "redirect:/login";
        model.addAttribute("myList",    appointmentMapper.listByUser(user.getId()));
        model.addAttribute("doctors",   doctorMapper.listAll());
        return "user/appointment";
    }

    @PostMapping("/appointment/add")
    public String appointmentAdd(Appointment appointment, HttpSession session) {
        User user = getLoginUser(session);
        if (user == null) return "redirect:/login";
        appointment.setUserId(user.getId());
        appointment.setStatus(0); // 待确认
        appointmentMapper.insert(appointment);
        return "redirect:/user/appointment";
    }

    @GetMapping("/appointment/cancel")
    public String appointmentCancel(@RequestParam Integer id, HttpSession session) {
        User user = getLoginUser(session);
        if (user == null) return "redirect:/login";
        appointmentMapper.updateStatus(id, 2);
        return "redirect:/user/appointment";
    }

    // ==================== 医生信息与评价 ====================
    @GetMapping("/doctors")
    public String doctorsPage(HttpSession session, Model model) {
        if (getLoginUser(session) == null) return "redirect:/login";

        List<Doctor> doctors = doctorMapper.listAll();
        for (Doctor d : doctors) {
            // 计算并设置平均分和总数
            d.setAvgScore(evaluationMapper.getAvgScore(d.getId()));
            d.setEvalCount(evaluationMapper.getCountByDoctor(d.getId()));
        }

        model.addAttribute("list", doctors);
        model.addAttribute("evalMapper", evaluationMapper);
        return "user/doctors";
    }

    // 提交评价接口
    @PostMapping("/evaluate/add")
    public String addEvaluation(Evaluation eval, HttpSession session) {
        User user = getLoginUser(session);
        if (user == null) return "redirect:/login";

        eval.setUserId(user.getId());
        evaluationMapper.insert(eval);

        return "redirect:/user/doctors";
    }

    // ==================== 我的病例 ====================
    @GetMapping("/cases")
    public String casesPage(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) return "redirect:/login";
        model.addAttribute("list", medicalCaseMapper.listByUser(user.getId()));
        return "user/cases";
    }

    // ==================== 药品查看 ====================
    @GetMapping("/drug")
    public String drugPage(HttpSession session, Model model,
                           @RequestParam(required = false) String keyword,
                           @RequestParam(required = false) String category) {
        User user = getLoginUser(session);
        if (user == null) return "redirect:/login";

        List<Drug> list;
        if (category != null && !category.isEmpty()) {
            // 利用现有 search 逻辑或单独写分类查询
            list = drugMapper.search(category);
        } else if (keyword != null && !keyword.isEmpty()) {
            list = drugMapper.search(keyword);
        } else {
            list = drugMapper.listAll();
        }

        // 为每个药品判断当前用户是否已收藏
        model.addAttribute("list", list);
        model.addAttribute("favMapper", drugFavoriteMapper);
        model.addAttribute("currentCategory", category);
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

    // ==================== 社区公告 ====================
    @GetMapping("/notice")
    public String noticePage(HttpSession session, Model model) {
        if (getLoginUser(session) == null) return "redirect:/login";
        model.addAttribute("list", noticeMapper.listAll());
        return "user/notice";
    }

    // ==================== 个人中心 ====================
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
    public String changePwd(@RequestParam Integer id,
                            @RequestParam String oldPwd,
                            @RequestParam String newPwd,
                            HttpSession session, Model model) {
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
    // ==================== 健康体征录入与预警 ====================
    @GetMapping("/health")
    public String healthPage(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) return "redirect:/login";
        model.addAttribute("list", healthRecordMapper.listByUser(user.getId()));
        return "user/health";
    }

    @PostMapping("/health/add")
    public String healthAdd(HealthRecord record, HttpSession session) {
        User user = getLoginUser(session);
        if (user == null) return "redirect:/login";

        record.setUserId(user.getId());

        // 核心亮点：自动医学阈值预警逻辑
        int status = 0; // 默认0正常
        // 血压预警：高压>140或<90，低压>90或<60
        if (record.getSystolicBp() != null && (record.getSystolicBp() > 140 || record.getSystolicBp() < 90)) status = 1;
        if (record.getDiastolicBp() != null && (record.getDiastolicBp() > 90 || record.getDiastolicBp() < 60)) status = 1;
        // 血糖预警：空腹血糖>7.0或<3.9
        if (record.getBloodSugar() != null && (record.getBloodSugar().doubleValue() > 7.0 || record.getBloodSugar().doubleValue() < 3.9)) status = 1;

        record.setStatus(status);
        healthRecordMapper.insert(record);

        return "redirect:/user/health";
    }
}