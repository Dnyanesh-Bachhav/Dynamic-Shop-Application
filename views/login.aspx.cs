using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace Dynamic_Shop_Application.views
{

    public partial class login : System.Web.UI.Page
    {
        static string connstr = @"Server=localhost;Database=Dynamic_Shop;Uid=root;Password=sa123;";
        MySqlConnection sqlcon;
        protected void Page_Load(object sender, EventArgs e)
        {
             sqlcon = new MySqlConnection(connstr); 
             sqlcon.Open();

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

                using (sqlcon)
                {
                    //Response.Write("Connection Successfully made...");
                    string name = Request.Form["username"];
                    string password = Request.Form["password"];
                    //Response.Write(name + " " + password);
                    MySqlCommand sql = new MySqlCommand("select * from guest_data where username=@username and password=@password", sqlcon);
                    sql.Parameters.AddWithValue("@username", name);
                    sql.Parameters.AddWithValue("@password", password);
                    //sql.CommandType = System.Data.CommandType.Text;
                    //sql.ExecuteNonQuery();
                    MySqlDataReader md = sql.ExecuteReader();

                    if (md.Read())
                    {
                        Label1.Text = "Connection Successfully Made with Database...";
                        Session["guest_name"] = name;
                        Response.Redirect("dashboard.aspx");
                    }
                    else
                    {
                        Label1.Text = "Something went Wrong...";
                    }
                }
                sqlcon.Close();


            
        }
    }
}