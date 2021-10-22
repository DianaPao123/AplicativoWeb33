<%@ Page Title="CFDI 3.3" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrFactura.aspx.cs" MaintainScrollPositionOnPostBack="true" Inherits="Ntlink33.wfrFactura"  EnableEventValidation="false" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
 <%@ MasterType VirtualPath="~/Site.Master" %>
 

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
   
 
  <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server" />

<%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />--%>

 <link href="template/css/Checkbox.css" rel="stylesheet" />    


<%--  <link href="Content/Mensajes.css" rel="stylesheet" />--%>


<script type="text/javascript">

    
$(document).ready(function () {
    $('.drpCountryRGV').selectpicker({
        //style: 'btn-info',
        size: 8
    });   

});

function pageLoad() {
    $('.drpCountryRGV').selectpicker({
        //style: 'btn-info',
        size: 8
    });

};



//  $(function () {
//    ApplySelectPicker();
//});
////On UpdatePanel Refresh
//var prm = Sys.WebForms.PageRequestManager.getInstance();
//if (prm != null) {
//    prm.add_endRequest(function (sender, e) {
//        if (sender._postBackSettings.panelsToUpdate != null) {
//            ApplySelectPicker();
//        }
//    });
//};
//function ApplySelectPicker() {
//    $('.drpCountryRGV').selectpicker({
//        //style: 'btn-light',
//        size: 8
        
//    });
//};

  


     function ShowPopup() {
            $('#MainContent_ModalConfirmar').modal('show');
            return false;
    }
       function HideModal() {
            $('#MainContent_ModalConfirmar').modal('hide');
            return false;
    }
    
      function HideModal2() {
            $('#MainContent_ModalOK').modal('hide');
            return false;
    }

    </script>

            <style type="text/css">
                .anchoDrop {
                    width:89px;
                }
        .overrideClass
        {
            left: 0px !important;
            top: 0px !important;
        }

        .bootstrap-select:not([class*=col-]):not([class*=form-control]):not(.input-group-btn) {
    width: 100%;
}
                
                .bootstrap-select.btn-group .dropdown-menu.inner {
                max-width:300px;
                
                }

              .optionAlinear {
   text-align:left;   
}
.bootstrapRGV-select:not([class*=col-]):not([class*=form-control]):not(.input-group-btn) {
    width: 89%;
}

    </style>
      

   
   
    <%-- progress--%>

      <asp:UpdatePanel ID="UpdatePanelR12" runat="server"  UpdateMode="Conditional"  >
    <ContentTemplate>
 
          <asp:UpdateProgress ID="UpdateProgress2" runat="server"  >
<ProgressTemplate>
     <div class="overlay" />
            <div class="overlayContent">
            <img alt="" src="Imagen/ajax-loader.gif" />
         </div>
    
</ProgressTemplate>
</asp:UpdateProgress>
     
    </ContentTemplate>
            </asp:UpdatePanel>
         <%-- progress--%>
    
     <div  class = "card mt-1">   
            <div class="card-header">
               <h3> Generar CFDI 3.3</h3>
            </div>
            <br />
                 <div class="panel panel-default" style="width:100%">
	  
          <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#Acordion1">
         <span data-toggle="collapse" class="icon pull-right"><em class=" glyphicon glyphicon-s glyphicon-plus fa-lg" style="font-size: 14px" ></em></span>
              <h4 class="panel-title">
            <a>
                <b>    Datos Generales</b>
            </a>
          </h4>
          </div>
		 
        <div id="Acordion1" class="panel-collapse collapse ">
          <div class="panel-body">
             <asp:UpdatePanel ID="UpdatePanelR2" runat="server"  UpdateMode="Conditional"  >
                     <ContentTemplate>
    
                <div class = "row form-group"> <%--Empresa--%>
                                     
        <div class="col-lg-6">
         <asp:Label  class="control-label" ID="lbEmpresa" runat="server" Text="Empresa"></asp:Label>
          <asp:DropDownList ID="ddlEmpresa"  runat="server" Width="100%" AutoPostBack="True"
              OnSelectedIndexChanged="ddlEmpresa_SelectedIndexChanged"  backColor="White"
              CssClass ="btn btn-default dropdown-toggle optionAlinear" data-live-search-style="begins" 
              DataTextField="RazonSocial" DataValueField="idEmpresa"  >
                  
             </asp:DropDownList>

        </div>
                     
                     <div class="col-lg-3 " style="color:red;" >
                            <asp:Label ID="lblVencimiento" class="control-label " ForeColor="#ffc107" runat="server" Font-Bold="true" style=" font-size: x-small; text-align: left; font-variant: small-caps;" Width="250px"></asp:Label>
                    </div>

                </div>  
             
                <div class = "row form-group">
                      <div class = "col-lg-6">
                
                    <asp:UpdatePanel ID="UpdatePanelR1" runat="server" UpdateMode="Conditional">
                       <ContentTemplate>                      
                        <asp:Label  class="control-label" ID="lblCliente" runat="server" Text="Cliente"  ></asp:Label>

                           <div class="form-inline" style="width:100%">
                                <asp:DropDownList ID="ddlClientes" runat="server" 
                            CssClass ="drpCountryRGV bootstrapRGV"  data-live-search-style="begins" title="Seleccione"
                                    data-live-search="true" 
                                    OnSelectedIndexChanged="ddlClientes_SelectedIndexChanged"
                            DataTextField="RazonSocial"  AutoPostBack="True"  DataValueField="idCliente">
                           </asp:DropDownList>
                  
                         <asp:LinkButton ID="btnBuscar" CssClass="btn btn-default "   OnClick="btnBuscar_Click" 
                             runat="server" ><span class="glyphicon glyphicon-search"></span> 
                         </asp:LinkButton>
                               </div>                           
                  
                            </ContentTemplate>
                            <Triggers>
                             <asp:AsyncPostBackTrigger ControlID="btnBuscarRFC" />
                            </Triggers>
                           </asp:UpdatePanel>               
                     </div> 
                    <div class="col-lg-3 " >
                        <asp:Label  class="control-label" ID="Label12" runat="server" Text="Folio NTLINK" ></asp:Label>
                        <asp:TextBox ID="txtFolio" runat="server" CssClass="form-control"  Enabled="False" />
                       
                    </div>
                    <div class="col-lg-3" >
                        <asp:Label  class="control-label" ID="Label10" runat="server" Text="RazonSocial" ></asp:Label>
                        <asp:TextBox ID="txtRazonSocial" runat="server"  CssClass="form-control" TextMode="MultiLine"/>
                    </div>
                 </div>
                         </ContentTemplate>
                         <Triggers>
                             <asp:AsyncPostBackTrigger ControlID="ddlEmpresa" EventName="SelectedIndexChanged" /> 
                                 <asp:AsyncPostBackTrigger ControlID="ddlClientes" EventName="SelectedIndexChanged" />    
                                  </Triggers>
                         </asp:UpdatePanel>
                
         
                   <asp:UpdatePanel ID="UpdatePanelR3" runat="server"  UpdateMode="Conditional">
                   <ContentTemplate>     
                 <div class = "row form-group " > 
                   
                    <div class="col-lg-3 " >
                        <asp:Label  class="control-label" ID="lblFolio" runat="server" Text="Folio" ></asp:Label>
                        <asp:TextBox ID="txtFolioSat" runat="server" CssClass="form-control" />
                       
                    </div>
                    <div class="col-lg-3" >
                        <asp:Label  class="control-label" ID="Label1" runat="server" Text="Serie" ></asp:Label>
                        <asp:TextBox ID="txtSerie" runat="server"  CssClass="form-control"/>
                    </div>

                    <div class="col-lg-3 " >
                        <asp:Label  class="control-label" ID="Label9" runat="server" Text="Sucursal"></asp:Label>
                        <asp:DropDownList ID="ddlSucursales" runat="server"  Width="100%" BackColor="White" 
                              CssClass ="btn btn-default dropdown-toggle optionAlinear" 
                            AppendDataBoundItems="True" DataValueField="LugarExpedicion"     DataTextField="Nombre">

                        </asp:DropDownList>
                     </div>
                

                        <div class="col-lg-3 " >
                        <asp:Label  class="control-label" ID="lblTipoDocumento" runat="server" Text="Tipo de Comprobante"></asp:Label>
                                          
                          <asp:DropDownList runat="server" ID="ddlTipoDocumento" AutoPostBack="True"
                            OnSelectedIndexChanged="ddlTipoDocumento_SelectedIndexChanged" Width="100%" 
                              CssClass ="btn btn-default dropdown-toggle optionAlinear" BackColor="White">
                            <asp:ListItem Text="Factura" Value="Ingreso" ></asp:ListItem>
                            <asp:ListItem Text="Nota de Crédito" Value="Egreso" ></asp:ListItem>
                            <asp:ListItem Text="Recibo de Donativo" Value="Donativo" ></asp:ListItem>
                            <asp:ListItem Text="Recibo de Arrendamiento" Value="Arrendamiento" ></asp:ListItem>
                            <asp:ListItem Text="Recibo de Honorarios" Value="Honorarios" ></asp:ListItem>
                            
                        </asp:DropDownList>
                    </div>

                     

                    </div>
      
             
                <div class = "row form-group " > 
                       <div class="col-lg-3 " >
                        <asp:Label  class="control-label" ID="lblFormaPago" runat="server" Text="Forma de Pago"></asp:Label>
                        <asp:DropDownList ID="ddlFormaPago"  runat="server"  AutoPostBack="True" 
                            OnSelectedIndexChanged="ddlFormaPago_SelectedIndexChanged" 
                              CssClass ="btn btn-default dropdown-toggle optionAlinear"  BackColor="White" Width="100%" >
                        
                            <asp:ListItem runat="server" Text="Efectivo" Value="01"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Cheque nominativo" Value="02"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Transferencia electrónica de fondos" Value="03"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Tarjeta de crédito" Value="04"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Monedero electrónico" Value="05"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Dinero electrónico" Value="06"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Vales de despensa" Value="08"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Dación en pago" Value="12"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Pago por subrogación" Value="13"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Pago por consignación" Value="14"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Condonación" Value="15"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Compensación" Value="17"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Novación" Value="23"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Confusión" Value="24"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Remisión de deuda" Value="25"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Prescripción o caducidad" Value="26"></asp:ListItem>
                            <asp:ListItem runat="server" Text="A satisfacción del acreedor" Value="27"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Tarjeta de débito" Value="28"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Tarjeta de servicios" Value="29"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Aplicación de anticipos" Value="30"></asp:ListItem>
                            <asp:ListItem runat="server" Value="31" Text="Intermediario pagos"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Por definir" Value="99"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                     <div class = "form-group col-lg-3">
                        <asp:Label ID="lblMetodoPago" class="control-label" runat="server" Text="Método de Pago"></asp:Label>
                        <asp:DropDownList ID="ddlMetodoPago"   runat="server" 
                             CssClass ="btn btn-default dropdown-toggle optionAlinear"  BackColor="White" Width="100%"
                            AutoPostBack="True" OnSelectedIndexChanged="ddlMetodoPago_SelectedIndexChanged" >
                            <asp:ListItem runat="server" Text="Pago en una sola exhibición" Value="PUE"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Pago en parcialidades o diferido" Value="PPD"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                      <div class="col-lg-3 " >
                        <asp:Label  class="control-label" ID="Label11" runat="server" Text="Status Factura" ></asp:Label>
                           <asp:DropDownList runat="server" ID="ddlStatusFactura" AutoPostBack="true"
                               OnSelectedIndexChanged="ddlStatusFactura_SelectedIndexChanged" 
                                  CssClass ="btn btn-default dropdown-toggle optionAlinear"  BackColor="White" Width="100%">
                            <asp:ListItem Value="0" Text="Pendiente"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Pagada"></asp:ListItem>
                        </asp:DropDownList>    
                    </div>
                    <div class="col-lg-3" >
                        <asp:Label  class="control-label" ID="lblFechaPago" runat="server" Text="Fecha de Pago" Visible="False"  ></asp:Label>
                    <asp:TextBox runat="server" ID="txtFechaPago" CssClass="form-control"  Visible="False" />
                        <asp:CompareValidator runat="server" ID="cvFechaInicial" ControlToValidate="txtFechaPago"
                            Display="Dynamic" ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" ForeColor="Red"/>
                        <asp:CalendarExtender runat="server" ID="ceFechaInicial" Animated="False" PopupButtonID="txtFechaPago"
                            TargetControlID="txtFechaPago" Format="dd/MM/yyyy" />
                        <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator9" ControlToValidate="txtFechaPago"
                            Display="Dynamic" ErrorMessage="* Requerido" ForeColor="Red"
                         ValidationGroup="CrearFactura"  />
                    </div>
                    

                  </div>
              
                    </ContentTemplate>
                           <Triggers>
                               <asp:AsyncPostBackTrigger ControlID="ddlTipoDocumento" EventName="SelectedIndexChanged" /> 
                               </Triggers>
                    </asp:UpdatePanel>          
                
                   <asp:UpdatePanel ID="UpdatePanelR6" runat="server"  UpdateMode="Conditional">
                   <ContentTemplate>   
                   <div class = "row"> 
                     <div class = "form-group col-lg-3">
                           <asp:Label ID="Label7" class="control-label" runat="server" Text="CondicionesPago"></asp:Label>
           
                    <asp:TextBox ID="txtCondicionesPago" runat="server"         CssClass="form-control" ></asp:TextBox>
                        </div>
                       <div class = "form-group col-lg-3">
                           <asp:Label ID="Label13" class="control-label" runat="server" Text="UsoCFDI"></asp:Label>
                        <asp:DropDownList ID="ddlUsoCFDI" runat="server"
                            CssClass ="btn btn-default dropdown-toggle optionAlinear"  BackColor="White" Width="100%" >
                         <asp:ListItem runat="server"  Value="G01" Text="Adquisición de mercancias" ></asp:ListItem>
                         <asp:ListItem runat="server"  Value="G02" Text="Devoluciones, descuentos o bonificaciones" ></asp:ListItem>
                         <asp:ListItem runat="server"  Value="G03" Text="Gastos en general" ></asp:ListItem>
                         <asp:ListItem runat="server"  Value="I01" Text="Construcciones" ></asp:ListItem>
                         <asp:ListItem runat="server"  Value="I02" Text="Mobilario y equipo de oficina por inversiones" ></asp:ListItem>
                         <asp:ListItem runat="server"  Value="I03" Text="Equipo de transporte" ></asp:ListItem>
                         <asp:ListItem runat="server"  Value="I04" Text="Equipo de computo y accesorios" ></asp:ListItem>
