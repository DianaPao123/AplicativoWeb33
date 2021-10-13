<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrSucursalesConsulta.aspx.cs" Inherits="Ntlink33.wfrSucursalesConsulta" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
              
     <div  class = "card mt-2">   
            <div class="card-header">
               <h3>Sucursales de la empresa</h3>
            </div>
            <div class ="card-body" >
                 <div class = "row form-group">
      <div class = "col-lg-12">
    
     <h5><asp:Label ID="lblEmpresa" runat="server"></asp:Label></h5>
          <%--</div>--%>
                     </div>
                     </div>
     <asp:HiddenField ID="hdIdempresa" runat="server" />
           
             <div  class="row mt-4">
                <div class = "col-12">
                  <div class="table-responsive  border border-dark">
                          <asp:GridView ID="gvSucursales" class="table table-bordered table-hover table-striped grdViewTable" 
                         runat="server" AutoGenerateColumns="false" BackColor="White" AlternatingRowStyle-HorizontalAlign="Left"  
                         onrowcommand="gvSucursales_RowCommand" Width="100%" RowStyle-Height="5" FooterStyle-BorderStyle="None"
                              DataKeyNames="IdSucursal" AllowPaging="True" ItemStyle-Height = "5px"  onpageindexchanging="gvSucursales_PageIndexChanging" >
                         <RowStyle  Height="10" Font-Size="14px"  cssclass="RowStyle" />
                         <FooterStyle  Font-Bold="True"  BorderStyle="None" />
                         <PagerStyle  Height="5" />
                         <HeaderStyle BackColor="#f9f9f9" Font-Bold="True" ForeColor="Black" Height="30px" />
                          <AlternatingRowStyle  Height="10"  cssclass="AlternateRowStyle" />

        <EmptyDataTemplate>
            No se encontraron registros.
        </EmptyDataTemplate>
        <Columns>
            <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
            <asp:BoundField HeaderText="Lugar de Expedición" DataField="LugarExpedicion" />
           <%-- <asp:ButtonField Text="Editar" CommandName="EditarSucursal" />--%>
              <asp:TemplateField HeaderStyle-CssClass="sorting_disabled"  HeaderText= "Opciones"   ItemStyle-HorizontalAlign="Center">
                             <ItemTemplate  >
                              
                                 <div class="form-inline" >
                                  <asp:LinkButton ID="gvlnkEditC" CommandName="EditarSucursal" 
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


                    
     <div class = "row form-group mt-4">
         
          <div class = "col-12">
                       <div class="btn-toolbar pull-left">
                                <asp:LinkButton ID="btnNuevaSucursal" CssClass="btn btn-default" 
                             OnClick="btnNuevaSucursal_Click" 
                             Text="Empresa"
                             runat="server" ><span class="fas fa-plus"></span> Nueva Sucursal 
                         </asp:LinkButton>

                            <asp:LinkButton ID="btnCancelar" CssClass="btn btn-default"  CausesValidation="False"
                                      Text="Concepto" runat="server"   OnClick="btnCancelar_Click" >
                           <span class="glyphicon glyphicon-remove-sign "></span> Cancelar 
                         </asp:LinkButton>
                      </div>
                     </div>
         </div>

             
         
            
 </div>
         </div>

</asp:Content>
