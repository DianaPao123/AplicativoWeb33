<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" Culture="es-MX" UICulture="es-MX" CodeBehind="wfrFacturasConsulta.aspx.cs" Inherits="Ntlink33.wfrFacturasConsulta" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

        <link href="Content/Paginacion.css" rel="stylesheet" />    
     <link href="template/css/Checkbox.css" rel="stylesheet" />    
<style>
        .teamCalendar .ajax__calendar_container
        {
            background-color:cadetblue;
            font-size: 11px;
            color: white;
           

            
        }
    </style>

              
 
              
     <div  class = "card mt-2">   
            <div class="card-header">
               <h3>Consultas CFDI</h3>
            </div>
            <div class ="card-body" >
               <asp:UpdatePanel ID="UpdatePanel2" runat="server"  UpdateMode="Conditional"  >
    <ContentTemplate>
       
  <div class = "row">
   <div class = "col-lg-12">
                 
	<p>
	</p>
       </div>
      </div>
     <div class = "row">
   <div class = "form-group col-lg-12">
  
    <p>
        <a href="https://portalcfdi.facturaelectronica.sat.gob.mx" target="_blank">Sitio de cancelación del SAT</a>
    </p>
       </div>
                    </div>
      <div class = "row">
   <div class = "form-group col-lg-4">
    <asp:Label ID="Label1" runat="server" class="control-label" Text="Empresa"></asp:Label>
         <asp:DropDownList runat="server" ID="ddlEmpresas" AutoPostBack="true" DataTextField="RazonSocial" CssClass="form-control"
		DataValueField="idEmpresa" onselectedindexchanged="ddlEmpresas_SelectedIndexChanged" />      
       </div>
   <div class = "form-group col-lg-4">
    <asp:Label ID="Label2" runat="server" class="control-label" Text="Clientes"></asp:Label>
      <asp:DropDownList runat="server" ID="ddlClientes" AppendDataBoundItems="True" DataTextField="RazonSocial"
			 DataValueField="idCliente"  CssClass ="btn btn-default dropdown-toggle optionAlinear" BackColor="White" Width="100%" />
        </div>

          </div>
       <div class = "row">
   <div class = "form-group col-lg-4">
    <asp:Label ID="Label3" runat="server" class="control-label" Text="Fecha Inicial"></asp:Label>
   <asp:TextBox runat="server" ID="txtFechaInicial" CssClass="form-control" />
				<asp:CompareValidator runat="server" ID="cvFechaInicial" ControlToValidate="txtFechaInicial" Display="Dynamic" 
				 ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
				<asp:CalendarExtender runat="server" ID="ceFechaInicial" Animated="False" PopupButtonID="txtFechaInicial" TargetControlID="txtFechaInicial" Format="dd/MM/yyyy" />
		</div>
    <div class = "form-group col-lg-4">
    <asp:Label ID="Label4" runat="server" class="control-label" Text="Fecha Final"></asp:Label>
 	<asp:TextBox runat="server" ID="txtFechaFinal" CssClass="form-control"/>
				<asp:CompareValidator runat="server" ID="cvFechaFinal" ControlToValidate="txtFechaFinal" Display="Dynamic" 
				 ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
				<asp:CalendarExtender runat="server" ID="ceFechaFinal"  
                     PopupButtonID="txtFechaFinal"   TargetControlID="txtFechaFinal" Format="dd/MM/yyyy" />
		</div>
           </div>
                <div class = "row">
   <div class = "form-group col-lg-4">
    <asp:Label ID="Label5" runat="server" class="control-label" Text="Texto (En Observaciones)"></asp:Label>
  <asp:TextBox runat="server" ID="txtTexto" CssClass="form-control" />
	</div>
       <div class = "form-group col-lg-4">
  <br />

            <asp:LinkButton ID="btnBuscar" CssClass="btn btn-default" 
                Text="Concepto" runat="server"   OnClick="btnBuscar_Click" >
                           <span class="glyphicon  glyphicon-search"></span> Buscar </asp:LinkButton>
              
   
         </div>

                    </div>
    
    <div class = "row">
   <div class = "form-group col-lg-6">
    <asp:RadioButtonList RepeatDirection="Horizontal" ID="rbStatus" runat="server" RepeatLayout="Flow"  > 
					<asp:ListItem Text="Todas" Value="Todos" Selected="True" class="radio-inline"/>
					
					<asp:ListItem Text="Pendientes" Value="Pendiente" class="radio-inline"/>
				    <asp:ListItem Text="Pagadas" Value="Pagado"  class="radio-inline"/>
                    <asp:ListItem Text="Canceladas" Value="Cancelado" class="radio-inline"/>
				
				</asp:RadioButtonList>
            </div>
       <div class = "form-inline col-lg-12 ">
                   <div class="btn-toolbar pull-right">
		
            <asp:LinkButton ID="btnExportar" CssClass="btn btn-default"  
                                      Text="Concepto" runat="server"   OnClick="btnExportar_Click" >
                           <span class="glyphicon glyphicon-download"></span> Exportar Excel
                         </asp:LinkButton>

                               
                                   <asp:LinkButton ID="btnDescargarTodo" CssClass="btn btn-default"  
                                      Text="Concepto" runat="server"   OnClick="btnDescargarTodo_OnClick" >
                           <span class="glyphicon glyphicon-download"></span> Descargar Seleccionados
                         </asp:LinkButton>

                </div>
                          </div>

