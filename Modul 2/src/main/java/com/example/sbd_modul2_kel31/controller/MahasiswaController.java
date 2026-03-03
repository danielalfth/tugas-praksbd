package com.example.sbd_modul2_kel31.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import com.example.sbd_modul2_kel31.model.Mahasiswa;
import com.example.sbd_modul2_kel31.model.IrsDetail;

@Controller
public class MahasiswaController {
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    @GetMapping("/")
    public String index(Model model) {
        String sql = "SELECT * FROM mahasiswa ORDER BY nim";
        List<Mahasiswa> mahasiswa = jdbcTemplate.query(sql,
                BeanPropertyRowMapper.newInstance(Mahasiswa.class));
        model.addAttribute("mahasiswa", mahasiswa);
        return "index";
    }
    
    @GetMapping("/add")
    public String add(Model model) {
        return "add";
    }
    
    @PostMapping("/add")
    public String add(Mahasiswa mahasiswa) {
        String sql = "INSERT INTO mahasiswa (nim, nama, angkatan, gender) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, mahasiswa.getNim(), mahasiswa.getNama(), 
                mahasiswa.getAngkatan(), mahasiswa.getGender());
        return "redirect:/";
    }
    
    @GetMapping("/edit/{nim}")
    public String edit(@PathVariable("nim") String nim, Model model) {
        String sql = "SELECT * FROM mahasiswa WHERE nim = ?";
        Mahasiswa mahasiswa = jdbcTemplate.queryForObject(sql, 
                BeanPropertyRowMapper.newInstance(Mahasiswa.class), nim);
        model.addAttribute("mahasiswa", mahasiswa);
        return "edit";
    }
    
    @PostMapping("/edit")
    public String edit(Mahasiswa mahasiswa) {
        String sql = "UPDATE mahasiswa SET nama = ?, angkatan = ?, gender = ? WHERE nim = ?";
        jdbcTemplate.update(sql, mahasiswa.getNama(), mahasiswa.getAngkatan(), 
                mahasiswa.getGender(), mahasiswa.getNim());
        return "redirect:/";
    }
    
    @GetMapping("/delete/{nim}")
    public String delete(@PathVariable("nim") String nim) {
        String sql = "DELETE FROM mahasiswa WHERE nim = ?";
        jdbcTemplate.update(sql, nim);
        return "redirect:/";
    }
    
    @GetMapping("/detail/{nim}")
    public String detail(@PathVariable("nim") String nim, Model model) {
        // Data mahasiswa
        String sqlMahasiswa = "SELECT * FROM mahasiswa WHERE nim = ?";
        Mahasiswa mahasiswa = jdbcTemplate.queryForObject(sqlMahasiswa, 
                BeanPropertyRowMapper.newInstance(Mahasiswa.class), nim);
        
        // JOIN 3 tabel
        String sqlIrs = """
            SELECT i.irs_id, m.nim, m.nama, mk.matkul_id, mk.matkul_nama, 
                   mk.sks, mk.hari, i.status
            FROM mahasiswa m 
            JOIN irs i ON m.nim = i.nim 
            JOIN mata_kuliah mk ON i.matkul_id = mk.matkul_id 
            WHERE m.nim = ?
            ORDER BY i.irs_id
            """;
        
        List<IrsDetail> irsList = jdbcTemplate.query(sqlIrs,
                BeanPropertyRowMapper.newInstance(IrsDetail.class), nim);
        
        model.addAttribute("mahasiswa", mahasiswa);
        model.addAttribute("irsList", irsList);
        return "detail";
    }
}
