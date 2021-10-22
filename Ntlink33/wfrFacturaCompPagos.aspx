<%@ Page Title="Pagos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrFacturaCompPagos.aspx.cs" MaintainScrollPositionOnPostBack="true" Inherits="Ntlink33.wfrFacturaCompPagos"  EnableEventValidation="false" %>
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
               <h3> Complemento Pagos</h3>
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
                        <asp:Label  class="control-label" ID="lblCliente" runat="server" Text="Cliente"  ></asp:Label>

                           <asp:UpdatePanel ID="UpdatePanelR1" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>                      
                            <div style="width:100%;display: flex;  align-items: stretch;">
                                <asp:DropDownList ID="ddlClientes" runat="server" Width="100%"
                            CssClass ="drpCountryRGV" data-live-search-style="begins" title="Seleccione"
                                    data-live-search="true"
                                    OnSelectedIndexChanged="ddlClientes_SelectedIndexChanged"
                            DataTextField="RazonSocial"  AutoPostBack="True"  DataValueField="idCliente">
                           </asp:DropDownList>
                  
                         <asp:LinkButton ID="btnBuscar" CssClass="btn btn-default lineal"   OnClick="btnBuscar_Click" 
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
                                 

                     

                    </div>
      
                          
                    </ContentTemplate>
                       
                    </asp:UpdatePanel>          
                
                   <asp:UpdatePanel ID="UpdatePanelR6" runat="server"  UpdateMode="Conditional">
                   <ContentTemplate>   
                                  
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
              
            </asp:UpdatePanel>

                   
                   </div>  <%--Termina panel-body--%>
        </div>  <%--Termina Segunda Sección - CFDI Relacionados--%>
      
</div>
          
          <%---------------Termina  Relacionados---------------%>
    
         <%---------------Tercera Sección - complemento---------------%>
                
         
         <div class="panel panel-default" style="width:100%">
	     <div class="panel-heading" data-toggle="collapse" data-parent="#accordion3" data-target="#Acordion3">
         <span data-toggle="collapse" class="icon pull-right"><em class=" glyphicon glyphicon-s glyphicon-plus fa-lg" style="font-size: 14px" ></em></span>
              <h4 class="panel-title">
            <a>
                <b> Complemento</b>
            </a>
          </h4>
          </div>
		 
        <div id="Acordion3" class="panel-collapse collapse">
          <div class="panel-body">
               <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional"  >
               <ContentTemplate>
          
               
       <div class = "row"> 
                    <div class = "form-group col-lg-3">
                         <asp:Label ID="lblAsteriscoImpuesto" runat="server" ForeColor="Red" Text="* "></asp:Label>
                        <asp:Label ID="Label3" class="control-label" runat="server" Text="FechaPago"></asp:Label>
                        <asp:TextBox ID="txtFechaPagoP" runat="server" CssClass="form-control"></asp:TextBox>
                       
                        <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" 
                            PopupButtonID="txtFechaPagoP" 
                            TargetControlID="txtFechaPagoP" />
                   <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator9" ControlToValidate="txtFechaPagoP"
                            Display="Dynamic" ErrorMessage="* Requerido" ForeColor="Red" 
                         ValidationGroup="btnAgregarPagos" style="font-size: medium" />
                        
                        <asp:CompareValidator ID="cvFechaInicial" runat="server"
                            ControlToValidate="txtFechaPagoP" Display="Dynamic" ForeColor="Red" 
                            ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
                        </div>
             <div class = "form-group col-lg-3">
                  <asp:Label ID="Label2" runat="server" ForeColor="Red" Text="* "></asp:Label>
                        <asp:Label ID="Label11" class="control-label" runat="server" Text="FormaDePagoP"></asp:Label>
                  <asp:DropDownList runat="server" ID="ddlFormaPagoP" 
                    CssClass ="btn btn-default dropdown-toggle optionAlinear"  Width="100%" BackColor="White"
                         >
   <asp:ListItem runat="server" Value="01" Text="Efectivo"></asp:ListItem>
