<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrFacturaCompPagos.aspx.cs" MaintainScrollPositionOnPostBack="true" Inherits="GafLookPaid.wfrFacturaCompPagos"  EnableEventValidation="false" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
     <%@ Register Assembly="DropDownChosen" Namespace="CustomDropDown" TagPrefix="cc1" %>
 <%@ MasterType VirtualPath="~/Site.Master" %>
 

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
 
     <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server" />
  

    
<script type="text/javascript">
     
    function okClick() {
            //  find the confirm ModalPopup and hide it   
        $find("MainContent_mpexFac").hide();
        Progress();    
        
    }
    function Progress() {
        $find('<%= UpdateProgress2.ClientID %>').get_element().style.display = 'block';
          
        
        }
       </script>
     
     
  <style>

      .DivAncho {
          width:100%;
      }
      
      /*#MainContent_ddlClaveUnidadE_chzn {
          width:100%;
      }*/
      .auto-style1 {
          color:#FF0000
      }
  </style>

    <%-- ejemplo de modalpopu --%>
       
      <asp:UpdatePanel ID="UpdatePanel7" runat="server"  UpdateMode="Conditional"   >
    <ContentTemplate>
      <asp:HiddenField ID="hf_DeleteID" runat="server" />
         
    <asp:Button ID="btnShow" runat="server" Style="display:none"  Text="Show Modal Popup" />
     <asp:ModalPopupExtender ID="mpex" runat="server" PopupControlID="pnlPopup" TargetControlID="btnShow"
        OkControlID="btnYes" CancelControlID="btnNo" BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>
    <asp:Panel ID="pnlPopup" runat="server" CssClass="modalPopup" Style="display: none">
        <div class="header" >
            Eliminar Relacionado
        </div>
        <div class="body">
            <br />
          &nbsp;&nbsp;  ¿Desea eliminar el registro?
        </div>
        <div class="footer" >
                                    
            <asp:Button ID="btnYes" runat="server" Text="Yes" Style="display:none" CssClass="yes" />
                   <asp:LinkButton ID="lnkDelete" CssClass="btn btn-outline-success" OnClick="lnkDelete_Click"  runat="server" >
                            Eliminar <i class="fa fa-trash" title="delete"></i> 
                                </asp:LinkButton>
                        
            <asp:Button ID="btnNo" runat="server" Text="Cancelar"  CssClass="btn btn-outline-success"  />
        </div>
    </asp:Panel>



          <asp:Button ID="btnShowFac" runat="server" Style="display:none"  Text="Show Modal Popup" />
     <asp:ModalPopupExtender ID="mpexFac" runat="server" PopupControlID="pnlPopupFac" TargetControlID="btnShowFac"
        OkControlID="btnYesFac" CancelControlID="btnNoFac" BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>
    <asp:Panel ID="pnlPopupFac" runat="server" CssClass="modalPopup" Style="display: none">
        <div class="header" >
            Generar la factura
        </div>
        <div class="body">
            <br />
          &nbsp;&nbsp;  Confirma que deseas generar el comprobante
        </div>
        <div class="footer" >
                                    
            <asp:Button ID="btnYesFac" runat="server" Text="Yes" Style="display:none" CssClass="yes" />
                   <asp:LinkButton ID="lnkDeleteFac" CssClass="btn btn-outline-success" OnClientClick="okClick();"
                       OnClick="lnkDeleteFac_Click"  runat="server" >
                            Generar <i class="fa fa-check-square-o" title="delete"></i> 
                                </asp:LinkButton>
                        
            <asp:Button ID="btnNoFac" runat="server" Text="Cancelar"  CssClass="btn btn-outline-success"  />
        </div>
    </asp:Panel>

        <asp:Button ID="btnShow7" runat="server" Style="display:none"  Text="Show Modal Popup" />
     <asp:ModalPopupExtender ID="ModalBuscar" runat="server" PopupControlID="PanelBuscar"
         TargetControlID="btnShow7"  CancelControlID="btnNo7" BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>
    <asp:Panel ID="PanelBuscar" runat="server" CssClass="modalPopup" Style="display: none">
        <div class="header" >
            Buscar por RFC
        </div>
        <div class="body">
            <br />
                <div class = "row">
                    <div class = "col-lg-11 col-md-11 col-sm-11 col-xs-11">
                  <asp:Label ID="Label2" class="control-label" runat="server" Text="RFC"></asp:Label>
                     <asp:TextBox runat="server" CssClass="form-control" ID="txtRFCBus" />
             
                        </div>
                    </div>

            <br />
        </div>
        <div class="footer" >
         <asp:HiddenField ID="HiddenField6" runat="server" />
               <asp:Button runat="server" ID="btnBuscarRFC" Text="Buscar" 
                   class="btn btn-outline-success" OnClick="btnBuscarRFC_Click" />
             <asp:Button ID="btnNo7" runat="server" Text="Cancelar"  CssClass="btn btn-outline-success" />
                         
        </div>
    </asp:Panel>


