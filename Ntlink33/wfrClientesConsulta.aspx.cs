using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ServicioLocalContract;


namespace Ntlink33
{
    public partial class wfrClientesConsulta : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!this.IsPostBack)
            {
                var perfil = Session["perfil"] as string;
                var sistema = Session["idSistema"] as long?;
                var empresa =  perfil.Equals("Administrador") ? new empresa { IdEmpresa = 0 } : Session["empresa"] as empresa;
                var idEmpresa = Session["idEmpresa"] as int?;
                var cliente = NtLinkClientFactory.Cliente();
                using (cliente as IDisposable)
                {
                    this.ddlEmpresa.DataSource = cliente.ListaEmpresas(perfil, idEmpresa.Value, sistema.Value, null);
                }
                
                this.ddlEmpresa.Enabled = perfil.Equals("Administrador");
                this.ddlEmpresa.DataBind();
              //  this.GetClientes();
            }
        }

        protected void gvClientes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName.Equals("EditarCliente"))
            {
                DataKey key = this.gvClientes.DataKeys[Convert.ToInt32(e.CommandArgument)];
                if (key != null)
                {
                    int idCliente = Convert.ToInt32(key.Value);
                    Response.Redirect("wfrClientes.aspx?idCliente=" + idCliente);
                }
            }
            else if (e.CommandName.Equals("Eliminar"))
            {
                int index;

                index = Convert.ToInt32(e.CommandArgument);
                ViewState["IDCli"] = index;
                hf_DeleteID.Value = ID.ToString();
                // mpex.Show();
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), " ShowPopup",
              "$('#MainContent_ModalEliminarCliente').modal('show') ", true);

            }
        }
        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            var idcliente = ViewState["IDCli"] as int?;
            if (idcliente != null)
            {
                try
                {
                    var cliente = NtLinkClientFactory.Cliente();
                    using (cliente as IDisposable)
                    {
                        int idCliente = Convert.ToInt32(idcliente);
                        var cl = cliente.ObtenerClienteById(idCliente);
                        cliente.EliminarCliente(cl);

                    }
                    this.GetClientes();
                     ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Pop",
                   "$('#MainContent_ModalEliminarCliente').modal('hide');", true);

                }
                catch (FaultException fe)
                {
                    lblError.Text = fe.Message;
                    // mpMensajeError.Show();
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), " ShowPopup",
                     "$('#MainContent_ModalError').modal('show'); "+
                             "$('body').css('padding-right', '0px'); ", true);

                }
                catch (Exception ee)
                {
                    lblError.Text = "Ocurrió un error al eliminar el cliente";
                    // mpMensajeError.Show();
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), " ShowPopup",
            "$('#MainContent_ModalError').modal('show'); "+
                  "$('body').css('padding-right', '0px'); ", true);

                }


               // mpex.Hide();
               // up1.Update();



            }
        }


        //protected void gvClientes_RowDataBound(object sender, GridViewRowEventArgs e)
        //{
        //    LinkButton lb = e.Row.FindControl("gvlnkDelete") as LinkButton;
        //    if (lb != null)
        //        ScriptManager.GetCurrent(this).RegisterAsyncPostBackControl(lb);
        //}

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            this.GetClientes();
        }

        protected void btnNuevoCliente_Click(object sender, EventArgs e)
        {
             this.Response.Redirect("wfrClientes.aspx?idEmpresa=" + this.ddlEmpresa.SelectedValue);
          
        }

        protected void gvClientes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.gvClientes.DataSource = ViewState["clientes"];
            this.gvClientes.PageIndex = e.NewPageIndex;
            this.gvClientes.DataBind();
        }

        #region Helper Methods

        private void GetClientes()
        {
            int idEmpresa = int.Parse(this.ddlEmpresa.SelectedValue);
            
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                var clientes = cliente.ListaClientes(Session["perfil"] as string, idEmpresa, this.txtBusqueda.Text, false);
                ViewState["clientes"] = clientes;
                this.gvClientes.DataSource = clientes;
                this.gvClientes.DataBind();
            }
        }

        #endregion
    }
}