<asp:ListItem runat="server" Value="02" Text="Cheque nominativo"></asp:ListItem>
<asp:ListItem runat="server" Value="03" Text="Transferencia electrónica de fondos"></asp:ListItem>
<asp:ListItem runat="server" Value="04" Text="Tarjeta de crédito"></asp:ListItem>
<asp:ListItem runat="server" Value="05" Text="Monedero electrónico"></asp:ListItem>
<asp:ListItem runat="server" Value="06" Text="Dinero electrónico"></asp:ListItem>
<asp:ListItem runat="server" Value="08" Text="Vales de despensa"></asp:ListItem>
<asp:ListItem runat="server" Value="12" Text="Dación en pago"></asp:ListItem>
<asp:ListItem runat="server" Value="13" Text="Pago por subrogación"></asp:ListItem>
<asp:ListItem runat="server" Value="14" Text="Pago por consignación"></asp:ListItem>
<asp:ListItem runat="server" Value="15" Text="Condonación"></asp:ListItem>
<asp:ListItem runat="server" Value="17" Text="Compensación"></asp:ListItem>
<asp:ListItem runat="server" Value="23" Text="Novación"></asp:ListItem>
<asp:ListItem runat="server" Value="24" Text="Confusión"	></asp:ListItem>
<asp:ListItem runat="server" Value="25" Text="Remisión de deuda"></asp:ListItem>
<asp:ListItem runat="server" Value="26" Text="Prescripción o caducidad"></asp:ListItem>
<asp:ListItem runat="server" Value="27" Text="A satisfacción del acreedor"></asp:ListItem>
<asp:ListItem runat="server" Value="28" Text="Tarjeta de débito"></asp:ListItem>
<asp:ListItem runat="server" Value="29" Text="Tarjeta de servicios"></asp:ListItem>
<asp:ListItem runat="server" Value="30" Text="Aplicación de anticipos"></asp:ListItem>
<asp:ListItem runat="server" Value="31" Text="Intermediario pagos"></asp:ListItem>
<asp:ListItem runat="server" Value="99" Text="Por definir"></asp:ListItem>
 </asp:DropDownList>

                      <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator10" ControlToValidate="ddlFormaPagoP"
                            Display="Dynamic" ErrorMessage="* Requerido" ForeColor="Red"
                         ValidationGroup="btnAgregarPagos" style="font-size: medium" />

             </div>
        </div>
                 <div class = "row"> 
                    <div class = "form-group col-lg-3">
                         <asp:Label ID="Label5" runat="server" ForeColor="Red" Text="* "></asp:Label>
                        <asp:Label ID="Label4" class="control-label" runat="server" Text="Monto"></asp:Label>
                        <asp:TextBox ID="txtMonto" runat="server"  CssClass="form-control" 
                            ></asp:TextBox>
                          <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server"
            TargetControlID="txtMonto" FilterType="Custom, Numbers"   ValidChars="." Enabled="True" />
                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator12" ControlToValidate="txtMonto" CssClass="alert-error"
                            Display="Dynamic" ErrorMessage="* Requerido" 
                         ValidationGroup="btnAgregarPagos" ForeColor="Red"
                         style="color: #FF0000; font-size: medium;" />
                         <asp:CompareValidator runat="server" ID="CompareValidator4" ControlToValidate="txtMonto"
                            Display="Dynamic" ErrorMessage="* Precio invalido" Type="Double" Operator="DataTypeCheck"
                            ValidationGroup="btnAgregarPagos" ForeColor="Red"
                         style="color: #FF0000; font-size: medium;" />
   
                </div>
                      <div class = "form-group col-lg-3">
                           <asp:Label ID="Label6" runat="server" ForeColor="Red" Text="* "></asp:Label>
                        <asp:Label ID="Label16" class="control-label" runat="server" Text="MonedaP"></asp:Label>
        
                             <asp:DropDownList ID="ddlMonedaP" runat="server" Width="100%"  
                           AutoPostBack="True"  DataTextField="Descripción" DataValueField="c_Moneda1" 
                            CssClass ="drpCountryRGV" data-live-search-style="begins"  title="Seleccione"  data-live-search="true"
                           OnSelectedIndexChanged="ddlMonedaP_SelectedIndexChanged"   /> 


                          <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator11" ControlToValidate="ddlMonedaP"
                            Display="Dynamic" ErrorMessage="* *Requerido" ForeColor="Red"
                         ValidationGroup="btnAgregarPagos" style="font-size: medium" />

                          </div>
                         <div class = "form-group col-lg-3">
                        <asp:Label ID="lblTipoCambioP" class="control-label" runat="server" Text="Tipo Cambio" Visible="False"></asp:Label>
                       <asp:TextBox runat="server" ID="txtTipoCambioP" CssClass="form-control" Visible="False" />
                         </div>
                </div>
                <div class = "row"> 
                    <div class = "form-group col-lg-12">
                   <h4> <asp:Label ID="Label17" class="control-label" runat="server" Text="Datos Bancarios"></asp:Label></h4>
                 </div>
                    </div>
                  </ContentTemplate>
                   <Triggers><asp:AsyncPostBackTrigger  ControlID="btnAgregarPagos" EventName="Click" />
                </Triggers>
                   </asp:UpdatePanel>

                    <asp:UpdatePanel ID="UpdatePanel2" runat="server"  UpdateMode="Conditional"  >
               <ContentTemplate>
                  <div class = "row"> 
                    <div class = "form-group col-lg-3">
                    <asp:Label ID="Label14" class="control-label" runat="server" Text="NumOperacion"></asp:Label>
                 <asp:TextBox ID="txtNumOperacion" runat="server"  CssClass="form-control"></asp:TextBox>
   
                        </div>
                   
                    <div class = "form-group col-lg-3">
                    <asp:Label ID="Label31" class="control-label" runat="server" Text="RfcEmisorCtaOrd"></asp:Label>
            <asp:DropDownList runat="server" ID="ddlrfcemisor" 
             CssClass ="btn btn-default dropdown-toggle optionAlinear"  Width="100%" BackColor="White"
                OnSelectedIndexChanged="ddlrfcemisor_SelectedIndexChanged1"
                AutoPostBack="True" >
                <asp:ListItem runat="server" Value="" Text="Seleccione" Selected="True"></asp:ListItem>
             <asp:ListItem runat="server" Value="BMN930209927" Text="BMN930209927 - BANORTE" ></asp:ListItem>
             <asp:ListItem runat="server" Value="BNM840515VB1" Text="BNM840515VB1 - BANAMEX"></asp:ListItem>
             <asp:ListItem runat="server" Value="BSM970519DU8" Text="BSM970519DU8 - SANTANDER"></asp:ListItem>
             <asp:ListItem runat="server" Value="BBA830831LJ2" Text="BBA830831LJ2 - BANCOMER"></asp:ListItem>
             <asp:ListItem runat="server" Value="HMI950125KG8" Text="HMI950125KG8 - HSBC"></asp:ListItem>
             <asp:ListItem runat="server" Value="SIN9412025I4" Text="SIN9412025I4 - SCOTIABANK"></asp:ListItem>
             <asp:ListItem runat="server" Value="00" Text="Otro"></asp:ListItem>
          </asp:DropDownList>
          <asp:TextBox ID="txtRfcEmisorCtaOrd" runat="server"  CssClass="form-control" 
              Visible="False"></asp:TextBox>
                </div>
                       <div class = "form-group col-lg-3">
                    <asp:Label ID="Label32" class="control-label" runat="server" Text="NomBancoOrdExt"></asp:Label>
                  <asp:TextBox ID="txtNomBancoOrdExt" runat="server" CssClass="form-control" ></asp:TextBox>
   
                      </div>
                     </div>
                   <div class = "row"> 
                    <div class = "form-group col-lg-3">
                    <asp:Label ID="Label33" class="control-label" runat="server" Text="CtaOrdenante"></asp:Label>
                 <asp:TextBox ID="txtCtaOrdenante" runat="server" CssClass="form-control" ></asp:TextBox>
   
                        </div>
                        <div class = "form-group col-lg-3">
                       <asp:Label ID="Label34" class="control-label" runat="server" Text="RfcEmisorCtaBen"></asp:Label>
              <asp:DropDownList runat="server" ID="ddlrfcben" 
                   CssClass ="btn btn-default dropdown-toggle optionAlinear"  Width="100%" BackColor="White"
                  AutoPostBack="True" OnSelectedIndexChanged="ddlrfcben_SelectedIndexChanged">
              <asp:ListItem runat="server" Value="" Text="Seleccione" Selected="True"></asp:ListItem>
             <asp:ListItem runat="server" Value="BMN930209927" Text="BMN930209927 - BANORTE" ></asp:ListItem>
             <asp:ListItem runat="server" Value="BNM840515VB1" Text="BNM840515VB1 - BANAMEX"></asp:ListItem>
             <asp:ListItem runat="server" Value="BSM970519DU8" Text="BSM970519DU8 - SANTANDER"></asp:ListItem>
             <asp:ListItem runat="server" Value="BBA830831LJ2" Text="BBA830831LJ2 - BANCOMER"></asp:ListItem>
             <asp:ListItem runat="server" Value="HMI950125KG8" Text="HMI950125KG8 - HSBC"></asp:ListItem>
             <asp:ListItem runat="server" Value="SIN9412025I4" Text="SIN9412025I4 - SCOTIABANK"></asp:ListItem>
             <asp:ListItem runat="server" Value="00" Text="Otro"></asp:ListItem>
              </asp:DropDownList>
             <asp:TextBox ID="txtRfcEmisorCtaBen" runat="server" CssClass="form-control" Visible="False"></asp:TextBox>
                       </div>
                        <div class = "form-group col-lg-3">
                       <asp:Label ID="Label35" class="control-label" runat="server" Text="CtaBeneficiario"></asp:Label>
                        <asp:TextBox ID="txtCtaBeneficiario" runat="server"  CssClass="form-control"></asp:TextBox>
  
                            </div>
                        <div class = "form-group col-lg-3">
                         <asp:Label ID="Label36" class="control-label" runat="server" Text="TipoCadPago"></asp:Label>
                       <asp:DropDownList runat="server" ID="ddlTipoCadPago" 
                          CssClass ="btn btn-default dropdown-toggle optionAlinear"  Width="100%" BackColor="White">
                         <asp:ListItem runat="server" Value="" Text=""></asp:ListItem>
                         <asp:ListItem runat="server" Value="01" Text="SPEI"></asp:ListItem>
                           </asp:DropDownList>
   
                        </div>

                       </div>
               <div class = "row"> 
                    <div class = "form-group col-lg-3">
                    <asp:Label ID="Label37" class="control-label" runat="server" Text="CertPago"></asp:Label>
                    <asp:TextBox ID="txtCertPago" runat="server"  CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class = "form-group col-lg-3">
                    <asp:Label ID="Label38" class="control-label" runat="server" Text="CadPago"></asp:Label>
                    <asp:TextBox ID="txtCadPago" runat="server"  CssClass="form-control"></asp:TextBox>
                    </div>
                      <div class = "form-group col-lg-3">
                    <asp:Label ID="Label39" class="control-label" runat="server" Text="SelloPago"></asp:Label>
                          <asp:TextBox ID="txtSelloPago" runat="server"  CssClass="form-control"></asp:TextBox>
                    </div>
               </div>
                  <div class = "row">
                    <div class = "col-lg-12 float-right" style="float:right">
              

                             <asp:LinkButton ID="btnAgregarPagos" CssClass="btn btn-default" 
                             OnClick="btnAgregarPagos_Click" 
                              ValidationGroup="btnAgregarPagos" Text="Relacionado"
                             runat="server" ><span class="fas fa-plus"></span> Agregar 
                         </asp:LinkButton>

                       </div>
                </div>
                          <br />
                   </ContentTemplate>
                        </asp:UpdatePanel>
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server"  UpdateMode="Conditional"  >
               <ContentTemplate>
                     <div  class="row mt-4">
                <div class = "col-12"> 
                  <div class="table-responsive  border border-dark">
  
                     <asp:GridView ID="gvPagos" class="table table-bordered table-hover table-striped grdViewTable" 
                         runat="server" AutoGenerateColumns="false" DataKeyNames="ID"  BackColor="White" AlternatingRowStyle-HorizontalAlign="Left" 
                         OnRowCommand="gvPagos_RowCommand" Width="100%" RowStyle-Height="5"   BorderWidth="0px"
                        >
                         <RowStyle  Height="10" Font-Size="14px"  cssclass="RowStyle" />
                         <FooterStyle  Font-Bold="True"  />
                         <PagerStyle  Height="5"  />
                         <HeaderStyle BackColor="#f9f9f9" Font-Bold="True" ForeColor="Black" Height="30px" />
                          <AlternatingRowStyle Height="10"  cssclass="AlternateRowStyle" />  
                         <Columns>
                        <asp:BoundField HeaderText="ID" DataField="id"  ItemStyle-HorizontalAlign="Center" />
                                   <asp:BoundField HeaderText="FechaPago" DataField="FechaPago"  ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="FormaDePagoP" DataField="FormaDePagoP" ItemStyle-HorizontalAlign="Center"  />
				<asp:BoundField HeaderText="MonedaP" DataField="MonedaP" ItemStyle-HorizontalAlign="Center" />
				<asp:BoundField HeaderText="Monto" DataField="Monto"  ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="NumOperacion" DataField="NumOperacion"  ItemStyle-HorizontalAlign="Center" />
               			
			<%--	<asp:ButtonField Text="Eliminar" CommandName="EliminarPago" Visible="False" ItemStyle-HorizontalAlign="Center" />
			--%>    <asp:TemplateField  HeaderText="Opciones" ItemStyle-Width="10%" 
                           ItemStyle-HorizontalAlign="Center" >
                            <ItemTemplate  >
                                 <div class="form-inline">
                                       <asp:LinkButton ID="gvlnkDelete" ClientIDMode="AutoID"
                                           CommandName="EliminarPago"
                                           CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                           CssClass="btn btn-light" runat="server" style=" padding:0px 3px;" >
                                           <i class="glyphicon glyphicon-trash  " title="Eliminar"></i> 
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
                        <Triggers>        <asp:AsyncPostBackTrigger  ControlID="btnAgregarPagos" EventName="Click" />
                
                        </Triggers>
                   </asp:UpdatePanel>

   </div>
            </div>
