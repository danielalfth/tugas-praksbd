package com.example.sbd_modul2_kel31.model;

public class IrsDetail {
    private String irsId;
    private String nim;
    private String nama;
    private String matkulId;
    private String matkulNama;
    private int sks;
    private String hari;
    private String status;
    
    // Constructor kosong
    public IrsDetail() {}
    
    // Getters & Setters
    public String getIrsId() { return irsId; }
    public void setIrsId(String irsId) { this.irsId = irsId; }
    
    public String getNim() { return nim; }
    public void setNim(String nim) { this.nim = nim; }
    
    public String getNama() { return nama; }
    public void setNama(String nama) { this.nama = nama; }
    
    public String getMatkulId() { return matkulId; }
    public void setMatkulId(String matkulId) { this.matkulId = matkulId; }
    
    public String getMatkulNama() { return matkulNama; }
    public void setMatkulNama(String matkulNama) { this.matkulNama = matkulNama; }
    
    public int getSks() { return sks; }
    public void setSks(int sks) { this.sks = sks; }
    
    public String getHari() { return hari; }
    public void setHari(String hari) { this.hari = hari; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
