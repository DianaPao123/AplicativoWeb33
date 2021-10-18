
using ServicioLocalContract;
using ServicioLocalContract.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Pagos = ServicioLocalContract.Entities.Pagos;

namespace Ntlink33
{
    public partial class wfrFacturaCompPagos : Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

           // ScriptManager.GetCurrent(this.Page).RegisterPostBackControl(this.BtnVistaPreviaP);

            //  txtCodigo.Attributes.Add("onkeypress", "javascript:return SoloNum(event); ");

            if (!IsPostBack)
            {
        //        ddlClaveUnidadE.Style.Remove("width");

               try
                {
                    //DivCfdiRelacionados.Attributes.Add("style", "display:none;");
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
                       // this.ddlEmpresaE.DataSource = listaEmpresas;
                       // this.ddlEmpresaE.DataBind();


                        int idEmpresa = idEmpresaE = listaEmpresas.First().IdEmpresa;

                        if (!cliente.TieneConfiguradoCertificado(idEmpresa))
                        {
                            this.lblError.Text = "Tienes que configurar tus certificados antes de poder facturar";
                            this.btnGenerarFactura.Enabled = this.BtnVistaPreviaP.Enabled  
                                 =  false;
                            return;
                        }

                        if (listaEmpresas.Count > 0)
                        {
                        
                            this.ddlClientes.DataSource = cliente.ListaClientes(perfil, idEmpresa, string.Empty, false);
                            this.ddlClientes.DataBind();
                          //  this.ddlClientes.Items.Insert(0, "");


                            this.txtFolio.Text = cliente.SiguienteFolioFactura(idEmpresa);
                            this.txtFolioSat.Text = txtFolio.Text;
                            ddlClientes_SelectedIndexChanged(null, null);
                                                       
                        }

                        this.ddlSucursales.DataSource = cliente.ListaSucursales(idEmpresa);
                        ddlSucursales.DataValueField = "LugarExpedicion";
                        ddlSucursales.DataTextField = "Nombre";

                        this.ddlSucursales.DataBind();

                        //------------catalogos grandes----------------------


                        //--------------------------------------------
                        //Filtro_Moneda();
                        //ddlMoneda.DataSource = cliente.Consultar_MonedaAll().OrderBy(p => p.Descripción);
                        //ddlMoneda.DataTextField = "Descripción";
                        //ddlMoneda.DataValueField = "c_Moneda1";
                        //ddlMoneda.DataBind();
                        //ddlMoneda.SelectedValue = "MXN";
                        //Filtro_Moneda();

                        ddlMonedaDR.DataSource = cliente.Consultar_MonedaAll().OrderBy(p => p.Descripción);
                        ddlMonedaDR.DataTextField = "Descripción";
                        ddlMonedaDR.DataValueField = "c_Moneda1";
                        ddlMonedaDR.DataBind();
                        ddlMonedaDR.SelectedValue = "MXN";
                        ddlMonedaP.DataSource = cliente.Consultar_MonedaAll().OrderBy(p => p.Descripción);
                        ddlMonedaP.DataTextField = "Descripción";
                        ddlMonedaP.DataValueField = "c_Moneda1";
                        ddlMonedaP.DataBind();
                        ddlMonedaP.SelectedValue = "MXN";
                        Filtro_MonedaDR();
                        Filtro_Moneda();
                        CatalogosSAT.c_Moneda mone = cliente.Consultar_Moneda("MXN");
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
                    ViewState["DecimalActual"] = "2";
                    ViewState["Pagos"] = new List<Pagos>();
                    ViewState["PagoDoctoRelacionado"] = new List<PagoDoctoRelacionado>();



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
                if (this.ddlMonedaP.SelectedValue != "MXN")
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

           

            txtIdDocumento.Text = "";
            txtFolioD.Text = "";
            txtNumParcialidad.Text = "";
            txtImpPagado.Text = "";
            txtSerieD.Text = "";
            txtTipoCambioDR.Text = "";
            txtImpSaldoAnt.Text = "";
            txtImpSaldoInsoluto.Text = "";
            DRcb.Checked = true;
            BindDocumentosToGridView();
        }

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

        protected void btnGenerarFactura_Click(object sender, EventArgs e)
        {

           // mpexFac.Show();
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), " ShowPopup",
                           "$('#MainContent_ModalConfirmar').modal('show'); "+
                                "$('body').css('padding-right', '0px'); ", true);

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

