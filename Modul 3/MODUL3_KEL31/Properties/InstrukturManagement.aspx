<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InstrukturManagement.aspx.cs" Inherits="MODUL3_KEL31.InstrukturManagement" %>
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
            <h2>Manajemen Instruktur</h2>
            <asp:TextBox ID="txtNamaIns" runat="server" placeholder="Nama Instruktur"></asp:TextBox>
            <asp:TextBox ID="txtKeahlian" runat="server" placeholder="Keahlian (Contoh: Yoga)"></asp:TextBox>
            <asp:Button ID="btnSimpan" runat="server" Text="Tambah" OnClick="btnSimpan_Click" />
            
            <asp:GridView ID="gvInstruktur" runat="server" AutoGenerateColumns="False" DataKeyNames="id_instruktur" 
                OnRowEditing="gvInstruktur_RowEditing" OnRowCancelingEdit="gvInstruktur_RowCancelingEdit" 
                OnRowUpdating="gvInstruktur_RowUpdating" OnRowDeleting="gvInstruktur_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="id_instruktur" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="nama_instruktur" HeaderText="Nama Instruktur" />
                    <asp:BoundField DataField="keahlian" HeaderText="Keahlian" />
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>