<asp:Button ID="btnShow6" runat="server" Style="display:none"  Text="Show Modal Popup" />
     <asp:ModalPopupExtender ID="mpexImpuesto" runat="server" PopupControlID="PanelImpuestos"
         TargetControlID="btnShow6" OkControlID="btnYes6" CancelControlID="btnNo6" BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>
    <asp:Panel ID="PanelImpuestos" runat="server" CssClass="modalPopup" Style="display: none">
        <div class="header" >
            Eliminar Impuesto
        </div>
        <div class="body">
            <br />
          &nbsp;&nbsp;  ¿Desea eliminar el registro?
        </div>
        <div class="footer" >
         <asp:HiddenField ID="HiddenField2" runat="server" />
                                    
            <asp:Button ID="btnYes6" runat="server" Text="Yes" Style="display:none" CssClass="yes" />
                   <asp:LinkButton ID="bntEliminarImpuesto" CssClass="btn btn-outline-success" OnClick="bntEliminarImpuesto_Click"  runat="server" >
                            Eliminar <i class="fa fa-trash" title="delete"></i> 
                                </asp:LinkButton>
           <asp:Button ID="btnNo6" runat="server" Text="Cancelar" CausesValidation="false"  CssClass="btn btn-outline-success"  />
                        
        </div>
    </asp:Panel>


