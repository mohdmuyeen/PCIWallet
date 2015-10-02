using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PaymentsPCI
{
    public class BusLogic
    {
        public List<PaymentHistory> PaymentHistory(String AccountId)
        {
            List<PaymentHistory> lstPAyments = null;
            try
            {
                PCITokenDataModel context = new PCITokenDataModel();
                var payment = context.PymtHistory(AccountId);
                var payments = from p in payment
                               select new PaymentHistory
                               {
                                   Accountid = p.Accountid,
                                   PaymentAmount = p.PaymentAmount.ToString(),
                                   PaymentDate = p.PaymentDate,
                                   Void = p.Void == "Y" ? true : false,
                                   Reversal = p.Reversal == "Y" ? true : false,
                                   TransactionStatus = p.TransactionStatus,
                                   TransactionNumber = p.TransactionNumber
                               };
                lstPAyments = new List<PaymentHistory>(payments.ToList());
            }
            catch (Exception)
            {
                lstPAyments = null;
            }
            return lstPAyments;
        }
        public string MakePayment(Payment objPayment)
        {
            string ReturnValue = string.Empty;
            try
            {
                PCITokenDataModel context = new PCITokenDataModel();
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
        public string MakeWalletPayment(Payment objPayment)
        {
            string ReturnValue = string.Empty;
            try
            {
                PCITokenDataModel context = new PCITokenDataModel();
                int val = context.walletPayment(objPayment.Accountid, Convert.ToDecimal(objPayment.PaymentAmount), objPayment.TokenID);
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
        public string VoidPayment(string AccountId, string TransactionNumber)
        {
            string ReturnValue = string.Empty;
            try
            {
                PCITokenDataModel context = new PCITokenDataModel();
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
                PCITokenDataModel context = new PCITokenDataModel();
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
    }


    public class PaymentHistory
    {
        public String Accountid { get; set; }
        public String PaymentDate { get; set; }
        public String PaymentAmount { get; set; }
        public Boolean Void { get; set; }
        public Boolean Reversal { get; set; }
        public String TransactionStatus { get; set; }
        public String TransactionNumber { get; set; }
    }

    public class Payment
    {

        public String Accountid { get; set; }
        public String PaymentAmount { get; set; }
        public String CreditCard { get; set; }
        public String BankAccountNumber { get; set; }
        public String RoutingNumber { get; set; }
        public String TokenID { get; set; }
    }
}