package com.example.sbd_modul2_kel31.model;

public class Mahasiswa {
    private String nim;
    private String nama;
    private String angkatan;
    private String gender;
    
    // Constructor kosong
    public Mahasiswa() {}
    
    // Getters & Setters
    public String getNim() { return nim; }
    public void setNim(String nim) { this.nim = nim; }
    
    public String getNama() { return nama; }
    public void setNama(String nama) { this.nama = nama; }
    
    public String getAngkatan() { return angkatan; }
    public void setAngkatan(String angkatan) { this.angkatan = angkatan; }
    
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
}
