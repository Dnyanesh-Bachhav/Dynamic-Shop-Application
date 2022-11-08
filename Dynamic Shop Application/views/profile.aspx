<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="Dynamic_Shop_Application.views.profile" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Profile</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    
</head>
<body>

    <%

        string connstr = @"Server=localhost;Database=Dynamic_Shop;Uid=root;Password='';";
        int count = 1;
        int id = Convert.ToInt32(Request.QueryString["id"]);

        string username = "";
        string password = "";
        MySqlDataReader md;
        MySqlConnection sqlcon;
        sqlcon = new MySqlConnection(connstr);

        using (sqlcon)
        {

            sqlcon.Open();

            MySqlCommand sql = new MySqlCommand("select * from admin_data", sqlcon);
            sql.CommandType = System.Data.CommandType.Text;
            //sql.ExecuteNonQuery();
            
            md = sql.ExecuteReader();



            while(md.Read())
            {
                username = md[1].ToString();
                password = md[2].ToString();
                //Response.Write(username + " " + password + " " + id);
            }    
            sqlcon.Close();
        }
    %>
        <h1 class="shadow-lg text-center text-black-100 mt-5 border" style="width: 450px;margin-left: 400px;">Profile</h1>
    <form class="ml-5 mt-5 pl-5" style="width: 500px;border: 2px solid darkred;margin-left: 368px;padding-left: 50px;padding-right: 50px;" action="profile_backend.aspx" method="post" runat="server">
        <div class="mb-3 mt-4" hidden>
            <label for="exampleInputPassword1" class="form-label">ID</label>
            <input type="text" class="form-control" name="userid" id="userid" >
        </div>
        <div class="mb-3">
            <label for="exampleInputPassword1" class="form-label">Username:</label>
            <input type="text" class="form-control" name="username" id="username">
        </div>
        <div class="mb-3">
            <label for="exampleInputPassword1" class="form-label">Password:</label>
            <input type="text" class="form-control" name="password" id="password">
        </div>
        <div class="mb-3">
            <asp:Button ID="Button1" runat="server" Text="Submit" CssClass="btn btn-outline-primary"/>
        </div>
    </form>
    

    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/jquery-3.5.1.min.js"></script>
    <script>
        $(document).ready(function () {
            document.getElementById("username").value = "<%= username.ToString() %>";
            document.getElementById("password").value = "<%= password %>";
            document.getElementById("userid").value = "<%= id %>";
        });
        
    </script>
</body>
</html>
