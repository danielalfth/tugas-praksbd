<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MemberManagement.aspx.cs" Inherits="MODUL3_KEL31.MemberManagement" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Member Gym</title>
    <style>
        body { font-family: Arial; margin: 30px; background: #f4f4f4; }
        .box { background: white; padding: 20px; border-radius: 8px; }
        .nav { background: #333; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .nav a { color: white; margin-right: 15px; text-decoration: none; font-weight: bold; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th { background: #007bff; color: white; padding: 10px; }
        td { padding: 8px; border-bottom: 1px solid #ddd; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="box">
            <div class="nav">
                <a href="MemberManagement.aspx">Member</a>
                <a href="InstrukturManagement.aspx">Instruktur</a>
                <a href="KelasManagement.aspx">Kelas</a>
                <a href="PendaftaranManagement.aspx">Pendaftaran</a>
            </div>
            <h2>Manajemen Member</h2>
            <asp:TextBox ID="txtNama" runat="server" placeholder="Nama Member"></asp:TextBox>
            <asp:DropDownList ID="ddlTipe" runat="server">
                <asp:ListItem Value="Regular">Regular</asp:ListItem>
                <asp:ListItem Value="VIP">VIP</asp:ListItem>
            </asp:DropDownList>
            <asp:Button ID="btnSimpan" runat="server" Text="Tambah" OnClick="btnSimpan_Click" />
            
            <asp:GridView ID="gvMember" runat="server" AutoGenerateColumns="False" DataKeyNames="id_member" 
                OnRowEditing="gvMember_RowEditing" OnRowCancelingEdit="gvMember_RowCancelingEdit" 
                OnRowUpdating="gvMember_RowUpdating" OnRowDeleting="gvMember_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="id_member" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="nama" HeaderText="Nama Member" />
                    <asp:BoundField DataField="tipe_member" HeaderText="Tipe" />
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
