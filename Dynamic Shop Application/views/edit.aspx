<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="edit.aspx.cs" Inherits="Dynamic_Shop_Application.views.edit" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    
</head>
<body>

    <%
        if(Session["admin_name"] != null)
        { 
        string connstr = @"Server=localhost;Database=Dynamic_Shop;Uid=root;Password='';";
        int count = 1;
        int id = Convert.ToInt32(Request.QueryString["id"]);

        string menu_name = "";
        int price = 0;
        MySqlDataReader md;
        MySqlConnection sqlcon;
        sqlcon = new MySqlConnection(connstr);

        using (sqlcon)
        {

            sqlcon.Open();

            MySqlCommand sql = new MySqlCommand("select * from menu_item where id=@id", sqlcon);
            sql.CommandType = System.Data.CommandType.Text;
            //sql.ExecuteNonQuery();
            sql.Parameters.AddWithValue("@id", id);
            md = sql.ExecuteReader();



            while(md.Read())
            {
                menu_name = md[1].ToString();
                price = Convert.ToInt32(md[2]);
                Response.Write(menu_name + " " + price + " " + id);
            }
            sqlcon.Close();
        }
    %>
        <h1 class="shadow-lg text-center text-black-100 mt-5 border" style="width: 450px;margin-left: 400px;">Edit Data</h1>
    <form class="ml-5 mt-5 pl-5" style="width: 500px;border: 2px solid darkred;margin-left: 368px;padding-left: 50px;padding-right: 50px;" action="edit_backend.aspx" method="post" runat="server">
        <div class="mb-3 mt-4" hidden>
            <label for="exampleInputPassword1" class="form-label">ID</label>
            <input type="text" class="form-control" name="id" id="id" >
        </div>
        <div class="mb-3 mt-4">
            <label for="exampleInputPassword1" class="form-label">Menu Name:</label>
            <input type="text" class="form-control" name="menu_name" id="menu_name">
        </div>
        <div class="mb-3">
            <label for="exampleInputPassword1" class="form-label">Price:</label>
            <input type="text" class="form-control" name="price" id="price">
        </div>
        <div class="mb-3">
            <asp:Button ID="Button1" runat="server" Text="Submit" />
        </div>
    </form>
    

    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/jquery-3.5.1.min.js"></script>
    <script>
        $(document).ready(function () {
            document.getElementById("menu_name").value = "<%= menu_name.ToString() %>";
            document.getElementById("price").value = "<%= price %>";
            document.getElementById("id").value = "<%= id %>";
        });
        
    </script>
    <%
        }
        else
        {
            Response.Redirect("admin_login.aspx");
        }
    %>
</body>
</html>
