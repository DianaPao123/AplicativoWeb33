<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrEmpresasConsulta.aspx.cs" Inherits="Ntlink33.wfrEmpresasConsulta" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    
                          
     <div  class = "card mt-2">   
            <div class="card-header">
               <h3>Empresas</h3>
            </div>
            <div class ="card-body" >
          <asp:UpdatePanel ID="up1" runat="server"  UpdateMode="Conditional"  >
    <ContentTemplate>
  
                    <div  class="row mt-4">
                <div class = "col-12">
                  <div class="table-responsive  border border-dark">
                          <asp:GridView ID="gvEmpresas" class="table table-bordered table-hover table-striped grdViewTable" 
                         runat="server" AutoGenerateColumns="false" BackColor="White" AlternatingRowStyle-HorizontalAlign="Left"  
                         onrowcommand="gvEmpresas_RowCommand" Width="100%" RowStyle-Height="5" FooterStyle-BorderStyle="None"
                              DataKeyNames="IdEmpresa" AllowPaging="True" ItemStyle-Height = "5px"   >
                         <RowStyle  Height="10" Font-Size="14px"  cssclass="RowStyle" />
                         <FooterStyle  Font-Bold="True"  BorderStyle="None" />
                         <PagerStyle  Height="5" />
                         <HeaderStyle BackColor="#f9f9f9" Font-Bold="True" ForeColor="Black" Height="30px" />
                          <AlternatingRowStyle  Height="10"  cssclass="AlternateRowStyle" />

        <EmptyDataTemplate>
            No se encontraron registros.
        </EmptyDataTemplate>

        <Columns>
            <asp:BoundField   HeaderText="RFC"   DataField="RFC" />
            <asp:BoundField HeaderText="Razón Social" DataField="RazonSocial" />
          <%--  <asp:ButtonField Text="Editar" CommandName="EditarEmpresa" />
            <asp:ButtonField Text="Sucursales(Lugar de Expedición)" CommandName="EditarSucursal" />
           <asp:ButtonField Text="Conceptos" CommandName="EditarConceptos" />
         --%>     <asp:TemplateField HeaderStyle-CssClass="sorting_disabled"  HeaderText= "Opciones"   ItemStyle-HorizontalAlign="Center">
                             <ItemTemplate  >
                                <div class="row ">
                                 <div class="form-inline col-12" >
                                  <asp:LinkButton ID="gvlnkEditC" CommandName="EditarEmpresa" 
                                      CommandArgument='<%#((GridViewRow)Container).RowIndex%>' 
                                      CssClass="btn btn-light " runat="server" style=" padding:0px 3px;">
                                    <i class="glyphicon glyphicon-edit" title="Editar"></i> 
                                        </asp:LinkButton>
                                      <asp:LinkButton ID="gvlnkSucursal" CommandName="EditarSucursal" 
                                          CommandArgument='<%#((GridViewRow)Container).RowIndex%>' 
                                            CssClass="btn btn-light mx-2 " runat="server" style=" padding:0px 3px;" >
                                           <i class="	glyphicon glyphicon-globe " title="Sucursales"></i> 
                                        </asp:LinkButton>
                                         <asp:LinkButton ID="gvlnkConceptos" CommandName="EditarConceptos" 
                                          CommandArgument='<%#((GridViewRow)Container).RowIndex%>' 
                                            CssClass="btn btn-light " runat="server" style=" padding:0px 3px;" >
                                           <i class="glyphicon glyphicon-apple " title="Conceptos"></i> 
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

         <div class="row  mr-5  mt-4">
                       <div class = "col-12">
                       <div class="btn-toolbar pull-left">
                                <asp:LinkButton ID="btnNuevaEmpresa" CssClass="btn btn-default" 
                             OnClick="btnNuevaEmpresa_Click" 
                             Text="Empresa"
                             runat="server" ><span class="fas fa-plus"></span> Nueva Empresa 
                         </asp:LinkButton>

                      </div>
                     </div>
        </div>
            </ContentTemplate>
        </asp:UpdatePanel>

       </div>
         </div>
    

</asp:Content>
