﻿using System;
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
        public List<PaymentHistory> PaymentHistory(String AccountId)
        {
            List<PaymentHistory> lstPAyments = null;
            try
            {
                dbPCITokenSVCEntities  context = new dbPCITokenSVCEntities ();
                var payment = context.PymtHistory(AccountId);
                var payments = from p in payment
                               select new PaymentHistory
                               {
                                   Accountid = p.Accountid,
                                   PaymentAmount = p.PaymentAmount.ToString(),
                                   PaymentDate = p.PaymentDate,
                                   isVoid = p.Void =="Y" ? true : false,
                                   isReversal = p.Reversal =="Y" ? true: false,
                                   TransactionStatus = p.TransactionStatus,
                                   TransactionNumber = p.TransactionNumber
                               };
                lstPAyments = new List<PCIWallet.PaymentHistory>(payments.ToList());
            }
            catch (Exception)
            {
                lstPAyments = null;
            }
            return lstPAyments;
        }

        public string VoidPayment(string AccountId, string TransactionNumber)
        {
            string ReturnValue = string.Empty;
            try
            {
                dbPCITokenSVCEntities  context = new dbPCITokenSVCEntities ();
                int val = context.StopPayment(AccountId, TransactionNumber);
                if (val > 0)
                    ReturnValue = "OK";
                else
                    ReturnValue = "Error";

            }
            catch (Exception)
            {
                ReturnValue = "Error";
            }
            return ReturnValue;
        }

        public string ReversePayment(string AccountId, string TransactionNumber)
        {
            string ReturnValue = string.Empty;
            try
            {
                dbPCITokenSVCEntities  context = new dbPCITokenSVCEntities ();
                int val = context.ReversePayment(AccountId, TransactionNumber);
                if (val > 0)
                    ReturnValue = "OK";
                else
                    ReturnValue = "Error";

            }
            catch (Exception)
            {
                ReturnValue = "Error";
            }
            return ReturnValue;
        }

        public string MakePayment(Payment objPayment)
        {
            string ReturnValue = string.Empty;
            try
            {
                dbPCITokenSVCEntities  context = new dbPCITokenSVCEntities ();
                int val = context.insertpayment(objPayment.Accountid, Convert.ToDecimal(objPayment.PaymentAmount), objPayment.BankAccountNumber, objPayment.RoutingNumber, objPayment.CreditCard);
                if (val > 0)
                    ReturnValue = "OK";
                else
                    ReturnValue = "Error";

            }
            catch (Exception)
            {
                ReturnValue = "Error";
            }
            return ReturnValue;
        }
    }
}
