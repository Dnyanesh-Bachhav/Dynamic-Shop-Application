using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace Dynamic_Shop_Application.views
{
    public partial class edit_backend : System.Web.UI.Page
    {
        static string connstr = @"Server=localhost;Database=Dynamic_Shop;Uid=root;Password=sa123;";
        MySqlConnection sqlcon;
        protected void Page_Load(object sender, EventArgs e)
        {
            sqlcon = new MySqlConnection(connstr);
            sqlcon.Open();


            using (sqlcon)
            {

                string menu_name = Request.Form["menu_name"];
                int price = Convert.ToInt32(Request.Form["price"]);
                int id = Convert.ToInt32(Request.Form["id"]);
                MySqlCommand sql = new MySqlCommand("update menu_item set item_name=@menu_name,price=@price where id=@id", sqlcon);
                sql.Parameters.AddWithValue("@menu_name", menu_name);
                sql.Parameters.AddWithValue("@price", price);
                sql.Parameters.AddWithValue("@id", id);
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
