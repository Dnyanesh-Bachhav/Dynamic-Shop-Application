<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="Dynamic_Shop_Application.views.dashboard" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard</title>
	<link href="../css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.debug.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.12/jspdf.plugin.autotable.min.js"></script>
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
</head>
<body>
    		<%
                if (Session["guest_name"] != null)
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
                        while (md1.Read())
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
                        //sql.CommandType = System.Data.CommandType.Text;
                        //sql.ExecuteNonQuery();
                        md = sql.ExecuteReader();





		%>


    <!-- modal to insert new data -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Insert Data</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
        <form runat="server" method="post" action="insert_customer_data.aspx">
      <div class="modal-body">
        
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label">Customer Name:</label>
            <input type="text" class="form-control" name="customer_name" id="customer_name" />
          </div>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label">Bill:</label>
            <input type="text" class="form-control" name="bill" id="bill" />
          </div>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label">Phone:</label>
            <input type="text" class="form-control" name="phone_no" id="phone_no" />
          </div>
          <div class="mb-3" hidden>
            <label for="recipient-name" class="col-form-label">:Items Buy:</label>
            <input type="text" class="form-control" name="items_buy" id="items_buy" />
          </div>
          <div class="mb-3" hidden>
            <label for="recipient-name" class="col-form-label">Date:</label>
            <input type="text" class="form-control" name="date"  id="date"/>
          </div>
        
      </div>
            <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
        <asp:Button ID="Button1" runat="server" Text="Add" CssClass="btn btn-success" />
      </div>
            </form>
        <a href="Bill_PDF.aspx" id="Button2" class="btn btn-primary">Print and Add</a>

      
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
        <a href="logout.aspx" type="button" class="btn btn-success">Logout</a>
      </div>
    </div>
  </div>
</div>

    
      <div>
        <nav style="background: #2b8c87;">
            <h1 class="float-left ml-2 mt-3 font-weight-bold text-white" style="font-size: 29px;display: inline;"><%= shop_name %></h1>
            <ul>
                <li><a class=" text-decoration-none btn btn-home"   href="AdministratorLogin.jsp">Home</a></li>
                <li><a href="#" class="text-decoration-none btn btn-logout" data-bs-toggle="modal" data-bs-target="#logoutModal">Logout</a></li>
            </ul>
        </nav>
      </div>

    <div hidden id="data">
        <div style="border: 2px solid red;">
        <%=shop_name %>
        </div>
        </div>
	<div class="container-fluid btn">
		<div class="media">
			<div class="media-body" style="font-family: segoe print;font-size: 100px;background-image: url('../images/Background.jpg'); background-size: cover;color: rgb(255, 191, 0);height: 234px;"><%= shop_name %></div>
        </div>
	</div>
	<br><br>
	<marquee><h1 style="color: #990000;"><%= slogan %></h1></marquee><br>
	
    <!-- <div align="center"><img src="../images/Logo.jpeg" style="height: 250px;padding: 2px;border:4px solid #fff;"></div>  -->
	<div style="text-align: center;font-size: 20px; color: rgb(255, 128, 0);font-family: arial;">Welcome...!!!</div>

<table class="table table-light table-hover m-5 table-bordered" style="width: 90%;" id="table">
	<thead class="thead table-success">
                <th>No.</th>
				<th>Items</th>
				<th>Cost</th>
				<th>Select</th>
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
					<td><b>₹</b><%= md[2].ToString() %></td>
					<td>Select checkbox:<input type="checkbox" style="height: 20px;width:20px;" value='<%= md[2].ToString() %>' class="check"><br><input type="number" id="n1" style="width: 55px;height: 30px;" min="0" max="10"></td>
	</tr>
    <%
            }

            sqlcon.Close();
        }
    %>
	
    </tbody>
        </table>
	
	<script type="text/javascript">
        var table = document.getElementById("table");
        var tableRow = table.rows.length;
        var add = 0;

        console.log("Length: " + tableRow);
        function getValue() {
            var checks = document.querySelectorAll('.check');
            var items = document.querySelectorAll("#n1");
            var item_count = 0;
            var item_table = [];
            var item_array = [];
            //console.log(items);
            //console.log(checks[0].value);

            let i, j, val1 = 0;
            for (i = 0, j = 0; i < checks.length && j < items.length; i++, j++) {
                //var check1=document.getElementById('n[i]').value;

                var check1 = items[j].value;
                if (checks[i].checked === true) {
                    if (items[j].value === "") {
                        //console.log("Val: " + items[j].value);
                        items[j].value = 0;
                    }
                    else {
                    val1 = parseInt(items[j].value) * parseInt(checks[i].value);
                    console.log(val1);
                    add += val1;
                        item_count++;
                        let item_name = table.rows[i + 1].cells.item(1).innerText;
                        //console.log("Hello there: " + $(items[j]).parent().parent().html());
                        console.log("Hello there: " + table.rows[i + 1].cells.item(1).innerText);
                        console.log("Items: " + items[j].value * parseInt(checks[i].value) + "Item Purchased: " + item_count);
                        item_array.push(item_count, item_name, items[j].value, checks[i].value);
                        item_table.push(item_array);
                        item_array = [];
                    }
                    
                }

            }
            alert("Total Bill is " + add);
            let date = new Date();
            document.getElementById("value").value = add;
            document.getElementById("bill").value = add;
            document.getElementById("items_buy").value = item_count;
            document.getElementById("date").value = date.getDate() + "/" + (Integer.parseInt(date.getMonth()) + 1) + "/" + date.getFullYear();
            console.log(add);
            console.log(item_table);
            localStorage.setItem("item_table", JSON.stringify(item_table));

        }

        function createPDF() {
            let data = document.getElementById("data");
            var doc = new jsPDF();
            doc.fromHTML(data, 50, 50, {

            });
            doc.save();
        }

        document.getElementById("Button2").addEventListener("click", function (e) {
            // e.preventDefault();
            var customer_data = [];

            customer_data.push(document.getElementById("customer_name").value);
            customer_data.push(document.getElementById("phone_no").value);
            customer_data.push(document.getElementById("items_buy").value);
            customer_data.push(add);
            localStorage.setItem("customer_data", JSON.stringify(customer_data));
            console.log(customer_data);
            customer_data = [];
            setTimeout(() => { }, 2000);
            //createPDF();
        });
    </script><br>
    <%
        }
        else
        {
            Response.Redirect("login.aspx");
        }
    %>
	<div class="text-center">
	Total Bill: <input type="text" id="value" name="add_Value">
	<button type="text" class="btn btn-success" value="add" onclick="getValue();return false;" data-bs-toggle="modal" data-bs-target="#exampleModal">Add</button><br>
	
	<input type="submit" value="Submit" class="text-center btn btn-outline-primary  mt-5 mb-5" 
	style="width: 100px;font-family: arial;font-size: 25px;">
	</div>
	<script src="../js/bootstrap.min.js"></script>
    <script src="../js/jquery-3.5.1.min.js"></script>
</body>
</html>