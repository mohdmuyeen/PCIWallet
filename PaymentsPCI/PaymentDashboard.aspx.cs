using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace PaymentsPCI
{
    public partial class PaymentDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

            }
        }

        #region "Private Method"

        private void PaymentHistory()
        {
            try
            {
                BusLogic objBusLogic = new BusLogic();
                List<PaymentHistory> lstPmtHistory = objBusLogic.PaymentHistory(txtaccountno.Text.Trim());
                gvPmtHistory.DataSource = lstPmtHistory;
                gvPmtHistory.DataBind();
                
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void WalletPayments()
        {
            try
            {
                CustWalletSVC.CustomerWalletClient objclient = new CustWalletSVC.CustomerWalletClient();
                CustWalletSVC.WalletInfo[] arrWallet = objclient.RetrieveWallet(txtaccountno.Text.Trim());
                gvWallet.DataSource = arrWallet;
                gvWallet.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion

        #region "Control Events"

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                PaymentHistory();
                WalletPayments();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        #endregion

        protected void gvPmtHistory_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.ToUpper() == "VOID")
            {
                GridViewRow gvr = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
                int index = gvr.RowIndex;
                Label lblTransactionNumber = (Label)gvPmtHistory.Rows[index].FindControl("lblTransactionNumber");
                BusLogic objBuslogic = new BusLogic();
                string strReturn = objBuslogic.VoidPayment(txtaccountno.Text.Trim(), lblTransactionNumber.Text.Trim());
                if (strReturn.ToUpper() == "OK")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "javascript:alert('Payment Voided Successfully ' );", true);
                    PaymentHistory();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "javascript:alert('Payment Void Failed, Plesae try after sometime! ' );", true);
                }
              

            }
            else if (e.CommandName.ToUpper() == "REVERSE")
            {
                GridViewRow gvr = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
                int index = gvr.RowIndex;
                Label lblTransactionNumber = (Label)gvPmtHistory.Rows[index].FindControl("lblTransactionNumber");
                BusLogic objBuslogic = new BusLogic();
                string strReturn = objBuslogic.ReversePayment(txtaccountno.Text.Trim(), lblTransactionNumber.Text.Trim());
                if (strReturn.ToUpper() == "OK")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "javascript:alert('Payment Reversed Successfully ' );", true);
                    PaymentHistory();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "javascript:alert('Payment Reverse Failed, Plesae try after sometime! ' );", true);
                }
               
            }
        }

        protected void btnwallet_Click(object sender, EventArgs e)
        {
            try
            {
                for (int i = 0; i < gvWallet.Rows.Count; i++)
                {
                    RadioButton rbWallet = (RadioButton)gvWallet.Rows[i].FindControl("rbAccountInfo");
                    if (rbWallet.Checked)
                    {
                        Label lblTokenID = (Label)gvWallet.Rows[i].FindControl("lblwalletTokenid");
                        String TokenID = lblTokenID.Text;
                        BusLogic objBus = new BusLogic();
                        Payment objPayment = new Payment();
                        objPayment.Accountid = txtaccountno.Text.Trim();
                        objPayment.PaymentAmount = txtPaymentAmountWallet.Text.Trim();
                        objPayment.TokenID = TokenID;
                        String strRetun = objBus.MakeWalletPayment(objPayment);
                        if (strRetun.ToUpper() == "OK")
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "javascript:alert('Payment Processed Successfully ' );", true);
                            PaymentHistory();
                        }
                        else {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "javascript:alert('Payment Failed, Plesae try after sometime! ' );", true);
                        }
                    }
                }
            }
            catch (Exception)
            {
                throw;
            }

        }

        protected void btnCard_Click(object sender, EventArgs e)
        {
            try
            {
                BusLogic objBus = new BusLogic();
                Payment objPayment = new Payment();
                objPayment.Accountid = txtaccountno.Text.Trim();
                objPayment.PaymentAmount = txtPaymentAmountCard.Text.Trim();
                objPayment.CreditCard = txtcardnbr.Text.Trim();
                String strRetun = objBus.MakePayment(objPayment);
                if (strRetun.ToUpper() == "OK")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "javascript:javascript:alert('Payment Processed Successfully ' );", true);
                    PaymentHistory();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "javascript:javascript:alert('Payment Failed, Plesae try after sometime! ' );", true);
                }

            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void btnBank_Click(object sender, EventArgs e)
        {
            try
            {
                
                BusLogic objBus = new BusLogic();
                Payment objPayment = new Payment();
                objPayment.Accountid = txtaccountno.Text.Trim();
                objPayment.PaymentAmount = txtPaymentAmountBankAccount.Text.Trim();
                objPayment.BankAccountNumber = txtBankacctnbr.Text.Trim();
                objPayment.RoutingNumber = txtroutingnbr.Text.Trim();
                String strRetun = objBus.MakePayment(objPayment);
                if (strRetun.ToUpper() == "OK")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "javascript:alert('Payment Processed Successfully ' );", true);
                    PaymentHistory();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "javascript:alert('Payment Failed, Plesae try after sometime! ' );", true);
                }
            }
            catch (Exception)
            {

                throw;
            }
        }





    }
}