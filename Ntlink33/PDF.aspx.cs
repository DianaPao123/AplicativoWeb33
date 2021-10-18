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
                if (Session["cacheKey"] != null && Session["cacheName"] != null && Session["cacheTipo"]!=null)
                {
                    var pdf = Session["cacheKey"];
                    var  name= Session["cacheName"];
                    var tipo = Session["cacheTipo"];

                    Session["cacheKey"] = null;
                    Session["cacheName"] = null;
                    Session["cacheTipo"] = null;

                    Response.Clear();
                    if (tipo.ToString() == "pdf")
                    {
                        Response.ContentType = "application/pdf";
                        Response.BinaryWrite(pdf as byte[]);
                    }
                    else
                    {
                        Response.ContentType = "text/xml";
                        Response.Write(pdf);
                    }
                    Response.AddHeader("Content-Disposition", "attachment; filename="+name.ToString()+"."+tipo);
                   // 
                    Response.Flush();
                    Response.End();
                }
            }
        }
    }
}