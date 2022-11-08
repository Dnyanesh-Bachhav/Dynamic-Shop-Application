<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_login.aspx.cs" Inherits="Dynamic_Shop_Application.views.admin_login" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
   
    <link rel="stylesheet" href="../css/style.css">
    <style>
        .btn-home{
            background: rgb(255, 255, 255);
        }
        .btn-logout{
            background: rgb(255, 255, 255);
        }
        .active{
            background: rgb(15 239 216);
        }
    </style>
</head>
  <body>
    <%
                    string connstr = @"Server=localhost;Database=Dynamic_Shop;Uid=root;Password='';";
                    int count = 1;
                    MySqlDataReader md;
                    MySqlDataReader md1;
                    string shop_name = "";
                    string slogan = "";
                    MySqlConnection sqlcon;
                    sqlcon = new MySqlConnection(connstr);
                    MySqlConnection sqlcon2 = new MySqlConnection(connstr);
                    using (sqlcon)
                    {
                        sqlcon.Open();
                        MySqlCommand sql2 = new MySqlCommand("select * from gui_data where id=1", sqlcon);
                        md1 = sql2.ExecuteReader();
                        while (md1.Read())
                        {
                            shop_name = md1[1].ToString();
                            slogan = md1[2].ToString();
                        }
                        sqlcon.Close();
                    }    
    %>
    <div class="bg-img">
        <nav style="border: 2px solid white;">
            <h1 class="float-left ml-2 mt-3 font-weight-bold text-white" style="font-size: 29px;position: relative;top: 10px;left: 10px;display: inline;font-weight: bold;" ><%= shop_name %></h1>
        <ul>
            <li><a class=" text-decoration-none btn btn-home active"   href="admin_login.aspx">Admin Login</a></li>
            <li><a href="login.aspx" class="text-decoration-none btn btn-logout">Guest Login</a></li>
        </ul>
        </nav>

      <div class="content">
        <header>Login</header>
        <br>
        <form runat="server" method="post">
          <div class="field">
            <span class="fa fa-user"></span>
            <input type="text" placeholder="Username" name="username" required>
          </div>
          <div class="field space">
            <span class="fa fa-lock"></span>
            <input type="password" class="pass-key" placeholder="Password" name="password" required>
            <span class="show"><i class="fas fa-eye"></i></span>
          </div>
          <div class="pass">
            
          </div>
          <br>
          <div class="field">
            <asp:Button ID="Button1" runat="server" Text="LOGIN" OnClick="Button1_Click"/>
              <asp:Label ID="Label1" runat="server" Text="Label" hidden></asp:Label>
          </div>
        </form>
  
          </div>
      </div>
    </div>

    <script>
      const pass_field = document.querySelector('.pass-key');
      const showBtn = document.querySelector('.show');
      showBtn.addEventListener('click', function(){
       if(pass_field.type === "password"){
         pass_field.type = "text";
         showBtn.innerHTML = "<i class='fas fa-eye-slash'></i>";
         showBtn.style.color = "#3498db";
       }else{
         pass_field.type = "password";
         showBtn.innerHTML = "<i class='fas fa-eye'></i>";
         showBtn.style.color = "#222";
       }
      });
    </script>

    <script src="../js/bootstrap.min.js"></script>
  </body>
</html>

