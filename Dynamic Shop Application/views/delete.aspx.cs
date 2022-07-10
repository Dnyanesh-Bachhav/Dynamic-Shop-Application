using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;


namespace Dynamic_Shop_Application.views
{
    public partial class delete : System.Web.UI.Page
    {
        static string connstr = @"Server=localhost;Database=Dynamic_Shop;Uid=root;Password=sa123;";
        MySqlConnection sqlcon;
        protected void Page_Load(object sender, EventArgs e)
        {
            sqlcon = new MySqlConnection(connstr); 
             sqlcon.Open(); sqlcon = new MySqlConnection(connstr);
            sqlcon.Open();
            using (sqlcon)
            {
                Response.Write("Connection Successfully made...");
                int id = Convert.ToInt32(Request.QueryString["id"]);
                MySqlCommand sql = new MySqlCommand("delete from menu_item where id=@id", sqlcon);
                sql.Parameters.AddWithValue("@id", id);
                //sql.CommandType = System.Data.CommandType.Text;
                int count = sql.ExecuteNonQuery();
                
                if (count >= 1)
                {
                    Response.Redirect("admin_dashboard.aspx");
                }
                else
                {
                    
                }
            }
            sqlcon.Close();
        }
    }
}