using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;


namespace Dynamic_Shop_Application.views
{
    public partial class insert_customer_data : System.Web.UI.Page
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
                string customer_name = Request.Form["customer_name"];
                string phone_no = Request.Form["phone_no"];
                int bill = Convert.ToInt32(Request.Form["bill"]);
                int items_buy = Convert.ToInt32(Request.Form["items_buy"]);
                string date = Request.Form["date"];

                MySqlCommand sql = new MySqlCommand("insert into customer_data(customer_name,phone_no,items_buy,bill,date) values(@customer_name,@phone_no,@items_buy,@bill,@date);", sqlcon);
                sql.Parameters.AddWithValue("@customer_name", customer_name);
                sql.Parameters.AddWithValue("@phone_no", phone_no);
                sql.Parameters.AddWithValue("@items_buy", items_buy);
                sql.Parameters.AddWithValue("@bill", bill);
                sql.Parameters.AddWithValue("@date", date);
                //sql.CommandType = System.Data.CommandType.Text;
                int count = sql.ExecuteNonQuery();

                if (count >= 1)
                {
                    Response.Redirect("dashboard.aspx");
                }
                else
                {
                    
                }
            }
            sqlcon.Close();
        }
    }
}