<asp:ListItem runat="server"  Value="I05" Text="Dados, troqueles, moldes, matrices y herramental" ></asp:ListItem>
<asp:ListItem runat="server"  Value="I06" Text="Comunicaciones telefónicas" ></asp:ListItem>
<asp:ListItem runat="server"  Value="I07" Text="Comunicaciones satelitales" ></asp:ListItem>
<asp:ListItem runat="server"  Value="I08" Text="Otra maquinaria y equipo" ></asp:ListItem>
<asp:ListItem runat="server"  Value="D01" Text="Honorarios médicos, dentales y gastos hospitalarios." ></asp:ListItem>
<asp:ListItem runat="server"  Value="D02" Text="Gastos médicos por incapacidad o discapacidad" ></asp:ListItem>
<asp:ListItem runat="server"  Value="D03" Text="Gastos funerales." ></asp:ListItem>
<asp:ListItem runat="server"  Value="D04" Text="Donativos." ></asp:ListItem>
<asp:ListItem runat="server"  Value="D05" Text="Intereses reales efectivamente pagados por créditos hipotecarios (casa habitación)." ></asp:ListItem>
<asp:ListItem runat="server"  Value="D06" Text="Aportaciones voluntarias al SAR." ></asp:ListItem>
<asp:ListItem runat="server"  Value="D07" Text="Primas por seguros de gastos médicos." ></asp:ListItem>
<asp:ListItem runat="server"  Value="D08" Text="Gastos de transportación escolar obligatoria." ></asp:ListItem>
<asp:ListItem runat="server"  Value="D09" Text="Depósitos en cuentas para el ahorro, primas que tengan como base planes de pensiones." ></asp:ListItem>
<asp:ListItem runat="server"  Value="D10" Text="Pagos por servicios educativos (colegiaturas)" ></asp:ListItem>
<asp:ListItem runat="server"  Value="P01" Text="Por definir" ></asp:ListItem> 
  </asp:DropDownList>    

                       </div>
                    <div class = "form-group col-lg-3">
                        <asp:Label ID="lblMoneda" class="control-label" runat="server" Text="Moneda"></asp:Label>
           
               
                        
                                 <asp:DropDownList ID="ddlMoneda" runat="server" Width="100%"  
                           AutoPostBack="True"  DataTextField="RazonSocial" DataValueField="idEmpresa" 
                            CssClass ="drpCountryRGV" data-live-search-style="begins"  title="Seleccione"  data-live-search="true"
                           OnSelectedIndexChanged="ddlMoneda_SelectedIndexChanged"   /> 

                    </div>
                    <div class = "form-group col-lg-3">
                        <asp:Label ID="lblTipoCambio" class="control-label" runat="server" Text="Tipo de Cambio" Visible="false"></asp:Label>
                        <asp:TextBox ID="txtTipoCambio" runat="server" Visible="false" CssClass="form-control"/>
                    </div>
                </div>  
                
                   <div class = "row form-group " > 
                   
                    <div class="col-lg-6 " >
                        <asp:Label  class="control-label" ID="Label15" runat="server" Text="Observaciones" ></asp:Label>
                        <asp:TextBox runat="server" ID="txtProyecto"  CssClass="form-control" />
          
                    </div>
                        <div class="col-lg-3 " >
                        <asp:Label  class="control-label" ID="Label29" runat="server" Text="Decimales Importe" ></asp:Label>
                       <asp:DropDownList runat="server" ID="ddlDecimales" AutoPostBack="True" 
                                OnSelectedIndexChanged="ddlDecimales_SelectedIndexChanged" 
                                  CssClass ="btn btn-default dropdown-toggle optionAlinear"  BackColor="White" Width="100%">
                            <asp:ListItem Value="2" Text="2" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="3" Text="3"></asp:ListItem>
                        <asp:ListItem Value="4" Text="4"></asp:ListItem>
                        <asp:ListItem Value="5" Text="5"></asp:ListItem>
                        <asp:ListItem Value="6" Text="6"></asp:ListItem>
                        </asp:DropDownList>
          
                    </div>
                      <div class="col-lg-3 " >
                        <asp:Label  class="control-label" ID="LblConfirmacion" runat="server" Text="Confirmación" visible="false" ></asp:Label>
                        <asp:TextBox ID="txtConfirmacion" runat="server" CssClass="form-control" visible="false"/>
              </div>
            </div>  
                       </ContentTemplate>
                       </asp:UpdatePanel>
                  <asp:UpdatePanel ID="UpdatePanelR7" runat="server"  UpdateMode="Conditional">
                   <ContentTemplate>   
               
                  <div class = "row form-group " id="trDonativo"  runat="server"> 
                          <div class="col-lg-3 " >
                        <asp:Label  class="control-label" ID="Label16" runat="server" Text="N. de autorización del Donativo" ></asp:Label>
                        <asp:TextBox runat="server" ID="txtDonatAutorizacion"  CssClass="form-control" />
          
                    </div>
                    <div class="col-lg-3 " >
                        <asp:Label  class="control-label" ID="Label17" runat="server" Text="Fecha de autorización del donativo" ></asp:Label>
                        <asp:TextBox ID="txtDonatFechautorizacion" runat="server" CssClass="form-control" ></asp:TextBox>
                        <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" 
                            PopupButtonID="txtDonatFechautorizacion" 
                            TargetControlID="txtDonatFechautorizacion" />
                    </div>
                
                 </div>
    
              </ContentTemplate>
                           <Triggers>
                               <asp:AsyncPostBackTrigger ControlID="ddlTipoDocumento" EventName="SelectedIndexChanged" /> 
                               </Triggers>
                    </asp:UpdatePanel>          
            </div>
            </div>
                </div> 
        
      <%--Termina Primera Sección - Generar CFDI--------------------------------------------%>
          

        <%---------------Segunda Sección - CFDI Relacionados---------------%>
               
                <div class="panel panel-default" style="width:100%">
	  
          <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#Acordion2">
         <span data-toggle="collapse" class="icon pull-right"><em class=" glyphicon glyphicon-s glyphicon-plus fa-lg" style="font-size: 14px" ></em></span>
              <h4 class="panel-title">
            <a>
                <b>    CFDI Relacionados</b>
            </a>
          </h4>
          </div>
		 
        <div id="Acordion2" class="panel-collapse collapse">
          <div class="panel-body">
               <asp:UpdatePanel ID="UpdatePanelR4" runat="server"  UpdateMode="Conditional"  >
               <ContentTemplate>
              

                <div class = "row">
                    <div class = "form-group col-lg-6">
                        <asp:Label ID="lblUUID" runat="server" class="control-label" Text="UUID"></asp:Label>
                        <asp:TextBox ID="txtUUDI" runat="server" Width="100%" CssClass="form-control"/>
                    </div>
                    <div class = "form-group col-lg-6">
                        <asp:Label ID="lblTipoRelacion" runat="server" class="control-label" Text="Tipo de Relación"></asp:Label>
                        <asp:DropDownList ID="ddlTipoRelacion"  runat="server" 
                                 CssClass ="btn btn-default dropdown-toggle optionAlinear"  BackColor="White" Width="100%" >
                            <asp:ListItem runat="server" Text="Nota de crédito de los documentos relacionados" Value="01" />
                            <asp:ListItem runat="server" Text="Nota de débito de los documentos relacionados" Value="02" />
                            <asp:ListItem runat="server" Text="Devolución de mercancía sobre facturas o traslados previos" Value="03" />
                            <asp:ListItem runat="server" Text="Sustitución de los CFDI previos" Value="04" />
                            <asp:ListItem runat="server" Text="Traslados de mercancias facturados previamente" Value="05" />
                            <asp:ListItem runat="server" Text="Factura generada por los traslados previos" Value="06" />
                            <asp:ListItem runat="server" Text="CFDI por aplicación de anticipo" Value="07" />
                             <asp:ListItem runat="server" Text="Factura generada por pagos en parcialidades" Value="08" />
                             <asp:ListItem runat="server" Text="Factura generada por pagos diferidos" Value="09" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class = "row">
                    <div class = "col-lg-12 float-right" style="float:right">
                                              
                         <asp:LinkButton ID="btnCfdiRelacionado" CssClass="btn btn-default" 
                             OnClick="btnCfdiRelacionado_Click" 
                              ValidationGroup="AgregarCfdiRelacionado" Text="Relacionado"
                             runat="server" ><span class="fas fa-plus"></span> Agregar 
                         </asp:LinkButton>
             
                    </div>
                </div>
                <div  class="row mt-4">
                <div class = "col-12"> 
                  <div class="table-responsive  border border-dark">
  
                     <asp:GridView ID="gvCfdiRelacionado" class="table table-bordered table-hover table-striped grdViewTable" 
                         runat="server" AutoGenerateColumns="false"  BackColor="White" AlternatingRowStyle-HorizontalAlign="Left" 
                         OnRowCommand="gvCfdiRelacionado_RowCommand" Width="100%" RowStyle-Height="5"   BorderWidth="0px"
                         OnRowDataBound="gvCfdiRelacionado_RowDataBound">
                         <RowStyle  Height="10" Font-Size="14px"  cssclass="RowStyle" />
                         <FooterStyle  Font-Bold="True"  />
                         <PagerStyle  Height="5"  />
                         <HeaderStyle BackColor="#f9f9f9" Font-Bold="True" ForeColor="Black" Height="30px" />
                          <AlternatingRowStyle Height="10"  cssclass="AlternateRowStyle" />  
                         <Columns>
                                <asp:BoundField DataField="ID" HeaderText="ID"  />
                                <asp:BoundField DataField="UUID" HeaderText="UUID" />
                              
                            
                       <asp:TemplateField  HeaderText="Opciones" ItemStyle-Width="10%" 
                           ItemStyle-HorizontalAlign="Center" >
                            <ItemTemplate  >
                                 <div class="form-inline">
                                       <asp:LinkButton ID="gvlnkDelete" ClientIDMode="AutoID"
                                           CommandName="deleteRecord"
                                           CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                           CssClass="btn btn-light" runat="server" style=" padding:0px 3px;" >
                                           <i class="glyphicon glyphicon-trash  " title="Eliminar"></i> 
                                        </asp:LinkButton>
                               </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                            </Columns>
                           <footerstyle />
                        </asp:GridView>    
                      </div>

                  </div>
                </div>
            
               </ContentTemplate>
              <Triggers>

                 <%--   <asp:AsyncPostBackTrigger ControlID="gvCfdiRelacionado"/>   
                        <asp:AsyncPostBackTrigger ControlID="gvCfdiRelacionado" EventName="RowCommand" />    
                 --%>  
                    <%--   <asp:AsyncPostBackTrigger ControlID="cbCfdiRelacionados" EventName="CheckedChanged" /> --%>
                       <asp:AsyncPostBackTrigger  ControlID="lnkDelete" EventName="Click" />
          
                  
                    </Triggers>
            </asp:UpdatePanel>

                   
                   </div>  <%--Termina panel-body--%>
        </div>  <%--Termina Segunda Sección - CFDI Relacionados--%>
      
