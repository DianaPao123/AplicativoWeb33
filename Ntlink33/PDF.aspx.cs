using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ntlink33
{
    public partial class PDF : System.Web.UI.Page
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
                if (Session["cacheKey"] != null)
                {
                    var pdf = Session["cacheKey"];

                    Session["cacheKey"] = null;
                    Response.Clear();
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("Content-Disposition", "attachment; filename=preview.pdf");
                    Response.BinaryWrite(pdf as byte[]);
                   // Response.Write("RGV");
                    Response.Flush();
                    Response.End();
                }
            }
        }
    }
}