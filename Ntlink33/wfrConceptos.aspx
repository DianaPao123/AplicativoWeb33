<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrConceptos.aspx.cs" Inherits="Ntlink33.wfrConceptos" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
 <link href="Content/Paginacion.css" rel="stylesheet" />    
<%--<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />--%>
     <asp:UpdatePanel ID="up1" runat="server"  UpdateMode="Conditional"  >
    <ContentTemplate>
 
          
              
     <div  class = "card mt-2">   
            <div class="card-header">
               <h3>Conceptos de Facturación de la empresa </h3>
            </div>
            <div class ="card-body" >
                 <div class = "row form-group">
             <div class = "col-lg-12">
      
	<h4><asp:Label runat="server" ID="lblEmpresa"></asp:Label></h4>
        </div>
                     </div>
               <asp:HiddenField runat="server" ID="txtIdEmpresa" />
	
	      <div  class="row mt-4">
                <div class = "col-12">
                  <div class="table-responsive  border border-dark">
                          <asp:GridView ID="gvDetalles" class="table table-bordered table-hover table-striped grdViewTable" 
                         runat="server" AutoGenerateColumns="false" BackColor="White" AlternatingRowStyle-HorizontalAlign="Left"  
                         onrowcommand="gvDetalles_RowCommand"  onpageindexchanging="gvDetalles_PageIndexChanging" 
                              Width="100%" RowStyle-Height="5" FooterStyle-BorderStyle="None" PageSize="10"  AllowPaging="true"
                              DataKeyNames="IdProducto" ItemStyle-Height = "5px"   >
                         <RowStyle  Height="10" Font-Size="14px"  cssclass="RowStyle" />
                         <FooterStyle  Font-Bold="True"  BorderStyle="None" />
                         <HeaderStyle BackColor="#f9f9f9" Font-Bold="True" ForeColor="Black" Height="30px" />
                          <AlternatingRowStyle  Height="10"  cssclass="AlternateRowStyle" />
                              <PagerStyle HorizontalAlign = "Center" Height="5" CssClass="GridPager"  />
        <EmptyDataTemplate>
            No se encontraron registros.
        </EmptyDataTemplate>

            <Columns>
				<asp:BoundField HeaderText="Unidad" DataField="Unidad" />
				<asp:BoundField HeaderText="N° de identificación" DataField="Codigo" />
				<asp:BoundField HeaderText="Descripción" DataField="Descripcion" />
				<asp:BoundField HeaderText="Observaciones" DataField="Observaciones" />
				<asp:BoundField HeaderText="Precio Unitario" DataField="PrecioP" DataFormatString="{0:F2}"   />
		<%--		<asp:ButtonField Text="Editar" CommandName="Editar" />--%>
                 <asp:TemplateField HeaderStyle-CssClass="sorting_disabled"  HeaderText= "Opciones"   ItemStyle-HorizontalAlign="Center">
                             <ItemTemplate  >
                              
                                 <div class="form-inline" >
                                  <asp:LinkButton ID="gvlnkEditC" CommandName="Editar" 
                                      CommandArgument='<%#((GridViewRow)Container).RowIndex%>' 
                                      CssClass="btn btn-light " runat="server" style=" padding:0px 3px;">
                                    <i class="glyphicon glyphicon-edit" title="Editar"></i> 
                                        </asp:LinkButton>
                                
                                     </div>
                            </ItemTemplate>
                        </asp:TemplateField>
			
            </Columns>
		</asp:GridView>
	</div>

                    </div>
         </div>
                <br />
                
	<div class="row" >
	
           <div class = "col-12">
                       <div class="btn-toolbar pull-left">
                                <asp:LinkButton ID="btnNuevoConcepto" CssClass="btn btn-default" 
                             OnClick="btnNuevoConcepto_Click" 
                             Text="Empresa"
                             runat="server" ><span class="fas fa-plus"></span> Nuevo Concepto 
                         </asp:LinkButton>

                               <asp:LinkButton ID="btnCancelarS" CssClass="btn btn-default"  CausesValidation="False"
                                      Text="Concepto" runat="server"   OnClick="btnCancelarS_Click" >
                           <span class="glyphicon glyphicon-remove-sign "></span> Cancelar 
                         </asp:LinkButton>
                      </div>
                     </div>
	</div>
	
   </div>
         </div>

     
        </ContentTemplate>
         <Triggers>
                   <asp:AsyncPostBackTrigger  ControlID="btnGuardar" EventName="Click" />
                       
         </Triggers>
         </asp:UpdatePanel>

            <!--mensaje -->
     
        <div id="ModalBuscarConcepto" class="modal fade" data-backdrop="static" role="dialog"
        runat="server" data-keyboard="false">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
        <div class="modal-header d-block bg-light" id="titulo"  style="padding:10px 10px 0 10px; ">
        <h4 class="d-inline-block ml-3" id="myModalLabel2" >Concepto </h4>
                               <button type="button" class="close  bottom-ri  ght mr-3 btn-lg" aria-label="Close" 
                                   data-dismiss="modal" style="font-size: 40px;">
                            <span aria-hidden="true">&times;</span></button>

         </div>

                   <asp:UpdatePanel ID="UpdatePanelRM2" runat="server"  UpdateMode="Conditional"   >
    <ContentTemplate>


      <div class="modal-body">
           <div class = "row">
                <div class="col-lg-12" >
             	<asp:Label runat="server" ID="lblConcepto" Visible="false" class="control-label"></asp:Label>
	         </div>
                    </div>
           	 <div class = "row"> 
            <div class="col-lg-11" >
        	<asp:Label runat="server" ID="Label1" Text="Unidad de Medida" class="control-label"></asp:Label>
	        <asp:TextBox runat="server" ID="txtUnidad" CssClass="form-control"/>
				<asp:RequiredFieldValidator runat="server" ID="rfvNombre" ErrorMessage="* Requerido" Display="Dynamic"
				 ControlToValidate="txtUnidad" ValidationGroup="Concepto" />
				  <asp:HiddenField runat="server" ID="txtIdProducto"/>
            </div>
        </div>
             <div class = "row"> 
            <div class="col-lg-11" >
        	<asp:Label runat="server" ID="Label2" Text="N° de identificación" class="control-label"></asp:Label>
	    	<asp:TextBox runat="server" ID="txtCodigo"  CssClass="form-control"></asp:TextBox>
		    </div>
          </div>
             <div class = "row"> 
            <div class="col-lg-11" >
        	<asp:Label runat="server" ID="Label3" Text="Descripción" class="control-label"></asp:Label>
	    	<asp:TextBox runat="server" ID="txtDescripcion"  CssClass="form-control"></asp:TextBox>
				<asp:RequiredFieldValidator runat="server" ID="rfvLugarExpedicion" ErrorMessage="* Requerido" Display="Dynamic"
				 ControlToValidate="txtDescripcion" ValidationGroup="Concepto" />
			</div>
           </div>
		  <div class = "row"> 
            <div class="col-lg-11" >
        	<asp:Label runat="server" ID="Label4" Text="Observaciones" class="control-label"></asp:Label>
	    	<asp:TextBox runat="server" ID="txtObservaciones"   CssClass="form-control" ></asp:TextBox>
			</div>
          </div>
		 <div class = "row"> 
            <div class="col-lg-11" >
        	<asp:Label runat="server" ID="Label5" Text="Precio Unitario" class="control-label"></asp:Label>
	    	<asp:TextBox runat="server" ID="txtPrecioUnitario"  CssClass="form-control"></asp:TextBox>
				<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ErrorMessage="* Requerido" Display="Dynamic"
				 ControlToValidate="txtPrecioUnitario" ValidationGroup="Concepto" />
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
                                     <asp:AsyncPostBackTrigger  ControlID="btnNuevoConcepto" EventName="Click" />
                                    
                           <asp:AsyncPostBackTrigger ControlID="gvDetalles" EventName="RowCommand"/> 
         
                       </Triggers>
                       </asp:UpdatePanel>

    </div>

  </div>
    </div>  
 
    




</asp:Content>
