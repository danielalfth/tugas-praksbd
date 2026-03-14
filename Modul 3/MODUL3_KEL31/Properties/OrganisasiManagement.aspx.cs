using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace MODUL3_KEL31
{
    public partial class OrganisasiManagement : System.Web.UI.Page
    {
        // ── Connection string ke database ORGANISASI_KEL31 ──
        private readonly string connStr =
            @"Data Source=WINDOWS\SQLEXPRESS;Initial Catalog=ORGANISASI_KEL31;Integrated Security=True";

        // ============================================================
        // Page Load
        // ============================================================
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDropdownBidang();
                BindGrid();
                BindStats();
            }
        }

        // ============================================================
        // Helper – Isi dropdown Bidang
        // ============================================================
        private void BindDropdownBidang()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlDataAdapter sda = new SqlDataAdapter(
                    "SELECT id_bidang, nama_bidang FROM bidang ORDER BY nama_bidang", con);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                ddlBidang.DataSource     = dt;
                ddlBidang.DataTextField  = "nama_bidang";
                ddlBidang.DataValueField = "id_bidang";
                ddlBidang.DataBind();
            }
        }

        // ============================================================
        // Helper – Load data JOIN ke GridView
        // ============================================================
        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = @"
                    SELECT
                        m.id_mahasiswa,
                        m.nim,
                        m.nama,
                        m.angkatan,
                        m.jabatan,
                        m.email,
                        b.id_bidang,
                        b.nama_bidang,
                        b.ketua AS ketua_bidang
                    FROM mahasiswa m
                    JOIN bidang b ON m.id_bidang = b.id_bidang
                    ORDER BY m.id_mahasiswa";

                SqlDataAdapter sda = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                gvMahasiswa.DataSource = dt;
                gvMahasiswa.DataBind();
            }
        }

        // ============================================================
        // Helper – Statistik (total mahasiswa & bidang)
        // ============================================================
        private void BindStats()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                SqlCommand cmdM = new SqlCommand("SELECT COUNT(*) FROM mahasiswa", con);
                lblTotalMahasiswa.Text = cmdM.ExecuteScalar().ToString();

                SqlCommand cmdB = new SqlCommand("SELECT COUNT(*) FROM bidang", con);
                lblTotalBidang.Text = cmdB.ExecuteScalar().ToString();
            }
        }

        // ============================================================
        // CREATE – Tambah mahasiswa baru
        // ============================================================
        protected void btnSimpan_Click(object sender, EventArgs e)
        {
            // Validasi
            if (string.IsNullOrWhiteSpace(txtNIM.Text)    ||
                string.IsNullOrWhiteSpace(txtNama.Text)   ||
                string.IsNullOrWhiteSpace(txtJabatan.Text)||
                string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                lblPesan.Text     = "⚠ NIM, Nama, Jabatan, dan Email wajib diisi!";
                lblPesan.CssClass = "msg-error";
                return;
            }

            int angkatan = 0;
            if (!string.IsNullOrWhiteSpace(txtAngkatan.Text) &&
                !int.TryParse(txtAngkatan.Text.Trim(), out angkatan))
            {
                lblPesan.Text     = "⚠ Angkatan harus berupa angka (contoh: 2022).";
                lblPesan.CssClass = "msg-error";
                return;
            }

            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(@"
                    INSERT INTO mahasiswa (nim, nama, angkatan, jabatan, email, id_bidang)
                    VALUES (@nim, @nama, @angkatan, @jabatan, @email, @idbidang)", con);

                cmd.Parameters.AddWithValue("@nim",      txtNIM.Text.Trim());
                cmd.Parameters.AddWithValue("@nama",     txtNama.Text.Trim());
                cmd.Parameters.AddWithValue("@angkatan", angkatan);
                cmd.Parameters.AddWithValue("@jabatan",  txtJabatan.Text.Trim());
                cmd.Parameters.AddWithValue("@email",    txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@idbidang", int.Parse(ddlBidang.SelectedValue));

                con.Open();
                cmd.ExecuteNonQuery();
            }

            // Reset form
            txtNIM.Text      = "";
            txtNama.Text     = "";
            txtAngkatan.Text = "";
            txtJabatan.Text  = "";
            txtEmail.Text    = "";
            lblPesan.Text    = "✔ Mahasiswa berhasil ditambahkan.";
            lblPesan.CssClass = "msg-success";

            BindGrid();
            BindStats();
        }

        // ============================================================
        // READ – Row Data Bound (isi ddlEditBidang saat edit mode)
        // ============================================================
        protected void gvMahasiswa_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            bool isEditRow = (e.Row.RowState == DataControlRowState.Edit) ||
                             (e.Row.RowState == (DataControlRowState.Edit | DataControlRowState.Alternate));

            if (!isEditRow) return;

            DropDownList ddl = (DropDownList)e.Row.FindControl("ddlEditBidang");
            if (ddl == null) return;

            // Isi opsi bidang
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlDataAdapter sda = new SqlDataAdapter(
                    "SELECT id_bidang, nama_bidang FROM bidang ORDER BY nama_bidang", con);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                ddl.DataSource     = dt;
                ddl.DataTextField  = "nama_bidang";
                ddl.DataValueField = "id_bidang";
                ddl.DataBind();
            }

            // Pilih nilai bidang yang sedang aktif
            DataRowView drv = e.Row.DataItem as DataRowView;
            if (drv != null)
            {
                string currentBidangId = drv["id_bidang"].ToString();
                ListItem item = ddl.Items.FindByValue(currentBidangId);
                if (item != null) item.Selected = true;
            }
        }

        // ============================================================
        // UPDATE – Mulai mode edit
        // ============================================================
        protected void gvMahasiswa_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvMahasiswa.EditIndex = e.NewEditIndex;
            lblPesan.Text = "";
            BindGrid();
        }

        // ============================================================
        // UPDATE – Batal edit
        // ============================================================
        protected void gvMahasiswa_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvMahasiswa.EditIndex = -1;
            lblPesan.Text = "";
            BindGrid();
        }

        // ============================================================
        // UPDATE – Simpan perubahan
        // ============================================================
        protected void gvMahasiswa_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(gvMahasiswa.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvMahasiswa.Rows[e.RowIndex];

            // Ambil nilai dari TextBox inline edit (kolom BoundField)
            string nim      = ((TextBox)row.Cells[1].Controls[0]).Text.Trim();
            string nama     = ((TextBox)row.Cells[2].Controls[0]).Text.Trim();
            string angStr   = ((TextBox)row.Cells[3].Controls[0]).Text.Trim();
            string jabatan  = ((TextBox)row.Cells[4].Controls[0]).Text.Trim();
            string email    = ((TextBox)row.Cells[5].Controls[0]).Text.Trim();

            // Ambil DropDownList bidang dari TemplateField
            DropDownList ddlEdit = (DropDownList)row.FindControl("ddlEditBidang");
            int idBidang = (ddlEdit != null) ? Convert.ToInt32(ddlEdit.SelectedValue) : 0;

            int angkatan = 0;
            int.TryParse(angStr, out angkatan);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(@"
                    UPDATE mahasiswa
                    SET nim=@nim, nama=@nama, angkatan=@angkatan,
                        jabatan=@jabatan, email=@email, id_bidang=@idbidang
                    WHERE id_mahasiswa=@id", con);

                cmd.Parameters.AddWithValue("@nim",      nim);
                cmd.Parameters.AddWithValue("@nama",     nama);
                cmd.Parameters.AddWithValue("@angkatan", angkatan);
                cmd.Parameters.AddWithValue("@jabatan",  jabatan);
                cmd.Parameters.AddWithValue("@email",    email);
                cmd.Parameters.AddWithValue("@idbidang", idBidang);
                cmd.Parameters.AddWithValue("@id",       id);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            gvMahasiswa.EditIndex = -1;
            lblPesan.Text         = "✔ Data mahasiswa berhasil diperbarui.";
            lblPesan.CssClass     = "msg-success";
            BindGrid();
            BindStats();
        }

        // ============================================================
        // DELETE – Hapus mahasiswa
        // ============================================================
        protected void gvMahasiswa_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvMahasiswa.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(
                    "DELETE FROM mahasiswa WHERE id_mahasiswa=@id", con);
                cmd.Parameters.AddWithValue("@id", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblPesan.Text     = "✔ Mahasiswa berhasil dihapus.";
            lblPesan.CssClass = "msg-success";
            BindGrid();
            BindStats();
        }
    }
}
