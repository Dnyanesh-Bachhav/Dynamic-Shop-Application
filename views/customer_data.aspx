<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="customer_data.aspx.cs" Inherits="Dynamic_Shop_Application.views.customer_data" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Customer Data</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.1/css/all.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css" />
    
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/jquery-3.5.1.min.js"></script>
        <script src="../js/jquery.table2excel.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
</head>
<body class="m-5">

    <%
        if(Session["admin_name"] != null)
        { 
        string connstr = @"Server=localhost;Database=Dynamic_Shop;Uid=root;Password=sa123;";
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

            MySqlCommand sql = new MySqlCommand("select * from customer_data", sqlcon);
            sql.CommandType = System.Data.CommandType.Text;
            //sql.ExecuteNonQuery();
            //sql.Parameters.AddWithValue("@id", id);
            md = sql.ExecuteReader();

    %>
        <h1 class="shadow-lg text-center text-black-100 mt-5 border mb-5" style="width: 450px;margin-left: 400px;">Customer Data</h1>
    <br />
    <table class="table table-light table-hover table-bordered pt-4" id="customer_table">
        <thead class="thead" style="background-color:rgb(159, 232, 245);">
            <th>Customer Name</th>
            <th>Phone no.</th>
            <th>Items Buy</th>
            <th>Bill</th>
            <th>Date</th>
        </thead>
        <tbody>
            <%
                while (md.Read())
                {

            %>
            <tr>
                    <td><%= md[1].ToString() %></td>
                    <td><%= md[2].ToString() %></td>
                    <td><%= md[3].ToString() %></td>
                    <td><%= md[4].ToString() %></td>
                    <td><%= md[5].ToString() %></td>
            </tr>
            <%

                    }
                    sqlcon.Close();
                }
            %>
        </tbody>
    </table>
    <button type="text" class="btn btn-success float-end mb-5" style="margin-right: 0px;margin-top: 50px;" onclick="createExcel();"><i class="fas fa-plus"></i>&nbsp;&nbsp;Save as Excel</button>



    <script>

        function createExcel() {
            $("#customer_table").table2excel({
                name: "Output excel file ",
                filename: "Download",

                fileext: ".xlsx", //File extension type
                exclude_img: false,
                exclude_links: true,
                exclude_inputs: true,
            });
        }

        $(document).ready(function () {
            document.getElementById("menu_name").value = "<%= menu_name.ToString() %>";
            document.getElementById("price").value = "<%= price %>";
            document.getElementById("id").value = "<%= id %>";

            
        });
        $("#customer_table").DataTable();
        
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
