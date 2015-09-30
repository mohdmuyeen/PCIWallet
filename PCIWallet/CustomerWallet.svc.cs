using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace PCIWallet
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "CustomerWallet" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select CustomerWallet.svc or CustomerWallet.svc.cs at the Solution Explorer and start debugging.
    public class CustomerWallet : ICustomerWallet
    {
        public List<WalletInfo> RetrieveWallet(string AccountId)
        {
            List<WalletInfo> lstWallet = null;

            try
            {
                
                dbPCITokenSVCEntities  context = new dbPCITokenSVCEntities ();
                var wallet = context.uspGetWallet(AccountId);
                var wallets = from e in wallet
                              select new WalletInfo
                              {
                                  AccountID = e.AccountNumber,
                                  PaymentAccountLastFour = e.BankLastFour,
                                  RoutingNumber = e.RoutingNumber == null ? string.Empty : e.RoutingNumber,
                                  ToketID = e.TokenID,
                                  DisplayName = e.DisplayName

                              };
                lstWallet = new List<WalletInfo>(wallets.ToList());
            }
            catch (Exception)
            {
                lstWallet = null;
            }
            return lstWallet;
        }
        
    }
}
