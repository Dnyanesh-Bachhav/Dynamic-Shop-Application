using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;


namespace Dynamic_Shop_Application.views
{
    public partial class insert_data : System.Web.UI.Page
    {
        static string connstr = @"Server=localhost;Database=Dynamic_Shop;Uid=root;Password=sa123;";
        MySqlConnection sqlcon;
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Write(Request.Form["menu_item"]);
            sqlcon = new MySqlConnection(connstr);
            sqlcon.Open();

            using (sqlcon)
            {
                //Response.Write("Connection Successfully made...");
                string menu_item = Request.Form["menu_item"];
                string price = Request.Form["price"];
                MySqlCommand sql = new MySqlCommand("insert into menu_item(item_name,price,item_count) values(@item_name,@price,1);", sqlcon);
                sql.Parameters.AddWithValue("@item_name", menu_item);
                sql.Parameters.AddWithValue("@price", price);
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