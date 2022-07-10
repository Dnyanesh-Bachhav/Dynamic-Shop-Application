using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace Dynamic_Shop_Application.views
{
    public partial class profile_backend : System.Web.UI.Page
    {
        static string connstr = @"Server=localhost;Database=Dynamic_Shop;Uid=root;Password=sa123;";
        MySqlConnection sqlcon;
        protected void Page_Load(object sender, EventArgs e)
        {
            sqlcon = new MySqlConnection(connstr);
            sqlcon.Open();


            using (sqlcon)
            {

                string username = Request.Form["username"];
                string password = Request.Form["password"];
                MySqlCommand sql = new MySqlCommand("update admin_data set username=@username,password=@password where id=1", sqlcon);
                sql.Parameters.AddWithValue("@username", username);
                sql.Parameters.AddWithValue("@password", password);
                //sql.CommandType = System.Data.CommandType.Text;
                int count = sql.ExecuteNonQuery();

                if (count >= 1)
                {
                    Response.Redirect("admin_dashboard.aspx");
                }
                else
                {
                    Response.Write("Error Occured...!!!");
                }
            }
            sqlcon.Close();
        }
    }
}