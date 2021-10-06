
using ServicioLocalContract;
using ServicioLocalContract.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Pagos = ServicioLocalContract.Entities.Pagos;

namespace GafLookPaid
{
    public partial class wfrFacturaCompPagos : Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {


            //  txtCodigo.Attributes.Add("onkeypress", "javascript:return SoloNum(event); ");

            if (!IsPostBack)
            {
        //        ddlClaveUnidadE.Style.Remove("width");

                try
                {
                    DivCfdiRelacionados.Attributes.Add("style", "display:none;");
                    //DivImpuestos.Attributes.Add("style", "display:none;");

                    var perfil = Session["perfil"] as string;
                    var sistema = Session["idSistema"] as long?;
                    var idEmp = Session["idEmpresa"] as int?;
                    int idEmpresaE;
                    var cliente = NtLinkClientFactory.Cliente();
                    using (cliente as IDisposable)
                    {
                        var empresas = cliente.ListaEmpresas(perfil, idEmp.Value, sistema.Value, null);
                        var listaEmpresas = new List<empresa>(empresas);

                        this.ddlEmpresa.DataSource = listaEmpresas;
                        this.ddlEmpresa.DataBind();
                        

                        int idEmpresa = idEmpresaE = listaEmpresas.First().IdEmpresa;

                        if (!cliente.TieneConfiguradoCertificado(idEmpresa))
                        {
                            this.lblError.Text = "Tienes que configurar tus certificados antes de poder facturar";
                            this.btnGenerarFactura.Enabled = this.BtnVistaPreviaP.Enabled = false;
                            return;
                        }

                        if (listaEmpresas.Count > 0)
                        {
                        
                            this.ddlClientes.DataSource = cliente.ListaClientes(perfil, idEmpresa, string.Empty, false);
                            this.ddlClientes.DataBind();
                            this.ddlClientes.Items.Insert(0, "");


                            this.txtFolio.Text = cliente.SiguienteFolioFactura(idEmpresa);
                            this.txtFolioSat.Text = txtFolio.Text;
                            ddlClientes_SelectedIndexChanged(null, null);
                                                       
                        }

                        this.ddlSucursales.DataSource = cliente.ListaSucursales(idEmpresa);
                        ddlSucursales.DataValueField = "LugarExpedicion";
                        ddlSucursales.DataTextField = "Nombre";

                        this.ddlSucursales.DataBind();

                        //------------catalogos grandes----------------------
                        /*ddlClaveUnidad.DataSource = cliente.ConsultarClaveUnidadAll().Where(p => p.Nombre == "Pieza" || p.Nombre == "Unidad de servicio" || p.Nombre == "Kilogramo"
                                                    || p.Nombre == "Gramo" || p.Nombre == "Metro" || p.Nombre == "Metro cuadrado" || p.Nombre == "Metro cúbico" || p.Nombre == "Pulgada"
                                                    || p.Nombre == "Litro" || p.Nombre == "Lote" || p.Nombre == "Actividad");*/
                        //Filtro_ClaveUnidad();//Axl--Se coloco este subprograma para que se visualice la clave de unidad y la descripcion en el ddlClaveUnidad y su respectivo filtrado**

                        //ddlClaveUnidadE.DataSource = ddlClaveUnidad.DataSource; //cliente.ConsultarClaveUnidadAll().OrderBy(p => p.Nombre);//Axl--Se ordena por orden alfabetico
                        
                        //ListItem l = new ListItem("---Otro---", "0", true);
                        //ddlClaveUnidadE.DataTextField = "Nombre";
                        //ddlClaveUnidadE.DataValueField = "c_ClaveUnidad1";
                        //ddlClaveUnidadE.DataBind();
                        //this.ddlClaveUnidadE.Items.Add(l);
                        //ddlClaveUnidadE.SelectedValue = "H87";

                        //--------------------------------------------

                        //--------------------------------------------
                        ddlMoneda.DataSource = cliente.Consultar_MonedaAll().OrderBy(p => p.Descripción);
                        ddlMoneda.DataTextField = "Descripción";
                        ddlMoneda.DataValueField = "c_Moneda1";
                        ddlMoneda.DataBind();
                        ddlMoneda.SelectedValue = "XXX";

                        Filtro_MonedaDR();
                        ddlMonedaDR.DataSource = cliente.Consultar_MonedaAll().OrderBy(p => p.Descripción);
                        // ddlMonedaDR.DataSource = ddlMoneda.DataSource;
                        ddlMonedaDR.DataTextField = "Descripción";
                        ddlMonedaDR.DataValueField = "c_Moneda1";
                        ddlMonedaDR.DataBind();
                        ddlMonedaDR.SelectedValue = "MXN";
                        Filtro_MonedaDR();

                        Filtro_Moneda();

                        ddlMonedaP.DataSource = cliente.Consultar_MonedaAll().OrderBy(p => p.Descripción);
                        ddlMonedaP.DataTextField = "Descripción";
                        ddlMonedaP.DataValueField = "c_Moneda1";
                        ddlMonedaP.DataBind();
                        ddlMonedaP.SelectedValue = "MXN";
                        Filtro_Moneda();
                        CatalogosSAT.c_Moneda mone = cliente.Consultar_Moneda(ddlMoneda.SelectedValue);
                        ViewState["DecimalMoneda"] = mone.Decimales;



                        ViewState["DecimalMoneda"] = mone.Decimales;


                    }
                    ViewState["detalles"] = new List<facturasdetalle>();
                    ViewState["detallesImpuestos"] = new List<facturasdetalleRT>();//para impuestos
                    ViewState["CfdiRelacionado"] = new List<string>();
                    ViewState["iva"] = 0M;
                    ViewState["total"] = 0M;
                    ViewState["subtotal"] = 0M;
                    ViewState["descuento"] = 0M;
                    ViewState["Bloq"] = new bool();
                    ViewState["Pagos"] = new List<Pagos>();
                    ViewState["PagoDoctoRelacionado"] = new List<PagoDoctoRelacionado>();

                    ViewState["DecimalActual"] = "2";


                   // this.BindDetallesToGridView();
                    this.UpdateTotales();
                    // ActualizarSaldosMaster();
                    Fecha_Sello(idEmpresaE);
                }
                catch (Exception ex)
                {
                    //Logger.Error(ex.Message);
                }

            }


        }

       

        protected void Filtro_Moneda()
        {
            var cliente = NtLinkClientFactory.Cliente();
            List<CatalogosSAT.c_Moneda> cu = cliente.Consultar_MonedaAll();
            cu = cliente.Consultar_MonedaAll().Select(
        p =>
        new CatalogosSAT.c_Moneda()
        {
            c_Moneda1 = p.c_Moneda1,
            Descripción = p.Descripción,


        }).ToList();
            ddlMonedaP.DataSource = cu.Where(p => p.Descripción == "Peso Mexicano" || p.Descripción == "Dolar americano" || p.Descripción == "Euro" || p.Descripción == "Yen");
            ListItem l = new ListItem("---Otro---", "0", true);
            ddlMonedaP.DataValueField = "c_Moneda1";
            ddlMonedaP.DataTextField = "Descripción";
            ddlMonedaP.DataBind();
            this.ddlMonedaP.Items.Add(l);
            ddlMonedaP.SelectedValue = "MXN";


        }

        protected void Filtro_MonedaDR()
        {
            var cliente = NtLinkClientFactory.Cliente();
            List<CatalogosSAT.c_Moneda> cu = cliente.Consultar_MonedaAll();
            cu = cliente.Consultar_MonedaAll().Select(
        p =>
        new CatalogosSAT.c_Moneda()
        {
            c_Moneda1 = p.c_Moneda1,
            Descripción = p.Descripción,


        }).ToList();
            ddlMonedaDR.DataSource = cu.Where(p => p.Descripción == "Peso Mexicano" || p.Descripción == "Dolar americano" || p.Descripción == "Euro" || p.Descripción == "Yen");
            ListItem l = new ListItem("---Otro---", "0", true);
            ddlMonedaDR.DataValueField = "c_Moneda1";
            ddlMonedaDR.DataTextField = "Descripción";
            ddlMonedaDR.DataBind();
            this.ddlMonedaDR.Items.Add(l);
            ddlMonedaDR.SelectedValue = "MXN";


        }


        