</div>
	</ContentTemplate>
                <Triggers>
                         <asp:AsyncPostBackTrigger  ControlID="btnExportar" EventName="Click" />
                 </Triggers>
                   </asp:UpdatePanel>


                 <asp:UpdatePanel ID="up1" runat="server"  UpdateMode="Conditional"  >
    <ContentTemplate>
      
                   <asp:HiddenField runat="server" ID="hidSel"  Value="t" EnableViewState="true" />

                     <div  class="row mt-4">
                <div class = "col-12">
                  <div class="table-responsive  border border-dark">
                          <asp:GridView ID="gvFacturas" class="table table-bordered table-hover table-striped grdViewTable" 
                         runat="server" AutoGenerateColumns="false" BackColor="White" AlternatingRowStyle-HorizontalAlign="Left"  
                          onrowcommand="gvFacturas_RowCommand"    	onrowdatabound="gvFacturas_RowDataBound" 
                              onpageindexchanging="gvFacturas_PageIndexChanging"  PageSize="10"  AllowPaging="true"
                              Width="100%" RowStyle-Height="5" FooterStyle-BorderStyle="None"
                              DataKeyNames="Guid,IdCliente,idventa"  ItemStyle-Height = "5px"   >
                         <RowStyle  Height="10" Font-Size="14px"  cssclass="RowStyle" />
                         <FooterStyle  Font-Bold="True"  BorderStyle="None" />
                         <HeaderStyle BackColor="#f9f9f9" Font-Bold="True" ForeColor="Black" Height="30px" />
                          <AlternatingRowStyle  Height="10"  cssclass="AlternateRowStyle" />
                         <PagerSettings Position="Bottom" Visible="true" />
                          <PagerStyle HorizontalAlign = "Center" Height="5" CssClass="GridPager"  />
	                     	<Columns>
			<asp:BoundField HeaderText="Folio" DataField="folio" />
			<asp:BoundField HeaderText="Folio Fiscal" DataField="Guid" >
             <FooterStyle HorizontalAlign="Center" Width="20%" Wrap="False" />
                            <HeaderStyle HorizontalAlign="Center" Width="20%" Wrap="False" />
                            <ItemStyle HorizontalAlign="Center" Width="20%" Wrap="False" />
                        </asp:BoundField>
			<asp:BoundField HeaderText="Fecha Emisión" DataField="fecha" DataFormatString="{0:d}" />
		<%--	<asp:BoundField HeaderText="Cliente" DataField="Cliente" />
       --%>     <asp:BoundField HeaderText="RFC Cliente" DataField="Rfc" />
			<asp:BoundField HeaderText="% I.V.A." DataField="PorcentajeIva" DataFormatString="{0:F2}" ItemStyle-HorizontalAlign="Right" />
			<asp:BoundField HeaderText="SubTotal" DataField="Subtotal" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" />
	        <asp:BoundField HeaderText="Total" DataField="Total" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" />
 <%--           <asp:BoundField HeaderText="Usuario" DataField="Usuario"/>--%>
			<asp:BoundField HeaderText="Status CFDI" DataField="StatusFactura"/>
            <asp:BoundField HeaderText="Fecha Cancelación" DataField="FechaCancelacion" />
		<%--<asp:ButtonField ButtonType="Link" Text="PDF" CommandName="DescargarPdf" />
			<asp:ButtonField ButtonType="Link" Text="EnviarEmail" CommandName="EnviarEmail" />--%>
               <asp:TemplateField HeaderStyle-CssClass="sorting_disabled"  HeaderText= "Opciones"     
                   ItemStyle-HorizontalAlign="Center">
             <ItemTemplate>
                   
                                <div class="mx-auto" style="width: 100px;" >

                                     <asp:LinkButton ID="gvlnkEditC" CommandName="Pagar" 
                              CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                              CssClass="btn btn-light" runat="server" style=" padding:0px 2px;">
                                    <i class="glyphicon glyphicon-usd" title="Pagar"></i> 
                                        </asp:LinkButton>
                        
                          <asp:LinkButton ID="LinkButton1" CommandName="DescargarXml" 
                              CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                              CssClass="btn btn-light " runat="server" style=" padding:0px 3px;">
                                    <i class="fas fa-file-code" title="XML"></i> 
                                        </asp:LinkButton>
                     
                          <asp:LinkButton ID="LinkButton2" CommandName="DescargarPdf" 
                              CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                              CssClass="btn btn-light " runat="server" style=" padding:0px 3px;">
                                    <i class="fas fa-file-pdf" title="PDF"></i> 
                                        </asp:LinkButton>

                        <asp:LinkButton ID="LinkButton3" CommandName="EnviarEmail" 
                              CommandArgument='<%#((GridViewRow)Container).RowIndex%>'
                              CssClass="btn btn-light" runat="server" style=" padding:0px 2px;">
                                    <i class="glyphicon glyphicon-envelope" title="Email"></i> 
                                        </asp:LinkButton>
                                         </div>
                               
                        
                 </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField  HeaderText="Cancelar" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                 <%--   <asp:Button class="btn btn-light"  runat="server" 
                        Text='<%# (short)Eval("Cancelado") == 1 ? "Acuse Cancelacion" : "Cancelar"  %>'
                        CommandName='<%# (short)Eval("Cancelado") == 1 ? "Acuse" : "Cancelar"  %>'
                        ID="btnCancelarf" CommandArgument='<%#Eval("idventa") %>'  />--%>
                    
                            <asp:LinkButton  CommandName='<%# (short)Eval("Cancelado") == 1 ? "Acuse" : "Cancelar"  %>'
                                 ID="btnCancelarf" CommandArgument='<%#Eval("idventa") %>' 
                                CssClass="btn btn-light" runat="server" style="padding:0px 2px; " >   
                                <i class= '<%# (short)Eval("Cancelado") == 1 ? "glyphicon glyphicon-download' title='Acuse' style='color:red"  :
                                         "glyphicon glyphicon-remove-circle' title='Cancelar"  %>' ></i>  
                                                                             </asp:LinkButton>
                                         


                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField  HeaderText="Seleccionar" ItemStyle-HorizontalAlign="Center">
                <HeaderTemplate>
                    <asp:Button class="btn btn-light"  runat="server" ID="btnSelectAll" Text='<%# this.SelText %>' CommandName="SelectAll" />
                </HeaderTemplate>
                <ItemTemplate> 
                     <asp:CheckBox ID="cbChecked" runat="server" Checked='<%# (bool)Eval("Seleccionar") %>'/>
                </ItemTemplate>
            </asp:TemplateField>
		</Columns>
	</asp:GridView> 
    </div>
	 
	<asp:GridView ID="gvFacturaCustumer"  CssClass="page2" Visible="False" runat="server"
        AutoGenerateColumns="False" >
        <Columns>
            <asp:BoundField HeaderText="Folio" DataField="folio" />
			<asp:BoundField HeaderText="Folio Fiscal" DataField="Guid" />
			<asp:BoundField HeaderText="Fecha" DataField="fecha" DataFormatString="{0:d}" />
		<%--	<asp:BoundField HeaderText="Cliente" DataField="Cliente" />--%>
            <asp:BoundField HeaderText="RFC" DataField="Rfc" />
			<asp:BoundField HeaderText="% I.V.A." DataField="PorcentajeIva" DataFormatString="{0:F2}" ItemStyle-HorizontalAlign="Right" />
			<asp:BoundField HeaderText="SubTotal" DataField="Subtotal" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" />
			<asp:BoundField HeaderText="Total" DataField="Total" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Right" />