            if (!ValidarFactura())
            {
                btnGenerarFactura.Enabled = true;

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), " ShowPopup",
                       "$('#MainContent_ModalError').modal('show') ", true);
                return;
            }
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
                        { x.DoctoRelacionado = new List<PagoDoctoRelacionado>();
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
                     if (ss.resultado)
                    {
                        this.lblError.Text = string.Empty;
                        Session["UUDINuevo"] = "";
                        string x = ss.UUDI;
                        Session["UUDINuevo"] = x;

                        this.ClearAll();
                        UpdatePanelR2.Update();
                        UpdatePanelR4.Update();
                        UpdatePanelR10.Update();
                    }
                    else
                        error = true;
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
                this.lblError.Text = "Error al generar el comprobante:" + ae.Message;
            }
                if (!error)
                {
                    this.lblOK2.Text = "Comprobante generado correctamente  y enviado por correo electrónico";

                    ActualizarSaldosMaster();
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), " ShowPopup",
                    "$('#MainContent_ModalOK').modal('show') ", true);
                    
                }
                else
                {
                    btnGenerarFactura.Enabled = true;
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), " ShowPopup",
                     "$('#MainContent_ModalError').modal('show') ", true);

                }
           
        }


        private void Clear()
        {

        }

        private void ClearAll()
        {
            this.Clear();
           // cbImpuestos.Visible = false;
            this.txtProyecto.Text =
              /*  this.txtFolioOriginal.Text = this.txtFechaOriginal.Text = this.txtMontoOriginal.Text = */
                this.txtFolioSat.Text =
             txtProyecto.Text = this.txtSerie.Text = string.Empty;
            this.lblTraslados.Text = 0M.ToString("C");
            this.lblRetenciones.Text = 0M.ToString("C");

            //this.txtdsc.Text = " ";

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

            ViewState["Pagos"] = new List<Pagos>();
            ViewState["PagoDoctoRelacionado"] = new List<PagoDoctoRelacionado>();

            BindDocumentosToGridView();
            BindPagosToGridView();
            this.BindCfdiRelacionadoToGridView();

            var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                int idEmpresa = int.Parse(this.ddlEmpresa.SelectedValue);
                this.txtFolio.Text = cliente.SiguienteFolioFactura(idEmpresa);
                this.txtFolioSat.Text = txtFolio.Text;

            }
         
            
        }

        private bool Validar()
        {


            return true;
        }

        //protected void ddlMoneda_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    var cliente = NtLinkClientFactory.Cliente();
        //    using (cliente as IDisposable)
        //    {


        //        if (ddlMoneda.SelectedValue == "0")
        //        {


        //            List<CatalogosSAT.c_Moneda> cu = cliente.Consultar_MonedaAll();
        //            cu = cliente.Consultar_MonedaAll().Select(
        //        p =>
        //        new CatalogosSAT.c_Moneda()
        //        {
        //            c_Moneda1 = p.c_Moneda1,
        //            Descripción = p.Descripción,



        //        }).ToList();


        //            ddlMoneda.DataSource = cu.OrderBy(p => p.Descripción);
                    

        //            ddlMoneda.DataTextField = "Descripción";
        //            ddlMoneda.DataValueField = "c_Moneda1";
        //            ddlMoneda.DataBind();
        //            ddlMoneda.SelectedValue = "MXN";
        //        }

        //        if (this.ddlMoneda.SelectedValue != "MXN")
        //        {
        //            this.txtTipoCambio.Visible = true;
        //            this.lblTipoCambio.Visible = true;

        //            this.txtConfirmacion.Visible = true;//c
        //            this.LblConfirmacion.Visible = true;//c

        //            CatalogosSAT.Divisas D = cliente.Consultar_TipoDivisa(this.ddlMoneda.SelectedValue);
        //            if (D != null)
        //                txtTipoCambio.Text = D.PesosDivisa.ToString();
        //            else
        //                txtTipoCambio.Text = "";


        //        }
        //        else
        //        {
        //            txtTipoCambio.Text = "";

        //            this.txtTipoCambio.Visible = false;
        //            this.lblTipoCambio.Visible = false;

        //            this.txtConfirmacion.Visible = false;//c
        //            this.LblConfirmacion.Visible = false;//c
        //        }
        //    }
        //}

        //protected void cbCfdiRelacionados_CheckedChanged(object sender, EventArgs e)
        //{
        //    if (cbCfdiRelacionados.Checked == true)
        //    {
        //        DivCfdiRelacionados.Attributes.Add("style", "display:block;");
        //    }
        //    else
        //    {
        //        DivCfdiRelacionados.Attributes.Add("style", "display:none;");

        //    }
        //}
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
        protected void gvBuscarConceptosHistorico_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            LinkButton lb = e.Row.FindControl("gvlnkEditar") as LinkButton;
            if (lb != null)
                ScriptManager.GetCurrent(this).RegisterAsyncPostBackControl(lb);
        }
        protected void gvBuscarConceptos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            LinkButton lb = e.Row.FindControl("gvlnkEditar") as LinkButton;
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
                //mpex.Show();
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), " ShowPopup",
                  "$('#MainContent_ModalEliminarReacionados').modal('show') ", true);

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

                //mpex.Hide();
                //UpdatePanel1.Update();
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Pop",
                 "$('#MainContent_ModalEliminarReacionados').modal('hide');", true);


            }
        }

        protected void lnkDeleteFac_Click(object sender, EventArgs e)
        {
            btnGenerarFactura.Enabled = false;
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Pop",
                "$('#MainContent_ModalConfirmar').modal('hide');", true);
            //mpexFac.Hide();
            //up1.Update();
            this.GuardarFactura();
            btnGenerarFactura.Enabled = true;


        }
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
                    
           ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), " ShowPopup",
                " document.getElementById('" + txtRFCBus.ClientID + "').value = '';" +
                      "$('#MainContent_ModalBuscarRFC').modal('show') ", true);

   
        }

        protected void btnBuscarRFC_Click(object sender, EventArgs e)
        {
          
            //ModalPopupRFC.Hide();
            var cliente = NtLinkClientFactory.Cliente();
            if (string.IsNullOrEmpty(this.ddlEmpresa.SelectedValue))

                return;

            using (cliente as IDisposable)
            {
                int idEmpresa = int.Parse(this.ddlEmpresa.SelectedValue);
                clientes c = cliente.ObtenerClienteByRFC(txtRFCBus.Text,idEmpresa);
                if (c != null)
                {
                    ddlClientes.SelectedValue = c.idCliente.ToString();
                    ddlClientes_SelectedIndexChanged(null, null);
                }
            }
            txtRFCBus.Text = "";
            //  up1.Update();
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Pop",
                 "$('#MainContent_ModalBuscarRFC').modal('hide');", true);



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

            /*  int idEmpresa = int.Parse(this.ddlEmpresa.SelectedValue);
              var emp = cliente.ObtenerEmpresaById(idEmpresa);

              if (emp.RFC == "CEJ060126UI2" || emp.RFC == "BTE1209279P8" || emp.RFC == "ASN1211077Y2" || emp.RFC == "SID080303VE0")
              {
                  this.lblIva.Text = iva.ToString("#0.00##", cul);
                  this.lblTotal.Text = total.ToString("#0.00##", cul);
                  this.lblSubtotal.Text = subtotal.ToString("#0.00##", cul);
              }
              else
              {*/
            this.lblDescuento.Text = descuento1.ToString("C", cul);
            this.lblRetenciones.Text = retenciontotal.ToString("C", cul);
            this.lblTraslados.Text = trasladototal.ToString("C", cul);

            this.lblTotal.Text = total.ToString("C", cul);
            this.lblSubtotal.Text = subtotal.ToString("C", cul);
            //     }
        }



        //--seccion de impuestos----------------------------------------------------------------------------------------
        private void AgregarIVA(string partida)
        {

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
            if ((ViewState["PagoDoctoRelacionado"] as List<PagoDoctoRelacionado>).Count == 0)
            {
                this.lblError.Text = "Por favor Agregue los Datos del Documento Relacionado";
               

                return false;
            }
            if (string.IsNullOrEmpty(this.txtFolio.Text))
            {
                this.lblError.Text = "Escribe el folio de la factura";
              

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

            // UpdatePanel7.Update();
            if (!ValidarFactura())
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), " ShowPopup",
                "$('#MainContent_ModalError').modal('show') ", true);

                return;
            }

            var pdf = Preview();

            if (pdf == null)
            {
                if (string.IsNullOrEmpty(this.lblError.Text))

                    this.lblError.Text = "Error al generar vista previa";
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), " ShowPopup",
                    "$('#MainContent_ModalError').modal('show') ", true);



                return;
            }
            else
            {

                 // this.lblOK.Text = "Comprobante Previo generado correctamente";
                 //  mpMensajeOK.Show();
                // UpdatePanel7.Update();

                Session["cacheKey"] = pdf;
                MyIframe.Attributes["src"] = "PDF.aspx";

                return;
            }

            //HttpResponse currentResponse = HttpContext.Current.Response;
            //currentResponse.Clear();
            //currentResponse.ContentType = "application/octet-stream";
            //currentResponse.AppendHeader("Content-Disposition", "attachment; filename=preview.pdf");
            ////  currentResponse.BinaryWrite(pdf);
            //currentResponse.Write("pdf");
            //currentResponse.Flush();
            //currentResponse.End();
            

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
                        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), " ShowPopup",
                       "$('#MainContent_ModalError').modal('show') ", true);

                        //mpMensajeError.Show();
                        // UpdatePanel7.Update();
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
            if (error)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), " ShowPopup",
                "$('#MainContent_ModalError').modal('show') ", true);


                // this.lblOK.Text = "Comprobante generado correctamente";
                // mpMensajeOK.Show();
                // UpdatePanel7.Update();
                return null;
            }
            //this.lblError.Text = string.Empty;
           // mpMensajeError.Show();
            //UpdatePanel7.Update();

            return null;
        }
        private facturas GetFactura(string iniciales, List<facturasdetalle> detalles)
        {
            var fact = new facturas
            {
                TipoDocumento = TipoDocumento.FacturaGeneral,
                TipoDeComprobante = "P",
                IdEmpresa = int.Parse(this.ddlEmpresa.SelectedValue),
                Importe = decimal.Parse(this.lblTotal.Text, NumberStyles.Currency),
                SubTotal = decimal.Parse("0"),
                Total = decimal.Parse("0"),
                PorcentajeIva = 16,
                MonedaID = "XXX", //this.ddlMoneda.SelectedValue,
                idcliente = int.Parse(this.ddlClientes.SelectedValue),
                Fecha = DateTime.Now,
                Folio = this.txtFolioSat.Text,//this.txtFolio.Text.PadLeft(4, '0'),
                FolioSAT = this.txtFolio.Text.PadLeft(4, '0'),
                Serie = string.IsNullOrEmpty(this.txtSerie.Text) ? null : this.txtSerie.Text,
                nProducto = detalles.Count,
                captura = DateTime.Now,
                Cancelado = 0,
                Usuario = iniciales,
                LugarExpedicion = this.ddlSucursales.SelectedValue,
                Proyecto = this.txtProyecto.Text,

                MonedaS = "XXX",//this.ddlMoneda.SelectedItem.Text,
              
                UsoCFDI = "P01"

            };

      

            /* Checar si va o no---------------------------------------------------------------------
            if (!string.IsNullOrEmpty(txtFolioOriginal.Text))
            {
                fact.Fecha = DateTime.ParseExact(txtFechaOriginal.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                fact.FolioFiscalOriginal = txtFolioOriginal.Text;
                fact.SerieFolioFiscalOriginal = txtSerieOriginal.Text;
                fact.MontoFolioFiscalOriginal = Decimal.Parse(txtMontoOriginal.Text);
            }*/

            fact.Fecha = DateTime.Now;

            List<string> CfdiRelacionado = ViewState["CfdiRelacionado"] as List<string>;

            if (CfdiRelacionado != null)
                if (CfdiRelacionado.Count() > 0)
                {
                    fact.UUID = CfdiRelacionado;
                    fact.TipoRelacion = ddlTipoRelacion.SelectedValue;
                }

            //if (ddlMoneda.SelectedValue == "MXN")
                fact.NumeroDecimal = ddlDecimales.SelectedValue;

            return fact;
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            // ClearAll();

            this.ClearAll();
            UpdatePanelR2.Update();
            UpdatePanelR4.Update();
          
            UpdatePanelR10.Update();
     
            //Response.Redirect("wfrFactura.aspx");

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
                    this.btnGenerarFactura.Enabled = this.BtnVistaPreviaP.Enabled = false;
                   
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
                this.btnGenerarFactura.Enabled = this.BtnVistaPreviaP.Enabled = true;
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
                   // lblVencimiento.ForeColor = System.Drawing.Color.Red;//-------->
                    this.lblVencimiento.Text = "Su CSD caduca el dia: " + FechaVenceString;
                    /*
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
                       // this.mpeSellos.Show();
                       
                    }*/
                }
            }
            catch (Exception ex)
            {
            }
        }
        
        protected void ddlTipoComprobante_SelectedIndexChanged(object sender, EventArgs e)
        {
            
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





        protected void ddlClaveUnidad_SelectedIndexChanged(object sender, EventArgs e)
        {
            //if (ddlClaveUnidad.SelectedValue == "0")
            //{
            //    var cliente = NtLinkClientFactory.Cliente();
            //    List<CatalogosSAT.c_ClaveUnidad> cu = cliente.ConsultarClaveUnidadAll();
            //    cu = cliente.ConsultarClaveUnidadAll().Select(
            //            p =>
            //            new CatalogosSAT.c_ClaveUnidad()
            //            {
            //                Nombre = p.Nombre + " - " + p.c_ClaveUnidad1,
            //                c_ClaveUnidad1 = p.c_ClaveUnidad1,
            //                Descripcion = p.Nombre

            //            }).ToList();

            //    ddlClaveUnidad.DataSource = cu.OrderBy(p => p.Descripcion);
            //    //ddlClaveUnidad.DataSource = cliente.ConsultarClaveUnidadAll().OrderBy(p => p.Nombre);
            //    ddlClaveUnidad.DataTextField = "Nombre";
            //    ddlClaveUnidad.DataValueField = "c_ClaveUnidad1";
            //    ddlClaveUnidad.DataBind();
            //    ddlClaveUnidad.SelectedValue = "H87";
            //}

        }


        /*
        protected void descuento_CheckedChanged(object sender, EventArgs e)
        {
            txtdsc.Text = "";
            if (descuento.Enabled == true)
            {
                if(!string.IsNullOrEmpty( txtPrecio.Text)&& !string.IsNullOrEmpty(txtCantidad.Text))
                txtdsc.Enabled = true;
                else
                    txtdsc.Enabled = false;
            }
            else
            {

                txtdsc.Enabled = false;
            }
        }

        protected void txtdsc_TextChanged(object sender, EventArgs e)
        {
            decimal result = ((decimal.Parse(txtdsc.Text) / 100));

            decimal total = (decimal.Parse(txtPrecio.Text) * decimal.Parse(txtCantidad.Text));

            decimal descuento = Decimal.Round((total * result), 2);


            txtDescuento.Text = descuento.ToString();

        }
        */
     
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

              
                }


            }

        }
        protected void ddlDecimales_SelectedIndexChanged(object sender, EventArgs e)
        {
            string dec = ViewState["DecimalActual"] as string;
            if ((ViewState["detalles"] as List<facturasdetalle>).Count == 0 )
            {
                string z = ddlDecimales.SelectedValue;
                ViewState["DecimalActual"] = z;
            }
            else
            {
                ddlDecimales.SelectedValue = dec;
            }

        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {

       
            //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Pop",
            //  "$('#MainContent_ModalOK').modal('hide');", true);
                       
            string uudi = Session["UUDINuevo"].ToString();
           // string uudi = "E581633B-5889-4D09-B90E-933DA9DEB0701";
                  var cliente = NtLinkClientFactory.Cliente();
            using (cliente as IDisposable)
            {
                 var pdf = cliente.FacturaPdf(uudi);
                if (pdf == null)
                {
                

                    this.lblError.Text = "PDF no encontrado,consulte con el Administrador";
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), " ShowPopup",
                      "$('body').css('padding-right', '0px'); "+
                     "$('#MainContent_ModalError').modal('show') ", true);
                   
                }
                else
                {

                   

                    Session["cacheKey"] = pdf;
                    MyIframe.Attributes["src"] = "PDF.aspx";

                    UpdatePanelR100.Update();
                  
                    Session["UUDINuevo"] = "";
                }
            }
        }

      
    }
}