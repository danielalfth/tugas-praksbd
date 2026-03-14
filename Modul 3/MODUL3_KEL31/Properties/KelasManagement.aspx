<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="KelasManagement.aspx.cs" Inherits="MODUL3_KEL31.KelasManagement" %>
<!DOCTYPE html>
<html>
<head runat="server"><style> body { font-family: Arial; margin: 30px; background: #f4f4f4; } .box { background: white; padding: 20px; border-radius: 8px; } .nav { background: #333; padding: 15px; border-radius: 5px; margin-bottom: 20px; } .nav a { color: white; margin-right: 15px; text-decoration: none; font-weight: bold; } table { width: 100%; border-collapse: collapse; margin-top: 15px; } th { background: #007bff; color: white; padding: 10px; } td { padding: 8px; border-bottom: 1px solid #ddd; } </style></head>
<body>
    <form id="form1" runat="server">
        <div class="box">
            <div class="nav">
                <a href="MemberManagement.aspx">Member</a>
                <a href="InstrukturManagement.aspx">Instruktur</a>
                <a href="KelasManagement.aspx">Kelas</a>
                <a href="PendaftaranManagement.aspx">Pendaftaran</a>
            </div>
            <h2>Manajemen Kelas</h2>
            <asp:TextBox ID="txtNamaKelas" runat="server" placeholder="Nama Kelas"></asp:TextBox>
            <asp:DropDownList ID="ddlInstruktur" runat="server"></asp:DropDownList>
            <asp:TextBox ID="txtJadwal" runat="server" placeholder="Jadwal"></asp:TextBox>
            <asp:TextBox ID="txtKapasitas" runat="server" placeholder="Kapasitas" TextMode="Number"></asp:TextBox>
            <asp:Button ID="btnSimpan" runat="server" Text="Tambah" OnClick="btnSimpan_Click" />
            
            <asp:GridView ID="gvKelas" runat="server" AutoGenerateColumns="False" DataKeyNames="id_kelas" OnRowDeleting="gvKelas_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="id_kelas" HeaderText="ID" />
                    <asp:BoundField DataField="nama_kelas" HeaderText="Nama Kelas" />
                    <asp:BoundField DataField="nama_instruktur" HeaderText="Instruktur" />
                    <asp:BoundField DataField="jadwal" HeaderText="Jadwal" />
                    <asp:BoundField DataField="kapasitas" HeaderText="Kapasitas" />
                    <asp:CommandField ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
