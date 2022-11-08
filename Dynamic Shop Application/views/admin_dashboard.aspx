<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin_dashboard.aspx.cs" Inherits="Dynamic_Shop_Application.views.admin_dashboard" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard</title>
	<link href="../css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.1/css/all.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.debug.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.12/jspdf.plugin.autotable.min.js"></script>
</head>
    <style>
        *{
          margin: 0;
          padding: 0;
          box-sizing: border-box;
          list-style: none;
          text-decoration: none;
        }
        .btn-home{
            background: rgb(255, 255, 255);
        }
        .btn-logout{
            background: rgb(255, 255, 255);
        }
        nav{
          background: gray;
          height: 70px;
          width: 100%;
        }
        nav ul{
          float: right;
          margin-right: 60px;
          display: inline;
        }
        nav ul li{
          display: inline-block;
          line-height: 70px;
        }
        nav ul li a{
          color: black;
          font-weight: 500;
          font-size: 20px;
          padding: 7px 13px;
          border-radius: 3px;
          /* text-transform: uppercase; */
          font-family: 'Poppins', sans-serif;
        }
        nav h1{
            position: relative;
            left: 10px;
            top: 15px;
        }
        </style>
<body>

    		<%
                if(Session["admin_name"] != null)
                { 

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
                    while(md1.Read())
                    {
                        shop_name = md1[1].ToString();
                        slogan = md1[2].ToString();
                    }
                    sqlcon.Close();
                }
                using (sqlcon)
                {

                    sqlcon.Open();

                    //Response.Write("Connection Successfully made...");
                    string name = Request.Form["username"];
                    string password = Request.Form["password"];
                    Response.Write(name + " " + password);
                    MySqlCommand sql = new MySqlCommand("select * from menu_item", sqlcon);
                    //md1 = sql2.ExecuteReader();
                    //sql.CommandType = System.Data.CommandType.Text;
                    //sql.ExecuteNonQuery();
                    md = sql.ExecuteReader();





		%>
    <!-- Modal Form to Insert Data-->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Insert Data</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
        <form runat="server" method="post" action="insert_data.aspx">
      <div class="modal-body">
        
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label">Menu Name:</label>
            <input type="text" class="form-control" name="menu_item" />
          </div>
            <div class="mb-3">
            <label for="recipient-name" class="col-form-label">Price:</label>
            <input type="text" class="form-control" name="price" />
          </div>
        
      </div>
            <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
        <asp:Button ID="Button1" runat="server" Text="Add" CssClass="btn btn-success" />
      </div>
            </form>
      
    </div>
  </div>
</div>

    <!-- modal for logout -->
    <div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Logout</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Are you sure you want to exit this session?
      </div>
      <div class="modal-footer">
           <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
        <a href="admin_logout.aspx" type="button" class="btn btn-success">Logout</a>
      </div>
    </div>
  </div>
</div>
        </div>
      <div>
        <nav style="background: #2b8c87;">
            <h1 class="float-left ml-2 mt-3 font-weight-bold text-white" style="font-size: 29px;display: inline;"><%= shop_name %></h1>
            <ul class="mt-3">
                <!-- <li><a class=" text-decoration-none btn btn-home"   href="AdministratorLogin.jsp">Home</a></li>
                <li><a href="#" class="text-decoration-none btn btn-logout" data-bs-toggle="modal" data-bs-target="#logoutModal">Logout</a></li> -->
                <img src="../images/Boy.png" style="width: 45px;height: 45px;border-radius: 50%;"/>
                
            </ul>
            
        </nav>
          <div class="dropdown" style="position: absolute;top: 15px; right: 20px;">
                  <button class="btn btn-lg dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                  </button>
                  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                    <li class="dropdown-item"><i class="fas fa-user-alt"></i><a href="profile.aspx" style="margin-left: 5px;" class="text-decoration-none text-dark">Profile</a></li>
                    <li class="dropdown-item"><i class="fas fa-users"></i><a href="customer_data.aspx" style="margin-left: 5px;" class="text-decoration-none text-dark">Customer Data</a></li>
                    <li class="dropdown-item"><i class="fas fa-adjust"></i><a href="customize_GUI.aspx" style="margin-left: 5px;" class="text-decoration-none text-dark">Customize GUI</a></li>
                    <li class="dropdown-item" data-bs-toggle="modal" data-bs-target="#logoutModal"><i class="fas fa-sign-out-alt"></i><a href="#" style="margin-left: 5px;" class="text-decoration-none text-dark">Logout</a></li>
                  </ul>
          </div>
      </div>

	<div class="container-fluid btn">
		<div class="media">
			<div class="media-body" style="font-family: segoe print;font-size: 100px;background-image: url(../images/Background.jpg);background-size: cover;color: rgb(255, 191, 0);height: 200px;"><%= shop_name %></div>
        </div>
	</div>
	<br><br>
	<marquee><h1 style="color: #990000;"><%= slogan %></h1></marquee><br>
	
    <!-- <div align="center"><img src="../images/Logo.jpeg" style="height: 250px;padding: 2px;border:4px solid #fff;"></div>  -->
	<div style="text-align: center;font-size: 20px; color: rgb(255, 128, 0);font-family: arial;">Welcome...!!!</div>

<table class="table table-light table-hover table-bordered m-5" style="width: 90%;" id="table">
	<thead class="thead table-success">
                <th>No.&nbsp;&nbsp;</th>
				<th>Items</th>
				<th>Cost</th>
				<th>Action</th>
	</thead>
    <tbody>
    
	<%
                    while (md.Read())
                    {
                        //Response.Write("<br>"+md[0].ToString()+" "+md[1].ToString()+" "+md[2].ToString()+" "+md[3].ToString());

    %>
	<tr>
					<td><%= count++ %>.</td>
					<td><%= md[1].ToString() %></td>
					<td>₹<%= md[2].ToString() %></td>
					<td><a href="edit.aspx?id=<%= md[0].ToString() %>" class="btn btn-warning"><i class="fas fa-pencil-alt"></i>&nbsp;&nbsp;Edit</a>&nbsp;&nbsp;<a href="delete.aspx?id=<%= md[0].ToString() %>" class="btn btn-danger"><i class="fas fa-trash-alt"></i>&nbsp;&nbsp;Delete</a></td>
	</tr>
    <%
                        }

                        sqlcon.Close();
                    }
    %>
	
    </tbody>
        </table>
    <%
        }
        else
        {
            Response.Redirect("admin_login.aspx");
        }
    %>
	
	<script type="text/javascript">
        var doc = new jsPDF();
        function getValue() {
            var checks = document.querySelectorAll('.check');
            var items = document.querySelectorAll("#n1");
            console.log(items);
            console.log(checks[0].value);

            let add = 0, i, j, val1 = 0;
            for (i = 0, j = 0; i < checks.length && j < items.length; i++, j++) {
                //var check1=document.getElementById('n[i]').value;

                var check1 = items[j].value;
                if (checks[i].checked === true) {
                    if (items[j].value === "") {
                        console.log("Val: " + items[j].value);
                        items[j].value = 0;
                    }
                    val1 = parseInt(items[j].value) * parseInt(checks[i].value);
                    console.log(val1);
                    add += val1;
                    console.log("Items: " + items[j].value * parseInt(checks[i].value));
                }

            }
            alert("Total Bill is " + add);
            document.getElementById("value").value = add;
            console.log(add);

        }

        function createPDF() {
            doc = new jsPDF();
            doc.autoTable({
                html: "#table",
                theme: "grid"
            });
            doc.save();
        }
    </script>

    <button type="text" class="btn btn-success float-end mb-5" style="margin-right: 100px;" value="add" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="getValue();return false;"><i class="fas fa-plus"></i>&nbsp;&nbsp;Add</button>
    <button type="text" class="btn btn-success mb-5 ml-5" style="display: inline;margin-left: 50px;" value="Save as PDF" onclick="createPDF();return false;">Save as PDF&nbsp;&nbsp;<i class="far fa-file-pdf"></i></button><br>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
</body>
</html>
