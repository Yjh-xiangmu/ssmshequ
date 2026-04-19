package com.ssmshequ.controller;

import com.ssmshequ.entity.*;
import com.ssmshequ.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired private AdminMapper adminMapper;
    @Autowired private DoctorMapper doctorMapper;
    @Autowired private UserMapper userMapper;
    @Autowired private DrugMapper drugMapper;
    @Autowired private NoticeMapper noticeMapper;
    @Autowired private MedicalCaseMapper medicalCaseMapper;
    @Autowired private AppointmentMapper appointmentMapper;
    @Autowired private BannerMapper bannerMapper;
    @Autowired private BaseDataMapper baseDataMapper;

    private final String UPLOAD_PATH = System.getProperty("user.dir") + "/upload/";

    private boolean noAuth(HttpSession session) {
        return session.getAttribute("loginUser") == null || !"admin".equals(session.getAttribute("role"));
    }

    @GetMapping("/index")
    public String index(HttpSession session, Model model) {
        if (noAuth(session)) return "redirect:/login";
        model.addAttribute("userCount",   userMapper.countAll());
        model.addAttribute("doctorCount", doctorMapper.countActive());
        model.addAttribute("todayAppoint",appointmentMapper.countToday());
        model.addAttribute("drugCount",   drugMapper.countAll());
        return "admin/index";
    }

    @GetMapping("/doctor")
    public String doctorList(HttpSession session, Model model) {
        if (noAuth(session)) return "redirect:/login";
        model.addAttribute("list", doctorMapper.listAll());
        model.addAttribute("departments", baseDataMapper.listByType("department"));
        return "admin/doctor";
    }

    @PostMapping("/doctor/add")
    public String doctorAdd(Doctor doctor, HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        doctor.setStatus(1);
        doctorMapper.insert(doctor);
        return "redirect:/admin/doctor";
    }

    @PostMapping("/doctor/edit")
    public String doctorEdit(Doctor doctor, HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        doctorMapper.update(doctor);
        return "redirect:/admin/doctor";
    }

    @GetMapping("/doctor/delete")
    public String doctorDelete(@RequestParam Integer id, HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        doctorMapper.delete(id);
        return "redirect:/admin/doctor";
    }

    @GetMapping("/user")
    public String userList(HttpSession session, Model model) {
        if (noAuth(session)) return "redirect:/login";
        model.addAttribute("list", userMapper.listAll());
        return "admin/user";
    }

    @PostMapping("/user/add")
    public String userAdd(User user, HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        userMapper.register(user);
        return "redirect:/admin/user";
    }

    @PostMapping("/user/edit")
    public String userEdit(User user, HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        userMapper.update(user);
        return "redirect:/admin/user";
    }

    @GetMapping("/user/delete")
    public String userDelete(@RequestParam Integer id, HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        userMapper.delete(id);
        return "redirect:/admin/user";
    }

    @GetMapping("/drug")
    public String drugList(HttpSession session, Model model, @RequestParam(required = false) String keyword) {
        if (noAuth(session)) return "redirect:/login";
        List<Drug> list = (keyword != null && !keyword.isEmpty()) ? drugMapper.search(keyword) : drugMapper.listAll();
        model.addAttribute("list", list);
        model.addAttribute("keyword", keyword);
        model.addAttribute("categories", baseDataMapper.listByType("drug_category"));
        return "admin/drug";
    }

    @PostMapping("/drug/add")
    public String drugAdd(Drug drug, HttpSession session, org.springframework.web.servlet.mvc.support.RedirectAttributes ra) {
        if (noAuth(session)) return "redirect:/login";

        // 后端拦截逻辑：库存不能为负数
        if (drug.getStock() != null && drug.getStock() < 0) {
            ra.addFlashAttribute("errorMsg", "添加失败：药品库存不能为负数");
            return "redirect:/admin/drug";
        }
        // 后端拦截逻辑：价格不能为负数
        if (drug.getPrice() != null && drug.getPrice().compareTo(java.math.BigDecimal.ZERO) < 0) {
            ra.addFlashAttribute("errorMsg", "添加失败：药品零售价不能为负数");
            return "redirect:/admin/drug";
        }

        drugMapper.insert(drug);
        return "redirect:/admin/drug";
    }

    @PostMapping("/drug/edit")
    public String drugEdit(Drug drug, HttpSession session, org.springframework.web.servlet.mvc.support.RedirectAttributes ra) {
        if (noAuth(session)) return "redirect:/login";

        // 后端拦截逻辑：库存不能为负数
        if (drug.getStock() != null && drug.getStock() < 0) {
            ra.addFlashAttribute("errorMsg", "修改失败：药品库存不能为负数");
            return "redirect:/admin/drug";
        }
        // 后端拦截逻辑：价格不能为负数
        if (drug.getPrice() != null && drug.getPrice().compareTo(java.math.BigDecimal.ZERO) < 0) {
            ra.addFlashAttribute("errorMsg", "修改失败：药品零售价不能为负数");
            return "redirect:/admin/drug";
        }

        drugMapper.update(drug);
        return "redirect:/admin/drug";
    }

    @GetMapping("/drug/delete")
    public String drugDelete(@RequestParam Integer id, HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        drugMapper.delete(id);
        return "redirect:/admin/drug";
    }

    @GetMapping("/notice")
    public String noticeList(HttpSession session, Model model) {
        if (noAuth(session)) return "redirect:/login";
        model.addAttribute("list", noticeMapper.listAll());
        return "admin/notice";
    }

    @PostMapping("/notice/add")
    public String noticeAdd(Notice notice, HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        if (notice.getIsTop() == null) notice.setIsTop(0);
        notice.setStatus(1);
        noticeMapper.insert(notice);
        return "redirect:/admin/notice";
    }

    @PostMapping("/notice/edit")
    public String noticeEdit(Notice notice, HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        if (notice.getIsTop() == null) notice.setIsTop(0);
        noticeMapper.update(notice);
        return "redirect:/admin/notice";
    }

    @GetMapping("/notice/delete")
    public String noticeDelete(@RequestParam Integer id, HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        noticeMapper.delete(id);
        return "redirect:/admin/notice";
    }

    @GetMapping("/case")
    public String caseList(HttpSession session, Model model) {
        if (noAuth(session)) return "redirect:/login";
        model.addAttribute("list",    medicalCaseMapper.listAll());
        model.addAttribute("users",   userMapper.listAll());
        model.addAttribute("doctors", doctorMapper.listAll());
        return "admin/case";
    }

    @PostMapping("/case/add")
    public String caseAdd(MedicalCase medicalCase, HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        medicalCase.setStatus(1);
        medicalCaseMapper.insert(medicalCase);
        return "redirect:/admin/case";
    }

    @PostMapping("/case/edit")
    public String caseEdit(MedicalCase medicalCase, HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        medicalCaseMapper.update(medicalCase);
        return "redirect:/admin/case";
    }

    @GetMapping("/case/delete")
    public String caseDelete(@RequestParam Integer id, HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        medicalCaseMapper.delete(id);
        return "redirect:/admin/case";
    }

    @GetMapping("/banner")
    public String bannerList(HttpSession session, Model model) {
        if (noAuth(session)) return "redirect:/login";
        model.addAttribute("list", bannerMapper.listAll());
        return "admin/banner";
    }

    @PostMapping("/banner/add")
    public String bannerAdd(Banner banner, @RequestParam("file") org.springframework.web.multipart.MultipartFile file, HttpSession session) {
        if (!file.isEmpty()) {
            try {
                String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
                String targetPath = session.getServletContext().getRealPath("/upload/");
                java.io.File targetDir = new java.io.File(targetPath);
                if (!targetDir.exists()) targetDir.mkdirs();
                java.io.File targetFile = new java.io.File(targetDir, fileName);
                file.transferTo(targetFile);
                String srcPath = System.getProperty("user.dir") + "/src/main/webapp/upload/";
                java.io.File srcDir = new java.io.File(srcPath);
                if (!srcDir.exists()) srcDir.mkdirs();
                java.io.File srcFile = new java.io.File(srcDir, fileName);
                org.apache.commons.io.FileUtils.copyFile(targetFile, srcFile);
                banner.setImageUrl("/upload/" + fileName);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (banner.getStatus() == null) banner.setStatus(1);
        if (banner.getSortOrder() == null) banner.setSortOrder(0);
        bannerMapper.insert(banner);
        return "redirect:/admin/banner";
    }

    @PostMapping("/banner/edit")
    public String bannerEdit(Banner banner, HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        bannerMapper.update(banner);
        return "redirect:/admin/banner";
    }

    @GetMapping("/banner/delete")
    public String bannerDelete(@RequestParam Integer id, HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        bannerMapper.delete(id);
        return "redirect:/admin/banner";
    }

    @GetMapping("/basedata")
    public String basedataList(HttpSession session, Model model) {
        if (noAuth(session)) return "redirect:/login";
        model.addAttribute("list", baseDataMapper.listAll());
        return "admin/basedata";
    }

    @PostMapping("/basedata/add")
    public String basedataAdd(BaseData baseData, HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        baseData.setStatus(1);
        baseDataMapper.insert(baseData);
        return "redirect:/admin/basedata";
    }

    @PostMapping("/basedata/edit")
    public String basedataEdit(BaseData baseData, HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        baseDataMapper.update(baseData);
        return "redirect:/admin/basedata";
    }

    @GetMapping("/basedata/delete")
    public String basedataDelete(@RequestParam Integer id, HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        baseDataMapper.delete(id);
        return "redirect:/admin/basedata";
    }

    @GetMapping("/admins")
    public String adminList(HttpSession session, Model model) {
        if (noAuth(session)) return "redirect:/login";
        model.addAttribute("list", adminMapper.listAll());
        return "admin/admins";
    }

    @PostMapping("/admins/add")
    public String adminAdd(Admin admin, HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        adminMapper.insert(admin);
        return "redirect:/admin/admins";
    }

    @PostMapping("/admins/edit")
    public String adminEdit(Admin admin, HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        adminMapper.update(admin);
        return "redirect:/admin/admins";
    }

    @GetMapping("/admins/delete")
    public String adminDelete(@RequestParam Integer id, HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        adminMapper.delete(id);
        return "redirect:/admin/admins";
    }

    @GetMapping("/profile")
    public String profile(HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        return "admin/profile";
    }

    @PostMapping("/profile/save")
    public String profileSave(Admin admin, HttpSession session) {
        if (noAuth(session)) return "redirect:/login";
        adminMapper.update(admin);
        Admin updated = adminMapper.getById(admin.getId());
        session.setAttribute("loginUser", updated);
        return "redirect:/admin/profile";
    }
}