<asp:Button ID="btnShow3" runat="server" Style="display:none"  Text="Show Modal Popup" />
     <asp:ModalPopupExtender ID="mpMensajeError" runat="server" PopupControlID="PanelError"
         TargetControlID="btnShow3" OkControlID="btnYes3" BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>
    <asp:Panel ID="PanelError" runat="server" CssClass="modalPopup" Style="display: none">
        <div class="header"  style="background-color:red">
            Error
        </div>
        <div class="body">
            <br />
          &nbsp;&nbsp;  <asp:Label ID="lblError" runat="server" ForeColor="Red" />
        </div>
        <div class="footer" >
         <asp:HiddenField ID="HiddenField4" runat="server" />
                                    
            <asp:Button ID="btnYes3" runat="server" Text="Aceptar"  CssClass="btn btn-outline-success" />
                         
        </div>
    </asp:Panel>

        <asp:Button ID="btnShow4" runat="server" Style="display:none"  Text="Show Modal Popup" />
     <asp:ModalPopupExtender ID="mpMensajeOK" runat="server" PopupControlID="PanelOK"
         TargetControlID="btnShow4" OkControlID="btnYes4" BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>
    <asp:Panel ID="PanelOK" runat="server" CssClass="modalPopup" Style="display: none">
        <div class="header" >
            Mensaje
        </div>
        <div class="body">
            <br />
          &nbsp;&nbsp;  <asp:Label ID="lblOK" runat="server" ForeColor="Black" />
        </div>
        <div class="footer" >
         <asp:HiddenField ID="HiddenField1" runat="server" />
                                    
            <asp:Button ID="btnYes4" runat="server" Text="Aceptar"  CssClass="btn btn-outline-success" />
                         
        </div>
    </asp:Panel>


    <asp:Button ID="btnShow5" runat="server" Style="display:none"  Text="Show Modal Popup" />
     <asp:ModalPopupExtender ID="mpMensajeOK2" runat="server" PopupControlID="PanelOK2"
         TargetControlID="btnShow5" OkControlID="btnYes5" BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>
    <asp:Panel ID="PanelOK2" runat="server" CssClass="modalPopup" Style="display: none">
        <div class="header" >
            Mensaje
        </div>
        <div class="body">
            <br />
             <div class = "row">
                    <div class = "col-lg-12">
          &nbsp;&nbsp;  <asp:Label ID="lblOK2" runat="server" ForeColor="Black" />
                            </div>
                    </div>
            <br />
             <div class = "row">
                    <div class = "col-lg-12 text-center">
            
             <asp:LinkButton ID="LinkButton1" runat="server" ForeColor="#FF3300" 
                onclick="LinkButton1_Click">Descargar PDF</asp:LinkButton>
                                 </div>
            </div>
        </div>
        <div class="footer" >
         <asp:HiddenField ID="HiddenField5" runat="server" />
                                    
            <asp:Button ID="btnYes5" runat="server" Text="Aceptar"  CssClass="btn btn-outline-success" />
                         
        </div>
    </asp:Panel>




    </ContentTemplate>
           <Triggers>
               
                 <asp:AsyncPostBackTrigger  ControlID="lnkDelete" EventName="Click" />
                <%--         <asp:AsyncPostBackTrigger  ControlID="bntCancelar" EventName="Click" />
        --%> 
            </Triggers>
            </asp:UpdatePanel>

    <%-- ejemplo de modalpopu consultas--%>
  
  <asp:UpdatePanel ID="up1" runat="server"  UpdateMode="Conditional"  >
    <ContentTemplate>
         
    <section class="services">
        <div class="container">
            <div class="title text-center">
            
               
            </div>
          
              
     <div  class = "card mt-2">   
            <div class="card-header">
               <h3> Generar Complemento de Pagos</h3>
            </div>
            <div class ="card-body" >
                 
                               
                     <asp:UpdatePanel ID="UpdatePanel6" runat="server"  UpdateMode="Conditional"  >
                     <ContentTemplate>
    
                <div class = "row form-group"> <%--Empresa--%>
                    <div class="col-lg-6 " >
                        <asp:Label  class="control-label" ID="Label8" runat="server" Text="Empresa"></asp:Label>
                       <asp:DropDownList runat="server" Width="100%" ID="ddlEmpresa" 
                           AutoPostBack="True"  DataTextField="RazonSocial" DataValueField="idEmpresa" 
                           CssClass="form-control"
                           OnSelectedIndexChanged="ddlEmpresa_SelectedIndexChanged"   />                        
                    </div>
                                        
                    <div class="col-lg-3 " style="color:red;" >
                            <asp:Label ID="lblVencimiento" class="control-label" runat="server" ForeColor="Red" Font-Bold="true" style=" font-size: x-small; text-align: left; font-variant: small-caps;" Width="250px"></asp:Label>
                    </div>
                    
                </div>  
             
                <div class = "row form-group">
                    <div class = "col-lg-6">
                        <asp:Label  class="control-label" ID="lblCliente" runat="server" Text="Cliente"  ></asp:Label>
                        <div style="width:100%;display: flex;  align-items: stretch;">
                         <cc1:DropDownListChosen ID="ddlClientes" runat="server" AllowSingleDeselect="true"
                               AutoPostBack="True"  cssClass="form-control" data-toggle="dropdown"  
                               DataPlaceHolder="Seleccione..." DataTextField="RazonSocial" class="form-control"
                               DataValueField="idCliente"   NoResultsText="No hay resultados coincidentes."
                               OnSelectedIndexChanged="ddlClientes_SelectedIndexChanged"   
                               SelectMethod=""   AppendDataBoundItems="True" Width="100%">
                     
                            </cc1:DropDownListChosen>
                                   <asp:LinkButton ID="btnBuscar" CssClass="btn btn-outline-success"  OnClick="btnBuscar_Click" 
                             runat="server" ><span class="glyphicon glyphicon-search"></span> 
                         </asp:LinkButton>

                     </div>
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
                        <asp:DropDownList ID="ddlSucursales" runat="server"   CssClass="form-control"
                            AppendDataBoundItems="True" DataValueField="LugarExpedicion"     DataTextField="Nombre">

                        </asp:DropDownList>
                     </div>

                      <div class = "form-group col-lg-3" >
                        <asp:Label ID="lblMoneda" Visible="false" class="control-label" runat="server" Text="Moneda"></asp:Label>
           
                        <cc1:DropDownListChosen ID="ddlMoneda" runat="server" Visible="false" 
            NoResultsText="No hay resultados coincidentes."  Width="185px"
                            SelectMethod=""  OnSelectedIndexChanged="ddlMoneda_SelectedIndexChanged"        
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" AutoPostBack="True" AppendDataBoundItems="True" >              
        </cc1:DropDownListChosen>
                    </div>
                    </div>
                   <div class = "row form-group " > 
                   
                    <div class="col-lg-6 " >
                        <asp:Label  class="control-label" ID="Label15" runat="server" Text="Observaciones" ></asp:Label>
                        <asp:TextBox runat="server" ID="txtProyecto"  CssClass="form-control" />
          
                    </div>
                        <div class = "col-lg-3">
                           <asp:Label ID="Label3" class="control-label" runat="server" Text="UsoCFDI"></asp:Label>
                        <asp:DropDownList ID="ddlUsoCFDI" runat="server" AutoPostBack="True" 
                            CssClass="form-control" Width="209px"  >
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
<asp:ListItem runat="server"  Value="P01" Text="Por definir" Selected="True"></asp:ListItem> 
  </asp:DropDownList>    

                       </div>
                   
                        <div class="col-lg-3 " >
                        <asp:Label  class="control-label" ID="Label29" runat="server" Text="Decimales Importe" ></asp:Label>
                       <asp:DropDownList runat="server" ID="ddlDecimales" AutoPostBack="True" 
                                OnSelectedIndexChanged="ddlDecimales_SelectedIndexChanged" 
                                CssClass="form-control" Width="66px" >
                            <asp:ListItem Value="2" Text="2" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="3" Text="3"></asp:ListItem>
                        <asp:ListItem Value="4" Text="4"></asp:ListItem>
                        <asp:ListItem Value="5" Text="5"></asp:ListItem>
                        <asp:ListItem Value="6" Text="6"></asp:ListItem>
                        </asp:DropDownList>
          
                    </div>
            </div>  
                
        </div>  <%--Termina Primera Sección - Generar CFDI--%>
         
         </div>

            <asp:UpdatePanel ID="UpdatePanel8" runat="server"  UpdateMode="Conditional"  >
               <ContentTemplate>
         
        <div class = "card mt-2"> 
            <div class = "card-header">
                <b>  Complemento </b>
            </div>
            <div class = "card-body">

               
       <div class = "row"> 
                    <div class = "form-group col-lg-3">
                        <asp:Label ID="Label7" class="control-label" runat="server" Text="FechaPago"></asp:Label>
                        <asp:TextBox ID="txtFechaPagoP" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" 
                            PopupButtonID="txtFechaPagoP" 
                            TargetControlID="txtFechaPagoP" />
                   <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator9" ControlToValidate="txtFechaPagoP"
                            Display="Dynamic" ErrorMessage="* Requerido" ForeColor="Red" 
                         ValidationGroup="btnAgregarPagos" style="font-size: medium" />
                        </div>
             <div class = "form-group col-lg-3">
                        <asp:Label ID="Label11" class="control-label" runat="server" Text="FormaDePagoP"></asp:Label>
                  <asp:DropDownList runat="server" ID="ddlFormaPagoP" 
                         style="margin-left: 0px" CssClass="form-control">
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
                        <asp:Label ID="Label13" class="control-label" runat="server" Text="Monto"></asp:Label>
                        <asp:TextBox ID="txtMonto" runat="server"  CssClass="form-control" AutoPostBack="True" OnTextChanged="txtMonto_TextChanged"></asp:TextBox>
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
                        <asp:Label ID="Label16" class="control-label" runat="server" Text="MonedaP"></asp:Label>
           <cc1:DropDownListChosen ID="ddlMonedaP" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes." CssClass="form-control"  Width="150px"  SelectMethod=""  OnSelectedIndexChanged="ddlMonedaP_SelectedIndexChanged"        
            DataPlaceHolder="Escriba aquí..." AllowSingleDeselect="true" AutoPostBack="True"  >                
        </cc1:DropDownListChosen>
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
                  <div class = "row"> 
                    <div class = "form-group col-lg-3">
                    <asp:Label ID="Label30" class="control-label" runat="server" Text="NumOperacion"></asp:Label>
                 <asp:TextBox ID="txtNumOperacion" runat="server"  CssClass="form-control"></asp:TextBox>
   
                        </div>
                   
                    <div class = "form-group col-lg-3">
                    <asp:Label ID="Label31" class="control-label" runat="server" Text="RfcEmisorCtaOrd"></asp:Label>
            <asp:DropDownList runat="server" ID="ddlrfcemisor" 
                         style="margin-left: 0px" CssClass="form-control" 
                OnSelectedIndexChanged="ddlrfcemisor_SelectedIndexChanged1"
                AutoPostBack="True" Width="246px">
                <asp:ListItem runat="server" Value="" Text="Seleccione" Selected="True"></asp:ListItem>
             <asp:ListItem runat="server" Value="BMN930209927" Text="BMN930209927 - BANORTE" ></asp:ListItem>
             <asp:ListItem runat="server" Value="BNM840515VB1" Text="BNM840515VB1 - BANAMEX"></asp:ListItem>
             <asp:ListItem runat="server" Value="BSM970519DU8" Text="BSM970519DU8 - SANTANDER"></asp:ListItem>
             <asp:ListItem runat="server" Value="BBA830831LJ2" Text="BBA830831LJ2 - BANCOMER"></asp:ListItem>
             <asp:ListItem runat="server" Value="HMI950125KG8" Text="HMI950125KG8 - HSBC"></asp:ListItem>
             <asp:ListItem runat="server" Value="SIN9412025I4" Text="SIN9412025I4 - SCOTIABANK"></asp:ListItem>
             <asp:ListItem runat="server" Value="00" Text="Otro"></asp:ListItem>
          </asp:DropDownList>
          <asp:TextBox ID="txtRfcEmisorCtaOrd" runat="server"  CssClass="form-control" Visible="False" OnTextChanged="txtRfcEmisorCtaOrd_TextChanged"></asp:TextBox>
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
                         style="margin-left: 0px" CssClass="form-control" AutoPostBack="True" Width="246px" OnSelectedIndexChanged="ddlrfcben_SelectedIndexChanged">
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
                       <asp:DropDownList runat="server" ID="ddlTipoCadPago"  Width="97px"
                         style="margin-left: 0px" CssClass="form-control">
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
                    <div class = "form-group col-lg-1"></div>
                       <div class = "form-group col-lg-3">
                           <asp:Button runat="server" ID="btnAgregarPagos" Text="Agregar Pagos" 
                        ValidationGroup ="btnAgregarPagos" Cssclass="btn btn-outline-success"   onclick="btnAgregarPagos_Click"/>
                       </div>
                </div>
                          <br />
                <div style="text-align:center; width:100%">
                    <div class="border border-success" style=" width:80%;   background-color: #2d282808;margin:0px auto  " >
                        <asp:GridView ID="gvPagos" runat="server" AutoGenerateColumns="False" GridLines="None" 
                          ShowHeaderWhenEmpty="True" DataKeyNames="ID" Width="100%"  AlternatingRowStyle-HorizontalAlign="Center"
                            CssClass="table table-hover table-striped grdViewTable"
                             onrowcommand="gvPagos_RowCommand"  onselectedindexchanged="gvPagos_SelectedIndexChanged">
                            <rowstyle Height="6px" /><alternatingrowstyle  Height="6px"/>
                           <Columns>
                               <asp:BoundField HeaderText="ID" DataField="id"  ItemStyle-HorizontalAlign="Center" />
                                   <asp:BoundField HeaderText="FechaPago" DataField="FechaPago"  ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="FormaDePagoP" DataField="FormaDePagoP" ItemStyle-HorizontalAlign="Center"  />
				<asp:BoundField HeaderText="MonedaP" DataField="MonedaP" ItemStyle-HorizontalAlign="Center" />
				<asp:BoundField HeaderText="Monto" DataField="Monto"  ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="NumOperacion" DataField="NumOperacion"  ItemStyle-HorizontalAlign="Center" />
               			
				<asp:ButtonField Text="Eliminar" CommandName="EliminarPago" Visible="False" ItemStyle-HorizontalAlign="Center" />
			
                            </Columns>
                        </asp:GridView>                            
                    </div>
                </div>
      


   </div>
            </div>

              <div class = "card mt-2"> 
            <div class = "card-header">
                <b>  Documento Relacionado </b>
            </div>
            <div class = "card-body">
                   <div class = "row"> 
                    <div class = "form-group col-lg-3">
                    <asp:Label ID="Label40" class="control-label" runat="server" Text="ID"></asp:Label>
                        <asp:DropDownList ID="ddlID" runat="server" AutoPostBack="True" CssClass="form-control"
                          OnSelectedIndexChanged="ddlID_SelectedIndexChanged"> </asp:DropDownList>
                    </div>
                   <div class = "form-group col-lg-3">
                    <asp:Label ID="Label41" class="control-label" runat="server" Text="Folio Fiscal"></asp:Label>
                   <asp:TextBox ID="txtIdDocumento" runat="server" CssClass="form-control" width="290px" MaxLength="36"></asp:TextBox>
    <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator17" ControlToValidate="txtIdDocumento"
                            Display="Dynamic" ErrorMessage="* Requerido" ForeColor="Red"
                         ValidationGroup="AgregarDocumento" style="font-size: medium" />
                       </div>
                       <div class = "form-group col-lg-1"></div>
                       <div class = "form-group col-lg-2">
      <input type="button" value="Consulta Reportes" onclick="javascript: window.open('wfrFacturasConsulta.aspx', '', 'width=1000,height=1000,left=50,top=50,toolbar=yes');" class="btn btn-outline-success" />
                       
                   </div>
                     </div>
                 <div class = "row"> 
                    <div class = "form-group col-lg-3">
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
                    <cc1:DropDownListChosen ID="ddlMonedaDR" runat="server" 
        AllowSingleDeselect="true" AutoPostBack="True" CausesValidation="false" 
        DataPlaceHolder="Escriba aquí..." Height="18px" CssClass="form-control"
        NoResultsText="No hay resultados coincidentes." 
        OnSelectedIndexChanged="ddlMonedaDR_SelectedIndexChanged" SelectMethod="" 
        width="210px">
    </cc1:DropDownListChosen>
                            <asp:Label ID="lblTipoCambioDR" runat="server" Text="Tipo Cambio"   Visible="False" />
                             <asp:TextBox ID="txtTipoCambioDR" runat="server" Visible="False" CssClass="form-control" />
   
                </div>

            </div>
                 <div class = "row"> 
                    <div class = "form-group col-lg-3">
                    <asp:Label ID="Label45" class="control-label" runat="server" Text="MetodoDePagoDR"></asp:Label>
                   <asp:DropDownList runat="server" ID="ddlMetodoDePagoDR" AutoPostBack="True"
                       OnSelectedIndexChanged="ddlMetodoDePagoDR_SelectedIndexChanged" CssClass="form-control" >
                          <%-- <asp:ListItem runat="server" Text="Pago en una sola exhibición" Value="PUE" Selected="False" ></asp:ListItem>--%>
                            <asp:ListItem runat="server" Text="Pago en parcialidades o diferido" Value="PPD" Selected="True"></asp:ListItem>
                        </asp:DropDownList>
   
                        </div>
                                          
                    <div class = "form-group col-lg-3">
                    <asp:Label ID="Label46" class="control-label" runat="server" Text="NumParcialidad"></asp:Label>
                     <asp:TextBox ID="txtNumParcialidad" runat="server" CssClass="form-control">1</asp:TextBox>
                     <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator13" ControlToValidate="txtNumParcialidad"
                            Display="Dynamic" ErrorMessage="* Requerido" ForeColor="Red"
                         ValidationGroup="AgregarDocumento" style="font-size: medium" />    
                     </div>
                     <div class = "form-group col-lg-3">
                     <asp:Label ID="Label47" class="control-label" runat="server" Text="ImpSaldoAnt"></asp:Label>
                    <asp:TextBox ID="txtImpSaldoAnt" runat="server" CssClass="form-control" AutoPostBack="True" OnTextChanged="txtImpSaldoAnt_TextChanged"></asp:TextBox>
                   <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator16" ControlToValidate="txtImpSaldoAnt"
                            Display="Dynamic" ErrorMessage="* Requerido" ForeColor="Red"
                         ValidationGroup="AgregarDocumento" style="font-size: medium" />
                     </div>
                     </div>
                 <div class = "row"> 

                       <div class = "form-group col-lg-3">
                     <asp:Label ID="Label48" class="control-label" runat="server" Text="ImpPagado"></asp:Label>
                      <asp:TextBox ID="txtImpPagado" runat="server" CssClass="form-control"
                          AutoPostBack="True" OnTextChanged="txtImpPagado_TextChanged"  Width="97px"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator14" ControlToValidate="txtImpPagado"
                            Display="Dynamic" ErrorMessage="* Requerido" ForeColor="Red"
                         ValidationGroup="AgregarDocumento" style="font-size: medium" />    

                       </div>
                        <div class = "form-group col-lg-3">
                      <asp:Label ID="Label49" class="control-label" runat="server" Text="ImpSaldoInsoluto"></asp:Label>
                      <asp:TextBox ID="txtImpSaldoInsoluto" runat="server" CssClass="form-control" AutoPostBack="True" OnTextChanged="txtImpSaldoInsoluto_TextChanged"></asp:TextBox>
                         <asp:RequiredFieldValidator runat="server" CssClass="alert-error"
                         ID="RequiredFieldValidator15" ControlToValidate="txtImpSaldoInsoluto" ForeColor="Red"
                            Display="Dynamic" ErrorMessage="* Requerido" ValidationGroup="AgregarDocumento" 
                             style="font-size: medium" />    
    
                        </div>

                </div>
                 <div class = "row"> 
                         <div class = "form-group col-lg-1"></div>
                
                       <div class = "form-group col-lg-3">
                <asp:Button runat="server" ID="AgregarDocumento" Text="Agregar Documento" 
        ValidationGroup="AgregarDocumento"  Cssclass="btn btn-outline-success"
        onclick="btnAgregarDocumento_Click" Width="160px"/>
    <asp:CheckBox ID="DRcb" runat="server" AutoPostBack="True" Visible="False" />
                           </div>
                     </div>
                 <br />
                <div style="text-align:center; width:100%">
                    <div class="border border-success" style=" width:80%;   background-color: #2d282808;margin:0px auto  " >
                        <asp:GridView ID="gvDocumento" runat="server" AutoGenerateColumns="False" GridLines="None" 
                          ShowHeaderWhenEmpty="True" DataKeyNames="ID" Width="100%"  AlternatingRowStyle-HorizontalAlign="Center"
                            CssClass="table table-hover table-striped grdViewTable"
                             onrowcommand="gvDocumento_RowCommand"     >
                            <rowstyle Height="6px" /><alternatingrowstyle  Height="6px"/>
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
                		
				<asp:ButtonField Text="Eliminar" CommandName="EliminarDocumento" Visible="False" ItemStyle-HorizontalAlign="Center" />
			</Columns>
	
                        </asp:GridView>                            
                    </div>
                </div>
      


                </div>

