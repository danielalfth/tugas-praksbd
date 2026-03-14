using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace MODUL3_KEL31
{
    public partial class InstrukturManagement : System.Web.UI.Page
    {
        string connStr = @"Data Source=WINDOWS\SQLEXPRESS;Initial Catalog=MOD3PERCOBAAN2KEL31;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e) { if (!IsPostBack) BindGrid(); }

        void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlDataAdapter sda = new SqlDataAdapter("SELECT * FROM instruktur", con);
                DataTable dt = new DataTable(); sda.Fill(dt);
                gvInstruktur.DataSource = dt; gvInstruktur.DataBind();
            }
        }

        protected void btnSimpan_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO instruktur (nama_instruktur, keahlian) VALUES (@n, @k)", con);
                cmd.Parameters.AddWithValue("@n", txtNamaIns.Text); cmd.Parameters.AddWithValue("@k", txtKeahlian.Text);
                con.Open(); cmd.ExecuteNonQuery();
            }
            txtNamaIns.Text = ""; txtKeahlian.Text = ""; BindGrid();
        }

        protected void gvInstruktur_RowEditing(object sender, GridViewEditEventArgs e) { gvInstruktur.EditIndex = e.NewEditIndex; BindGrid(); }
        protected void gvInstruktur_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e) { gvInstruktur.EditIndex = -1; BindGrid(); }
        protected void gvInstruktur_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(gvInstruktur.DataKeys[e.RowIndex].Value);
            string nama = ((TextBox)gvInstruktur.Rows[e.RowIndex].Cells[1].Controls[0]).Text;
            string keahlian = ((TextBox)gvInstruktur.Rows[e.RowIndex].Cells[2].Controls[0]).Text;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("UPDATE instruktur SET nama_instruktur=@n, keahlian=@k WHERE id_instruktur=@id", con);
                cmd.Parameters.AddWithValue("@n", nama); cmd.Parameters.AddWithValue("@k", keahlian); cmd.Parameters.AddWithValue("@id", id);
                con.Open(); cmd.ExecuteNonQuery();
            }
            gvInstruktur.EditIndex = -1; BindGrid();
        }
        protected void gvInstruktur_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvInstruktur.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM instruktur WHERE id_instruktur=@id", con);
                cmd.Parameters.AddWithValue("@id", id); con.Open(); cmd.ExecuteNonQuery();
            }
            BindGrid();
        }
    }
}