</div>

                         
         <div class="panel panel-default" style="width:100%">
	     <div class="panel-heading" data-toggle="collapse" data-parent="#accordion4" data-target="#Acordion4">
         <span data-toggle="collapse" class="icon pull-right"><em class=" glyphicon glyphicon-s glyphicon-plus fa-lg" style="font-size: 14px" ></em></span>
              <h4 class="panel-title">
            <a>
                <b> Documento Relacionado</b>
            </a>
          </h4>
          </div>
		 
        <div id="Acordion4" class="panel-collapse collapse">
          <div class="panel-body">

             <asp:UpdatePanel ID="UpdatePanel10" runat="server"  UpdateMode="Conditional"  >
               <ContentTemplate> 
                   
                   <div class = "row"> 
                       <div class = "form-group col-lg-3">
                            <asp:Label ID="Label7" runat="server" ForeColor="Red" Text="* "></asp:Label>
                        <asp:Label ID="Label40" class="control-label" runat="server" Text="ID"></asp:Label>
                        <asp:DropDownList ID="ddlID" runat="server" AutoPostBack="True" 
                               CssClass ="btn btn-default dropdown-toggle optionAlinear"  Width="100%" BackColor="White"
                         > </asp:DropDownList>
                          <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator1" ControlToValidate="ddlID"
                            Display="Dynamic" ErrorMessage="* Requerido" ForeColor="Red"
                         ValidationGroup="AgregarDocumento" style="font-size: medium" />
                    </div>
                   
                   <div class = "form-group col-lg-5">
                        <asp:Label ID="Label18" runat="server" ForeColor="Red" Text="* "></asp:Label>
                    <asp:Label ID="Label41" class="control-label" runat="server" Text="Folio Fiscal"></asp:Label>
                   <asp:TextBox ID="txtIdDocumento" runat="server" CssClass="form-control" MaxLength="36"></asp:TextBox>
    <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator17" ControlToValidate="txtIdDocumento"
                            Display="Dynamic" ErrorMessage="* Requerido" ForeColor="Red"
                         ValidationGroup="AgregarDocumento" style="font-size: medium" />
                       </div>
                       <div class = "form-group col-lg-1"></div>
                       <div class = "form-group col-lg-2">
                           <br />
                      <button type="button" class="btn btn-default"   
                               onclick="javascript: window.open('wfrFacturasConsulta.aspx', '', 'width=1000,height=1000,left=50,top=50,toolbar=yes');"  >
                               <span class="glyphicon  glyphicon-search"></span>Consulta Reportes</button>
                   </div>
                     </div>
         </ContentTemplate>   <Triggers>
                              <asp:AsyncPostBackTrigger  ControlID="btnAgregarPagos" EventName="Click" />
             <asp:AsyncPostBackTrigger  ControlID="AgregarDocumento" EventName="Click" />
                
                           </Triggers>
                 </asp:UpdatePanel>
                                                <asp:UpdatePanel ID="UpdatePanel11" runat="server"  UpdateMode="Conditional"  >
                                        <ContentTemplate> 
                   <div class = "row"> 
                    <div class = "form-group col-lg-3">
                         <asp:Label ID="Label19" runat="server" ForeColor="Red" Text="* "></asp:Label>
                    <asp:Label ID="Label42" class="control-label" runat="server" Text="Folio"></asp:Label>
                    <asp:TextBox ID="txtFolioD" runat="server" CssClass="form-control"></asp:TextBox>
                     <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator18" ControlToValidate="txtFolioD"
                            Display="Dynamic" ErrorMessage="* Requerido" ForeColor="Red"
                         ValidationGroup="AgregarDocumento" style="font-size: medium" />
   
                    </div>
                      <div class = "form-group col-lg-3">
                    <asp:Label ID="Label43" class="control-label" runat="server" Text="Serie"></asp:Label>
                    <asp:TextBox ID="txtSerieD" runat="server" CssClass="form-control"></asp:TextBox>
   
                       </div>
                     
                               
            <div class = "form-group col-lg-3">
                    <asp:Label ID="Label44" class="control-label" runat="server" Text="MonedaDR"></asp:Label>

                              <asp:DropDownList ID="ddlMonedaDR" runat="server" Width="100%"  
                           AutoPostBack="True"  DataTextField="Descripción" DataValueField="c_Moneda1" 
                            CssClass ="drpCountryRGV" data-live-search-style="begins"  title="Seleccione"  data-live-search="true"
                           OnSelectedIndexChanged="ddlMonedaDR_SelectedIndexChanged"   /> 
                </div>
            <div class = "form-group col-lg-3">
                  
                            <asp:Label ID="lblTipoCambioDR" runat="server" Text="Tipo Cambio"   Visible="False" />
                             <asp:TextBox ID="txtTipoCambioDR" runat="server" Visible="False" CssClass="form-control" />
         </div>
