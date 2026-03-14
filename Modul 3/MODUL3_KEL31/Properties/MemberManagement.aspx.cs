using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace MODUL3_KEL31
{
    public partial class MemberManagement : System.Web.UI.Page
    {
        string connStr = @"Data Source=WINDOWS\SQLEXPRESS;Initial Catalog=MOD3PERCOBAAN2KEL31;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e) { if (!IsPostBack) BindGrid(); }

        void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlDataAdapter sda = new SqlDataAdapter("SELECT * FROM member", con);
                DataTable dt = new DataTable(); sda.Fill(dt);
                gvMember.DataSource = dt; gvMember.DataBind();
            }
        }

        protected void btnSimpan_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtNama.Text)) return;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO member (nama, tipe_member) VALUES (@n, @t)", con);
                cmd.Parameters.AddWithValue("@n", txtNama.Text);
                cmd.Parameters.AddWithValue("@t", ddlTipe.SelectedValue);
                con.Open(); cmd.ExecuteNonQuery();
            }
            txtNama.Text = ""; BindGrid();
        }

        protected void gvMember_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvMember.EditIndex = e.NewEditIndex; BindGrid();
        }
        protected void gvMember_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvMember.EditIndex = -1; BindGrid();
        }
        protected void gvMember_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(gvMember.DataKeys[e.RowIndex].Value);
            string nama = ((TextBox)gvMember.Rows[e.RowIndex].Cells[1].Controls[0]).Text;
            string tipe = ((TextBox)gvMember.Rows[e.RowIndex].Cells[2].Controls[0]).Text;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("UPDATE member SET nama=@n, tipe_member=@t WHERE id_member=@id", con);
                cmd.Parameters.AddWithValue("@n", nama); cmd.Parameters.AddWithValue("@t", tipe); cmd.Parameters.AddWithValue("@id", id);
                con.Open(); cmd.ExecuteNonQuery();
            }
            gvMember.EditIndex = -1; BindGrid();
        }
        protected void gvMember_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvMember.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM member WHERE id_member=@id", con);
                cmd.Parameters.AddWithValue("@id", id);
                con.Open(); cmd.ExecuteNonQuery();
            }
            BindGrid();
        }
    }
}
