using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace MODUL3_KEL31
{
    public partial class MatkulManagement : System.Web.UI.Page
    {
        // ⚠️ Ganti nama database sesuai percobaan pertama kamu
        string connStr = @"Data Source=WINDOWS\SQLEXPRESS;Initial Catalog=Modul3_Kel31_Percobaan1;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) BindGrid();
        }

        void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlDataAdapter sda = new SqlDataAdapter("SELECT * FROM matkul", con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvMatkul.DataSource = dt;
                gvMatkul.DataBind();
            }
        }

        protected void btnSimpan_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtNamaMatkul.Text) || string.IsNullOrWhiteSpace(txtKelas.Text))
            {
                lblPesan.Text = "Nama Matkul dan Kelas wajib diisi!";
                return;
            }
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO matkul (Nama_Matkul, Kelas) VALUES (@nm, @k)", con);
                cmd.Parameters.AddWithValue("@nm", txtNamaMatkul.Text.Trim());
                cmd.Parameters.AddWithValue("@k", txtKelas.Text.Trim());
                con.Open();
                cmd.ExecuteNonQuery();
            }
            txtNamaMatkul.Text = "";
            txtKelas.Text = "";
            lblPesan.Text = "";
            BindGrid();
        }

        protected void gvMatkul_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvMatkul.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvMatkul_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvMatkul.EditIndex = -1;
            BindGrid();
        }

        protected void gvMatkul_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(gvMatkul.DataKeys[e.RowIndex].Value);
            string namaMatkul = ((TextBox)gvMatkul.Rows[e.RowIndex].Cells[1].Controls[0]).Text;
            string kelas = ((TextBox)gvMatkul.Rows[e.RowIndex].Cells[2].Controls[0]).Text;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "UPDATE matkul SET Nama_Matkul=@nm, Kelas=@k WHERE id_matkul=@id", con);
                cmd.Parameters.AddWithValue("@nm", namaMatkul);
                cmd.Parameters.AddWithValue("@k", kelas);
                cmd.Parameters.AddWithValue("@id", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            gvMatkul.EditIndex = -1;
            BindGrid();
        }

        protected void gvMatkul_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvMatkul.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM matkul WHERE id_matkul=@id", con);
                cmd.Parameters.AddWithValue("@id", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            BindGrid();
        }
    }
}
