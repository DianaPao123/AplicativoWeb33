using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ntlink33
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        void Page_Init(object sender, EventArgs e)
        {
            // menu.InnerHtml = " <a class=\"nav-link collapsed\" href=\"#\" data-bs-toggle=\"collapse\" data-bs-target=\"#collapseLayouts\" aria-expanded=\"false\" aria-controls=\"collapseLayouts\"> <div class=\"sb-nav-link-icon\"><i class=\"fas fa-columns\"></i></div> Layouts <div class=\"sb-sidenav-collapse-arrow\"><i class=\"fas fa-angle-down\"></i></div></a>" ;
            if (Session["userId"] == null)
            {
                this.Response.Redirect("wfrLogin.aspx");
            }
            else
            {

                int indiceFacturas = 3;
                var perfil = Session["perfil"] as string;
                               
                this.lblEmpresa.Text = Session["razonSocial"] as string;
                  //this.lblNombreUsuario.Text = Session["nombre"] as string;
                var emision = Session["SaldoEmision"];
                var timbrado = Session["SaldoTimbrado"];
                var contratos = Session["Contratos"] ?? "0";
                lblEmision.Text = emision.ToString();
                lblTimbrado.Text = timbrado.ToString();
                lblContratos.Text = contratos.ToString();
                
                //------------------Folios restantes----------------

                var emite = Convert.ToInt32(emision);
                if (emite < 10)
                lblEmision.ForeColor = System.Drawing.Color.Red;
                
                string rfc = "";
                string correo = "";
                try
                {
                    rfc = Session["RGVRFC"].ToString();
                    correo = Session["UserNameRGV"].ToString();
                }
                catch (Exception ex)
                {
                }

            }

        }
    }
}