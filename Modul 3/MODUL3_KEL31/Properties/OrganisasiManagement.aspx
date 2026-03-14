<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrganisasiManagement.aspx.cs"
    Inherits="MODUL3_KEL31.OrganisasiManagement" %>
    <!DOCTYPE html>
    <html lang="id">

    <head runat="server">
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Organisasi KEL31 – Manajemen Anggota</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
            rel="stylesheet" />
        <style>
            *,
            *::before,
            *::after {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'Inter', sans-serif;
                background: #0f0c29;
                background: linear-gradient(135deg, #0f0c29 0%, #302b63 50%, #24243e 100%);
                min-height: 100vh;
                color: #e0e0e0;
            }

            /* ── HERO HEADER ── */
            .hero {
                text-align: center;
                padding: 48px 20px 32px;
            }

            .hero .badge {
                display: inline-block;
                background: rgba(255, 255, 255, 0.12);
                border: 1px solid rgba(255, 255, 255, 0.25);
                padding: 4px 16px;
                border-radius: 99px;
                font-size: 12px;
                letter-spacing: 2px;
                text-transform: uppercase;
                color: #a78bfa;
                margin-bottom: 14px;
            }

            .hero h1 {
                font-size: 2.6rem;
                font-weight: 700;
                background: linear-gradient(90deg, #a78bfa, #60a5fa, #34d399);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                line-height: 1.2;
            }

            .hero p {
                margin-top: 10px;
                color: #94a3b8;
                font-size: 0.95rem;
            }

            /* ── NAVIGATION ── */
            .nav-bar {
                display: flex;
                flex-wrap: wrap;
                gap: 8px;
                justify-content: center;
                padding: 0 20px 28px;
            }

            .nav-bar a {
                text-decoration: none;
                color: #cbd5e1;
                font-size: 0.85rem;
                font-weight: 500;
                padding: 8px 20px;
                border-radius: 8px;
                background: rgba(255, 255, 255, 0.07);
                border: 1px solid rgba(255, 255, 255, 0.12);
                transition: background 0.2s, color 0.2s;
            }

            .nav-bar a:hover,
            .nav-bar a.active {
                background: rgba(167, 139, 250, 0.25);
                color: #a78bfa;
                border-color: #a78bfa;
            }

            /* ── MAIN WRAPPER ── */
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px 60px;
            }

            /* ── GLASS CARD ── */
            .card {
                background: rgba(255, 255, 255, 0.06);
                backdrop-filter: blur(14px);
                border: 1px solid rgba(255, 255, 255, 0.12);
                border-radius: 16px;
                padding: 28px 32px;
                margin-bottom: 28px;
            }

            .card-title {
                font-size: 1rem;
                font-weight: 600;
                color: #a78bfa;
                text-transform: uppercase;
                letter-spacing: 1px;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .card-title::before {
                content: '';
                display: inline-block;
                width: 4px;
                height: 18px;
                background: linear-gradient(180deg, #a78bfa, #60a5fa);
                border-radius: 4px;
            }

            /* ── FORM ── */
            .form-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
                gap: 14px;
                margin-bottom: 16px;
            }

            .form-group {
                display: flex;
                flex-direction: column;
                gap: 6px;
            }

            .form-group label {
                font-size: 0.78rem;
                font-weight: 500;
                color: #94a3b8;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .form-group input[type=text],
            .form-group select,
            .form-group asp-textbox {
                width: 100%;
            }

            input[type=text],
            select {
                background: rgba(255, 255, 255, 0.08);
                border: 1px solid rgba(255, 255, 255, 0.15);
                border-radius: 8px;
                padding: 10px 14px;
                color: #e2e8f0;
                font-size: 0.9rem;
                font-family: 'Inter', sans-serif;
                width: 100%;
                transition: border-color 0.2s, box-shadow 0.2s;
                appearance: none;
            }

            input[type=text]:focus,
            select:focus {
                outline: none;
                border-color: #a78bfa;
                box-shadow: 0 0 0 3px rgba(167, 139, 250, 0.2);
                background: rgba(255, 255, 255, 0.12);
            }

            input[type=text]::placeholder {
                color: #64748b;
            }

            select option {
                background: #1e1b4b;
                color: #e2e8f0;
            }

            .form-actions {
                display: flex;
                align-items: center;
                gap: 14px;
                flex-wrap: wrap;
            }

            /* ── BUTTONS ── */
            input[type=submit],
            button,
            .btn {
                font-family: 'Inter', sans-serif;
                font-weight: 600;
                font-size: 0.88rem;
                padding: 10px 24px;
                border-radius: 8px;
                border: none;
                cursor: pointer;
                transition: transform 0.15s, box-shadow 0.2s, opacity 0.2s;
            }

            input[type=submit]:hover,
            button:hover {
                transform: translateY(-1px);
                opacity: 0.9;
            }

            input[type=submit]:active,
            button:active {
                transform: translateY(0);
            }

            .btn-primary {
                background: linear-gradient(135deg, #7c3aed, #4f46e5);
                color: white;
                box-shadow: 0 4px 14px rgba(124, 58, 237, 0.4);
            }

            .btn-edit {
                background: linear-gradient(135deg, #0ea5e9, #0284c7);
                color: white;
                padding: 6px 14px;
                font-size: 0.8rem;
            }

            .btn-delete {
                background: linear-gradient(135deg, #ef4444, #dc2626);
                color: white;
                padding: 6px 14px;
                font-size: 0.8rem;
            }

            .btn-update {
                background: linear-gradient(135deg, #10b981, #059669);
                color: white;
                padding: 6px 14px;
                font-size: 0.8rem;
            }

            .btn-cancel {
                background: rgba(255, 255, 255, 0.1);
                color: #cbd5e1;
                padding: 6px 14px;
                font-size: 0.8rem;
                border: 1px solid rgba(255, 255, 255, 0.15);
            }

            /* ── MESSAGE ── */
            .msg-error {
                color: #f87171;
                font-size: 0.85rem;
            }

            .msg-success {
                color: #34d399;
                font-size: 0.85rem;
            }

            /* ── TABLE ── */
            .table-wrapper {
                overflow-x: auto;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            table th {
                background: rgba(124, 58, 237, 0.35);
                color: #c4b5fd;
                padding: 12px 16px;
                text-align: left;
                font-size: 0.78rem;
                font-weight: 600;
                letter-spacing: 0.6px;
                text-transform: uppercase;
                border-bottom: 1px solid rgba(167, 139, 250, 0.3);
            }

            table td {
                padding: 11px 16px;
                font-size: 0.88rem;
                color: #cbd5e1;
                border-bottom: 1px solid rgba(255, 255, 255, 0.06);
                vertical-align: middle;
            }

            table tr:hover td {
                background: rgba(167, 139, 250, 0.06);
            }

            /* inline-edit inputs inside grid */
            table input[type=text],
            table select {
                padding: 6px 10px;
                font-size: 0.82rem;
                border-radius: 6px;
            }

            /* bidang pill */
            .pill {
                display: inline-block;
                background: rgba(96, 165, 250, 0.18);
                color: #93c5fd;
                border: 1px solid rgba(96, 165, 250, 0.3);
                border-radius: 99px;
                padding: 2px 12px;
                font-size: 0.78rem;
                font-weight: 500;
            }

            .pill.ti {
                background: rgba(167, 139, 250, 0.18);
                color: #c4b5fd;
                border-color: rgba(167, 139, 250, 0.3);
            }

            .pill.media {
                background: rgba(52, 211, 153, 0.18);
                color: #6ee7b7;
                border-color: rgba(52, 211, 153, 0.3);
            }

            .pill.dik {
                background: rgba(251, 191, 36, 0.18);
                color: #fde68a;
                border-color: rgba(251, 191, 36, 0.3);
            }

            .pill.humas {
                background: rgba(248, 113, 113, 0.18);
                color: #fca5a5;
                border-color: rgba(248, 113, 113, 0.3);
            }

            /* stats strip */
            .stats {
                display: flex;
                gap: 16px;
                flex-wrap: wrap;
                margin-bottom: 28px;
            }

            .stat-box {
                flex: 1;
                min-width: 150px;
                background: rgba(255, 255, 255, 0.05);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 12px;
                padding: 18px 20px;
                text-align: center;
            }

            .stat-box .stat-num {
                font-size: 1.8rem;
                font-weight: 700;
                background: linear-gradient(90deg, #a78bfa, #60a5fa);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .stat-box .stat-label {
                font-size: 0.75rem;
                color: #64748b;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                margin-top: 4px;
            }

            @media(max-width: 640px) {
                .hero h1 {
                    font-size: 1.8rem;
                }

                .card {
                    padding: 20px 16px;
                }

                .form-grid {
                    grid-template-columns: 1fr 1fr;
                }
            }
        </style>
    </head>

    <body>

        <form id="form1" runat="server">

            <!-- HERO -->
            <div class="hero">
                <div class="badge">TUGAS PRAKTIKUM SBD MODUL 3</div>
                <h1>KELOMPOK 31</h1>
            </div>

            <!-- NAV -->
            <div class="nav-bar">
                <a href="MahasiswaManagement.aspx">Mahasiswa</a>
                <a href="MatkulManagement.aspx">Mata Kuliah</a>
                <a href="InstrukturManagement.aspx">Instruktur</a>
                <a href="OrganisasiManagement.aspx" class="active">Organisasi</a>
            </div>

            <div class="container">

                <!-- STATS -->
                <div class="stats">
                    <div class="stat-box">
                        <div class="stat-num">
                            <asp:Label ID="lblTotalMahasiswa" runat="server" Text="0"></asp:Label>
                        </div>
                        <div class="stat-label">Total Mahasiswa</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-num">
                            <asp:Label ID="lblTotalBidang" runat="server" Text="0"></asp:Label>
                        </div>
                        <div class="stat-label">Bidang Aktif</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-num">31</div>
                        <div class="stat-label">Kelompok</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-num">2024</div>
                        <div class="stat-label">Angkatan</div>
                    </div>
                </div>

                <!-- FORM TAMBAH -->
                <div class="card">
                    <div class="card-title">Tambah Mahasiswa Baru</div>
                    <div class="form-grid">
                        <div class="form-group">
                            <label>NIM</label>
                            <asp:TextBox ID="txtNIM" runat="server" placeholder="240601221200xx"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Nama Lengkap</label>
                            <asp:TextBox ID="txtNama" runat="server" placeholder="Nama mahasiswa"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Angkatan</label>
                            <asp:TextBox ID="txtAngkatan" runat="server" placeholder="2022"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Jabatan</label>
                            <asp:TextBox ID="txtJabatan" runat="server" placeholder="Ketua / Anggota"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <asp:TextBox ID="txtEmail" runat="server" placeholder="email@students.undip.ac.id">
                            </asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Bidang</label>
                            <asp:DropDownList ID="ddlBidang" runat="server"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-actions">
                        <asp:Button ID="btnSimpan" runat="server" Text="+ Tambah Mahasiswa" CssClass="btn-primary"
                            OnClick="btnSimpan_Click" />
                        <asp:Label ID="lblPesan" runat="server" CssClass="msg-error"></asp:Label>
                    </div>
                </div>

                <!-- DATA TABLE -->
                <div class="card">
                    <div class="card-title">Data Anggota &amp; Bidang (JOIN)</div>
                    <div class="table-wrapper">
                        <asp:GridView ID="gvMahasiswa" runat="server" AutoGenerateColumns="False"
                            DataKeyNames="id_mahasiswa" OnRowEditing="gvMahasiswa_RowEditing"
                            OnRowCancelingEdit="gvMahasiswa_RowCancelingEdit" OnRowUpdating="gvMahasiswa_RowUpdating"
                            OnRowDeleting="gvMahasiswa_RowDeleting" OnRowDataBound="gvMahasiswa_RowDataBound"
                            GridLines="None">

                            <Columns>
                                <asp:BoundField DataField="id_mahasiswa" HeaderText="ID" ReadOnly="True" />
                                <asp:BoundField DataField="nim" HeaderText="NIM" />
                                <asp:BoundField DataField="nama" HeaderText="Nama Lengkap" />
                                <asp:BoundField DataField="angkatan" HeaderText="Angkatan" />
                                <asp:BoundField DataField="jabatan" HeaderText="Jabatan" />
                                <asp:BoundField DataField="email" HeaderText="Email" />

                                <asp:TemplateField HeaderText="Bidang">
                                    <ItemTemplate>
                                        <span class="pill">
                                            <%# Eval("nama_bidang") %>
                                        </span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlEditBidang" runat="server"></asp:DropDownList>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Aksi">
                                    <ItemTemplate>
                                        <div style="display:flex; gap:8px; align-items:center;">
                                            <asp:LinkButton ID="lbEdit" runat="server" CommandName="Edit"
                                                CssClass="btn btn-edit">Edit</asp:LinkButton>
                                            <asp:LinkButton ID="lbDelete" runat="server" CommandName="Delete"
                                                CssClass="btn btn-delete"
                                                OnClientClick="return confirm('Hapus mahasiswa ini?');">Hapus
                                            </asp:LinkButton>
                                        </div>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <div style="display:flex; gap:8px; align-items:center;">
                                            <asp:LinkButton ID="lbUpdate" runat="server" CommandName="Update"
                                                CssClass="btn btn-update">Simpan</asp:LinkButton>
                                            <asp:LinkButton ID="lbCancel" runat="server" CommandName="Cancel"
                                                CssClass="btn btn-cancel">Batal</asp:LinkButton>
                                        </div>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

            </div>
        </form>

    </body>

    </html>