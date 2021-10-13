<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrSucursales.aspx.cs" Inherits="Ntlink33.wfrSucursales" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

      <style type="text/css">
 
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

    <asp:UpdatePanel ID="up1" runat="server"   >
    <ContentTemplate>
              
     <div  class = "card mt-2">   
            <div class="card-header">
               <h3>Sucursal</h3>
            </div>
            <div class ="card-body" >
       <div class = "row">
       <div class = "form-group col-lg-12">

    <asp:Label runat="server" ID="lblError" ForeColor="Red" />
           </div>
           </div>
                <div class = "row">
       <div class = "form-group col-lg-6">
      <asp:Label ID="Label1" runat="server" class="control-label" Text="Nombre"></asp:Label>
             
                <asp:HiddenField runat="server" ID="txtIdEmpresa"/>
                <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ID="rfvNombre" ForeColor="Red" ErrorMessage="* Requerido" Display="Dynamic"
                 ControlToValidate="txtNombre" />
           </div>
                    </div>
                             <div class = "row">
       <div class = "form-group col-lg-2">
      <asp:Label ID="Label2" runat="server" class="control-label" Text="Lugar de expedición"></asp:Label>
           </div>
           <div class = "form-group col-lg-3">
                <asp:DropDownList ID="ddlEstado" runat="server" AutoPostBack="True" 
                     CssClass="btn btn-default dropdown-toggle optionAlinear" backColor="White" Width="100%"
                    onselectedindexchanged="ddlEstado_SelectedIndexChanged">
                </asp:DropDownList>
               </div>
               <div class = "form-group col-lg-3">
                <asp:DropDownList ID="ddlMunicipio" runat="server" AutoPostBack="True"
                     CssClass="btn btn-default dropdown-toggle optionAlinear" backColor="White" Width="100%"
                    onselectedindexchanged="ddlMunicipio_SelectedIndexChanged">
                </asp:DropDownList>
                   </div>
                   <div class = "form-group col-lg-3">
                <asp:DropDownList ID="ddlCP" runat="server" AutoPostBack="True"
                     CssClass="btn btn-default dropdown-toggle optionAlinear" backColor="White" Width="100%"
                    onselectedindexchanged="ddlCP_SelectedIndexChanged">
                </asp:DropDownList>

                <%--
                <asp:TextBox runat="server" ID="txtLugarExpedicion"  Width="400px"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="rfvLugarExpedicion" ErrorMessage="* Requerido" Display="Dynamic"
                 ControlToValidate="txtLugarExpedicion" />
                 --%>
            </div>
                                 </div>
                             <div class = "row">
       <div class = "form-group col-lg-8">
      <asp:Label ID="Label3" runat="server" class="control-label" Text="Domicilio"></asp:Label>
             <asp:TextBox runat="server" ID="txtDomicilio"  CssClass="form-control" 
                    TextMode="MultiLine" Height="44px" ></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" 
                    ErrorMessage="* Requerido" Display="Dynamic" ForeColor="Red"
                 ControlToValidate="txtDomicilio" />
        </div>
</div>

             <div class = "row">
       <div class = "form-group col-lg-12">
      <div class="btn-toolbar pull-right">
                 
                    <asp:LinkButton ID="btnGuardar" CssClass="btn btn-default" 
                                      Text="Concepto" runat="server"   OnClick="btnGuardar_Click" >
                           <span class="glyphicon glyphicon-floppy-saved align-bottom"></span> Guardar 
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
      
        </ContentTemplate>
        </asp:UpdatePanel>
</asp:Content>
