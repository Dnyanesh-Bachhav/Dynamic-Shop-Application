<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Bill_PDF.aspx.cs" Inherits="Dynamic_Shop_Application.views.Bill_PDF" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Bill PDF</title>
	<link rel="stylesheet" href="../css/bootstrap.min.css" />
	<script src="../js/jquery-3.5.1.min.js"></script>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.1/css/all.css">
</head>
<body>
	<%
        if(Session["guest_name"] != null)
        { 
        string connstr = @"Server=localhost;Database=Dynamic_Shop;Uid=root;Password='';";

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
	%>
	<div class="mt-5" style="text-align: center;border: 1px solid black;width:500px;height: auto; margin: auto;">
	<h1 class="p-2" style="width: 400px;border: 2px solid red;margin-top: 20px;margin-left: 40px;"><%= shop_name %></h1>
	<div id="slogan"><%= slogan %></div><br>
	<div id="data">
		<b style="float: left;margin-left: 25px;">Name:</b><span id="name" style="float:  left;"></span>
		<b style="margin-right: -154px;">Date:</b><span id="date" style="float: right;margin-right: 25px;"></span>
	</div><br>
	<table class="table table-bordered table-hover m-auto border border-success border-0" style="width: 90%;">
		<thead class="table-success">
			<th>No.</th>
			<th>Item Name</th>
			<th>Quantity</th>
			<th>Price</th>
		</thead>
		<tbody>
			
		</tbody>
	</table>
	<div class="mx-5" style="height: 25px;">
		<div style="float: right;" >
	<b  style="margin-right: 70px;">Total:</b>
	<span id="total" ></span></div>
    </div>
    <div class="mx-5" style="height: 25px;border-bottom: 2px solid red;">
		<div style="float: right;" >
	<b  style="margin-right: 90px;">Tax:</b>
	<span id="total_tax"></span></div>
    </div>
    <div class="mx-5" style="height: 25px;">
		<div style="float: right;" >
	<b  style="margin-right: 70px;">Bill:</b>
	<span id="total_Bill" ></span></div>
    </div>
    <br>
    <div id="message" class="" style="display: flex;justify-content: center;align-items: center;">Thanks for purchasing...<span></span></div>
    
		<div id="message" class="" style="display: flex;justify-content: center;align-items: center;">Have a Great Day ahead...!!!🙏🙏<span></span></div>
	</div><br/>
	<div class="m-5">
		<button class="btn btn-primary" id="back_btn"><i class="fas fa-arrow-circle-left"></i>&nbsp;&nbsp;Back</button>
		<button class="btn btn-primary" style="margin-left: 500px;">Add</button>
		<button class="btn btn-primary float-end" id="print"><i class="fas fa-print"></i>&nbsp;&nbsp;Print</button>
	</div>
	<hr>
	<%
        }
        else
        {
            Response.Redirect("login.aspx");
        }
	%>
	<script>
		$(document).ready(function(){
			let date = new Date();
			$("#date").html(date.getDate()+"/"+(date.getMonth()+1)+"/"+date.getFullYear());
			//window.print();

			var item_table = JSON.parse(localStorage.getItem("item_table"));
			var customer_data = JSON.parse(localStorage.getItem("customer_data"));
			console.log(customer_data);
			console.log(item_table);
			
			let tax = 0;
			for (let item_array of item_table) {
				console.log(item_array[0]);
				$("tbody").append("<tr><td>" + item_array[0] + "</td>" + "<td>" + item_array[1] + "</td>" + "<td>" + item_array[2] + "</td>" + "<td>" + item_array[3] + "</td></tr>");
			}
			document.getElementById("name").innerText = customer_data[0];
			document.getElementById("total").innerText = customer_data[3];
			document.getElementById("total_tax").innerText = (5 / 100) * customer_data[3];
			document.getElementById("total_Bill").innerText = customer_data[3] + ((5 / 100) * customer_data[3]);

			$("#back_btn").on("click", function () {
				window.history.back();
			});
            $("#print").on("click", function () {
				window.print();
            });
	});
    </script>
	<script src="../js/bootstrap.min.js"></script>
</body>
</html>
