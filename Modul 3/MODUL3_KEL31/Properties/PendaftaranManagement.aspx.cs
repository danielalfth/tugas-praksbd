using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace MODUL3_KEL31
{
    public partial class PendaftaranManagement : System.Web.UI.Page
    {
        string connStr = @"Data Source=WINDOWS\SQLEXPRESS;Initial Catalog=MOD3PERCOBAAN2KEL31;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { BindDropdowns(); BindGrid(); }
        }

        void BindDropdowns()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                // Load Member
                SqlDataAdapter sdaM = new SqlDataAdapter("SELECT id_member, nama FROM member", con);
                DataTable dtM = new DataTable(); sdaM.Fill(dtM);
                ddlMember.DataSource = dtM; ddlMember.DataTextField = "nama"; ddlMember.DataValueField = "id_member"; ddlMember.DataBind();

                // Load Kelas
                SqlDataAdapter sdaK = new SqlDataAdapter("SELECT id_kelas, nama_kelas FROM kelas", con);
                DataTable dtK = new DataTable(); sdaK.Fill(dtK);
                ddlKelas.DataSource = dtK; ddlKelas.DataTextField = "nama_kelas"; ddlKelas.DataValueField = "id_kelas"; ddlKelas.DataBind();
            }
        }

        void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = "SELECT p.id_daftar, m.nama, k.nama_kelas, p.tgl_daftar FROM pendaftaran p JOIN member m ON p.id_member = m.id_member JOIN kelas k ON p.id_kelas = k.id_kelas";
                SqlDataAdapter sda = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable(); sda.Fill(dt);
                gvPendaftaran.DataSource = dt; gvPendaftaran.DataBind();
            }
        }

        protected void btnDaftar_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO pendaftaran (id_member, id_kelas) VALUES (@m, @k)", con);
                cmd.Parameters.AddWithValue("@m", ddlMember.SelectedValue); cmd.Parameters.AddWithValue("@k", ddlKelas.SelectedValue);
                con.Open(); cmd.ExecuteNonQuery();
            }
            BindGrid();
        }

        protected void gvPendaftaran_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvPendaftaran.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM pendaftaran WHERE id_daftar=@id", con);
                cmd.Parameters.AddWithValue("@id", id); con.Open(); cmd.ExecuteNonQuery();
            }
            BindGrid();
        }
    }
}