</div>
                   </ContentTemplate>
                              <Triggers>
     <asp:AsyncPostBackTrigger ControlID="txtMonto"/>
     <asp:AsyncPostBackTrigger ControlID="ddlrfcben"/>
     <asp:AsyncPostBackTrigger ControlID="ddlrfcemisor"/>
     <asp:AsyncPostBackTrigger ControlID="ddlID"/>       
      <asp:AsyncPostBackTrigger ControlID="txtImpSaldoAnt"/>   
      <asp:AsyncPostBackTrigger ControlID="txtImpPagado"/>   
      <asp:AsyncPostBackTrigger ControlID="txtImpSaldoInsoluto"/>   
            <asp:AsyncPostBackTrigger ControlID="ddlUsoCFDI" EventName="SelectedIndexChanged" /> 
           
                                  
</Triggers>
                </asp:UpdatePanel>


        <%---------------Segunda Sección - CFDI Relacionados---------------%>
               <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional"  >
               <ContentTemplate>
      <asp:Panel runat="server" CssClass="table-responsive">
          
        <div class = "card mt-2">   
            <div class = "card-header">
                <asp:CheckBox ID="cbCfdiRelacionados" runat="server" AutoPostBack="true"
                Text="CFDIs Relacionados" OnCheckedChanged="cbCfdiRelacionados_CheckedChanged" />
            </div>
            <div class = "card-body" id="DivCfdiRelacionados" runat="server" >
                <div class = "row">
                    <div class = "form-group col-lg-6">
                        <asp:Label ID="lblUUID" runat="server" class="control-label" Text="UUID"></asp:Label>
                        <asp:TextBox ID="txtUUDI" runat="server" Width="100%" CssClass="form-control"/>
                    </div>
                    <div class = "form-group col-lg-6">
                        <asp:Label ID="lblTipoRelacion" runat="server" class="control-label" Text="Tipo de Relación"></asp:Label>
                        <asp:DropDownList ID="ddlTipoRelacion" Height="28px"  runat="server" CssClass="form-control">
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
                        <asp:Button ID="btnCfdiRelacionado" runat="server" Cssclass="btn btn-outline-success" 
                        Text="Añadir Cfdi Relacionado" ValidationGroup="AgregarCfdiRelacionado" OnClick="btnCfdiRelacionado_Click"/>                            
                    </div>
                </div>
                <br />
                <div style="text-align:center; width:100%">
                    <div class="border border-success" style=" width:80%;   background-color: #2d282808;margin:0px auto  " >
                        <asp:GridView ID="gvCfdiRelacionado" runat="server" AutoGenerateColumns="False" GridLines="None" 
                          ShowHeaderWhenEmpty="True" DataKeyNames="ID" Width="100%"  AlternatingRowStyle-HorizontalAlign="Center"
                            OnRowCommand="gvCfdiRelacionado_RowCommand"   CssClass="table table-hover table-striped grdViewTable" OnRowDataBound="gvCfdiRelacionado_RowDataBound">
                            <rowstyle Height="6px" /><alternatingrowstyle  Height="6px"/>
                            <Columns>
                                <asp:BoundField DataField="ID" HeaderText="ID" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="UUID" HeaderText="UUID" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                              
                            
                            <asp:TemplateField HeaderStyle-CssClass="sorting_disabled"  ItemStyle-Width="10%"   ItemStyle-HorizontalAlign="Right" >
                            <ItemTemplate  >
                                 <div class="form-inline">
                                       <asp:LinkButton ID="gvlnkDelete" ClientIDMode="AutoID" CommandName="deleteRecord" CommandArgument='<%#((GridViewRow)Container).RowIndex%>' CssClass="btn btn-outline-success" runat="server" style=" padding:1px 6px;" >
                                    <i class="fa fa-trash " title="Eliminar"></i> 
                                        </asp:LinkButton>
                               </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                            </Columns>
                        </asp:GridView>                            
                    </div>
                </div>
            </div>  <%--Termina panel-body--%>
        </div>  <%--Termina Segunda Sección - CFDI Relacionados--%>
          </asp:Panel>


        

                     </ContentTemplate>
              <Triggers>

                 <%--   <asp:AsyncPostBackTrigger ControlID="gvCfdiRelacionado"/>   
                        <asp:AsyncPostBackTrigger ControlID="gvCfdiRelacionado" EventName="RowCommand" />    
                   
                --%>   <asp:AsyncPostBackTrigger ControlID="cbCfdiRelacionados" EventName="CheckedChanged" /> 
                      
                  
                    </Triggers>
            </asp:UpdatePanel>




        <%-------------------- Quinta Sección - Totales --------------------%>

            <asp:UpdatePanel ID="UpdatePanel4" runat="server"  UpdateMode="Conditional"  >
               <ContentTemplate>
         
        <div class = "card mt-2">
            <div class = "card-header">
                Totales
            </div>
            <div class = "card-body">
                <div class = "row">
                           <div  class="col-md-7 col-sm-0"></div>
                           <div class = "col-md-2 col-sm-6   text-right " style="padding:0"><b> Subtotal:</b> </div>
                           <div class = "d-inline-flex-reverse col-md-2  col-sm-6 text-right " style="padding:0">
                           <asp:Label ID="lblSubtotal" runat="server" /> </div>
                           <div  class="col-md-1 col-sm-0"></div>
                           </div>
               <div class = "row">
                           <div  class="col-md-7 col-sm-0"></div>
                           <div class = "col-md-2 col-sm-6  text-right" style="padding:0"><b>Retenciones:</b></div>
                           <div class = "d-inline-flex-reverse  col-md-2  col-sm-6 text-right" style="padding:0">
                           <asp:Label ID="lblRetenciones" runat="server" /></div>
                           <div  class="col-md-1 col-sm-0"></div>
                           </div>
              <div class = "row">
                           <div  class="col-md-7 col-sm-0"></div>
                           <div class = "col-md-2 col-sm-6 text-right" style="padding:0"><b>Traslados:</b></div>
                           <div class = "d-inline-flex-reverse col-md-2 col-sm-6 text-right" style="padding:0">
                           <asp:Label ID="lblTraslados" runat="server" /></div>
                           <div  class="col-md-1 col-sm-0"></div>
                           </div>
             <div class = "row">
                           <div  class="col-md-7 col-sm-0"></div>
                           <div class = "col-md-2 col-sm-6  text-right" style="padding:0"><b>Descuento:</b></div>
                           <div class = "d-inline-flex-reverse col-md-2 col-sm-6 text-right" style="padding:0">
                           <asp:Label ID="lblDescuento" runat="server" /></div>
                          <div  class="col-md-1 col-sm-0"></div>
                           </div>
             <div class = "row">
                           <div  class="col-md-7 col-sm-0"></div>
                           <div class = "col-md-2 col-sm-6  text-right" style="padding:0"><b>Total</b>:</div>
                           <div class = "d-inline-flex-reverse col-md-2 col-sm-6 text-right" style="padding:0">
                           <asp:Label ID="lblTotal" runat="server" /></div>
                           <div  class="col-md-1 col-sm-0"></div>
                           </div>
                        
                    </div>
                   
                    
                    
                 
                  <div class = "row">
                      <div class="col-lg-7 "></div>
                    <div class = "col-lg-5 justify-content-end">
                        <asp:Button ID="btnLimpiar" runat="server" class= "btn btn-outline-success" Text="Limpiar" OnClick="btnLimpiar_Click"/>
                        &nbsp;&nbsp;&nbsp;
                       <asp:LinkButton ID="BtnVistaPreviaP" CssClass="btn btn-outline-success" OnClientClick="Progress();" Text="Vista Previa" 
                        ValidationGroup="CrearFactura"        OnClick="BtnVistaPreviaP_Click"  runat="server" >
                                  </asp:LinkButton>
                         &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnGenerarFactura" runat="server" class="btn btn-outline-success" Text="Generar" 
                         OnClick="btnGenerarFactura_Click"/>
                        <%--<asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Confirma que deseas generar el comprobante" 
                        TargetControlID="btnGenerarFactura" />--%>
                    </div>
               </div>
            <br />
            </div>
        </div>
              </ContentTemplate>
                <Triggers>
                </Triggers>
             </asp:UpdatePanel>


        <%--------------------Termina formato--------------------%>
        
           <div style=" width:100%" >
           <div style="float:right; text-align:right;">
            </div>
          </div>


            
                </div>
      
              
        </div>
        </section>
    
        
    <iframe id="MyIframe" runat="server" style="display:none;" ></iframe>
    
        
      <asp:ModalPopupExtender runat="server" ID="mpeSellos" TargetControlID="btnSelloDummy"
          PopupControlID="pnlSello" BackgroundCssClass="modalBackground"/>
    <asp:Panel runat="server" ID="pnlSello" CssClass="modalPopup" Style="display: none">
        <br />
        <asp:Label runat="server" ID="Label14" Text="¡Importante!" Visible="True"  CssClass="form-control" style="color: #000000"/>
        <br />
        <asp:Label runat="server" ID="LblDiasSello" Text="Su sello caduca en x dias" Visible="True"  CssClass="form-control" style="color: #000000" Height="50px"/>
        <br />
        <asp:Label runat="server" ID="lblpop" Text="Seleccione otra empresa" Visible="false"  CssClass="form-control" style="color: #000000"/>
        <br />
        <asp:DropDownList runat="server" ID="ddlEmpresaE" AutoPostBack="false"  CssClass="form-control"
            DataTextField="RazonSocial" DataValueField="idEmpresa" OnSelectedIndexChanged="ddlEmpresa_SelectedIndexChanged" Visible="false"/>
        <br />
        <br />
        <asp:Button runat="server" ID="btclose" Text="Aceptar"  CssClass="btn btn-outline-success" />
    </asp:Panel>
    <asp:Button runat="server" ID="btnSelloDummy" Style="display: none;" />



        </ContentTemplate>
              <Triggers>

                        <asp:AsyncPostBackTrigger  ControlID="btnGenerarFactura" EventName="Click" />
                  
                      <asp:AsyncPostBackTrigger ControlID="ddlMoneda" EventName="SelectedIndexChanged" /> 
                      
               
                    </Triggers>
            </asp:UpdatePanel>

         
    <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="up1">
<ProgressTemplate>
    <div class="modalUP" >
        <div class="centerUP">
                 
                 <asp:Image ID="Image1" runat="server"  ImageUrl="Imagen/ajax-loader.gif" />
                 <br class="auto-style1" />
                 <span class="auto-style1"><strong>CFDI en proceso .. </strong></span>
        </div>
    </div>
</ProgressTemplate>
</asp:UpdateProgress>


</asp:Content>
