package com.ssmshequ.controller;

import com.ssmshequ.entity.*;
import com.ssmshequ.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Calendar;

@Controller
@RequestMapping("/doctor")
public class DoctorController {

    @Autowired private DoctorMapper doctorMapper;
    @Autowired private MedicalCaseMapper medicalCaseMapper;
    @Autowired private AppointmentMapper appointmentMapper;
    @Autowired private DrugMapper drugMapper;
    @Autowired private NoticeMapper noticeMapper;
    @Autowired private UserMapper userMapper;
    @Autowired private EvaluationMapper evaluationMapper;

    // 权限检查，返回当前登录医生
    private Doctor getLoginDoctor(HttpSession session) {
        if (!"doctor".equals(session.getAttribute("role"))) return null;
        return (Doctor) session.getAttribute("loginUser");
    }

    // ==================== 工作台首页 ====================
    @GetMapping("/index")
    public String index(HttpSession session, Model model) {
        Doctor doctor = getLoginDoctor(session);
        if (doctor == null) return "redirect:/login";

        // 保留你写的今日预约数逻辑
        long todayCount = appointmentMapper.listByDoctor(doctor.getId())
                .stream()
                .filter(a -> {
                    if (a.getAppointDate() == null) return false;
                    Calendar cal = Calendar.getInstance();
                    Calendar apCal = Calendar.getInstance();
                    apCal.setTime(a.getAppointDate());
                    return cal.get(Calendar.DATE) == apCal.get(Calendar.DATE)
                            && cal.get(Calendar.MONTH) == apCal.get(Calendar.MONTH)
                            && cal.get(Calendar.YEAR) == apCal.get(Calendar.YEAR);
                }).count();

        long pendingCount = appointmentMapper.listByDoctor(doctor.getId())
                .stream().filter(a -> a.getStatus() != null && a.getStatus() == 0).count();
        long caseCount = medicalCaseMapper.listByDoctor(doctor.getId()).size();

        model.addAttribute("todayCount", todayCount);
        model.addAttribute("appointCount", pendingCount);
        model.addAttribute("caseCount", caseCount);

        // 新增：满意度统计
        Double avg = evaluationMapper.getAvgScore(doctor.getId());
        model.addAttribute("avgScore", avg != null ? avg : 0.0);
        model.addAttribute("evalCount", evaluationMapper.getCountByDoctor(doctor.getId()));

        return "doctor/index";
    }

    // ==================== 评价管理 ====================
    @GetMapping("/evaluation")
    public String evaluationPage(HttpSession session, Model model) {
        Doctor doc = getLoginDoctor(session);
        if (doc == null) return "redirect:/login";
        model.addAttribute("list", evaluationMapper.listByDoctor(doc.getId()));
        return "doctor/evaluation";
    }

    // ==================== 病例管理 ====================
    @GetMapping("/case")
    public String caseList(HttpSession session, Model model) {
        Doctor doctor = getLoginDoctor(session);
        if (doctor == null) return "redirect:/login";
        model.addAttribute("list", medicalCaseMapper.listByDoctor(doctor.getId()));
        model.addAttribute("users", userMapper.listAll());
        return "doctor/case";
    }

    @PostMapping("/case/add")
    public String caseAdd(MedicalCase medicalCase, HttpSession session) {
        Doctor doctor = getLoginDoctor(session);
        if (doctor == null) return "redirect:/login";
        medicalCase.setDoctorId(doctor.getId());
        medicalCase.setStatus(1);
        medicalCaseMapper.insert(medicalCase);
        return "redirect:/doctor/case";
    }

    @PostMapping("/case/edit")
    public String caseEdit(MedicalCase medicalCase, HttpSession session) {
        Doctor doctor = getLoginDoctor(session);
        if (doctor == null) return "redirect:/login";
        medicalCase.setDoctorId(doctor.getId());
        medicalCaseMapper.update(medicalCase);
        return "redirect:/doctor/case";
    }

    // ==================== 预约管理 ====================
    @GetMapping("/appointment")
    public String appointmentList(HttpSession session, Model model) {
        Doctor doctor = getLoginDoctor(session);
        if (doctor == null) return "redirect:/login";
        model.addAttribute("list", appointmentMapper.listByDoctor(doctor.getId()));
        return "doctor/appointment";
    }

    @GetMapping("/appointment/confirm")
    public String confirmAppointment(@RequestParam Integer id, HttpSession session) {
        if (getLoginDoctor(session) == null) return "redirect:/login";
        appointmentMapper.updateStatus(id, 1);
        return "redirect:/doctor/appointment";
    }

    @GetMapping("/appointment/cancel")
    public String cancelAppointment(@RequestParam Integer id, HttpSession session) {
        if (getLoginDoctor(session) == null) return "redirect:/login";
        appointmentMapper.updateStatus(id, 2);
        return "redirect:/doctor/appointment";
    }

    @GetMapping("/appointment/finish")
    public String finishAppointment(@RequestParam Integer id, HttpSession session) {
        if (getLoginDoctor(session) == null) return "redirect:/login";
        appointmentMapper.updateStatus(id, 3);
        return "redirect:/doctor/appointment";
    }

    // ==================== 药品查看 ====================
    @GetMapping("/drug")
    public String drugList(HttpSession session, Model model,
                           @RequestParam(required = false) String keyword) {
        if (getLoginDoctor(session) == null) return "redirect:/login";
        model.addAttribute("list", keyword != null && !keyword.isEmpty()
                ? drugMapper.search(keyword) : drugMapper.listAll());
        model.addAttribute("keyword", keyword);
        return "doctor/drug";
    }

    // ==================== 社区公告 ====================
    @GetMapping("/notice")
    public String noticeList(HttpSession session, Model model) {
        if (getLoginDoctor(session) == null) return "redirect:/login";
        model.addAttribute("list", noticeMapper.listAll());
        return "doctor/notice";
    }

    // ==================== 个人中心 ====================
    @GetMapping("/profile")
    public String profile(HttpSession session) {
        if (getLoginDoctor(session) == null) return "redirect:/login";
        return "doctor/profile";
    }

    @PostMapping("/profile/save")
    public String profileSave(Doctor doctor, HttpSession session) {
        if (getLoginDoctor(session) == null) return "redirect:/login";
        doctorMapper.update(doctor);
        Doctor updated = doctorMapper.getById(doctor.getId());
        session.setAttribute("loginUser", updated);
        return "redirect:/doctor/profile";
    }

    @PostMapping("/profile/pwd")
    public String changePwd(@RequestParam Integer id,
                            @RequestParam String oldPwd,
                            @RequestParam String newPwd,
                            HttpSession session, Model model) {
        Doctor doctor = getLoginDoctor(session);
        if (doctor == null) return "redirect:/login";
        if (!oldPwd.equals(doctor.getPassword())) {
            model.addAttribute("pwdError", "原密码错误");
            return "doctor/profile";
        }
        doctor.setPassword(newPwd);
        doctorMapper.updatePassword(id, newPwd);
        session.setAttribute("loginUser", doctorMapper.getById(id));
        return "redirect:/doctor/profile";
    }
}