</div>
                                        </ContentTemplate>
                                                    <Triggers>
                                                                <asp:AsyncPostBackTrigger  ControlID="AgregarDocumento" EventName="Click" />
                                                    </Triggers>
                                    </asp:UpdatePanel>
   
                        <asp:UpdatePanel ID="UpdatePanel6" runat="server"  UpdateMode="Conditional"  >
                            <Triggers> <asp:AsyncPostBackTrigger  ControlID="AgregarDocumento" EventName="Click" />
                
                                
                            </Triggers>
                                        <ContentTemplate> 

                 <div class = "row"> 
                          
                    <div class = "form-group col-lg-3">
                         <asp:Label ID="Label20" runat="server" ForeColor="Red" Text="* "></asp:Label>
                    <asp:Label ID="Label46" class="control-label" runat="server" Text="NumParcialidad"></asp:Label>
                     <asp:TextBox ID="txtNumParcialidad" runat="server" CssClass="form-control">1</asp:TextBox>
                     <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator13" ControlToValidate="txtNumParcialidad"
                            Display="Dynamic" ErrorMessage="* Requerido" ForeColor="Red"
                         ValidationGroup="AgregarDocumento" style="font-size: medium" />    
                     </div>
                     <div class = "form-group col-lg-3">
                          <asp:Label ID="Label21" runat="server" ForeColor="Red" Text="* "></asp:Label>
                     <asp:Label ID="Label47" class="control-label" runat="server" Text="ImpSaldoAnt"></asp:Label>
                    <asp:TextBox ID="txtImpSaldoAnt" runat="server" CssClass="form-control" 
                         ></asp:TextBox>
                   <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator16" ControlToValidate="txtImpSaldoAnt"
                            Display="Dynamic" ErrorMessage="* Requerido" ForeColor="Red"
                         ValidationGroup="AgregarDocumento" style="font-size: medium" />
                     </div>
                        <div class = "form-group col-lg-4">
                             <asp:Label ID="Label22" runat="server" ForeColor="Red" Text="* "></asp:Label>
                    <asp:Label ID="Label45" class="control-label" runat="server" Text="MetodoDePagoDR"></asp:Label>
                   <asp:DropDownList runat="server" ID="ddlMetodoDePagoDR" AutoPostBack="True"
                          CssClass ="btn btn-default dropdown-toggle optionAlinear"  Width="100%" BackColor="White" >
                          <%-- <asp:ListItem runat="server" Text="Pago en una sola exhibición" Value="PUE" Selected="False" ></asp:ListItem>--%>
                            <asp:ListItem runat="server" Text="Pago en parcialidades o diferido" Value="PPD" Selected="True"></asp:ListItem>
                        </asp:DropDownList>
   
                        </div>
                                 
                     </div>
                 <div class = "row"> 

                       <div class = "form-group col-lg-3">
                            <asp:Label ID="Label23" runat="server" ForeColor="Red" Text="* "></asp:Label>
                     <asp:Label ID="Label48" class="control-label" runat="server" Text="ImpPagado"></asp:Label>
                      <asp:TextBox ID="txtImpPagado" runat="server" CssClass="form-control"
                          AutoPostBack="True" ></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator14" ControlToValidate="txtImpPagado"
                            Display="Dynamic" ErrorMessage="* Requerido" ForeColor="Red"
                         ValidationGroup="AgregarDocumento" style="font-size: medium" />    

                       </div>
                        <div class = "form-group col-lg-3">
                             <asp:Label ID="Label24" runat="server" ForeColor="Red" Text="* "></asp:Label>
                      <asp:Label ID="Label49" class="control-label" runat="server" Text="ImpSaldoInsoluto"></asp:Label>
                      <asp:TextBox ID="txtImpSaldoInsoluto" runat="server" CssClass="form-control"
                          AutoPostBack="True" ></asp:TextBox>
                         <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator15" ControlToValidate="txtImpSaldoInsoluto" ForeColor="Red"
                            Display="Dynamic" ErrorMessage="* Requerido" ValidationGroup="AgregarDocumento" 
                             style="font-size: medium" />    
    
                        </div>

                </div>
                 <div class = "row">
                    <div class = "col-lg-12 float-right" style="float:right">
              
                                 <asp:LinkButton ID="AgregarDocumento" CssClass="btn btn-default" 
                             OnClick="btnAgregarDocumento_Click" 
                              ValidationGroup="AgregarDocumento" Text="Relacionado"
                             runat="server" ><span class="fas fa-plus"></span> Agregar 
                         </asp:LinkButton>

    <asp:CheckBox ID="DRcb" runat="server" AutoPostBack="True" Visible="False" />
                           </div>
                     </div>
                 <br />
                   </ContentTemplate>
                           </asp:UpdatePanel>

                            <asp:UpdatePanel ID="UpdatePanel7" runat="server"  UpdateMode="Conditional"  >
               <ContentTemplate> 
         
                        <div  class="row mt-4">
                <div class = "col-12"> 
                  <div class="table-responsive  border border-dark">
  
                     <asp:GridView ID="gvDocumento" class="table table-bordered table-hover table-striped grdViewTable" 
                         runat="server" AutoGenerateColumns="false" DataKeyNames="ID"  BackColor="White" AlternatingRowStyle-HorizontalAlign="Left" 
                         OnRowCommand="gvDocumento_RowCommand" Width="100%" RowStyle-Height="5"   BorderWidth="0px"
                        >
                         <RowStyle  Height="10" Font-Size="14px"  cssclass="RowStyle" />
                         <FooterStyle  Font-Bold="True"  />
                         <PagerStyle  Height="5"  />
                         <HeaderStyle BackColor="#f9f9f9" Font-Bold="True" ForeColor="Black" Height="30px" />
                          <AlternatingRowStyle Height="10"  cssclass="AlternateRowStyle" />  
                          <Columns>
              	<asp:BoundField HeaderText="ID" DataField="ID"  ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="IdDocumento" DataField="IdDocumento" ItemStyle-HorizontalAlign="Center"  />
				<asp:BoundField HeaderText="Serie" DataField="Serie" ItemStyle-HorizontalAlign="Center" />
				<asp:BoundField HeaderText="Folio" DataField="Folio"  ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="MonedaDR" DataField="MonedaDR" ItemStyle-HorizontalAlign="Center" />
               	<asp:BoundField HeaderText="NumParcialidad" DataField="NumParcialidad"  ItemStyle-HorizontalAlign="Center" />
               	<asp:BoundField HeaderText="ImpPagado" DataField="ImpPagado" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Center" />
               	<asp:BoundField HeaderText="ImpSaldoAnt" DataField="ImpSaldoAnt" DataFormatString="{0:C}"  ItemStyle-HorizontalAlign="Center" />
               	<asp:BoundField HeaderText="ImpSaldoInsoluto" DataField="ImpSaldoInsoluto"  DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Center" />
                		
		<%--		<asp:ButtonField Text="Eliminar" CommandName="EliminarDocumento" Visible="False" ItemStyle-HorizontalAlign="Center" />
	--%>		 <asp:TemplateField  HeaderText="Opciones" ItemStyle-Width="10%" 
                           ItemStyle-HorizontalAlign="Center" >
                            <ItemTemplate  >
                                 <div class="form-inline">
                                       <asp:LinkButton ID="gvlnkDelete" ClientIDMode="AutoID"
                                           CommandName="EliminarDocumento"
                                           CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                                           CssClass="btn btn-light" runat="server" style=" padding:0px 3px;" >
                                           <i class="glyphicon glyphicon-trash  " title="Eliminar"></i> 
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
                                  <Triggers>        <asp:AsyncPostBackTrigger  ControlID="AgregarDocumento" EventName="Click" />
                
                        </Triggers>
                </asp:UpdatePanel>
    
          </div>


                </div>

</div>
         
          <%---------------Termina  complemento---------------%>
              
    
         <%---------------totales---------------%>
    
         
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
                     <asp:Label ID="lblError" runat="server" CssClass="form-label"  />
                   </ContentTemplate>
                       <Triggers>
                             <asp:AsyncPostBackTrigger  ControlID="BtnVistaPreviaP" EventName="Click" />
                            <asp:AsyncPostBackTrigger  ControlID="lnkDeleteFac" EventName="Click" />
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
