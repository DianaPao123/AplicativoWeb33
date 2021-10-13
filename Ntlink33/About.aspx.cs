using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ntlink33
{
    public partial class About : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            //txtRFCBus.Text = "";

            // ModalBuscar.Show();
            // UpdatePanel7.Update();

            //   ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Modal", "$('#MainContent_ModalRFC').modal();", true);
            // ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "none", "< script >$('#MainContent_ModalRFC').modal('show');</ script > ", false);


            //  ModalPopupRFC.Show();

            // UpdatePanel7.Update();


            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), " ShowPopup",
                 " document.getElementById('" + txtRFCBus.ClientID + "').value = '';" +
                       "$('#MainContent_ModalBuscarRFC').modal('show') ", true);
        }
      

    }
}