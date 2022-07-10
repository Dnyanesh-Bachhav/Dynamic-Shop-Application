using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Dynamic_Shop_Application.views
{
    public partial class admin_logot : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["admin_name"] = null;
            Response.Redirect("admin_login.aspx");
        }
    }
}