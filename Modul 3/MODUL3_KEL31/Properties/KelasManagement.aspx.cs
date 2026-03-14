using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace MODUL3_KEL31
{
    public partial class KelasManagement : System.Web.UI.Page
    {
        string connStr = @"Data Source=WINDOWS\SQLEXPRESS;Initial Catalog=MOD3PERCOBAAN2KEL31;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { BindDropdown(); BindGrid(); }
        }

        void BindDropdown()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlDataAdapter sda = new SqlDataAdapter("SELECT id_instruktur, nama_instruktur FROM instruktur", con);
                DataTable dt = new DataTable(); sda.Fill(dt);
                ddlInstruktur.DataSource = dt; ddlInstruktur.DataTextField = "nama_instruktur"; ddlInstruktur.DataValueField = "id_instruktur"; ddlInstruktur.DataBind();
            }
        }

        void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = "SELECT k.id_kelas, k.nama_kelas, i.nama_instruktur, k.jadwal, k.kapasitas FROM kelas k JOIN instruktur i ON k.id_instruktur = i.id_instruktur";
                SqlDataAdapter sda = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable(); sda.Fill(dt);
                gvKelas.DataSource = dt; gvKelas.DataBind();
            }
        }

        protected void btnSimpan_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO kelas (nama_kelas, id_instruktur, jadwal, kapasitas) VALUES (@n, @i, @j, @k)", con);
                cmd.Parameters.AddWithValue("@n", txtNamaKelas.Text); cmd.Parameters.AddWithValue("@i", ddlInstruktur.SelectedValue);
                cmd.Parameters.AddWithValue("@j", txtJadwal.Text); cmd.Parameters.AddWithValue("@k", txtKapasitas.Text);
                con.Open(); cmd.ExecuteNonQuery();
            }
            BindGrid();
        }

        protected void gvKelas_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvKelas.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM kelas WHERE id_kelas=@id", con);
                cmd.Parameters.AddWithValue("@id", id); con.Open(); cmd.ExecuteNonQuery();
            }
            BindGrid();
        }
    }
}