        protected void btnGenerarFactura_Click(object sender, EventArgs e)
        {
            
            mpexFac.Show();
            
        }

        private void GuardarFactura()
        {
            bool error = false;

            ViewState["detalles"] = new List<facturasdetalle>();

            var detalles = ViewState["detalles"] as List<facturasdetalle>;
            //---------------------------
            facturasdetalle detalle = new facturasdetalle()
            {
                Partida = 1,
                Cantidad = 1,
                Descripcion = "Pago",
                Codigo = "84111506",
                Precio = 0,
                Total = 0,
                idproducto = 1,

            };


            detalle.ConceptoClaveUnidad = "ACT";
            detalles.Add(detalle);
            //----------------------------

            if (ValidarFactura())
            {
                //var detalles = ViewState["detalles"] as List<facturasdetalle>;
                var iniciales = Session["iniciales"] as string;
                var fact = GetFactura(iniciales, detalles);
                try
                {
                    var clienteServicio = NtLinkClientFactory.Cliente();
                    int idCliente = int.Parse(this.ddlClientes.SelectedValue);
                    clientes c = clienteServicio.ObtenerClienteById(idCliente);
                    using (clienteServicio as IDisposable)
                    {
                        List<facturasdetalle33> fact33 = new List<facturasdetalle33>();
                        foreach (var de in detalles)
                        {
                            facturasdetalle33 f33 = new facturasdetalle33();
                            f33.ConceptoRetenciones = de.ConceptoRetenciones;
                            f33.ConceptoTraslados = de.ConceptoTraslados;
                            f33.ConceptoClaveProdServ = de.Codigo;
                            f33.partida = de.Partida.ToString();
                            fact33.Add(f33);
                        }

                        //-----------------------------------------------------------
                        facturaComplementos comple = new facturaComplementos();
                        List<Pagos> pagos = ViewState["Pagos"] as List<Pagos>;
                        List<PagoDoctoRelacionado> documentos = ViewState["PagoDoctoRelacionado"] as List<PagoDoctoRelacionado>;

                        foreach (var x in pagos)
                        {          x.DoctoRelacionado = new List<PagoDoctoRelacionado>();
                                x.DoctoRelacionado = null;
                              foreach (var d in documentos)
                            {
                                if (x.id == d.ID)
                                {
                                    if (x.DoctoRelacionado == null)
                                        x.DoctoRelacionado = new List<PagoDoctoRelacionado>();
                                    x.DoctoRelacionado.Add(d);
                                }
                            }
                        }

                        comple.pagos = pagos;
                        //--------------------------------------------------------------
                        var ss = clienteServicio.GuardarFactura33(fact, detalles, fact33, true, comple, null);
                        if (!ss.resultado)
                        {
                            this.lblError.Text = "* Error al generar la factura";
                            btnGenerarFactura.Enabled = true;
                            return;
                        }
                        this.lblError.Text = string.Empty;
                        Session["UUDINuevo"] = "";
                        string udii = ss.UUDI;
                        Session["UUDINuevo"] = udii;
                    }
                    this.ClearAll();
                }
                catch (FaultException ae)
                {
                    error = true;
                    this.lblError.Text = ae.Message;
                }
                catch (ApplicationException ae)
                {
                    error = true;
                    //Logger.Error(ae.Message);
                    if (ae.InnerException != null)
                    {
                        //Logger.Error(ae.InnerException.Message);
                    }
                    this.lblError.Text = ae.Message;
                }
                catch (Exception ae)
                {
                    error = true;
                    //Logger.Error(ae.Message);
                    if (ae.InnerException != null)
                    {
                        //Logger.Error(ae.InnerException.Message);
                    }
                    this.lblError.Text = "Error al generar el comprobante:" + ae.Message;
                }
                if (!error)
                {
                    this.lblOK2.Text = "Comprobante generado correctamente  y enviado por correo electrónico";

                    ActualizarSaldosMaster();

                    mpMensajeOK2.Show();
                    UpdatePanel7.Update();

                    //this.Page.Response.Write("<script language='JavaScript'>window.alert('Comprobante generado');</script>");
                }
                else
                {
                    btnGenerarFactura.Enabled = true;
                    // this.lblError.Text = string.Empty;
                    mpMensajeError.Show();
                    UpdatePanel7.Update();

                }

            }
            else
                btnGenerarFactura.Enabled = true;


        }


        private void Clear()
        {
            //this.txtCodigo.Text = this.txtDescripcion.Text = this.txtPrecio.Text =
            //    this.txtCantidad.Text = txtNoIdentificacion.Text = txtDescuento.Text = 
            //    txtUnidad.Text = string.Empty;
        }

