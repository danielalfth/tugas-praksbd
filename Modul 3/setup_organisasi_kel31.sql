-- =============================================
-- MODUL 3 - Kelompok 31
-- Database: ORGANISASI_KEL31
-- Tabel: bidang, mahasiswa (relasi ONE-TO-MANY)
-- =============================================

-- Buat Database
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'ORGANISASI_KEL31')
BEGIN
    CREATE DATABASE ORGANISASI_KEL31;
END
GO

USE ORGANISASI_KEL31;
GO

-- =============================================
-- Tabel: bidang
-- Kolom bebas: nama_bidang, deskripsi, ketua, tanggal_berdiri
-- =============================================
IF OBJECT_ID('dbo.bidang', 'U') IS NOT NULL
    DROP TABLE dbo.mahasiswa;
IF OBJECT_ID('dbo.bidang', 'U') IS NOT NULL
    DROP TABLE dbo.bidang;
GO

CREATE TABLE bidang (
    id_bidang       INT IDENTITY(1,1) PRIMARY KEY,
    nama_bidang     VARCHAR(100)  NOT NULL,
    deskripsi       VARCHAR(255)  NOT NULL,
    ketua           VARCHAR(100)  NOT NULL,
    tanggal_berdiri DATE         NOT NULL
);
GO

-- =============================================
-- Tabel: mahasiswa
-- Kolom bebas: nim, nama, angkatan, jabatan, email
-- FK: id_bidang → bidang(id_bidang)
-- =============================================
CREATE TABLE mahasiswa (
    id_mahasiswa    INT IDENTITY(1,1) PRIMARY KEY,
    nim             VARCHAR(20)   NOT NULL,
    nama            VARCHAR(100)  NOT NULL,
    angkatan        INT           NOT NULL,
    jabatan         VARCHAR(50)   NOT NULL,
    email           VARCHAR(100)  NOT NULL,
    id_bidang       INT           NOT NULL,
    CONSTRAINT FK_mahasiswa_bidang
        FOREIGN KEY (id_bidang) REFERENCES bidang(id_bidang)
);
GO

-- =============================================
-- Insert Data Bidang
-- =============================================
INSERT INTO bidang (nama_bidang, deskripsi, ketua, tanggal_berdiri) VALUES
('RISTEK',   'Untuk kuitivasi ide dan pengembangan prestasi',                                                                                                   'Ketua RISTEK',   '2024-01-15'),
('INFOKOM',  'Menyajikan informasi dan komunikasi bagi mahasiswa Teknik Komputer',                                                                              'Ketua INFOKOM',  '2024-01-15'),
('PSDM',     'Inisiator dalam pengembangan potensi softskill dan karakter mahasiswa Teknik Komputer',                                                           'Ketua PSDM',     '2024-01-15'),
('SOSIAL',   'Meningkatkan jiwa sosial mahasiswa Teknik Komputer demi mewujudkan mahasiswa yang aktif dan peduli dengan masyarakat dan sesama mahasiswa Teknik Komputer', 'Ketua SOSIAL',   '2024-01-15');
GO

-- =============================================
-- Insert Data Mahasiswa (Anggota Kelompok 31)
-- =============================================
INSERT INTO mahasiswa (nim, nama, angkatan, jabatan, email, id_bidang) VALUES
('21120124130077', 'Daniel Alfatha Cameron Prayudia', 2024, 'Ketua',   'danielalfatha@students.undip.ac.id',      1),
('21120124120025', 'Oktavia Damayanti',               2024, 'Anggota', 'oktvpia@students.undip.ac.id',            2),
('21120124140165', 'Jhon Filbert Tarigan',            2024, 'Anggota', 'jhonfilberttarigan@students.undip.ac.id', 3),
('21120124140109', 'Kevin Novantino Hindiarto',       2024, 'Anggota', 'kevinnovantino@students.undip.ac.id',     4);
GO

-- =============================================
-- Verifikasi dengan JOIN
-- =============================================
SELECT
    m.id_mahasiswa,
    m.nim,
    m.nama,
    m.angkatan,
    m.jabatan,
    m.email,
    b.nama_bidang,
    b.ketua AS ketua_bidang
FROM mahasiswa m
JOIN bidang b ON m.id_bidang = b.id_bidang
ORDER BY m.id_mahasiswa;
GO
