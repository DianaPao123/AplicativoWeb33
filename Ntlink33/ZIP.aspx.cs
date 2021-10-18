using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ntlink33
{
    public partial class ZIP : System.Web.UI.Page
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
                if (Session["cacheKey"] != null && Session["cacheName"]!=null)
                {
                    var zip= Session["cacheKey"];
                    var name = Session["cacheName"];

                    Session["cacheKey"] = null;
                    Session["cacheName"]=null;

                    Response.Clear();
                     // 
                    Response.AddHeader("Content-Disposition", "attachment; filename=" + name + "_Comprobantes" + ".zip");
                    this.Response.ContentType = "application/zip, application/octet-stream";
                    this.Response.BinaryWrite(Convert.FromBase64String(zip.ToString()));
                                       
                    Response.Flush();
                    Response.End();
                }
            }
        }
    }
}