</div>
          
      

        <%---------------Tercera Sección - Conceptos---------------%>
               
                 <div class="panel panel-default" style="width:100%">
	  
          <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#Acordion3">
         <span data-toggle="collapse" class="icon pull-right"><em class=" glyphicon glyphicon-s glyphicon-plus fa-lg" style="font-size: 14px" ></em></span>
              <h4 class="panel-title">
            <a>
                 <b>   Conceptos</b>
            </a>
          </h4>
          </div>
		 
        <div id="Acordion3" class="panel-collapse collapse">
          <div class="panel-body">
                     <asp:UpdatePanel ID="UpdatePanelR5" runat="server"  UpdateMode="Conditional"  >
               <ContentTemplate>
         
               
       <div class = "row"> <%--Clave Unidad/No. Identificación--%>
                    <div class = "form-group col-lg-3">
                       <asp:Label ID="Label32" runat="server" ForeColor="Red" Text="* "></asp:Label>
                          <asp:Label ID="lblClaveUnidad" class="control-label" runat="server" Text="Unidad de medida"></asp:Label>
                       
                                 
                                 <asp:DropDownList ID="ddlClaveUnidad" runat="server" Width="100%"  
                           DataTextField="RazonSocial" DataValueField="idEmpresa" 
                            CssClass ="drpCountryRGV" data-live-search-style="begins" title="Seleccione"  data-live-search="true"
                           OnSelectedIndexChanged="ddlClaveUnidad_SelectedIndexChanged"   /> 
                   
                    </div>
                   <div class = "form-group col-lg-3">
          <%--                   <asp:Label ID="lbCuentaPredial" class="control-label" runat="server" Text="CuentaPredial"></asp:Label>
                             <asp:TextBox ID="txtCuentaPredial" runat="server" CssClass="form-control2" />
         --%>               <asp:Label ID="Label33" runat="server" ForeColor="Red" Text="* "></asp:Label>
                                        <asp:Label ID="lbUnidad" class="control-label" runat="server" Text="Unidad"></asp:Label>
                                                    <asp:TextBox runat="server" ID="txtUnidad" CssClass="form-control"  />
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ControlToValidate="txtUnidad" Display="Dynamic" 
                        ErrorMessage="* Requerido" ForeColor="Red" ValidationGroup="AgregarConcepto" />
                   
                   </div>
                    
                      <div class = "form-group col-lg-3">
                       <asp:Label ID="lblNoIdentificacion" class="control-label" runat="server" Text="NoIdentificacion"></asp:Label>
                       <asp:TextBox ID="txtNoIdentificacion" runat="server" CssClass="form-control"  />
                      </div>                                        
                
                    <div class = "form-group col-lg-3">
                     <asp:Label ID="Label34" runat="server" ForeColor="Red" Text="* "></asp:Label>
                    <asp:Label ID="lblCodigo" class="control-label" runat="server" Text="Clave de producto"></asp:Label>
                        <asp:TextBox ID="txtCodigo" runat="server" CssClass="form-control" 
                            MaxLength="8"/>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtCodigo" Display="Dynamic" 
                        ErrorMessage="* Requerido" ForeColor="Red" ValidationGroup="AgregarConcepto" />
                        <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server" FilterType="Numbers"
                       TargetControlID="txtCodigo" />
                    </div>
                   
                
               </div>
                <div class="row">
                     <div class = "form-group col-lg-3">
                             <asp:Label ID="Label35" runat="server" ForeColor="Red" Text="* "></asp:Label>
                           <asp:Label ID="lblCantidad" class="control-label" runat="server" Text="Cantidad"></asp:Label>
                        <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control"/>
                        <asp:RequiredFieldValidator ID="rfvCantidad" runat="server" ControlToValidate="txtCantidad" Display="Dynamic" 
                        ErrorMessage="* Requerido" ForeColor="Red" ValidationGroup="AgregarConcepto" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                        ControlToValidate="txtCantidad" ForeColor="Red" Display="Dynamic" ErrorMessage="Dato invalido" 
                        ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="AgregarConcepto" />
                    </div>
                   

                       <div class = "form-group col-lg-3">
                            <asp:Label ID="Label36" runat="server" ForeColor="Red" Text="* "></asp:Label>
                       <asp:Label ID="lblPrecioUnitario" class="control-label"  runat="server" Text="Precio Unitario"></asp:Label>
                        <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control"/>
                           <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server"
            TargetControlID="txtPrecio" FilterType="Custom, Numbers"   ValidChars="." Enabled="True" />
                        <asp:RequiredFieldValidator ID="rfvPrecio" runat="server" ControlToValidate="txtPrecio" Display="Dynamic" 
                        ErrorMessage="* Requerido" ForeColor="Red" ValidationGroup="AgregarConcepto" />
                        <asp:CompareValidator ID="cvPrecio" runat="server" ControlToValidate="txtPrecio" Display="Dynamic" 
                        ErrorMessage="* Dato invalido" ForeColor="Red" Operator="DataTypeCheck" Type="Double" ValidationGroup="AgregarConcepto" />
                    </div>
                    <%-- <div class = "form-group col-lg-3">
                             <asp:Label ID="Label30" class="control-label"  runat="server" Text="Descuento %"></asp:Label>
                      <div class = "form-inline" style="width:100%;">
                             <asp:CheckBox ID="descuento" runat="server" AutoPostBack="True" Checked="false" 
                                 CssClass="checkbox-inline"  OnCheckedChanged="descuento_CheckedChanged"  Text=" % Desc" />
                     <asp:TextBox ID="txtdsc" runat="server" AutoPostBack="True" CssClass="form-control" 
                         OnTextChanged="txtdsc_TextChanged"  ></asp:TextBox>
                     
                 </div>
                    </div>--%>
                    <div class = "form-group col-lg-3">
                        <asp:Label ID="lblDescu" class="control-label" runat="server" Text="Descuento"></asp:Label>
                        <asp:TextBox ID="txtDescuento" runat="server" CssClass="form-control"/>
                         <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server"
            TargetControlID="txtDescuento" FilterType="Custom, Numbers"   ValidChars="." Enabled="True" />
                              <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtDescuento" Display="Dynamic" 
                        ErrorMessage="* Dato invalido" ForeColor="Red" Operator="DataTypeCheck" Type="Double" ValidationGroup="AgregarConcepto" />
               
                    </div>
                    </div>
                  
                
                    <div class = "row"> 
                       <div class = "form-group col-lg-4">
                        <asp:Label ID="Label18" class="control-label" runat="server" Text="CuentaPredial"></asp:Label>
                        <asp:TextBox ID="txtCuentaPredial" runat="server" CssClass="form-control"   /> 
                       </div>
              
                     <div class = "form-group col-lg-2 ">
                      <asp:Label ID="lblIVA" class="control-label" runat="server" Text="I.V.A."></asp:Label>
                         <asp:DropDownList runat="server" ID="ddlIVA"   
                                  CssClass ="btn btn-default dropdown-toggle optionAlinear"  Width="100%" BackColor="White" >
                          <asp:ListItem runat="server" Text="No Aplica" Value="-1" ></asp:ListItem>
                             <asp:ListItem runat="server" Value="0.160000" Text="16%" Selected="True"></asp:ListItem>
                                   <asp:ListItem runat="server" Value="0.080000" Text="8%"></asp:ListItem>
                           <asp:ListItem runat="server" Text="0%" Value="0.000000"></asp:ListItem>
                            <asp:ListItem runat="server" Text="Exento" Value="Exento"></asp:ListItem>
                        </asp:DropDownList>

                    </div>
                      <div class = "form-group col-lg-2 ">
                      <asp:Label ID="Label4" class="control-label" runat="server" Text="Ret ISR"></asp:Label>
                           <asp:DropDownList runat="server" ID="ddlRISR"   
                                 CssClass ="btn btn-default dropdown-toggle optionAlinear"  Width="100%" BackColor="White" >
                             <asp:ListItem runat="server" Text="No Aplica" Value="-1" Selected="True"></asp:ListItem>
                         <asp:ListItem runat="server" Value="0.100000" Text="0.100000" ></asp:ListItem>
                       
                        </asp:DropDownList>

                          </div>
                      <div class = "form-group col-lg-2 ">
                              <asp:Label ID="Label3" class="control-label" runat="server" Text="Ret IVA"></asp:Label>
                     
                          <asp:DropDownList runat="server" ID="ddlRIVA" 
                                CssClass ="btn btn-default dropdown-toggle optionAlinear"  Width="100%" BackColor="White">
                              <asp:ListItem runat="server" Text="No Aplica" Value="-1" Selected="True"></asp:ListItem>
                         <asp:ListItem runat="server" Value="0.106666" Text="0.106666" ></asp:ListItem>
                              <asp:ListItem runat="server" Value="0.060000" Text="0.060000"></asp:ListItem>
                              <asp:ListItem runat="server" Text="0.040000" Value="0.040000"></asp:ListItem>
                        </asp:DropDownList>
                   </div>
                    
                </div>  
              <div class = "row"> 
                       <div class = "form-group col-lg-4">
                          <asp:Label ID="Label37" runat="server" ForeColor="Red" Text="* "></asp:Label>
                      <asp:Label ID="lblDescripcion" class="control-label" runat="server" Text="Descripción"></asp:Label>
                        <asp:TextBox ID="txtDescripcion" Width="100%" runat="server" TextMode="MultiLine" CssClass="form-control"/>
                        <asp:RequiredFieldValidator ID="rfvDescripcion" runat="server" ControlToValidate="txtDescripcion" Display="Dynamic" 
                        ErrorMessage="* Requerido" ForeColor="Red" ValidationGroup="AgregarConcepto" />
                    </div>
                      <div class = "form-group col-lg-4">
                        <asp:Label ID="Label19" class="control-label" runat="server" Text="Observaciones"></asp:Label>
                        <asp:TextBox ID="txtDetalles" Width="100%" runat="server" TextMode="MultiLine" CssClass="form-control"/>
                    </div>
              
              </div>
                    <div class="row">
                     <div class = "col-12">
                       <asp:Label ID="Label31" runat="server" ForeColor="Red" Text="Obligatorios (*)"></asp:Label> 
                    
                         </div>
               </div>
                      <div class="row">
                       <div class = "col-12">
               
                  <div class="btn-toolbar pull-right">
                     
                       <asp:LinkButton ID="btnAgregar" CssClass="btn btn-default mr-2" 
                             OnClick="btnAgregar_Click" 
                              ValidationGroup="AgregarConcepto" Text="Concepto"
                             runat="server" ><span class="fas fa-plus"></span> Agregar 
                         </asp:LinkButton>
                       
                       <asp:LinkButton ID="btnBuscarHistorico" CssClass="btn btn-default mr-2" 
                             OnClick="btnBuscarHistorico_Click" 
                             Text="Concepto" runat="server" >
                           <span class="glyphicon glyphicon-search"></span> Historico 
                         </asp:LinkButton>
                             
                      <button type="button"
                          onclick="javascript:window.open('http://200.57.3.46:443/PyS/catPyS.aspx','','width=600,height=400,left=50,top=50,toolbar=yes');" 
                          class="btn btn-default mr-2" > <span class="glyphicon glyphicon-search"></span> BuscadorSAT 
                     </button>
                      
                              <asp:LinkButton ID="btnBuscarProducto" CssClass="btn btn-default mr-2" 
                             OnClick="btnBuscarProducto_Click" 
                             Text="Buscar" runat="server" >
                           <span class="glyphicon glyphicon-search"></span> ClaveProdServ 
                         </asp:LinkButton>
                     
             </div>
                </div>
                      </div>  <%--Termina Descripción/Botón Agregar/ Botón Buscar--%>
                 <div class="row">  
                       <div class = "col-lg-12 col-md-12 col-sm-12 col-xs-12">
             
                 <asp:HiddenField ID="txtIdProducto" runat="server" />
                  </div>  </div>

                   </ContentTemplate>
                         <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="gvBuscarConceptosHistorico" EventName="RowCommand"/> 
                                <asp:AsyncPostBackTrigger ControlID="gvBuscarConceptos" EventName="RowCommand"/> 
                         </Triggers>

                         </asp:UpdatePanel>
                
                   <asp:UpdatePanel ID="UpdatePanelR8" runat="server"  UpdateMode="Conditional"  >
               <ContentTemplate>
                                
                 <div  class="row mt-4">
                <div class = "col-12">
                  <div class="table-responsive  border border-dark">
  
                     <asp:GridView ID="gvDetalles" class="table table-bordered table-hover table-striped " 
                         runat="server" AutoGenerateColumns="false" BackColor="White" AlternatingRowStyle-HorizontalAlign="Left"  
                         OnRowCommand="gvDetalles_RowCommand" Width="100%" RowStyle-Height="5" FooterStyle-BorderStyle="None"
                         OnRowDataBound="gvDetalles_RowDataBound" DataKeyNames="Partida">
                         <RowStyle  Height="10" Font-Size="14px"  cssclass="RowStyle" />
                         <FooterStyle  Font-Bold="True"  BorderStyle="None" />
                         <PagerStyle  Height="5" />
                         <HeaderStyle BackColor="#f9f9f9" Font-Bold="True" ForeColor="Black" Height="30px" />
                          <AlternatingRowStyle  Height="10"  cssclass="AlternateRowStyle" />
                         
                         <Columns>
                        <asp:BoundField HeaderText="Partida" DataField="Partida"  />
                        <asp:BoundField HeaderText="ClaveProdServ" DataField="Codigo" />
                        <asp:BoundField HeaderText="NoIdentificacion" DataField="ConceptoNoIdentificacion"  ItemStyle-CssClass ="d-none d-md-table-cell" HeaderStyle-CssClass="d-none d-md-table-cell" />
                        <asp:BoundField HeaderText="Cantidad" DataField="Cantidad" />
                        <asp:BoundField HeaderText="ClaveUnidad" DataField="ConceptoClaveUnidad"  />
                        <asp:BoundField HeaderText="Unidad" DataField="Unidad"  />
                        <asp:BoundField HeaderText="ValorUnitario" DataField="Precio"  DataFormatString="${0:#,#.######}" />
                   <%--     <asp:BoundField HeaderText="Descripción" DataField="Descripcion" />
                 --%>       <asp:BoundField HeaderText="Importe" DataField="Total" DataFormatString="${0:#,#.######}" />
                       <asp:BoundField HeaderText="Descuento" DataField="ConceptoDescuento" DataFormatString="${0:#,#.######}" ItemStyle-CssClass ="d-none d-md-table-cell" HeaderStyle-CssClass="d-none d-md-table-cell" 
                             />
                        <asp:BoundField HeaderText="CuentaPredial" DataField="CuentaPredial"  ItemStyle-CssClass ="d-none d-md-table-cell" HeaderStyle-CssClass="d-none d-md-table-cell" />
                        <%--<asp:BoundField HeaderText="Observaciones" DataField="Observaciones" />--%>
                   <%--     <asp:ButtonField Text="Editar" CommandName="Editar" Visible="False" ItemStyle-HorizontalAlign="Center" />
                   --%>     <asp:TemplateField HeaderStyle-CssClass="sorting_disabled"  HeaderText= "Opciones"   ItemStyle-HorizontalAlign="Center">
                             <ItemTemplate  >
                                <div class="row-fluid">
                                 <div class="form-inline">
                                  <asp:LinkButton ID="gvlnkEditC" CommandName="Editar" 
                                      CommandArgument='<%#((GridViewRow)Container).RowIndex%>' 
                                      CssClass="btn btn-light" runat="server" style=" padding:0px 3px;">
                                    <i class="glyphicon glyphicon-edit" title="Editar"></i> 
                                        </asp:LinkButton>
                                    &nbsp;
                                      <asp:LinkButton ID="gvlnkDeleteC" CommandName="EliminarConcepto" 
                                          CommandArgument='<%#((GridViewRow)Container).RowIndex%>' 
                                            CssClass="btn btn-light" runat="server" style=" padding:0px 3px;" >
                                           <i class="glyphicon glyphicon-trash " title="Eliminar"></i> 
                                        </asp:LinkButton>
                                </div>
                                     </div>
                            </ItemTemplate>
                        </asp:TemplateField>
    
                               </Columns>
               </asp:GridView>
                      
                   </div>
                        </div>
                </div>
                

                   </ContentTemplate>
                     <Triggers>
                         <asp:AsyncPostBackTrigger ControlID="gvDetalles"/>   
                         <asp:AsyncPostBackTrigger ControlID="gvDetalles" EventName="RowCommand"/>   
                          <asp:AsyncPostBackTrigger  ControlID="btnAgregar" EventName="Click" />
                          <asp:AsyncPostBackTrigger  ControlID="bntEliminarConcepto" EventName="Click" />
                           <asp:AsyncPostBackTrigger  ControlID="btnGuardar" EventName="Click" />
                       
                
                     </Triggers>
             </asp:UpdatePanel>

                        </div>  <%--Termina panel-body--%>
      
              
        </div>  <%--Termina Tercera Sección - Conceptos--%>
