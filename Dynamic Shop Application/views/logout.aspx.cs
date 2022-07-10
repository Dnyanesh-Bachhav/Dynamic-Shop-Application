using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Dynamic_Shop_Application.views
{
    public partial class logot : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["guest_name"] = null;
            Response.Redirect("login.aspx");
        }
    }
}