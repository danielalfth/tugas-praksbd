using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace MODUL3_KEL31
{
    public partial class MahasiswaManagement : System.Web.UI.Page
    {
        string connStr = @"Data Source=WINDOWS\SQLEXPRESS;Initial Catalog=Modul3_Kel31_Percobaan1;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDropdownMatkul();
                BindGrid();
            }
        }

        void BindDropdownMatkul()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlDataAdapter sda = new SqlDataAdapter("SELECT id_matkul, Nama_Matkul, Kelas FROM matkul", con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                dt.Columns.Add("Display", typeof(string));
                foreach (DataRow row in dt.Rows)
                    row["Display"] = row["Nama_Matkul"] + " - " + row["Kelas"];

                ddlMatkul.DataSource = dt;
                ddlMatkul.DataTextField = "Display";
                ddlMatkul.DataValueField = "id_matkul";
                ddlMatkul.DataBind();
            }
        }

        void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = @"SELECT m.ID, m.Nama, m.NIM, m.Angkatan, m.Gender,
                                      mk.id_matkul, mk.Nama_Matkul, mk.Kelas
                               FROM mahasiswa m
                               JOIN matkul mk ON m.id_matkul = mk.id_matkul";
                SqlDataAdapter sda = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvMahasiswa.DataSource = dt;
                gvMahasiswa.DataBind();
            }
        }

        protected void gvMahasiswa_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowState == DataControlRowState.Edit ||
                e.Row.RowState == (DataControlRowState.Edit | DataControlRowState.Alternate))
            {
                DropDownList ddl = (DropDownList)e.Row.FindControl("ddlEditMatkul");
                if (ddl != null)
                {
                    using (SqlConnection con = new SqlConnection(connStr))
                    {
                        SqlDataAdapter sda = new SqlDataAdapter("SELECT id_matkul, Nama_Matkul, Kelas FROM matkul", con);
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        dt.Columns.Add("Display", typeof(string));
                        foreach (DataRow row in dt.Rows)
                            row["Display"] = row["Nama_Matkul"] + " - " + row["Kelas"];

                        ddl.DataSource = dt;
                        ddl.DataTextField = "Display";
                        ddl.DataValueField = "id_matkul";
                        ddl.DataBind();
                    }

                    DataRowView drv = e.Row.DataItem as DataRowView;
                    if (drv != null)
                    {
                        string currentIdMatkul = drv["id_matkul"].ToString();
                        if (ddl.Items.FindByValue(currentIdMatkul) != null)
                            ddl.SelectedValue = currentIdMatkul;
                    }
                }
            }
        }

        protected void btnSimpan_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtNama.Text) || string.IsNullOrWhiteSpace(txtNIM.Text))
            {
                lblPesan.Text = "Nama dan NIM wajib diisi!";
                return;
            }
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    @"INSERT INTO mahasiswa (Nama, NIM, Angkatan, Gender, id_matkul)
                      VALUES (@nama, @nim, @angkatan, @gender, @idmatkul)", con);
                cmd.Parameters.AddWithValue("@nama", txtNama.Text.Trim());
                cmd.Parameters.AddWithValue("@nim", txtNIM.Text.Trim());
                cmd.Parameters.AddWithValue("@angkatan", txtAngkatan.Text.Trim());
                cmd.Parameters.AddWithValue("@gender", ddlGender.SelectedValue);
                cmd.Parameters.AddWithValue("@idmatkul", ddlMatkul.SelectedValue);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            txtNama.Text = "";
            txtNIM.Text = "";
            txtAngkatan.Text = "";
            lblPesan.Text = "";
            BindGrid();
        }

        protected void gvMahasiswa_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvMahasiswa.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvMahasiswa_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvMahasiswa.EditIndex = -1;
            BindGrid();
        }

        protected void gvMahasiswa_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(gvMahasiswa.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvMahasiswa.Rows[e.RowIndex];

            string nama = ((TextBox)row.Cells[1].Controls[0]).Text;
            string nim = ((TextBox)row.Cells[2].Controls[0]).Text;
            string angkatan = ((TextBox)row.Cells[3].Controls[0]).Text;
            string gender = ((TextBox)row.Cells[4].Controls[0]).Text;

            DropDownList ddlEdit = (DropDownList)row.FindControl("ddlEditMatkul");
            int idMatkul = Convert.ToInt32(ddlEdit.SelectedValue);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    @"UPDATE mahasiswa
                      SET Nama=@nama, NIM=@nim, Angkatan=@angkatan, Gender=@gender, id_matkul=@idmatkul
                      WHERE ID=@id", con);
                cmd.Parameters.AddWithValue("@nama", nama);
                cmd.Parameters.AddWithValue("@nim", nim);
                cmd.Parameters.AddWithValue("@angkatan", angkatan);
                cmd.Parameters.AddWithValue("@gender", gender);
                cmd.Parameters.AddWithValue("@idmatkul", idMatkul);
                cmd.Parameters.AddWithValue("@id", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            gvMahasiswa.EditIndex = -1;
            BindGrid();
        }

        protected void gvMahasiswa_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvMahasiswa.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM mahasiswa WHERE ID=@id", con);
                cmd.Parameters.AddWithValue("@id", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            BindGrid();
        }
    }
}