<%--            <asp:BoundField HeaderText="Usuario" DataField="Usuario"/>
			--%><asp:BoundField HeaderText="Status" DataField="StatusFactura"/>
        </Columns>
    </asp:GridView>

                      </div>
                         </div>
   

</ContentTemplate>
           <Triggers>
                               <asp:AsyncPostBackTrigger  ControlID="btnBuscar" EventName="Click" />
                <asp:AsyncPostBackTrigger  ControlID="btnPagar" EventName="Click" />
              <%--  <asp:AsyncPostBackTrigger  ControlID="btnExportar" EventName="Click" />--%>
                       <asp:AsyncPostBackTrigger  ControlID="lnkDelete" EventName="Click" />
        
                      
                
           </Triggers>
           
           </asp:UpdatePanel>
        

</div>
         </div>
        

                         
    <asp:UpdatePanel ID="UpdatePanelR100" runat="server"  UpdateMode="Conditional"  >
    <ContentTemplate>
 
    <iframe id="MyIframe" runat="server" style="display:none;" ></iframe>
          

        </ContentTemplate>
        <Triggers>
                           <asp:AsyncPostBackTrigger ControlID="gvFacturas" EventName="RowCommand"/> 
              <asp:AsyncPostBackTrigger  ControlID="btnExportar" EventName="Click" />
            <asp:AsyncPostBackTrigger  ControlID="btnDescargarTodo" EventName="Click" />
                      
              
        </Triggers>
        </asp:UpdatePanel>

    <%-- mensajes --%>
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
                    <asp:Label runat="server" ID="lblError" CssClass="form-label" ForeColor="Red" />
    
                   </ContentTemplate>
                       <Triggers>
                             <asp:AsyncPostBackTrigger  ControlID="btnBuscar" EventName="Click" />
                              <asp:AsyncPostBackTrigger ControlID="gvFacturas" EventName="RowCommand"/> 
                                 <asp:AsyncPostBackTrigger  ControlID="btnEnviarEmail" EventName="Click" />
                              <asp:AsyncPostBackTrigger  ControlID="lnkDelete" EventName="Click" />
                       
                       
                       </Triggers>
                    </asp:UpdatePanel>
                        
                    </div>
                    </div>
                     
        
     </div>
    
      <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
               <span class="glyphicon glyphicon-remove-sign p-1" title="cerrar"></span>Cerrar</button>

      </div>

    </div>

  </div>
    </div>
   

    <%--  --%>
      <div id="ModalPagar" class="modal fade" data-backdrop="static" role="dialog"
        runat="server" data-keyboard="false">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
        <div class="modal-header d-block bg-light"  style="padding:10px 10px 0 10px; ">
        <h4 class="d-inline-block ml-3"  >
                              Pagar Factura</h4>
                               <button type="button" class="close  bottom-ri    ght mr-3 btn-lg" aria-label="Close" data-dismiss="modal" style="font-size: 40px;">
                            <span aria-hidden="true">&times;</span></button>
         </div>

         <asp:UpdatePanel ID="UpdatePanel7" runat="server"  UpdateMode="Conditional"   >
       <ContentTemplate>
           
      <div class="modal-body">
        <div class = "row"> 
                    <div class="col-lg-11" >       
                   <asp:Label runat="server" ID="lblIdventa" Visible="False" Font-Bold="true" />
                        </div>
                    </div>
            <div class = "row"> 
                    <div class="col-lg-11" >       
                     <asp:Label runat="server" ID="lblErrorPago" ForeColor="Red" class="control-label" />
                        </div>
                </div>
            <div class = "row"> 
                    <div class="col-lg-11" >       
             <asp:Label runat="server" ID="Label9"  class="control-label" Font-Bold="true" Text="No. de Folio "/>
	    <asp:Label runat="server" ID="lblFolioPago" />
                        </div>
                </div>
		    <div class = "row"> 
                    <div class="col-lg-11" >       
             <asp:Label runat="server" ID="Label10"  class="control-label" Text="Fecha Pago "/>
	    	 <asp:TextBox runat="server" ID="txtFechaPago" Text='<%# DateTime.Now %>' CssClass="form-control"/>
			<asp:CompareValidator runat="server" ID="cvFechaPago" ControlToValidate="txtFechaPago" Display="Dynamic" 
			 ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" ValidationGroup="Pago" />
			<asp:CalendarExtender runat="server" ID="ceFechaPago" TargetControlID="txtFechaPago" PopupButtonID="txtFechaPago" Format="dd/MM/yyyy" />
			<asp:RequiredFieldValidator runat="server" ID="rfvFechaPago" ErrorMessage="* Requerido" ControlToValidate="txtFechaPago"
			 ValidationGroup="Pago" Display="Dynamic"/>
                        </div>
                </div>
		<div class = "row"> 
                    <div class="col-lg-11" >       
             <asp:Label runat="server" ID="Label11"  class="control-label" Text="Referencia "/>
	    	<asp:TextBox runat="server" ID="txtReferenciaPago" CssClass="form-control"/>
			<asp:RequiredFieldValidator runat="server" ID="rfvReferenciaPago" ErrorMessage="* Requerido"
			 ControlToValidate="txtReferenciaPago" ValidationGroup="Pago" Display="Dynamic"/>
		</div>
            </div>
            
        
     </div>
    
      <div class="modal-footer">
 
                           <asp:LinkButton ID="btnPagar" CssClass="btn btn-default" 
                                          ValidationGroup="Pago"     Text="Concepto"
                               runat="server"   OnClick="btnPagar_Click" >
                           <span class="glyphicon glyphicon-usd"></span> Pago 
                         </asp:LinkButton>
           <button type="button" class="btn btn-default" data-dismiss="modal">
               <span class="glyphicon glyphicon-remove-sign p-1" title="enviar"></span>Cerrar</button>
      </div>
        </ContentTemplate>
             <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="gvFacturas" EventName="RowCommand"/> 
         
             </Triggers>
                       </asp:UpdatePanel>

    </div>

  </div>
    </div>  
   

       <div id="ModalCorreo" class="modal fade" data-backdrop="static" role="dialog"
        runat="server" data-keyboard="false">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
        <div class="modal-header d-block bg-light"  style="padding:10px 10px 0 10px; ">
        <h4 class="d-inline-block ml-3"  >
                              Enviar correo</h4>
                               <button type="button" class="close  bottom-ri    ght mr-3 btn-lg" aria-label="Close" data-dismiss="modal" style="font-size: 40px;">
                            <span aria-hidden="true">&times;</span></button>
         </div>

         <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional"   >
       <ContentTemplate>
           
      <div class="modal-body">
                      <div class = "row"> 
                    <div class="col-lg-11" >       
        <asp:Label runat="server" ID="lblGuid" Visible="False"  class="control-label" />
                        </div>
                    </div>
                         <div class = "row">
       <div class = "form-group col-lg-11">
             <asp:Label  class="control-label" ID="Label6" runat="server" Font-Bold="true" Text="Se enviara a"></asp:Label>
           
			 <asp:Label runat="server" ID="lblEmailCliente"  class="control-label"/>
		</div>
                             </div>
        <div class = "row">
       <div class = "form-group col-lg-11">
           <asp:Label  class="control-label" ID="Label7" runat="server" Text="Correos adicionales"></asp:Label>
   			<asp:TextBox runat="server" ID="txtEmails" CssClass="form-control" />
            <asp:Label  ID="Label8" runat="server" Font-Bold="false" Text="Separados por comas"></asp:Label>
   			</div>
            </div>
        
     </div>
    
      <div class="modal-footer">
 	
                           <asp:LinkButton ID="btnEnviarEmail" CssClass="btn btn-default" 
                                           Text="Concepto"
                               runat="server"   OnClick="btnEnviarMail_Click" >
                           <span class="glyphicon glyphicon-envelope"></span> Enviar 
                         </asp:LinkButton>
           <button type="button" class="btn btn-default" data-dismiss="modal">
               <span class="glyphicon glyphicon-remove-sign p-1" title="enviar"></span>Cerrar</button>
      </div>
        </ContentTemplate>
             <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="gvFacturas" EventName="RowCommand"/> 
         
             </Triggers>
                       </asp:UpdatePanel>

    </div>

  </div>
    </div>  
        
       <div id="ModalCancelar" class="modal fade" data-backdrop="static" role="dialog"
        runat="server" data-keyboard="false">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header d-block bg-light"  style="padding:10px 10px 0 10px; ">
        <h4 class="d-inline-block ml-3"  >
                           Cancelar</h4>
                               <button type="button" class="close  bottom-ri    ght mr-3 btn-lg" aria-label="Close" data-dismiss="modal" style="font-size: 40px;">
                            <span aria-hidden="true">&times;</span></button>  </div>
               
      <div class="modal-body">
           <div class = "row">
           <div class = "col-12">
             <span> ¿Desea Cancelar Documento?</span>
             </div>
                    </div>
                           
     </div>
      <div class="modal-footer">
    <asp:UpdatePanel ID="UpdatePanel3" runat="server"  UpdateMode="Conditional"   >
    <ContentTemplate>

   <asp:HiddenField ID="hf_DeleteID" runat="server" />

        
          <asp:LinkButton ID="lnkDelete" CssClass="btn btn-default" OnClick="lnkDelete_Click"  runat="server" >
                           <i class="fa fa-trash" title="delete"></i>  Cancelar 
                                </asp:LinkButton>
                        
             <button type="button" class="btn btn-default" data-dismiss="modal">
               <span class="glyphicon glyphicon-remove-sign p-1" title="cerrar"></span>Cerrar</button>
      </ContentTemplate>
                </asp:UpdatePanel>
      </div>

    </div>

  </div>
    </div>





             

 




</asp:Content>