</div>        

        
        <%---------------Cuarta Sección - Impuestos---------------%>
      
           <div class="panel panel-default" style="width:100%">
	  
          <div class="panel-heading" data-toggle="collapse" data-parent="#accordion" data-target="#Acordion4">
         <span data-toggle="collapse" class="icon pull-right"><em class=" glyphicon glyphicon-s glyphicon-plus fa-lg" style="font-size: 14px" ></em></span>
              <h4 class="panel-title">
            <a>
                 <b>   Impuestos</b>
            </a>
          </h4>
          </div>
		 
        <div id="Acordion4" class="panel-collapse collapse">
          <div class="panel-body">
         <asp:UpdatePanel ID="UpdatePanelR9" runat="server"  UpdateMode="Conditional"  >
               <ContentTemplate>
           
       
                <div class ="row">
                    <div class = "form-group col-lg-4">
                        <asp:Label ID="lblAsteriscoTipoImpuesto" runat="server" ForeColor="Red" Text="* "></asp:Label>
                        <asp:Label ID="lblTipoImpuesto" runat="server" Text="Tipo de Impuesto"></asp:Label> 
                        <asp:DropDownList ID="ddlTipoImpuesto" runat="server"   
                         CssClass ="btn btn-default dropdown-toggle optionAlinear"  Width="100%" BackColor="White"
                            AutoPostBack="True" OnSelectedIndexChanged="ddlTipoImpuesto_SelectedIndexChanged">
                            <asp:ListItem Value="Traslados">Traslados</asp:ListItem>
                            <asp:ListItem Value="Retenciones">Retenciones</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class = "form-group col-lg-4">
                        <asp:Label ID="lblAsteriscoBase" runat="server" ForeColor="Red" Text="* "></asp:Label>
                        <asp:Label ID="lblBase" runat="server" Text="Base"></asp:Label>
                        <asp:TextBox ID="txtBase" runat="server" Enabled="False" CssClass="form-control"></asp:TextBox>
                        <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Numbers, Custom" 
                        TargetControlID="txtBase" ValidChars="." />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtBase" Display="Dynamic" 
                        ErrorMessage="Requerido" ForeColor="Red" ValidationGroup="AgregarImpuesto"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtBase" 
                        Display="Dynamic" ForeColor="Red" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="AgregarImpuesto" />
                    </div>
                    <div class = "form-group col-lg-4">
                        <asp:Label ID="lblAsteriscoTipoFactor" runat="server" ForeColor="Red" Text="* "></asp:Label>
                        <asp:Label ID="lblTipoFactor" runat="server" Text="Tipo Factor"></asp:Label>
                        <asp:DropDownList ID="ddlTipoFactor" runat="server" 
                             CssClass ="btn btn-default dropdown-toggle optionAlinear"  Width="100%" BackColor="White"
                            AutoPostBack="True" OnSelectedIndexChanged="ddlTipoFactor_SelectedIndexChanged">
                            <asp:ListItem Value="Tasa">Tasa</asp:ListItem>
                            <asp:ListItem Value="Cuota">Cuota</asp:ListItem>
                            <asp:ListItem Value="Exento">Exento</asp:ListItem>
                        </asp:DropDownList>                        
                    </div>
                    
                                                      
                </div>
                <div class = "row">
                     <div class = "form-group col-lg-4 ">
                        <asp:Label ID="lblAsteriscoClaveConcepto" runat="server" ForeColor="Red" Text="* "></asp:Label>
                        <asp:Label ID="lblClaveConcepto" runat="server" Text="Partida"></asp:Label>
                        <asp:DropDownList ID="ddlConceptos" runat="server"  
                             CssClass ="btn btn-default dropdown-toggle optionAlinear"  Width="100%" BackColor="White"
                            AutoPostBack="True" OnSelectedIndexChanged="ddlConceptos_SelectedIndexChanged" >
                        </asp:DropDownList>
                    </div>    

                    <div class = "form-group col-lg-4">
                        <asp:Label ID="lblAsteriscoImpuesto" runat="server" ForeColor="Red" Text="* "></asp:Label>
                        <asp:Label ID="lblImpuesto" runat="server" Text="Impuesto"></asp:Label>
                        <asp:DropDownList ID="ddlImpuesto" runat="server" 
                             CssClass ="btn btn-default dropdown-toggle optionAlinear"  Width="100%" BackColor="White"
                            AutoPostBack="True" OnSelectedIndexChanged="ddlImpuesto_SelectedIndexChanged" >
                            <asp:ListItem Value="002">IVA</asp:ListItem>
                            <asp:ListItem Value="001">ISR</asp:ListItem>
                            <asp:ListItem Value="003">IEPS</asp:ListItem>
                        </asp:DropDownList>                      
                    </div>
                    <div class = "form-group col-lg-4 ">
                        <asp:Label ID="lblAsteriscoTasa" runat="server" ForeColor="Red" Text="* "></asp:Label>
                        <asp:Label ID="lblTasa" runat="server" Text="Tasa o Cuota"></asp:Label>
                        <asp:TextBox ID="txtTasa" runat="server" class="form-control" ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTasa" Display="Dynamic" 
                        ErrorMessage="Requerido-" ForeColor="Red" ValidationGroup="AgregarImpuesto"></asp:RequiredFieldValidator>
                        
                        <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" 
                        FilterType="Numbers, Custom" TargetControlID="txtTasa" ValidChars="." />
                        <asp:DropDownList ID="ddlTasaOCuota" runat="server" 
                           CssClass ="btn btn-default dropdown-toggle optionAlinear"  Width="100%" BackColor="White"
                            DataTextField="Maximo" DataValueField="Maximo" >
                        </asp:DropDownList>                                                
                    </div>
                </div>
                
             <%--   <asp:Label ID="LblAux" runat="server" ForeColor="Red" Text="*"/>--%>

                <div class = "row">
                    <div class = "col-md-2">
                           <asp:LinkButton ID="btnAgregarImpuesto" CssClass="btn btn-default" 
                             OnClick="btnAgregarImpuesto_Click" 
                              ValidationGroup="AgregarImpuesto" Text="Concepto"
                             runat="server" ><span class="fas fa-plus"></span> Agregar 
                         </asp:LinkButton>
                    </div>
                </div>
                <br />

            
                <div  class="row mt-4">
                <div class = "col-12">
                  <div class="table-responsive  border border-dark">
                          <asp:GridView ID="gvImpuestos" class="table table-bordered table-hover table-striped grdViewTable" 
                         runat="server" AutoGenerateColumns="false" BackColor="White" AlternatingRowStyle-HorizontalAlign="Left"  
                         OnRowCommand="gvImpuestos_RowCommand" Width="100%" RowStyle-Height="5" FooterStyle-BorderStyle="None"
                         OnRowDataBound="gvImpuestos_RowDataBound" >
                         <RowStyle  Height="10" Font-Size="14px"  cssclass="RowStyle" />
                         <FooterStyle  Font-Bold="True"  BorderStyle="None" />
                         <PagerStyle  Height="5" />
                         <HeaderStyle BackColor="#f9f9f9" Font-Bold="True" ForeColor="Black" Height="30px" />
                          <AlternatingRowStyle  Height="10"  cssclass="AlternateRowStyle" />

                            <Columns>
                          	<asp:BoundField HeaderText="Partida" DataField="ConceptoClaveProdServ" />
                            <asp:BoundField DataField="TipoImpuesto" HeaderText="TipoImpuesto" />
                            <asp:BoundField DataField="Impuesto" HeaderText="Impuesto" ItemStyle-Width="10%" />
                            <asp:BoundField DataField="Base" HeaderText="Base"  />
                            <asp:BoundField DataField="TasaOCuota" HeaderText="TasaOCuota" />
                            <asp:BoundField DataField="Importe" DataFormatString="${0:#,#.######}" HeaderText="Importe" />
                            <asp:BoundField DataField="TipoFactor" HeaderText="TipoFactor" />
                         <asp:TemplateField HeaderStyle-CssClass="sorting_disabled"  HeaderText= "Opciones"  ItemStyle-Width="10%"   
                             ItemStyle-HorizontalAlign="Center" >
                            <ItemTemplate  >
                                <div class="form-inline" >
                                      <asp:LinkButton ID="gvlnkDelete" CommandName="deleteRecord"
                                          CommandArgument='<%#((GridViewRow)Container).RowIndex%>' 
                                           CssClass="btn btn-light" runat="server" style=" padding:0px 3px;" >
                                           <i class="glyphicon glyphicon-trash "  title="Eliminar"></i> 
                                        </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>  
                            </Columns>
                    </asp:GridView>     
                          </div>
                </div>
            </div>
                   </ContentTemplate>
                   <Triggers>

                   <asp:AsyncPostBackTrigger ControlID="gvImpuestos" EventName="RowCommand"/>     
               <asp:AsyncPostBackTrigger ControlID="ddlTipoImpuesto" EventName="SelectedIndexChanged" /> 
                       <asp:AsyncPostBackTrigger  ControlID="btnAgregar" EventName="Click" />
                         <asp:AsyncPostBackTrigger  ControlID="bntEliminarConcepto" EventName="Click" />
                         <asp:AsyncPostBackTrigger  ControlID="bntEliminarImpuesto" EventName="Click" />
                           <asp:AsyncPostBackTrigger  ControlID="btnGuardar" EventName="Click" />
            
                    </Triggers>
                </asp:UpdatePanel>

         </div>
            </div>
               </div>
                 

        <%-------------------- Quinta Sección - Totales --------------------%>

              
                 <div class="panel panel-default" style="width:100%">
	  
          <div class="panel-heading" >
              <h4 class="panel-title">
            <a>
                 <b>   Totales</b>
            </a>
          </h4>
          </div>
		 
        <div id="Acordion5" >
          <div class="panel-body">
         
      
            <asp:UpdatePanel ID="UpdatePanelR10" runat="server"  UpdateMode="Conditional"  >
               <ContentTemplate>
                
                <div class="row">
                               <div class = "col-12">
                            <div class = "pull-right">
                   <ul class="list-group d-inline-block text-right list-group-flush">
  <li class="list-group-item p-0" ><div class="fw-bold">Subtotal:</div> </li>
  <li class="list-group-item p-0"><b>Retenciones:</b></li>
  <li class="list-group-item p-0"><b>Traslados:</b></li>
 <li class="list-group-item p-0"><b>Descuento:</b></li>
 <li class="list-group-item p-0"><b>Total:</b></li>
