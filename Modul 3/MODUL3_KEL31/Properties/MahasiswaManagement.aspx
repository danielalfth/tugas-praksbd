<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MahasiswaManagement.aspx.cs" Inherits="MODUL3_KEL31.MahasiswaManagement" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Manajemen Mahasiswa</title>
    <style>
        body { font-family: Arial; margin: 30px; background: #f4f4f4; }
        .box { background: white; padding: 20px; border-radius: 8px; }
        .nav { background: #333; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .nav a { color: white; margin-right: 15px; text-decoration: none; font-weight: bold; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th { background: #28a745; color: white; padding: 10px; }
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
            <h2>Manajemen Mahasiswa</h2>

            <div class="form-area">
                <asp:TextBox ID="txtNama" runat="server" placeholder="Nama Lengkap"></asp:TextBox>
                <asp:TextBox ID="txtNIM" runat="server" placeholder="NIM"></asp:TextBox>
                <asp:TextBox ID="txtAngkatan" runat="server" placeholder="Angkatan (contoh: 2024)"></asp:TextBox>
                <asp:DropDownList ID="ddlGender" runat="server">
                    <asp:ListItem Value="Pria">Pria</asp:ListItem>
                    <asp:ListItem Value="Wanita">Wanita</asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="ddlMatkul" runat="server"></asp:DropDownList>
                <asp:Button ID="btnSimpan" runat="server" Text="Tambah" OnClick="btnSimpan_Click" />
                <asp:Label ID="lblPesan" runat="server" ForeColor="Red"></asp:Label>
            </div>

            <asp:GridView ID="gvMahasiswa" runat="server" AutoGenerateColumns="False"
                DataKeyNames="ID"
                OnRowEditing="gvMahasiswa_RowEditing"
                OnRowCancelingEdit="gvMahasiswa_RowCancelingEdit"
                OnRowUpdating="gvMahasiswa_RowUpdating"
                OnRowDeleting="gvMahasiswa_RowDeleting"
                OnRowDataBound="gvMahasiswa_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="Nama" HeaderText="Nama" />
                    <asp:BoundField DataField="NIM" HeaderText="NIM" />
                    <asp:BoundField DataField="Angkatan" HeaderText="Angkatan" />
                    <asp:BoundField DataField="Gender" HeaderText="Gender" />
                    <asp:TemplateField HeaderText="Mata Kuliah">
                        <ItemTemplate>
                            <%# Eval("Nama_Matkul") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlEditMatkul" runat="server"></asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
