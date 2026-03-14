<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PendaftaranManagement.aspx.cs" Inherits="MODUL3_KEL31.PendaftaranManagement" %>
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
            <h2>Pendaftaran Kelas</h2>
            <asp:DropDownList ID="ddlMember" runat="server"></asp:DropDownList>
            <asp:DropDownList ID="ddlKelas" runat="server"></asp:DropDownList>
            <asp:Button ID="btnDaftar" runat="server" Text="Daftarkan" OnClick="btnDaftar_Click" />
            
            <asp:GridView ID="gvPendaftaran" runat="server" AutoGenerateColumns="False" DataKeyNames="id_daftar" OnRowDeleting="gvPendaftaran_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="id_daftar" HeaderText="ID" />
                    <asp:BoundField DataField="nama" HeaderText="Nama Member" />
                    <asp:BoundField DataField="nama_kelas" HeaderText="Kelas" />
                    <asp:BoundField DataField="tgl_daftar" HeaderText="Tgl Daftar" />
                    <asp:CommandField ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
