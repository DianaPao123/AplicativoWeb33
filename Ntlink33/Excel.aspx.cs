using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ntlink33
{
    public partial class Excel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["userId"] == null)
                {
                    this.Response.Redirect("wfrLogin.aspx");
                }
                //var bytes = context.Cache.Get(Request.QueryString.Get("cacheKey")) as byte[];
                if (Session["cacheKey"] != null )
                {
                    var excel= Session["cacheKey"];
                   
                    Session["cacheKey"] = null;

                    Response.Clear();
                    this.Response.AddHeader("Content-Disposition", "attachment; filename=Reporte.xlsx");
                    this.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.BinaryWrite(Convert.FromBase64String( excel.ToString()));
                    // 
                    Response.Flush();
                    Response.End();
                }
            }
        }
    }
}