</ul>
<ul class="list-group d-inline-block list-group-flush text-right ">
  <li class="list-group-item p-0"> <asp:Label ID="lblSubtotal" CssClass="form-label" runat="server" Text=""/></li>
  <li class="list-group-item p-0"> <asp:Label ID="lblRetenciones" CssClass="form-label" runat="server" Text="" /></li>
  <li class="list-group-item p-0"><asp:Label ID="lblTraslados" CssClass="form-label" runat="server" Text="" /></li>
  <li class="list-group-item p-0"><asp:Label ID="lblDescuento" CssClass="form-label" runat="server" Text="" /></li>
  <li class="list-group-item p-0"><asp:Label ID="lblTotal" CssClass="form-label" runat="server" Text="" /></li>
</ul>
                  </div>
                                   </div>
                          </div>
       
                   </ContentTemplate>
             </asp:UpdatePanel>
                    <asp:UpdatePanel ID="UpdatePanelR11" runat="server"  UpdateMode="Conditional"  >
               <ContentTemplate>
        
               
                  <div class="row">
                       <div class = "col-12">
               
                  <div class="btn-toolbar pull-right">
                   
                        <asp:LinkButton ID="btnLimpiar" CssClass="btn btn-default" 
                             OnClick="btnLimpiar_Click" 
                              Text="Limpiar" runat="server" >
                           <span class="glyphicon glyphicon-erase"></span> Limpiar 
                         </asp:LinkButton>

              
                         <asp:LinkButton ID="BtnVistaPreviaP" CssClass="btn btn-default"  
                             Text="Vista Previa"  ValidationGroup="CrearFactura"  OnClick="BtnVistaPreviaP_Click"
                             runat="server" >
                                <span class="glyphicon glyphicon-eye-open"></span> Vista Previa 
                                  </asp:LinkButton>
       

                         
                       <asp:LinkButton ID="btnGenerarFactura" CssClass="btn btn-default" 
                             OnClick="btnGenerarFactura_Click" 
                              Text="Concepto" runat="server" >
                           <span class="glyphicon glyphicon-floppy-save"></span> Generar 
                         </asp:LinkButton>
                     <%-- <button type="button" class="btn btn-default" onclick="ShowPopup()()">
                            <span class="glyphicon glyphicon glyphicon glyphicon-floppy-remove"></span>
                            Generar</button>
                    --%>
                    </div>
                           </div>
               </div>
                   </ContentTemplate>
                        <Triggers>
                               <asp:AsyncPostBackTrigger  ControlID="btnGenerarFactura" EventName="Click" />
                              <asp:AsyncPostBackTrigger  ControlID="BtnVistaPreviaP"  EventName="Click" />
                        </Triggers>
                        </asp:UpdatePanel>
            
            </div>
        </div>
            </div>
                        
          </div>      <%--------------------Termina formato--------------------%>
       
                     
    <asp:UpdatePanel ID="UpdatePanelR100" runat="server"  UpdateMode="Conditional"  >
    <ContentTemplate>
 
    <iframe id="MyIframe" runat="server" style="display:none;" ></iframe>
          

        </ContentTemplate>
        </asp:UpdatePanel>


           <%-- ************************************************************************************* --%>
        <%-- -----------------Buscar RFC -----------------------------------%>


              <div id="ModalBuscarRFC" class="modal fade" data-backdrop="static" role="dialog"
        runat="server" data-keyboard="false">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
        <div class="modal-header d-block bg-light" id="titulo"  style="padding:10px 10px 0 10px; ">
        <h4 class="d-inline-block ml-3" id="myModalLabel2" >
                           Buscar por RFC</h4>
                               <button type="button" class="close  bottom-ri    ght mr-3 btn-lg" aria-label="Close" data-dismiss="modal" style="font-size: 40px;">
                            <span aria-hidden="true">&times;</span></button>

         </div>

                   <asp:UpdatePanel ID="UpdatePanelRM2" runat="server"  UpdateMode="Conditional"   >
    <ContentTemplate>


      <div class="modal-body">
           <div class = "row">
                    
                    <div class = "col-12">
                  <asp:Label ID="Label8" class="control-label" runat="server" Text="RFC"></asp:Label>
                     <asp:TextBox runat="server" CssClass="form-control" ID="txtRFCBus" />
             
                        </div>
                    </div>
                     
        
     </div>
    
      <div class="modal-footer">
              
                           <asp:LinkButton ID="btnBuscarRFC" CssClass="btn btn-default" 
                                      Text="Concepto" runat="server"   OnClick="btnBuscarRFC_Click" >
                           <span class="glyphicon  glyphicon-search"></span> Buscar 
                         </asp:LinkButton>
             <%--  <button type="button" class="btn btn-default" onclick="HideModal()">
                            <span class="glyphicon glyphicon glyphicon glyphicon-floppy-remove"></span>
                            Close</button>
                --%>
           <button type="button" class="btn btn-default" data-dismiss="modal">
               <span class="glyphicon glyphicon-remove-sign p-1" title="enviar"></span>Cerrar</button>
      </div>
        </ContentTemplate>
                       </asp:UpdatePanel>

    </div>

  </div>
    </div>  
 
        <%-- .........................eliminar relacionados............................ --%>

     <div id="ModalEliminarReacionados" class="modal fade" data-backdrop="static" role="dialog"
        runat="server" data-keyboard="false">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header d-block bg-light" id="tituloa"  style="padding:10px 10px 0 10px; ">
        <h4 class="d-inline-block ml-3" id="myModalLabel" >
                           Eliminar Relacionado</h4>
                               <button type="button" class="close  bottom-ri    ght mr-3 btn-lg" aria-label="Close" data-dismiss="modal" style="font-size: 40px;">
                            <span aria-hidden="true">&times;</span></button>
                 
                    </div>

                
      <div class="modal-body">
           <div class = "row">
                    
                    <div class = "col-12">
             <span> ¿Desea eliminar el registro?</span>
                        </div>
                    </div>
                     
        
     </div>
    
      <div class="modal-footer">
              
            <asp:UpdatePanel ID="UpdatePanelRM1" runat="server"  UpdateMode="Conditional"   >
    <ContentTemplate>

        <asp:HiddenField ID="hf_DeleteID" runat="server" />
  
          <asp:LinkButton ID="lnkDelete" CssClass="btn btn-default" OnClick="lnkDelete_Click"  runat="server" >
                           <i class="fa fa-trash" title="delete"></i>  Eliminar 
                                </asp:LinkButton>
                        
             <button type="button" class="btn btn-default" data-dismiss="modal">
               <span class="glyphicon glyphicon-remove-sign p-1" title="cerrar"></span>Cerrar</button>
      </ContentTemplate>
                </asp:UpdatePanel>
      </div>

    </div>

  </div>
    </div>
     <%-- .........................eliminar conceptos............................ --%>

     <div id="ModalEliminarConceptos" class="modal fade" data-backdrop="static" role="dialog"
        runat="server" data-keyboard="false">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header d-block bg-light"  style="padding:10px 10px 0 10px; ">
        <h4 class="d-inline-block ml-3" id="myModalLabelxx" >
                           Eliminar Relacionado</h4>
                               <button type="button" class="close  bottom-ri    ght mr-3 btn-lg" aria-label="Close" data-dismiss="modal" style="font-size: 40px;">
                            <span aria-hidden="true">&times;</span></button>  </div>
               
      <div class="modal-body">
           <div class = "row">
           <div class = "col-12">
             <span> ¿Desea eliminar el registro?</span>
             </div>
                    </div>
                           
     </div>
      <div class="modal-footer">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional"   >
    <ContentTemplate>

        <asp:HiddenField ID="HiddenField6" runat="server" />
  
          <asp:LinkButton ID="bntEliminarConcepto" CssClass="btn btn-default" OnClick="bntEliminarConcepto_Click"  runat="server" >
                           <i class="fa fa-trash" title="delete"></i>  Eliminar 
                                </asp:LinkButton>
                        
             <button type="button" class="btn btn-default" data-dismiss="modal">
               <span class="glyphicon glyphicon-remove-sign p-1" title="cerrar"></span>Cerrar</button>
      </ContentTemplate>
                </asp:UpdatePanel>
      </div>

    </div>

  </div>
    </div>
      <%-- .........................eliminar impuesto............................ --%>
        <div id="ModalEliminarImpuesto" class="modal fade" data-backdrop="static" role="dialog"
        runat="server" data-keyboard="false">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header d-block bg-light"  style="padding:10px 10px 0 10px; ">
        <h4 class="d-inline-block ml-3"  >
                           Eliminar Impuesto</h4>
                               <button type="button" class="close  bottom-ri    ght mr-3 btn-lg" aria-label="Close" data-dismiss="modal" style="font-size: 40px;">
                            <span aria-hidden="true">&times;</span></button>  </div>
               
      <div class="modal-body">
           <div class = "row">
           <div class = "col-12">
             <span> ¿Desea eliminar el registro?</span>
             </div>
                    </div>
                           
     </div>
      <div class="modal-footer">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server"  UpdateMode="Conditional"   >
    <ContentTemplate>

        <asp:HiddenField ID="HiddenField3" runat="server" />
  
          <asp:LinkButton ID="bntEliminarImpuesto" CssClass="btn btn-default" OnClick="bntEliminarImpuesto_Click"  runat="server" >
                           <i class="fa fa-trash" title="delete"></i>  Eliminar 
                                </asp:LinkButton>
                        
             <button type="button" class="btn btn-default" data-dismiss="modal">
               <span class="glyphicon glyphicon-remove-sign p-1" title="cerrar"></span>Cerrar</button>
      </ContentTemplate>
                </asp:UpdatePanel>
      </div>

    </div>

  </div>
    </div>
      <%-- .........................Buscar Partida............................ --%>

        <div id="ModalBuscarPartida" class="modal fade" data-backdrop="static" role="dialog"
        runat="server" data-keyboard="false">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header d-block bg-light"  style="padding:10px 10px 0 10px; ">
        <h4 class="d-inline-block ml-3"  >
                           Buscar Conceptos Historico</h4>
                               <button type="button" class="close  bottom-ri    ght mr-3 btn-lg" aria-label="Close" data-dismiss="modal" style="font-size: 40px;">
                            <span aria-hidden="true">&times;</span></button>  </div>

            <asp:UpdatePanel ID="UpdatePanel3" runat="server"  UpdateMode="Conditional"   >
    <ContentTemplate>       
      <div class="modal-body">
        <div class = "row">
               <div class="col-12">
               <asp:Label ID="Label30" class="control-label" runat="server" Text="Clave de producto"></asp:Label>
                                   <asp:TextBox runat="server"  CssClass="form-control" ID="txtConceptoHistoricoBusqueda"  />
                </div>
               </div>
       
            <div class="row">
                <div class="col-12">
                   <asp:Label  class="control-label" runat="server" ID="lblMensajeHistorico" ForeColor="Red" />
		       </div>
            </div>
            
             <div  class="row mt-4">
                <div class = "col-12"> 
                  <div class="table-responsive  border border-dark">
  
        <asp:GridView runat="server" ID="gvBuscarConceptosHistorico" Width="100%" AutoGenerateColumns="False" 
		 DataKeyNames="IdProducto" ShowHeaderWhenEmpty="True" CssClass="table table-hover table-striped grdViewTable"
			onrowcommand="gvBuscarConceptosHistorico_RowCommand"  OnRowDataBound="gvBuscarConceptosHistorico_RowDataBound"
            allowpaging="true" pagesize="6" >
			<Columns>
				<asp:BoundField HeaderText="Código" DataField="Codigo" />
				<asp:BoundField HeaderText="Descripción" DataField="Descripcion" />
				<%--<asp:BoundField HeaderText="Observaciones" DataField="Observaciones" />--%>
				<asp:BoundField HeaderText="Precio" DataField="PrecioP" DataFormatString="{0:C}" />
			<%--	<asp:ButtonField  Text="Seleccionar" CommandName="Seleccionar"/>
             --%>       <asp:TemplateField HeaderStyle-CssClass="sorting_disabled"  HeaderText= "Opciones"  ItemStyle-Width="10%"   
                             ItemStyle-HorizontalAlign="Center" >
                            <ItemTemplate  >
                                <div class="form-inline" >
                                      <asp:LinkButton ID="gvlnkEditar" CommandName="Editar"
                                          CommandArgument='<%#((GridViewRow)Container).RowIndex%>' 
                                           CssClass="btn btn-light" runat="server" style=" padding:0px 3px;" >
                                           <i class="glyphicon glyphicon-ok"  title="Seleccionar"></i> 
                                        </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField> 
			</Columns>
		</asp:GridView>
        </div>
             </div>
                 </div>
        </div>
                             
    
      <div class="modal-footer">


        <asp:HiddenField ID="HiddenField2" runat="server" />
  
         <asp:LinkButton ID="btnBuscarConceptoHistorico" CssClass="btn btn-default" 
                Text="Concepto" runat="server"   OnClick="btnBuscarConceptoHistorico_Click" >
                           <span class="glyphicon  glyphicon-search"></span> Buscar </asp:LinkButton>
              
   
             <button type="button" class="btn btn-default" data-dismiss="modal">
               <span class="glyphicon glyphicon-remove-sign p-1" title="cerrar"></span>Cerrar</button>
      </div>
     </ContentTemplate>
           <Triggers>
                  <asp:AsyncPostBackTrigger  ControlID="btnBuscarConceptoHistorico" EventName="Click" />
                  <asp:AsyncPostBackTrigger  ControlID="btnBuscarHistorico" EventName="Click" />
           
           </Triggers>
       </asp:UpdatePanel>
      
        
    </div>
    </div>

  </div>

    <%-- .........................Buscar c_ClaveProdServ............................ --%>
        <div id="ModalBuscarClaveProduServ" class="modal fade" data-backdrop="static" role="dialog"
        runat="server" data-keyboard="false">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header d-block bg-light"  style="padding:10px 10px 0 10px; ">
        <h4 class="d-inline-block ml-3"  >
                           Buscar Conceptos </h4>
                               <button type="button" class="close  bottom-ri    ght mr-3 btn-lg" aria-label="Close" data-dismiss="modal" style="font-size: 40px;">
                            <span aria-hidden="true">&times;</span></button>  </div>

            <asp:UpdatePanel ID="UpdatePanel6" runat="server"  UpdateMode="Conditional"   >
    <ContentTemplate>       
      <div class="modal-body">
        <div class = "row">
               <div class="col-12">
               <asp:Label ID="Label6" class="control-label" runat="server" Text="Descripción producto"></asp:Label>
               <asp:TextBox runat="server" CssClass="form-control" ID="txtConceptoBusqueda" />
                </div>
               </div>
       
            <div class="row">
                <div class="col-12">
                   <asp:Label  class="control-label" runat="server" ID="lblMensaje" ForeColor="Red" />
		       </div>
            </div>
            
             <div  class="row mt-4">
                <div class = "col-12"> 
                  <div class="table-responsive  border border-dark">
  
        <asp:GridView runat="server" ID="gvBuscarConceptos" Width="100%" AutoGenerateColumns="False" 
		 DataKeyNames="c_ClaveProdServ1" ShowHeaderWhenEmpty="True" CssClass="table table-hover table-striped grdViewTable"
			onrowcommand="gvBuscarConceptos_RowCommand"  OnRowDataBound="gvBuscarConceptos_RowDataBound"
            allowpaging="true" pagesize="6" >
			<Columns>
				  <asp:BoundField HeaderText="Código" DataField="c_ClaveProdServ1" />
                    <asp:BoundField HeaderText="Descripción" DataField="Descripcion" />
                <asp:TemplateField HeaderStyle-CssClass="sorting_disabled"  HeaderText= "Opciones"  
                      ItemStyle-Width="10%"      ItemStyle-HorizontalAlign="Center" >
                            <ItemTemplate  >
                                <div class="form-inline" >
                                      <asp:LinkButton ID="gvlnkEditar" CommandName="Editar"
                                          CommandArgument='<%#((GridViewRow)Container).RowIndex%>' 
                                           CssClass="btn btn-light" runat="server" style=" padding:0px 3px;" >
                                           <i class="glyphicon glyphicon-ok"  title="Seleccionar"></i> 
                                        </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField> 
			</Columns>
		</asp:GridView>
        </div>
             </div>
                 </div>
        </div>
                             
    
      <div class="modal-footer">


        <asp:HiddenField ID="HiddenField7" runat="server" />
             

         <asp:LinkButton ID="btnBuscarConcepto" CssClass="btn btn-default" 
                Text="Concepto" runat="server"   OnClick="btnBuscarConcepto_Click" >
                           <span class="glyphicon  glyphicon-search"></span> Buscar </asp:LinkButton>
              
   
             <button type="button" class="btn btn-default" data-dismiss="modal">
               <span class="glyphicon glyphicon-remove-sign p-1" title="cerrar"></span>Cerrar</button>
      </div>
     </ContentTemplate>
           <Triggers>
                  <asp:AsyncPostBackTrigger  ControlID="btnBuscarConcepto" EventName="Click" />
                     <asp:AsyncPostBackTrigger  ControlID="btnBuscarProducto" EventName="Click" />
                      
           </Triggers>
       </asp:UpdatePanel>
      
        
    </div>
    </div>

  </div>
     <%-- .........................Editar Partida............................ --%>
     <div id="ModalEditarPartida" class="modal fade" data-backdrop="static" role="dialog"
        runat="server" data-keyboard="false">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
        <div class="modal-header d-block bg-light"  style="padding:10px 10px 0 10px; ">
        <h4 class="d-inline-block ml-3"  >
                            Editar Concepto</h4>
                               <button type="button" class="close  bottom-ri    ght mr-3 btn-lg" aria-label="Close" data-dismiss="modal" style="font-size: 40px;">
                            <span aria-hidden="true">&times;</span></button>
         </div>

         <asp:UpdatePanel ID="UpdatePanel7" runat="server"  UpdateMode="Conditional"   >
       <ContentTemplate>
           
      <div class="modal-body">
                    <div class = "row"> 
                    <div class="col-12" >
                        <asp:Label  class="control-label" ID="Label2" runat="server" Text="ClaveUnidad"></asp:Label>
                       <asp:DropDownList ID="ddlClaveUnidadE" runat="server" CssClass="form-control" AutoPostBack="True" 
                       OnSelectedIndexChanged="ddlClaveUnidadE_SelectedIndexChanged">
                      </asp:DropDownList>                        
                      </div>
                   </div>
                    
            <div class = "row "> 
            <div class="col-12" >                    
                        <asp:Label  class="control-label" ID="Label5" runat="server" Text="Código"></asp:Label>
                        <asp:TextBox ID="txtCodigoE" runat="server" CssClass="form-control" />
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="* Requerido"
                        Display="Dynamic" ControlToValidate="txtCodigoE" ValidationGroup="Concepto" />
                        </div>
            </div>
         <div class = "row "> 
                     <div class="col-12" >
                        <asp:Label  class="control-label" ID="Label20" runat="server" Text="Cantidad"></asp:Label>
                        <asp:TextBox runat="server" ID="txtCantidadEdita" CssClass="form-control"/>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Requerido"
                        Display="Dynamic" ControlToValidate="txtCantidadEdita" ValidationGroup="Concepto" />
                    <asp:CompareValidator runat="server" ID="CompareValidator2" ControlToValidate="txtCantidadEdita"
                        Display="Dynamic" Type="Double" ErrorMessage="* Cantidad Invalida" ValidationGroup="Concepto"
                        Operator="DataTypeCheck" />
                    <asp:HiddenField runat="server" ID="hidDetalle" />
                    <asp:HiddenField runat="server" ID="hidNumero" />
                </div>
          </div>
          <div class = "row "> 
                     <div class="col-12" >
                        <asp:Label  class="control-label" ID="Label21" runat="server" Text="Unidad de Medida"></asp:Label>
                        <asp:TextBox runat="server" ID="txtUnidadEdita" CssClass="form-control"/>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* Requerido"
                        Display="Dynamic" ControlToValidate="txtUnidadEdita" ValidationGroup="Concepto" />
          </div>
           </div>
           <div class = "row">
                    <div class="col-12" >
                        <asp:Label  class="control-label" ID="Label22" runat="server" Text="N° de identificación"></asp:Label>
                        <asp:TextBox runat="server" ID="txtNoIdentificacionEdita" CssClass="form-control"></asp:TextBox>
           </div>
            </div>
           <div class = "row "> 
                    <div class="col-12" >
                        <asp:Label  class="control-label" ID="Label23" runat="server" Text="Descripción"></asp:Label>
                        <asp:TextBox runat="server" ID="txtDescripcionEdita" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="* Requerido"
                        Display="Dynamic" ControlToValidate="txtDescripcionEdita" ValidationGroup="Concepto" />
              </div>
            </div> 
           <div class = "row"> 
                    <div class="col-12" >
                        <asp:Label  class="control-label" ID="Label24" runat="server" Text="Observaciones"></asp:Label>
                        <asp:TextBox runat="server" ID="txtObservacionesEdita" CssClass="form-control"></asp:TextBox>
          </div>
           </div>
           <div class = "row "> 
                    <div class="col-12" >
                        <asp:Label  class="control-label" ID="Label25" runat="server" Text="Precio Unitario"></asp:Label>
                        <asp:TextBox runat="server" ID="txtPrecioUnitarioEdita" CssClass="form-control"></asp:TextBox>
                    <asp:CompareValidator runat="server" ID="CompareValidator3" ControlToValidate="txtPrecioUnitarioEdita"
                        Display="Dynamic" Type="Double" ErrorMessage="* Cantidad Invalida" ValidationGroup="Concepto"
                        Operator="DataTypeCheck" />
                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator8" ErrorMessage="* Requerido"
                        Display="Dynamic" ControlToValidate="txtPrecioUnitarioEdita" ValidationGroup="Concepto" />
           </div>
           </div>
           <div class = "row "> 
                    <div class="col-12" >
                        <asp:Label  class="control-label" ID="Label26" runat="server" Text="Descuento"></asp:Label>
                        <asp:TextBox ID="txtDescuentoE" runat="server" CssClass="form-control" />
           </div>
           </div>
         <div class = "row"> 
                    <div class="col-12" >
                        <asp:Label  class="control-label" ID="Label27" runat="server" Text="Cuenta Predial"></asp:Label>
                        <asp:TextBox ID="txtCuentaPredialE" runat="server" CssClass="form-control"/>
                    </div>
             </div>            
        
     </div>
    
      <div class="modal-footer">
              
                           <asp:LinkButton ID="btnGuardar" CssClass="btn btn-default" 
                                      Text="Concepto" runat="server"   OnClick="btnGuardar_Click" >
                           <span class="glyphicon glyphicon-floppy-saved"></span> Guardar 
                         </asp:LinkButton>
           <button type="button" class="btn btn-default" data-dismiss="modal">
               <span class="glyphicon glyphicon-remove-sign p-1" title="enviar"></span>Cerrar</button>
      </div>
        </ContentTemplate>
             <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="gvDetalles" EventName="RowCommand"/> 
         
             </Triggers>
                       </asp:UpdatePanel>

    </div>

  </div>
    </div>  
      <%-- .........................Mensaje Error............................ --%>
     <div id="ModalError" class="modal fade" data-backdrop="static" role="dialog"
        runat="server" data-keyboard="false">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header d-block " style="padding:10px 10px 0 10px; background-color:#eb8181 ">
        <h4 class="d-inline-block ml-3" style="color:white" >Error </h4>
               <button type="button" class="close  bottom-ri    ght mr-3 btn-lg" aria-label="Close" data-dismiss="modal" style="font-size: 40px;">
                 <span aria-hidden="true">&times;</span></button>
                       </div>

                
      <div class="modal-body">
           <div class = "row">
                    
                    <div class = "col-12">
                   <asp:UpdatePanel ID="UpdatePanel4" runat="server"  UpdateMode="Conditional"   >
                    <ContentTemplate>
                     <asp:Label ID="lblError" runat="server"  CssClass="form-label"  />
                   </ContentTemplate>
                       <Triggers>
                             <asp:AsyncPostBackTrigger  ControlID="BtnVistaPreviaP" EventName="Click" />
                            <asp:AsyncPostBackTrigger  ControlID="lnkDeleteFac" EventName="Click" />
                               <asp:AsyncPostBackTrigger  ControlID="btnAgregar" EventName="Click" />
                               <asp:AsyncPostBackTrigger  ControlID="btnAgregarImpuesto" EventName="Click" />
                           <asp:AsyncPostBackTrigger  ControlID="LinkButton1" EventName="Click" />
                             
                       
                       </Triggers>
                    </asp:UpdatePanel>
                        
                    </div>
                    </div>
                     
        
     </div>
    
      <div class="modal-footer">
              
    

        <asp:HiddenField ID="HiddenField4" runat="server" />

                  <button type="button" class="btn btn-default" data-dismiss="modal">
               <span class="glyphicon glyphicon-remove-sign p-1" title="cerrar"></span>Cerrar</button>

      </div>

    </div>

  </div>
    </div>
     <%-- .........................Mensaje confirmar............................ --%>
    
    <div id="ModalConfirmar" class="modal fade" data-backdrop="static" role="dialog"
        runat="server" data-keyboard="false">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header d-block bg-light"  style="padding:10px 10px 0 10px; ">
        <h4 class="d-inline-block ml-3" >
                           Generar la factura</h4>
                               <button type="button" class="close  bottom-ri    ght mr-3 btn-lg" aria-label="Close" data-dismiss="modal" style="font-size: 40px;">
                            <span aria-hidden="true">&times;</span></button>
                 
                    </div>

                
      <div class="modal-body">
           <div class = "row">
                    
                    <div class = "col-12">
             <span> Confirma que deseas generar el comprobante </span>
                        </div>
                    </div>
                     
        
     </div>
    
      <div class="modal-footer">
              
            <asp:UpdatePanel ID="UpdatePanel5" runat="server"  UpdateMode="Conditional"   >
    <ContentTemplate>

        <asp:HiddenField ID="HiddenField8" runat="server" />
     <asp:LinkButton ID="lnkDeleteFac" CssClass="btn btn-default" OnClick="lnkDeleteFac_Click" 
        OnClientClick ="HideModal()" runat="server" >
                           <i class="fas fa-check" title="delete"></i>  Generar 
                                </asp:LinkButton>
    
                         
        
             <button type="button" class="btn btn-default" data-dismiss="modal">
               <span class="glyphicon glyphicon-remove-sign p-1" title="cerrar"></span>Cerrar</button>

      </ContentTemplate>
                <Triggers>
                       <asp:AsyncPostBackTrigger  ControlID="btnGenerarFactura" EventName="Click" />
                                  
                </Triggers>

                </asp:UpdatePanel>
      </div>

    </div>

  </div>
    </div>
  <%-- .........................Mensaje Generado correcto............................ --%>
    
         <div id="ModalOK" class="modal fade" data-backdrop="static" role="dialog"
        runat="server" data-keyboard="false">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header d-block " style="padding:10px 10px 0 10px; background-color:#A8CF38 ">
        <h4 class="d-inline-block ml-3" style="color:white" >Mensaje </h4>
               <button type="button" class="close  bottom-ri    ght mr-3 btn-lg" aria-label="Close" data-dismiss="modal" style="font-size: 40px;">
                 <span aria-hidden="true">&times;</span></button>
                      </div>

                
      <div class="modal-body">
           <div class = "row">
                    
                    <div class = "col-12">
                       <asp:Label ID="lblOK2" runat="server" Text="Comprobante generado correctamente  y enviado por correo electrónico" ForeColor="Black"  CssClass="form-label"  />
          
                        
                    </div>
                    </div>
                     
        
     </div>
    
      <div class="modal-footer">
           <asp:UpdatePanel ID="UpdatePanel8" runat="server"  UpdateMode="Conditional"   >
                    <ContentTemplate>
                   
           <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default"  OnClientClick ="HideModal2()"
                                      Text="Concepto" runat="server"   OnClick="LinkButton1_Click" >
                           <span class="glyphicon glyphicon-download"></span> Descargar PDF 
                         </asp:LinkButton>
           
                  </ContentTemplate>
                       <Triggers>
                          <asp:AsyncPostBackTrigger  ControlID="LinkButton1" EventName="Click" />
                            <asp:AsyncPostBackTrigger  ControlID="lnkDeleteFac" EventName="Click" />
                          <%-- <asp:postbacktrigger ControlID="LinkButton1"/>--%>

                       </Triggers>
                    </asp:UpdatePanel>
                   
                  <button type="button" class="btn btn-default" data-dismiss="modal">
               <span class="glyphicon glyphicon-remove-sign p-1" title="cerrar"></span>Cerrar</button>

      </div>

    </div>

  </div>
    </div>
 
  <%-- .........................Mensaje Sellos............................ --%>

     <div id="ModalSellos" class="modal fade" data-backdrop="static" role="dialog"
        runat="server" data-keyboard="false">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header d-block bg-warning" style="padding:10px 10px 0 10px;">
        <h4 class="d-inline-block ml-3" style="color:white" >¡Importante! </h4>
               <button type="button" class="close  bottom-ri    ght mr-3 btn-lg" aria-label="Close" data-dismiss="modal" style="font-size: 40px;">
                 <span aria-hidden="true">&times;</span></button>
                       </div>

                
      <div class="modal-body">
           <div class = "row">
                    
                    <div class = "col-12">
                   <asp:UpdatePanel ID="UpdatePanel9" runat="server"  UpdateMode="Conditional"   >
                    <ContentTemplate>
                     <asp:Label ID="Label28" runat="server" CssClass="form-label"  />
                   </ContentTemplate>
                      </asp:UpdatePanel>
                        
                    </div>
                    </div>
                     
        
     </div>
    
      <div class="modal-footer">
    

        <asp:HiddenField ID="HiddenField1" runat="server" />

                  <button type="button" class="btn btn-default" data-dismiss="modal">
               <span class="glyphicon glyphicon-remove-sign p-1" title="cerrar"></span>Cerrar</button>

      </div>

    </div>

  </div>
    </div>
   
  <%-- ...........................******************....................................... --%>
                           
  
      


</asp:Content>
