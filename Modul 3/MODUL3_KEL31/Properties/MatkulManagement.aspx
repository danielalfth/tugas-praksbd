<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MatkulManagement.aspx.cs" Inherits="MODUL3_KEL31.MatkulManagement" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Manajemen Mata Kuliah</title>
    <style>
        body { font-family: Arial; margin: 30px; background: #f4f4f4; }
        .box { background: white; padding: 20px; border-radius: 8px; }
        .nav { background: #333; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .nav a { color: white; margin-right: 15px; text-decoration: none; font-weight: bold; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th { background: #007bff; color: white; padding: 10px; }
        td { padding: 8px; border-bottom: 1px solid #ddd; }
        .form-area { margin-bottom: 15px; }
        .form-area input, .form-area select { margin-right: 8px; padding: 6px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="box">
            <div class="nav">
                <a href="MatkulManagement.aspx">Mata Kuliah</a>
                <a href="MahasiswaManagement.aspx">Mahasiswa</a>
            </div>
            <h2>Manajemen Mata Kuliah</h2>

            <div class="form-area">
                <asp:TextBox ID="txtNamaMatkul" runat="server" placeholder="Nama Mata Kuliah"></asp:TextBox>
                <asp:TextBox ID="txtKelas" runat="server" placeholder="Kelas (contoh: A)"></asp:TextBox>
                <asp:Button ID="btnSimpan" runat="server" Text="Tambah" OnClick="btnSimpan_Click" />
                <asp:Label ID="lblPesan" runat="server" ForeColor="Red"></asp:Label>
            </div>

            <asp:GridView ID="gvMatkul" runat="server" AutoGenerateColumns="False"
                DataKeyNames="id_matkul"
                OnRowEditing="gvMatkul_RowEditing"
                OnRowCancelingEdit="gvMatkul_RowCancelingEdit"
                OnRowUpdating="gvMatkul_RowUpdating"
                OnRowDeleting="gvMatkul_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="id_matkul" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="Nama_Matkul" HeaderText="Nama Mata Kuliah" />
                    <asp:BoundField DataField="Kelas" HeaderText="Kelas" />
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
