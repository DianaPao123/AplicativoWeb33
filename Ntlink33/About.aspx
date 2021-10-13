<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Ntlink33.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <h3>Your application description page.</h3>
    <p>Use this area to provide additional information.</p>

      <asp:LinkButton ID="btnBuscar" CssClass="btn btn-default lineal"   OnClick="btnBuscar_Click" 
                             runat="server" ><span class="glyphicon glyphicon-search"></span> 
                         </asp:LinkButton>
                       

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


</asp:Content>