        private void ClearAll()
        {
            this.Clear();
           // cbImpuestos.Visible = false;
            this.txtProyecto.Text =
              /*  this.txtFolioOriginal.Text = this.txtFechaOriginal.Text = this.txtMontoOriginal.Text = */
                this.txtFolioSat.Text =
             txtProyecto.Text = this.txtSerie.Text = string.Empty;
            // this.lblIva.Text = 0M.ToString("C");
            this.lblTraslados.Text = 0M.ToString("C");
            this.lblRetenciones.Text = 0M.ToString("C");

                                             

            this.lblSubtotal.Text = 0M.ToString("C");
            this.lblTotal.Text = 0M.ToString("C");
            // this.ddlMetodoPago.SelectedIndex = 0;
            //this.ddlMetodoPago_SelectedIndexChanged(null, null);
            var detalles = new List<facturasdetalle>();
            ViewState["detalles"] = detalles;

            var Impuestos = new List<facturasdetalleRT>();
            ViewState["detallesImpuestos"] = Impuestos;//para impuestos
            var Relacionado = new List<string>();
            ViewState["CfdiRelacionado"] = Relacionado;

            //this.BindDetallesToGridView();
            //this.BindDetallesImpuestosToGridView();
            this.BindCfdiRelacionadoToGridView();

            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                int idEmpresa = int.Parse(this.ddlEmpresa.SelectedValue);
                this.txtFolio.Text = cliente.SiguienteFolioFactura(idEmpresa);
                this.txtFolioSat.Text = txtFolio.Text;

            }
            //cbImpuestos.Checked = false;
            cbCfdiRelacionados.Checked = false;
            //ddlIVA.SelectedValue = "-1";
            //ddlRISR.SelectedValue = "-1";
            //ddlRIVA.SelectedValue = "-1";
            DivCfdiRelacionados.Attributes.Add("style", "display:none;");
            //DivImpuestos.Attributes.Add("style", "display:none;");
        }

        private bool Validar()
        {


            return true;
        }

         protected void cbCfdiRelacionados_CheckedChanged(object sender, EventArgs e)
        {
            if (cbCfdiRelacionados.Checked == true)
            {
                DivCfdiRelacionados.Attributes.Add("style", "display:block;");
            }
            else
            {
                DivCfdiRelacionados.Attributes.Add("style", "display:none;");

            }
        }
        protected void gvCfdiRelacionado_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            LinkButton lb = e.Row.FindControl("gvlnkDelete") as LinkButton;
            if(lb!=null)
            ScriptManager.GetCurrent(this).RegisterAsyncPostBackControl(lb);
        }
        protected void gvDetalles_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            LinkButton lb = e.Row.FindControl("gvlnkDeleteC") as LinkButton;
            if (lb != null)
                ScriptManager.GetCurrent(this).RegisterAsyncPostBackControl(lb);
            LinkButton lb2 = e.Row.FindControl("gvlnkEditC") as LinkButton;
            if (lb2 != null)
                ScriptManager.GetCurrent(this).RegisterAsyncPostBackControl(lb2);
        }
        protected void gvImpuestos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            LinkButton lb = e.Row.FindControl("gvlnkDelete") as LinkButton;
            if (lb != null)
                ScriptManager.GetCurrent(this).RegisterAsyncPostBackControl(lb);
        }

        private void BindCfdiRelacionadoToGridView()
        {
            List<string> CfdiRelacionado = ViewState["CfdiRelacionado"] as List<string>;
            if (CfdiRelacionado != null && CfdiRelacionado.Count > 0)
            {
                int noColumns = this.gvCfdiRelacionado.Columns.Count;
                this.gvCfdiRelacionado.Columns[noColumns - 1].Visible = true;
            }
            else
            {
                int noColumns = this.gvCfdiRelacionado.Columns.Count;
                this.gvCfdiRelacionado.Columns[noColumns - 1].Visible = false;
            }


            DataTable table = new DataTable();
            table.Columns.Add("ID");
            table.Columns.Add("UUID");
            int t = 0;
            foreach (var array in CfdiRelacionado)
            {
                DataRow row1 = table.NewRow();
                row1["ID"] = t + 1;
                row1["UUID"] = array;
                table.Rows.Add(row1);
                t++;
            }

            this.gvCfdiRelacionado.DataSource = table;
            this.gvCfdiRelacionado.DataBind();

        }

        protected void btnCfdiRelacionado_Click(object sender, EventArgs e)
        {

            if (!string.IsNullOrEmpty(txtUUDI.Text))
            {
                List<string> CfdiRelacionado = ViewState["CfdiRelacionado"] as List<string>;
                CfdiRelacionado.Add(txtUUDI.Text);
                ViewState["CfdiRelacionado"] = CfdiRelacionado;
                this.BindCfdiRelacionadoToGridView();

                txtUUDI.Text = "";
            }


        }

        protected void lnkDeleteFac_Click(object sender, EventArgs e)
        {
            btnGenerarFactura.Enabled = false;
            mpexFac.Hide();

            this.GuardarFactura();

            btnGenerarFactura.Enabled = true;

        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            txtRFCBus.Text = "";

            ModalBuscar.Show();
            UpdatePanel7.Update();


        }
        protected void btnBuscarRFC_Click(object sender, EventArgs e)
        {
            ModalBuscar.Hide();
            var cliente = NtLinkClientFactory.Cliente();
            if (string.IsNullOrEmpty(this.ddlClientes.SelectedValue))

                return;

            using (cliente as IDisposable)
            {
                int idEmpresa = int.Parse(this.ddlEmpresa.SelectedValue);
                clientes c = cliente.ObtenerClienteByRFC(txtRFCBus.Text, idEmpresa);
                if (c != null)
                {
                    ddlClientes.SelectedValue = c.idCliente.ToString();
                    ddlClientes_SelectedIndexChanged(null, null);
                }
            }
            txtRFCBus.Text = "";
            up1.Update();

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

            mpMensajeOK2.Hide();

            string uudi = Session["UUDINuevo"].ToString();
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                Response.AddHeader("Content-Disposition", "attachment; filename=" + "_" + uudi + ".pdf");
                this.Response.ContentType = "application/pdf";
                var pdf = cliente.FacturaPdf(uudi);
                if (pdf == null)
                {
                    this.lblError.Text = "Archivo no encontrado";
                    return;
                }
                this.Response.BinaryWrite(pdf);
                this.Response.End();
                Session["UUDINuevo"] = "";
            }
        }


        protected void gvCfdiRelacionado_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index;

            if (e.CommandName.Equals("deleteRecord"))
            {
                index = Convert.ToInt32(e.CommandArgument);
                //int ID = Convert.ToInt32(gvCfdiRelacionado.DataKeys[index].Value.ToString());
                ViewState["IDCli"] = index;
                hf_DeleteID.Value = ID.ToString();

                //System.Text.StringBuilder sb = new System.Text.StringBuilder();
                //sb.Append("$('#deleteModal').modal();");
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "clientscript", sb.ToString(), true);
                mpex.Show();


            }
        }
        protected void lnkDelete_Click(object sender, EventArgs e)
        {
            var idcliente = ViewState["IDCli"] as int?;
            if (idcliente != null)
            {
                var CfdiRelacionado = ViewState["CfdiRelacionado"] as List<string>;
                CfdiRelacionado.RemoveAt(Convert.ToInt32(idcliente));
                ViewState["CfdiRelacionado"] = CfdiRelacionado;
                this.BindCfdiRelacionadoToGridView();

                mpex.Hide();
                UpdatePanel1.Update();



            }
        }

        

        

        private void UpdateTotales()
        {
            CultureInfo cul = CultureInfo.CreateSpecificCulture("es-MX");
            var cliente = NtLinkClientFactory.Cliente();
            //int idCliente = int.Parse(this.ddlClientes.SelectedValue);
            //clientes c = cliente.ObtenerClienteById(idCliente);
            var detalles = ViewState["detalles"] as List<facturasdetalle>;
            var descuento = ViewState["descuento"].ToString();
            string m = ViewState["DecimalMoneda"].ToString();
            int mon = 0;
            if (!string.IsNullOrEmpty(m))
                mon = Convert.ToInt16(m);

            decimal descuento1 = 0M;
            if (!string.IsNullOrEmpty(descuento))
                descuento1 = Convert.ToDecimal(descuento);

            if (detalles == null)
                return;
            var iva = 0M;
            var total = 0M;
            var subtotal = 0M;
            var retenciontotal = 0M;
            var trasladototal = 0M;

            foreach (facturasdetalle detalle in detalles)
            {
                //  subtotal += detalle.TotalPartida;
                subtotal += detalle.Total;//para descuento
                iva += detalle.ImporteIva.HasValue ? detalle.ImporteIva.Value : 0;
                // total += detalle.TotalPartida + (detalle.ImporteIva.HasValue ? detalle.ImporteIva.Value : 0);
                total += detalle.Total + (detalle.ImporteIva.HasValue ? detalle.ImporteIva.Value : 0);

                foreach (var det in detalle.ConceptoTraslados)
                {
                    if (det.Importe != null)
                        trasladototal = (decimal)(trasladototal + det.Importe);
                }
                foreach (var ret in detalle.ConceptoRetenciones)
                {
                    retenciontotal = (decimal)(retenciontotal + ret.Importe);
                }

            }
            if (trasladototal > 0)
                trasladototal = Decimal.Round(trasladototal, mon);
            if (retenciontotal > 0)
                retenciontotal = Decimal.Round(retenciontotal, mon);
            if (descuento1 > 0)
                descuento1 = Decimal.Round(descuento1, mon);

            total = total + trasladototal - retenciontotal - descuento1;

          
            this.lblDescuento.Text = descuento1.ToString("C", cul);
            this.lblRetenciones.Text = retenciontotal.ToString("C", cul);
            this.lblTraslados.Text = trasladototal.ToString("C", cul);

            this.lblTotal.Text = total.ToString("C", cul);
            this.lblSubtotal.Text = subtotal.ToString("C", cul);
            UpdatePanel4.Update();
        }


        //--seccion de impuestos----------------------------------------------------------------------------------------
        private void AgregarIVA(string partida)
        {

        }

        
       
      
        //---------------------------------------------------------------
        

    protected void bntEliminarImpuesto_Click(object sender, EventArgs e)
        {
            var idimpuesto = ViewState["IDImpuesto"] as int?;
            if (idimpuesto != null)
            {

                List<facturasdetalle> detalles = ViewState["detalles"] as List<facturasdetalle>;
                var impuestos = ViewState["detallesImpuestos"] as List<facturasdetalleRT>;
                facturasdetalleRT dt = impuestos.ElementAt(Convert.ToInt32(idimpuesto));
                string Impuesto = "";
                if (dt.Impuesto == "IVA")
                    Impuesto = "002";
                if (dt.Impuesto == "ISR")
                    Impuesto = "001";
                if (dt.Impuesto == "IEPS")
                    Impuesto = "003";
                // detalles.RemoveAll(p => p. == x);
                foreach (var x in detalles)
                {
                    if (dt.ConceptoClaveProdServ == x.Partida.ToString())
                    {
                        if (dt.TipoImpuesto == "Traslados")
                        {
                            x.ConceptoTraslados.RemoveAll(p => p.Base == dt.Base && p.Importe == dt.Importe
                                      && p.Impuesto == Impuesto && Convert.ToDecimal(p.TasaOCuota) == Convert.ToDecimal(dt.TasaOCuota)
                                      && p.TipoFactor == dt.TipoFactor);

                        }
                        if (dt.TipoImpuesto == "Retenciones")
                        {
                            x.ConceptoRetenciones.RemoveAll(p => p.Base == dt.Base && p.Importe == dt.Importe
                                      && p.Impuesto == Impuesto && Convert.ToDecimal(p.TasaOCuota) == Convert.ToDecimal(dt.TasaOCuota) && p.TipoFactor == dt.TipoFactor);

                        }
                    }
                }

                ViewState["detalles"] = detalles;

                impuestos.RemoveAt(Convert.ToInt32(idimpuesto));
                ViewState["detallesImpuestos"] = impuestos;


                //this.BindDetallesImpuestosToGridView();
                this.UpdateTotales();
            }

            mpexImpuesto.Hide();
           // UpdatePanel3.Update();
        }

        protected void gvImpuestos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index;

            if (e.CommandName.Equals("deleteRecord"))
            {
                index = Convert.ToInt32(e.CommandArgument);
                //int ID = Convert.ToInt32(gvCfdiRelacionado.DataKeys[index].Value.ToString());
                ViewState["IDImpuesto"] = index;
                hf_DeleteID.Value = ID.ToString();
                //
                mpexImpuesto.Show();
            }
        }

        private static string numerodecimales(decimal d, int moneda)
        {
            string D = "0";
            if (moneda == 1)
                D = d.ToString("F1");
            if (moneda == 2)
                D = d.ToString("F2");
            if (moneda == 3)
                D = d.ToString("F3");
            if (moneda == 4)
                D = d.ToString("F4");
            if (moneda == 5)
                D = d.ToString("F5");
            if (moneda == 6)
                D = d.ToString("F6");
            return (D);
        }

        

        

        private bool ValidarFactura()
        {
            if ((ViewState["detalles"] as List<facturasdetalle>).Count == 0)
            {

                this.lblError.Text = "La factura no puede estar vacía";
                mpMensajeError.Show();
                UpdatePanel7.Update();

                return false;
            }
            if (string.IsNullOrEmpty(this.txtFolio.Text))
            {
                this.lblError.Text = "Escribe el folio de la factura";
                mpMensajeError.Show();
                UpdatePanel7.Update();

                return false;
            }
            //*  ya no es obligatorio */
            /*
            if ((this.ddlMetodoPago.SelectedValue == "02" || this.ddlMetodoPago.SelectedValue == "03" || this.ddlMetodoPago.SelectedValue == "04"
              || this.ddlMetodoPago.SelectedValue == "05") && string.IsNullOrEmpty(this.txtCuenta.Text))
            {
                this.lblError.Text = "Falta agregar el #Cuenta o # Tarjeta. ";
                return false;
            }*/
            return true;
        }

        protected void BtnVistaPreviaP_Click(object sender, EventArgs e)
        {
            ViewState["detalles"] = new List<facturasdetalle>();

            var detalles = ViewState["detalles"] as List<facturasdetalle>;
            //---------------------------
            facturasdetalle detalle = new facturasdetalle()
            {
                Partida = 1,
                Cantidad = 1,
                Descripcion = "Pago",
                Codigo = "84111506",
                Precio = 0,
                Total = 0,
                idproducto = 1,

            };

            if (!ValidarFactura())
                return;

            var pdf = Preview();
            if (pdf == null)
            {
                if (string.IsNullOrEmpty(this.lblError.Text))

                    this.lblError.Text = "Error al generar vista previa";
                mpMensajeError.Show();
                UpdatePanel7.Update();

                return;
            }
            else
            {

                this.lblOK.Text = "Comprobante Previo generado correctamente";
                mpMensajeOK.Show();

                Session["cacheKey"] = pdf;
                MyIframe.Attributes["src"] = "PDF.aspx";

                return;
            }
        }
        private byte[] Preview()
        {
            bool error = false;

            var detalles = ViewState["detalles"] as List<facturasdetalle>;
            var iniciales = Session["iniciales"] as string;
            var fact = GetFactura(iniciales, detalles);

            try
            {
                var clienteServicio = NtLinkClientFactory.Cliente();
                int idCliente = int.Parse(this.ddlClientes.SelectedValue);
                clientes c = clienteServicio.ObtenerClienteById(idCliente);
                using (clienteServicio as IDisposable)
                {
                    List<facturasdetalle33> fact33 = new List<facturasdetalle33>();
                    foreach (var de in detalles)
                    {
                        facturasdetalle33 f33 = new facturasdetalle33();
                        f33.ConceptoRetenciones = de.ConceptoRetenciones;
                        f33.ConceptoTraslados = de.ConceptoTraslados;
                        f33.ConceptoClaveProdServ = de.Codigo;
                        f33.partida = de.Partida.ToString();
                        fact33.Add(f33);
                    }

                    //-----------------------------------------------------------
                    facturaComplementos comple = new facturaComplementos();
                    List<Pagos> pagos = ViewState["Pagos"] as List<Pagos>;
                    List<PagoDoctoRelacionado> documentos = ViewState["PagoDoctoRelacionado"] as List<PagoDoctoRelacionado>;

                    foreach (var x in pagos)
                    {
						   x.DoctoRelacionado = new List<PagoDoctoRelacionado>();
                           x.DoctoRelacionado = null;
                             
                        foreach (var d in documentos)
                        {
							
                            if (x.id == d.ID)
                            {
                                if (x.DoctoRelacionado == null)
                                    x.DoctoRelacionado = new List<PagoDoctoRelacionado>();
                                x.DoctoRelacionado.Add(d);
                            }
                        }
                    }

                    comple.pagos = pagos;
                    //--------------------------------------------------------------

                    var pdf = clienteServicio.FacturaPreview33(fact, detalles, fact33, comple, null);
                    if (pdf == null)
                    {
                        this.lblError.Text = "* Error al generar la factura";
                        return null;
                    }
                    else return pdf;
                }
            }
            catch (FaultException ae)
            {
                error = true;
                this.lblError.Text = ae.Message;
            }
            catch (ApplicationException ae)
            {
                error = true;
                //Logger.Error(ae.Message);
                if (ae.InnerException != null)
                {
                    //Logger.Error(ae.InnerException.Message);
                }
                this.lblError.Text = ae.Message;
            }
            catch (Exception ae)
            {
                error = true;
                //Logger.Error(ae.Message);
                if (ae.InnerException != null)
                {
                    //Logger.Error(ae.InnerException.Message);
                }
                this.lblError.Text = "Error al generar el comprobante: " + ae.Message;

            }
            if (!error)
            {
                this.lblOK.Text = "Comprobante generado correctamente  y enviado por correo electrónico";

                ActualizarSaldosMaster();

                mpMensajeOK.Show();
                UpdatePanel7.Update();

                //this.Page.Response.Write("<script language='JavaScript'>window.alert('Comprobante generado');</script>");
            }
            else
            {
                btnGenerarFactura.Enabled = true;
                // this.lblError.Text = string.Empty;
                mpMensajeError.Show();
                UpdatePanel7.Update();

            }

            //this.lblError.Text = string.Empty;
            return null;
        }
        private facturas GetFactura(string iniciales, List<facturasdetalle> detalles)
        {
            var f = new facturas();

            f.TipoDocumento = TipoDocumento.FacturaGeneral;
            f.TipoDeComprobante = "P";
            f.IdEmpresa = int.Parse(this.ddlEmpresa.SelectedValue);
            f.Importe = decimal.Parse(this.lblTotal.Text, NumberStyles.Currency);
            f.SubTotal = decimal.Parse(this.lblSubtotal.Text, NumberStyles.Currency);
            f.Total = decimal.Parse(this.lblTotal.Text, NumberStyles.Currency);
            f.PorcentajeIva = 16;
            f.MonedaID = this.ddlMoneda.SelectedValue;
            f.idcliente = int.Parse(this.ddlClientes.SelectedValue);
            f.Fecha = DateTime.Now;
            f.Folio = this.txtFolioSat.Text;//this.txtFolio.Text.PadLeft(4, '0'),
            f.FolioSAT = this.txtFolio.Text.PadLeft(4, '0');
            f.Serie = string.IsNullOrEmpty(this.txtSerie.Text) ? null : this.txtSerie.Text;
            f.nProducto = detalles.Count;
            f.captura = DateTime.Now;
            f.Cancelado = 0;
            f.Usuario = iniciales;
            f.LugarExpedicion = this.ddlSucursales.SelectedValue;
            f.Proyecto = this.txtProyecto.Text;
            f.MonedaS = this.ddlMoneda.SelectedItem.Text;

            /* Checar cuando debe ir--------------------------------------------
            VoBoNombre = this.txtVoBoNombre.Text,
            VoBoPuesto = this.txtVoBoPuesto.Text,
            VoBoArea = this.txtVoBoArea.Text,
            RecibiNombre = this.txtRecibiNombre.Text,
            RecibiPuesto = this.txtRecibiPuesto.Text,
            RecibiArea = this.txtRecibiArea.Text,
            AutorizoNombre = this.txtAutorizoNombre.Text,
            AutorizoPuesto = this.txtAutorizoPuesto.Text,
            AutorizoArea = this.txtAutorizoArea.Text,
            */
            f.UsoCFDI = this.ddlUsoCFDI.SelectedValue;

           




            /* Checar si va o no---------------------------------------------------------------------
            if (!string.IsNullOrEmpty(txtFolioOriginal.Text))
            {
                fact.Fecha = DateTime.ParseExact(txtFechaOriginal.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                fact.FolioFiscalOriginal = txtFolioOriginal.Text;
                fact.SerieFolioFiscalOriginal = txtSerieOriginal.Text;
                fact.MontoFolioFiscalOriginal = Decimal.Parse(txtMontoOriginal.Text);
            }*/
            f.Fecha = DateTime.Now;

            List<string> CfdiRelacionado = ViewState["CfdiRelacionado"] as List<string>;

            if (CfdiRelacionado != null)
                if (CfdiRelacionado.Count() > 0)
                {
                    f.UUID = CfdiRelacionado;
                    f.TipoRelacion = ddlTipoRelacion.SelectedValue;
                }

            if (ddlMoneda.SelectedValue == "MXN")
                f.NumeroDecimal = ddlDecimales.SelectedValue;

            return f;
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            // ClearAll();
            Response.Redirect("wfrFactura.aspx");

        }
        protected void ddlMoneda_SelectedIndexChanged(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {


                if (ddlMoneda.SelectedValue == "0")
                {


                    List<CatalogosSAT.c_Moneda> cu = cliente.Consultar_MonedaAll();
                    cu = cliente.Consultar_MonedaAll().Select(
                p =>
                new CatalogosSAT.c_Moneda()
                {
                    c_Moneda1 = p.c_Moneda1,
                    Descripción = p.Descripción,



                }).ToList();


                    ddlMoneda.DataSource = cu.OrderBy(p => p.Descripción);


                    ddlMoneda.DataTextField = "Descripción";
                    ddlMoneda.DataValueField = "c_Moneda1";
                    ddlMoneda.DataBind();
                    ddlMoneda.SelectedValue = "MXN";
                }

                //if (this.ddlMoneda.SelectedValue != "MXN")
                //{
                //    this.txtTipoCambio.Visible = true;
                //    this.lblTipoCambio.Visible = true;

                //    this.txtConfirmacion.Visible = true;//c
                //    this.LblConfirmacion.Visible = true;//c

                //    CatalogosSAT.Divisas D = cliente.Consultar_TipoDivisa(this.ddlMoneda.SelectedValue);
                //    if (D != null)
                //        txtTipoCambio.Text = D.PesosDivisa.ToString();
                //    else
                //        txtTipoCambio.Text = "";


                //}
                //else
                //{
                //    txtTipoCambio.Text = "";

                //    this.txtTipoCambio.Visible = false;
                //    this.lblTipoCambio.Visible = false;

                //    this.txtConfirmacion.Visible = false;//c
                //    this.LblConfirmacion.Visible = false;//c
                //}
            }
        }

        protected void ddlEmpresa_SelectedIndexChanged(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                int idEmpresa = int.Parse(this.ddlEmpresa.SelectedValue);
                if (!cliente.TieneConfiguradoCertificado(idEmpresa))
                {
                    this.lblError.Text = "Tienes que configurar tus certificados antes de poder facturar";
                    this.btnGenerarFactura.Enabled = this.BtnVistaPreviaP.Enabled =  false;
                    ddlClientes.Items.Clear();
                    this.ddlClientes.DataSource = cliente.ListaClientes(Session["perfil"] as string, idEmpresa, string.Empty, false);
                    this.ddlClientes.DataBind();


                    return;
                }
                this.btnGenerarFactura.Enabled = this.BtnVistaPreviaP.Enabled = true;


                var emp = cliente.ObtenerEmpresaById(idEmpresa);
                //divViasConcesionadas.Visible = emp.RFC == "VCN940426PJ4";
                //lblMensaje.Text = "";
                //lblMensajeHistorico.Text = "";

                lblError.Text = "";
                this.ddlSucursales.DataSource = cliente.ListaSucursales(idEmpresa);
                ddlSucursales.DataValueField = "LugarExpedicion";
                ddlSucursales.DataTextField = "Nombre";
                ddlSucursales.DataBind();
                this.btnGenerarFactura.Enabled = this.BtnVistaPreviaP.Enabled =
                         this.ddlMoneda.Enabled = true;
                this.txtFolio.Text = cliente.SiguienteFolioFactura(idEmpresa);
                this.txtFolioSat.Text = txtFolio.Text;
                ddlClientes.Items.Clear();
                this.ddlClientes.DataSource = cliente.ListaClientes(Session["perfil"] as string, idEmpresa, string.Empty, false);
                this.ddlClientes.DataBind();


                ddlClientes_SelectedIndexChanged(null, null);
                ViewState["detalles"] = new List<facturasdetalle>();
                ViewState["iva"] = 0M;
                ViewState["total"] = 0M;
                ViewState["subtotal"] = 0M;

                //this.BindDetallesToGridView();
                this.UpdateTotales();
                Fecha_Sello(idEmpresa);
               
            }
        }


        protected void ddlClientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            var cliente = NtLinkClientFactory.Cliente();
            if (string.IsNullOrEmpty(this.ddlClientes.SelectedValue))

                return;

            using (cliente as IDisposable)
            {
                int idCliente = int.Parse(this.ddlClientes.SelectedValue);
                clientes c = cliente.ObtenerClienteById(idCliente);
                var sb = new StringBuilder();
                sb.AppendLine(c.RazonSocial);
                sb.AppendLine(c.RFC);
                this.txtRazonSocial.Text = sb.ToString();
                
            }
         
            
        }

       
       
        protected void Fecha_Sello(int idEmp)
        {
            try
            {
                bool bloq = false;
                ViewState["Bloq"] = bloq;
                string idEmpresaString = idEmp.ToString();
                int idEmpresa;
                if (!string.IsNullOrEmpty(idEmpresaString) && int.TryParse(idEmpresaString, out idEmpresa))
                {
                    empresa empresa;
                    var clienteServicio = NtLinkClientFactory.Cliente();
                    empresa = clienteServicio.ObtenerEmpresaById(idEmpresa);
                    var sistema = clienteServicio.ObtenerSistemaById((int)empresa.idSistema.Value);
                    string FechaVenceString = empresa.VencimientoCert;
                    //string FechaVenceString = "20/04/2018 12:25:53 p.m.";
                    lblVencimiento.ForeColor = System.Drawing.Color.Red;//-------->
                    this.lblVencimiento.Text = "Su CSD caduca el dia: " + FechaVenceString;
                    Int32[] FechaVenceInt = new Int32[6];
                    FechaVenceInt[0] = Convert.ToInt32(FechaVenceString.Substring(6, 4));
                    FechaVenceInt[1] = Convert.ToInt32(FechaVenceString.Substring(3, 2));
                    FechaVenceInt[2] = Convert.ToInt32(FechaVenceString.Substring(0, 2));
                    FechaVenceInt[3] = Convert.ToInt32(FechaVenceString.Substring(11, 2));
                    FechaVenceInt[4] = Convert.ToInt32(FechaVenceString.Substring(17, 2));
                    FechaVenceInt[5] = Convert.ToInt32(FechaVenceString.Substring(17, 2));

                    if (FechaVenceString.Substring(20, 1) == "p")
                    {
                        if (FechaVenceInt[3] != 12)
                            FechaVenceInt[3] += 12;
                    }
                    else if (FechaVenceString.Substring(20, 1) == "a" && FechaVenceInt[3] == 12)
                    {
                        FechaVenceInt[3] = 0;
                    }
                    DateTime FechaVence = new DateTime(FechaVenceInt[0], FechaVenceInt[1], FechaVenceInt[2],
                        FechaVenceInt[3], FechaVenceInt[4], FechaVenceInt[5]);
                    TimeSpan c = FechaVence - DateTime.Now;
                    //TimeSpan c = FechaVence - DateTime.Parse("30/04/2017 01:24:53 p. m.");
                    if (c <= TimeSpan.Parse("15.00:00:00.0"))
                    {
                        lblVencimiento.ForeColor = System.Drawing.Color.Red;//-------->
                        bloq = true;
                        ViewState["Bloq"] = bloq;
                        //LblDiasSello.Text = "*Su CSD ha Caducado*. Favor de tramitar un sello nuevo en el SAT para poder continuar con la factura.";
                        LblDiasSello.Text = "*El CSD para <b>'" + empresa.RFC + "'</b> ha Caducado*. Favor de tramitar un sello nuevo en el SAT para poder continuar con la factura.";
                        if (c > TimeSpan.Parse("00.00:00:00.0"))
                        {
                            bloq = false;
                            ViewState["Bloq"] = bloq;
                            //LblDiasSello.Text = "*Su CSD caduca en:";
                            LblDiasSello.Text = "*El CSD para <b>'" + empresa.RFC + "'</b> caduca en:";
                            string dias = (c).ToString("dd");
                            if (dias != "00")
                                LblDiasSello.Text += " " + dias + " Dias";
                            string horas = (c).ToString("hh");
                            if (horas != "00")
                            {
                                if (dias != "00")
                                    LblDiasSello.Text += ",";
                                LblDiasSello.Text += " " + horas + " Horas";
                            }
                            string min = (c).ToString("mm");
                            if (min != "00")
                            {
                                if (dias != "00" || horas != "00")
                                    LblDiasSello.Text += ",";
                                LblDiasSello.Text += " " + min + " Minutos";
                            }
                            LblDiasSello.Text += ".";

                            //LblDiasSello.Text = "¡Importante! *Su CSD caduca en: "+ dias + " Dias, " + horas + " Horas y "+ min +" Minutos.";
                        }
                        if (ddlEmpresa.Items.Count > 1 && bloq)
                        {
                            ddlEmpresaE.Visible = true;
                            lblpop.Visible = true;
                        }
                        else
                        {
                            ddlEmpresaE.Visible = false;
                            lblpop.Visible = false;
                        }
                        this.mpeSellos.Show();
                    }
                }
            }
            catch (Exception ex)
            {
            }
        }

        protected void ddlTipoComprobante_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

          
       

       
      
        
        protected void AgregarImpuesto(string Partida, string TipoImpuesto, string Impuesto, string TipoFactor, string TasaOCuota)
        {
            List<facturasdetalle> detalles = ViewState["detalles"] as List<facturasdetalle>;
            List<facturasdetalleRT> detallesImpuestos = ViewState["detallesImpuestos"] as List<facturasdetalleRT>;
            string m = ViewState["DecimalMoneda"].ToString();
            int mon = 0;
            if (!string.IsNullOrEmpty(m))
                mon = Convert.ToInt16(m);
            if (ddlMoneda.SelectedValue == "MXN")
                mon = Convert.ToInt16(ddlDecimales.SelectedValue);

            foreach (var x in detalles)
            {
                if (x.Partida.ToString() == Partida)//quitando lo del codigo
                //  if(x.Codigo==ddlConceptos.SelectedValue)
                {
                    //---
                    string BaseConcepto = "";
                    if (x.Partida.ToString() == Partida)
                    {
                        if (x.ConceptoDescuento != null)
                            BaseConcepto = (x.Total - x.ConceptoDescuento).ToString();
                        else
                            BaseConcepto = x.Total.ToString();
                    }
                    //---
                    facturasdetalleRT DRT = new facturasdetalleRT();
                    DRT.Base = Decimal.Round(Convert.ToDecimal(BaseConcepto), 6);
                    // DRT.Importe = Convert.ToDecimal(txtImporte.Text);
                    //----
                    if (TipoFactor != "Exento" || TipoImpuesto != "Traslados") //no se llenan 
                    {
                        DRT.Importe = Decimal.Round(Convert.ToDecimal(BaseConcepto) * Convert.ToDecimal(TasaOCuota), mon);
                        DRT.TasaOCuota = TasaOCuota;
                    }
                    //--------------------
                    DRT.Impuesto = Impuesto;

                    DRT.TipoFactor = TipoFactor;
                    DRT.TipoImpuesto = TipoImpuesto;
                    DRT.ConceptoClaveProdServ = Partida;
                    if (TipoImpuesto == "Retenciones")
                    {
                        if (x.ConceptoRetenciones == null)
                            x.ConceptoRetenciones = new List<ServicioLocalContract.Entities.facturasdetalleRetencion>();
                        ServicioLocalContract.Entities.facturasdetalleRetencion retencion = new ServicioLocalContract.Entities.facturasdetalleRetencion();
                        retencion.Base = Decimal.Round(Convert.ToDecimal(BaseConcepto), 6);
                        retencion.Importe = Decimal.Round(Convert.ToDecimal(BaseConcepto) * Convert.ToDecimal(TasaOCuota), mon);
                        retencion.Impuesto = Impuesto;
                        retencion.TasaOCuota = TasaOCuota;

                        retencion.TipoFactor = TipoFactor;
                        x.ConceptoRetenciones.Add(retencion);
                    }
                    if (TipoImpuesto == "Traslados")
                    {
                        if (x.ConceptoTraslados == null)
                            x.ConceptoTraslados = new List<ServicioLocalContract.Entities.facturasdetalleTraslado>();
                        ServicioLocalContract.Entities.facturasdetalleTraslado traslados = new ServicioLocalContract.Entities.facturasdetalleTraslado();
                        traslados.Base = Decimal.Round(Convert.ToDecimal(BaseConcepto), 6);
                        if (TipoFactor != "Exento")
                        {
                            traslados.Importe = Decimal.Round(Convert.ToDecimal(BaseConcepto) * Convert.ToDecimal(TasaOCuota), mon);
                            traslados.TasaOCuota = TasaOCuota;
                        }

                        traslados.Impuesto = Impuesto;
                        traslados.TipoFactor = TipoFactor;
                        x.ConceptoTraslados.Add(traslados);
                    }
                    detallesImpuestos.Add(DRT);
                }


            }
            ViewState["detalles"] = detalles;

            ViewState["detallesImpuestos"] = detallesImpuestos;

            // this.gvImpuestos.DataSource = detallesImpuestos;
            // this.gvImpuestos.DataBind();

            //BindDetallesImpuestosToGridView();
            this.UpdateTotales();
            //     txtBase.Text = "";
            //     txtTasa.Text = "";
        }

        protected void bntCancelar_Click(object sender, EventArgs e)
        {

            //mpexConceptos.Hide();
            //UpdatePanel2.Update();
        }
        public void ActualizarSaldosMaster()
        {
            var sis = Session["idSistema"] as long?;

            if (sis != null)//---nuevo---
            {
                var cliente = NtLinkClientFactory.Cliente();
                using (cliente as IDisposable)
                {
                    var sistema = cliente.ObtenerSistemaById((int)sis.Value, true);
                    Session["SaldoEmision"] = sistema.SaldoEmision;
                    Session["SaldoTimbrado"] = sistema.SaldoTimbrado;
                    Session["Contratos"] = sistema.TimbresContratados;
                    var emision = Session["SaldoEmision"];
                    var timbrado = Session["SaldoTimbrado"];
                    var contratos = Session["Contratos"] ?? "0";

                    //Master.labelcontratos.Text = contratos.ToString();
                    //Master.labelEmision.Text = emision.ToString();
                    //Master.labeltimbrado.Text = timbrado.ToString();
                    //Master.panel.Update();

                }


            }

        }
        protected void ddlrfcemisor_SelectedIndexChanged1(object sender, EventArgs e)
        {

            if (ddlrfcemisor.SelectedItem.Text == "Seleccione")

            {

                txtRfcEmisorCtaOrd.Text = "";
                txtNomBancoOrdExt.Text = "";
                txtRfcEmisorCtaOrd.Visible = false;
            }


            if (ddlrfcemisor.SelectedItem.Text == "BMN930209927 - BANORTE")

            {

                txtRfcEmisorCtaOrd.Text = "BMN930209927";
                txtNomBancoOrdExt.Text = "Banorte";
                txtRfcEmisorCtaOrd.Visible = false;
            }
            if (ddlrfcemisor.SelectedItem.Text == "BNM840515VB1 - BANAMEX")

            {
                txtRfcEmisorCtaOrd.Text = "BNM840515VB1";
                txtNomBancoOrdExt.Text = "Banamex";
                txtRfcEmisorCtaOrd.Visible = false;
            }

            if (ddlrfcemisor.SelectedItem.Text == "BSM970519DU8 - SANTANDER")

            {
                txtRfcEmisorCtaOrd.Text = "BSM970519DU8";
                txtNomBancoOrdExt.Text = "Santander";
                txtRfcEmisorCtaOrd.Visible = false;


            }

            if (ddlrfcemisor.SelectedItem.Text == "BBA830831LJ2 - BANCOMER")

            {
                txtRfcEmisorCtaOrd.Text = "BBA830831LJ2";
                txtNomBancoOrdExt.Text = "Bancomer";
                txtRfcEmisorCtaOrd.Visible = false;


            }

            if (ddlrfcemisor.SelectedItem.Text == "HMI950125KG8 - HSBC")

            {
                txtRfcEmisorCtaOrd.Text = "HMI950125KG8";
                txtNomBancoOrdExt.Text = "HSBC";
                txtRfcEmisorCtaOrd.Visible = false;


            }

            if (ddlrfcemisor.SelectedItem.Text == "SIN9412025I4 - SCOTIABANK")

            {
                txtRfcEmisorCtaOrd.Text = "SIN9412025I4";
                txtNomBancoOrdExt.Text = "Scotiabank";
                txtRfcEmisorCtaOrd.Visible = false;


            }

            if (ddlrfcemisor.SelectedItem.Text == "Otro")

            {
                txtRfcEmisorCtaOrd.Visible = true;
                txtRfcEmisorCtaOrd.Text = "";
                txtNomBancoOrdExt.Text = "";




            }



        }
        
        protected void txtMonto_TextChanged(object sender, EventArgs e)
        {
            decimal result = ((decimal.Parse(txtMonto.Text)));

            //double dec = (double.Parse(txtMonto.Text)) + result;


            txtMonto.Text = result.ToString("0.00");

        }
        protected void ddlrfcben_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (ddlrfcben.SelectedItem.Text == "Seleccione")

            {

                txtRfcEmisorCtaBen.Text = "";
                txtRfcEmisorCtaBen.Visible = false;

            }


            if (ddlrfcben.SelectedItem.Text == "BMN930209927 - BANORTE")

            {

                txtRfcEmisorCtaBen.Text = "BMN930209927";
                txtRfcEmisorCtaBen.Visible = false;

            }
            if (ddlrfcben.SelectedItem.Text == "BNM840515VB1 - BANAMEX")

            {
                txtRfcEmisorCtaBen.Text = "BNM840515VB1";
                txtRfcEmisorCtaBen.Visible = false;


            }

            if (ddlrfcben.SelectedItem.Text == "BSM970519DU8 - SANTANDER")

            {
                txtRfcEmisorCtaBen.Text = "BSM970519DU8";
                txtRfcEmisorCtaBen.Visible = false;


            }

            if (ddlrfcben.SelectedItem.Text == "BBA830831LJ2 - BANCOMER")

            {
                txtRfcEmisorCtaBen.Text = "BBA830831LJ2";
                txtRfcEmisorCtaBen.Visible = false;


            }

            if (ddlrfcben.SelectedItem.Text == "HMI950125KG8 - HSBC")

            {
                txtRfcEmisorCtaBen.Text = "HMI950125KG8";
                txtRfcEmisorCtaBen.Visible = false;


            }

            if (ddlrfcben.SelectedItem.Text == "SIN9412025I4 - SCOTIABANK")

            {
                txtRfcEmisorCtaBen.Text = "SIN9412025I4";
                txtRfcEmisorCtaBen.Visible = false;

            }

            if (ddlrfcben.SelectedItem.Text == "Otro")

            {
                txtRfcEmisorCtaBen.Visible = true;
                txtRfcEmisorCtaBen.Text = "";




            }

        }

        protected void txtImpSaldoInsoluto_TextChanged(object sender, EventArgs e)
        {
            decimal result = ((decimal.Parse(txtImpSaldoInsoluto.Text)));

            //double dec = (double.Parse(txtMonto.Text)) + result;


            txtImpSaldoInsoluto.Text = result.ToString("0.00");
        }


        protected void txtImpPagado_TextChanged(object sender, EventArgs e)
        {
            decimal result = ((decimal.Parse(txtImpPagado.Text)));

            //double dec = (double.Parse(txtMonto.Text)) + result;


            txtImpPagado.Text = result.ToString("0.00");
        }

        protected void txtImpSaldoAnt_TextChanged(object sender, EventArgs e)
        {
            decimal result = ((decimal.Parse(txtImpSaldoAnt.Text)));

            //double dec = (double.Parse(txtMonto.Text)) + result;


            txtImpSaldoAnt.Text = result.ToString("0.00");
        }

        protected void ddlMonedaP_SelectedIndexChanged(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                if (ddlMonedaP.SelectedValue == "0")
                {


                    List<CatalogosSAT.c_Moneda> cu = cliente.Consultar_MonedaAll();
                    cu = cliente.Consultar_MonedaAll().Select(
                p =>
                new CatalogosSAT.c_Moneda()
                {
                    c_Moneda1 = p.c_Moneda1,
                    Descripción = p.Descripción,



                }).ToList();


                    ddlMonedaP.DataSource = cu.OrderBy(p => p.Descripción);



                    ddlMonedaP.DataTextField = "Descripción";
                    ddlMonedaP.DataValueField = "c_Moneda1";
                    ddlMonedaP.DataBind();
                    ddlMonedaP.SelectedValue = "MXN";
                }
                if (this.ddlMoneda.SelectedValue != "MXN")
                {
                    this.txtTipoCambioP.Visible = true;
                    this.lblTipoCambioP.Visible = true;
                    this.txtTipoCambioDR.Text = "1";

                    CatalogosSAT.Divisas D = cliente.Consultar_TipoDivisa(this.ddlMonedaP.SelectedValue);
                    if (D != null)
                        txtTipoCambioP.Text = D.PesosDivisa.ToString();
                    else
                        txtTipoCambioP.Text = "";


                }
                else
                {
                    txtTipoCambioP.Text = "";

                    this.txtTipoCambioP.Visible = false;
                    this.lblTipoCambioP.Visible = false;
                }
            }
        }

        protected void ddlrfcemisor_SelectedIndexChanged(object sender, EventArgs e)

        {





        }
        protected void txtRfcEmisorCtaOrd_TextChanged(object sender, EventArgs e)
        {

        }


        protected void gvPagos_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        
        protected void btnAgregarPagos_Click(object sender, EventArgs e)
        {
            List<Pagos> pagos = ViewState["Pagos"] as List<Pagos>;
            int t = pagos.Count();

            Pagos p = new Pagos();
            p.id = (t + 1).ToString();
            p.cadPago = txtCadPago.Text;
            p.certPago = txtCertPago.Text;
            p.ctaBeneficiario = txtCtaBeneficiario.Text;
            p.ctaOrdenante = txtCtaOrdenante.Text;

            p.fechaPago =/* txtFechaPago.Text = */txtFechaPagoP.Text;
            DateTime s = Convert.ToDateTime(p.fechaPago);
            TimeSpan ts = new TimeSpan(12, 0, 0);
            s = s.Date + ts;
            p.fechaPago = s.ToString();
            p.formaDePagoP = ddlFormaPagoP.SelectedValue;
            p.monedaP = ddlMonedaP.SelectedValue;
            p.monto = txtMonto.Text;
            p.nomBancoOrdExt = txtNomBancoOrdExt.Text;
            p.numOperacion = txtNumOperacion.Text;
            p.rfcEmisorCtaBen = txtRfcEmisorCtaBen.Text;

            p.rfcEmisorCtaOrd = txtRfcEmisorCtaOrd.Text;
            p.selloPago = txtSelloPago.Text;
            p.tipoCadPago = ddlTipoCadPago.SelectedValue;
            p.tipoCambioP = txtTipoCambioP.Text;

            ddlID.Items.Add(p.id);

            pagos.Add(p);
            ViewState["Pagos"] = pagos;
            BindPagosToGridView();
            //  this.UpdateTotales();
            txtFechaPagoP.Text = "";
            txtMonto.Text = "";
            //txtRfcEmisorCtaOrd.Text = "";
            txtCtaOrdenante.Text = "";
            txtCtaBeneficiario.Text = "";
            txtCertPago.Text = "";
            txtSelloPago.Text = "";
            txtTipoCambioP.Text = "";
            txtNumOperacion.Text = "";
            txtNomBancoOrdExt.Text = "";
            txtRfcEmisorCtaBen.Text = "";

            txtCadPago.Text = "";






        }

        protected void gvPagos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("EliminarPago"))
            {
                var pagos = ViewState["Pagos"] as List<Pagos>;
                var documentos = ViewState["PagoDoctoRelacionado"] as List<PagoDoctoRelacionado>;
                Pagos dt = pagos.ElementAt(Convert.ToInt32(e.CommandArgument));
                string x = dt.id;
                pagos.RemoveAt(Convert.ToInt32(e.CommandArgument));
                ddlID.Items.Remove(x);
                ViewState["Pagos"] = pagos;

                documentos.RemoveAll(p => p.ID == x);
                ViewState["PagoDoctoRelacionado"] = documentos;
                BindPagosToGridView();
                this.BindDocumentosToGridView();
                UpdateTotales();
            }

        }
        private void BindPagosToGridView()
        {
            List<Pagos> pagos = ViewState["Pagos"] as List<Pagos>;

            if (pagos != null && pagos.Count > 0)
            {
                int noColumns = this.gvPagos.Columns.Count;
                this.gvPagos.Columns[noColumns - 1].Visible = this.gvPagos.Columns[noColumns - 2].Visible = true;
            }
            else
            {
                int noColumns = this.gvPagos.Columns.Count;
                this.gvPagos.Columns[noColumns - 1].Visible = this.gvPagos.Columns[noColumns - 2].Visible = false;
            }


            this.gvPagos.DataSource = pagos;
            this.gvPagos.DataBind();
        }

        private void BindDocumentosToGridView()
        {
            List<PagoDoctoRelacionado> documentos = ViewState["PagoDoctoRelacionado"] as List<PagoDoctoRelacionado>;


            if (documentos != null && documentos.Count > 0)
            {
                int noColumns = this.gvDocumento.Columns.Count;
                this.gvDocumento.Columns[noColumns - 1].Visible = this.gvDocumento.Columns[noColumns - 2].Visible = true;
            }
            else
            {
                int noColumns = this.gvDocumento.Columns.Count;
                this.gvDocumento.Columns[noColumns - 1].Visible = this.gvDocumento.Columns[noColumns - 2].Visible = false;
            }


            this.gvDocumento.DataSource = documentos;
            this.gvDocumento.DataBind();
        }
        //-------------------------------------------------------------------------------

        protected void ddlMonedaDR_SelectedIndexChanged(object sender, EventArgs e)
        {
            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                if (ddlMonedaDR.SelectedValue == "0")
                {


                    List<CatalogosSAT.c_Moneda> cu = cliente.Consultar_MonedaAll();
                    cu = cliente.Consultar_MonedaAll().Select(
                p =>
                new CatalogosSAT.c_Moneda()
                {
                    c_Moneda1 = p.c_Moneda1,
                    Descripción = p.Descripción,



                }).ToList();


                    ddlMonedaDR.DataSource = cu.OrderBy(p => p.Descripción);



                    ddlMonedaDR.DataTextField = "Descripción";
                    ddlMonedaDR.DataValueField = "c_Moneda1";
                    ddlMonedaDR.DataBind();
                    ddlMonedaDR.SelectedValue = "MXN";
                }

                if (this.ddlMonedaDR.SelectedValue != "MXN")
                {
                    this.txtTipoCambioDR.Visible = true;
                    this.lblTipoCambioDR.Visible = true;

                    CatalogosSAT.Divisas D = cliente.Consultar_TipoDivisa(this.ddlMonedaDR.SelectedValue);
                    if (D != null)
                        txtTipoCambioDR.Text = D.PesosDivisa.ToString();
                    else
                        txtTipoCambioDR.Text = "";


                }
                else
                {
                    txtTipoCambioDR.Text = "";

                    this.txtTipoCambioDR.Visible = false;
                    this.lblTipoCambioDR.Visible = false;
                }
            }
        }

        protected void ddlID_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gvDocumento_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("EliminarDocumento"))
            {
                var documentos = ViewState["PagoDoctoRelacionado"] as List<PagoDoctoRelacionado>;

                PagoDoctoRelacionado dt = documentos.ElementAt(Convert.ToInt32(e.CommandArgument));
                documentos.RemoveAt(Convert.ToInt32(e.CommandArgument));
                ViewState["PagoDoctoRelacionado"] = documentos;
                this.BindDocumentosToGridView();

                //this.UpdateTotales();

            }

        }

        protected void btnAgregarDocumento_Click(object sender, EventArgs e)
        {
            //List<Pagos> pagos = ViewState["Pagos"] as List<Pagos>;
            List<PagoDoctoRelacionado> documentos = ViewState["PagoDoctoRelacionado"] as List<PagoDoctoRelacionado>;

            PagoDoctoRelacionado Docum = new PagoDoctoRelacionado();
            Docum.Folio = txtFolioD.Text;
            Docum.IdDocumento = txtIdDocumento.Text;
            Docum.ImpPagado = txtImpPagado.Text;
            Docum.ImpSaldoAnt = txtImpSaldoAnt.Text;
            Docum.ImpSaldoInsoluto = txtImpSaldoInsoluto.Text;
            Docum.MetodoDePagoDR = ddlMetodoDePagoDR.SelectedValue;
            Docum.MonedaDR = ddlMonedaDR.SelectedValue;
            Docum.NumParcialidad = txtNumParcialidad.Text;
            Docum.Serie = txtSerieD.Text;
            Docum.TipoCambioDR = txtTipoCambioDR.Text;
            Docum.ID = ddlID.SelectedValue;
            //  if (x.DoctoRelacionado == null)
            //   x.DoctoRelacionado = new List<PagoDoctoRelacionado>();
            //   x.DoctoRelacionado.Add(Docum);
            documentos.Add(Docum);
            //      ViewState["Pagos"] = pagos;
            ViewState["PagoDoctoRelacionado"] = documentos;

            BindDocumentosToGridView();

            txtIdDocumento.Text = "";
            txtFolioD.Text = "";
            txtNumParcialidad.Text = "";
            txtImpPagado.Text = "";
            txtSerieD.Text = "";
            txtTipoCambioDR.Text = "";
            txtImpSaldoAnt.Text = "";
            txtImpSaldoInsoluto.Text = "";
            DRcb.Checked = true;
        }

        //protected void cbDoctoRelacionado_CheckedChanged(object sender, EventArgs e)
        //{
        //    if (cbDoctoRelacionado.Checked == true)
        //    {
        //        DivDoctoRelacionado.Visible = true;
        //    }
        //    else
        //        DivDoctoRelacionado.Visible = false;

        //}
        
        protected void ddlMetodoDePagoDR_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        //--------------------------------

        protected void ddlDecimales_SelectedIndexChanged(object sender, EventArgs e)
        {
            string dec = ViewState["DecimalActual"] as string;
            if ((ViewState["detalles"] as List<facturasdetalle>).Count == 0 && ddlMoneda.SelectedValue == "MXN")
            {
                string z = ddlDecimales.SelectedValue;
                ViewState["DecimalActual"] = z;
            }
            else
            {
                ddlDecimales.SelectedValue = dec;
            }

        }

    }
}