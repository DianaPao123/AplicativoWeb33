<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrClientes.aspx.cs" Inherits="Ntlink33.wfrClientes" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <link href="Content/Paginacion.css" rel="stylesheet" />  

  <asp:UpdatePanel ID="up1" runat="server"  UpdateMode="Conditional"  >
    <ContentTemplate>
                <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server" />

     <div  class = "card mt-2">   
            <div class="card-header">
               <h3>Cliente</h3>
            </div>
            <div class ="card-body" >
       <div class = "row">
       <div class = "form-group col-lg-6">
       <asp:Label ID="Label1" runat="server" class="control-label" Text="Empresa Emisora"></asp:Label>
            <asp:DropDownList runat="server" ID="ddlEmpresa" AppendDataBoundItems="true"
                DataTextField="RazonSocial" 
                    DataValueField="IdEmpresa" CssClass="form-control"  />
    </div>
      
       </div>
       <div class = "row">
       <div class = "form-group col-lg-3">
       <asp:Label ID="Label2" runat="server" class="control-label" Text="RFC"></asp:Label>
     <asp:TextBox runat="server" ID="txtRFC" CssClass="form-control"/>
         </div>  
       <div class = "form-group col-lg-3">
       <asp:Label ID="Label3" runat="server" class="control-label" Text="CURP"></asp:Label>
          <asp:TextBox ID="txtCurp" runat="server" CssClass="form-control"></asp:TextBox>
      </div>
       <div class = "form-group col-lg-3">
       <asp:Label ID="Label4" runat="server" class="control-label" Text="Nacionalidad"></asp:Label>
        <asp:DropDownList runat="server" ID="ddlNacionalidad" CssClass="form-control"  >
                    <asp:ListItem>Mexicana</asp:ListItem>
                    <asp:ListItem>Extranjero</asp:ListItem>
                </asp:DropDownList>
         </div>
           <div class = "form-group col-lg-3">
       <asp:Label ID="Label5" runat="server" class="control-label" Text="NumRegIdTrib"></asp:Label>
        <asp:TextBox ID="txtNumRegIdTrib" runat="server" CssClass="form-control"></asp:TextBox>
          </div>
           </div>
     <div class = "row">
       <div class = "form-group col-lg-6">
       <asp:Label ID="Label6" runat="server" class="control-label" Text="Razón Social"></asp:Label>
        <asp:TextBox runat="server" ID="txtRazonSocial" 
                    CssClass="form-control" /></td>
        </div>
         </div>
     <div class = "row">
       <div class = "form-group col-lg-3">
       <asp:Label ID="Label7" runat="server" class="control-label" Text="Calle"></asp:Label>
        <asp:TextBox runat="server" ID="txtDireccion" CssClass="form-control" />
           </div>
          <div class = "form-group col-lg-3">
       <asp:Label ID="Label8" runat="server" class="control-label" Text="No Exterior"></asp:Label>
      <asp:TextBox runat="server" ID="txtExt" CssClass="form-control" />
              </div>
        <div class = "form-group col-lg-3">
       <asp:Label ID="Label9" runat="server" class="control-label" Text="No Interior"></asp:Label>
        <asp:TextBox runat="server" ID="txtInt" CssClass="form-control" />
            </div>
         </div>
      <div class = "row">
       <div class = "form-group col-lg-3">
       <asp:Label ID="Label10" runat="server" class="control-label" Text="Colonia"></asp:Label>
     <asp:TextBox runat="server" ID="txtColonia" CssClass="form-control" />
           </div>
           <div class = "form-group col-lg-3">
       <asp:Label ID="Label11" runat="server" class="control-label" Text="Municipio"></asp:Label>
     <asp:TextBox runat="server" ID="txtMunicipio" CssClass="form-control" />
               </div>
            <div class = "form-group col-lg-3">
       <asp:Label ID="Label12" runat="server" class="control-label" Text="Localidad"></asp:Label>
     <asp:TextBox runat="server" ID="txtLocalidad" CssClass="form-control" />
                </div>
          </div>
      <div class = "row">
       <div class = "form-group col-lg-3">
       <asp:Label ID="Label13" runat="server" class="control-label" Text="Referencia"></asp:Label>
    <asp:TextBox runat="server" ID="txtReferencia" CssClass="form-control"/>
       </div>
        <div class = "form-group col-lg-3">
       <asp:Label ID="Label14" runat="server" class="control-label" Text="Estado"></asp:Label>
    <asp:TextBox runat="server" ID="txtEstado" CssClass="form-control" />
            </div>
             <div class = "form-group col-lg-3">
       <asp:Label ID="Label15" runat="server" class="control-label" Text="País"></asp:Label>
    <asp:TextBox runat="server" ID="txtPais" CssClass="form-control" >México</asp:TextBox>
                 </div>
          </div>

       <div class = "row">
       <div class = "form-group col-lg-3">
       <asp:Label ID="Label16" runat="server" class="control-label" Text="CP"></asp:Label>
    <asp:TextBox runat="server" ID="txtCP" CssClass="form-control" MaxLength="5" />
           </div>
             <div class = "form-group col-lg-3">
       <asp:Label ID="Label17" runat="server" class="control-label" Text="Teléfono"></asp:Label>
      <asp:TextBox runat="server" ID="txtTelefono" CssClass="form-control" />
                 </div>
           </div>
     <div class = "row">
       <div class = "form-group col-lg-3">
       <asp:Label ID="Label18" runat="server" class="control-label" Text="Email"></asp:Label>
       <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" />
           </div>
         <div class = "form-group col-lg-3">
       <asp:Label ID="Label19" runat="server" class="control-label" Text="Bcc"></asp:Label>
       <asp:TextBox runat="server" ID="txtBcc" CssClass="form-control" />
             </div>
         </div>
                <div class = "row">
       <div class = "form-group col-lg-3">
       <asp:Label ID="Label20" runat="server" class="control-label" Text="Web"></asp:Label>
     <asp:TextBox runat="server" ID="txtWeb" CssClass="form-control" />
           </div>
      <div class = "form-group col-lg-3">
      <asp:Label ID="Label21" runat="server" class="control-label" Text="Contacto"></asp:Label>
      <asp:TextBox runat="server" ID="txtContacto" CssClass="form-control" />
          </div>
                    </div>
                <div class = "row">
       <div class = "form-group col-lg-3">
       <asp:Label ID="Label22" runat="server" class="control-label" Text="Días Revisión"></asp:Label>
         <asp:TextBox runat="server" ID="txtDiasRevision" CssClass="form-control" />
                <asp:CompareValidator runat="server" ID="cvDiasRevision" ControlToValidate="txtDiasRevision" Display="Dynamic"
                 ErrorMessage="* Dato Invalido" Type="Integer" Operator="DataTypeCheck" />
           </div>
          <div class = "form-group col-lg-3">
       <asp:Label ID="Label23" runat="server" class="control-label" Text="Cta. Contable"></asp:Label>
    <asp:TextBox runat="server" ID="txtCuentaContable"      CssClass="form-control" />
              </div>
         <div class = "form-group col-lg-3">
       <asp:Label ID="Label24" runat="server" class="control-label" Text="Cta. Depósito"></asp:Label>
      <asp:TextBox runat="server" ID="txtCuentaDeposito"     CssClass="form-control" />
             </div>
                    </div>
        
               <div class = "row">
      
                     <div class = "form-inline col-lg-12 ">
                   <div class="btn-toolbar pull-right">
                 
                    <asp:LinkButton ID="btnSave" CssClass="btn btn-default" 
                                      Text="Concepto" runat="server"   OnClick="btnSave_Click" >
                           <span class="glyphicon glyphicon-floppy-saved align-bottom"></span> Guardar 
                         </asp:LinkButton>

                  <asp:LinkButton ID="btnCancel" CssClass="btn btn-default"  CausesValidation="False"
                                      Text="Concepto" runat="server"   OnClick="btnCancel_Click" >
                           <span class="glyphicon glyphicon-remove-sign "></span> Cancelar 
                         </asp:LinkButton>
                    </div>
                  </div>

        
  
    </div>



                   </div>

                </div>
          

        </ContentTemplate>
      </asp:UpdatePanel>

<!-- mensaje -->

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
                             <asp:AsyncPostBackTrigger  ControlID="btnSave" EventName="Click" />
                             
                       
                       </Triggers>
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
   


</asp:Content>
                            