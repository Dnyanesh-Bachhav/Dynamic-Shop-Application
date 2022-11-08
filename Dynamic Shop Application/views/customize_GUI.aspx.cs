using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;



namespace Dynamic_Shop_Application.views
{
    public partial class customize_GUI : System.Web.UI.Page
    {
        static string connstr = @"Server=localhost;Database=Dynamic_Shop;Uid=root;Password='';";
        MySqlConnection sqlcon;
        protected void Page_Load(object sender, EventArgs e)
        {
            


            
        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            using (sqlcon)
            {
                sqlcon = new MySqlConnection(connstr);
                sqlcon.Open();
                string shop_name = Request.QueryString["shop_name"];
                string slogan = Request.QueryString["slogan"];

                Response.Write(shop_name + " " + slogan);
                MySqlCommand sql = new MySqlCommand("update gui_data set shop_name=@shop_name,slogan=@slogan where id=1", sqlcon);
                sql.Parameters.AddWithValue("@shop_name", shop_name);
                sql.Parameters.AddWithValue("@slogan", slogan);
                //sql.CommandType = System.Data.CommandType.Text;
                int count = sql.ExecuteNonQuery();

                if (count >= 1)
                {
                    //Response.Redirect("admin_dashboard.aspx");
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