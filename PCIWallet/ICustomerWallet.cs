using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace PCIWallet
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "ICustomerWallet" in both code and config file together.
    [ServiceContract]
    public interface ICustomerWallet
    {
        [OperationContract]
        List<WalletInfo> RetrieveWallet(String AccountId);

        [OperationContract]
        List<PaymentHistory> PaymentHistory(String AccountId);

        [OperationContract]
        String VoidPayment(String AccountId, String TransactionNumber);

        [OperationContract]
        String ReversePayment(String AccountId, String TransactionNumber);

        [OperationContract]
        String MakePayment(Payment objPayment);



    }
    [DataContract]
    public class WalletInfo
    {
        [DataMember]
        public String AccountID { get; set; }
        [DataMember]
        public String PaymentAccountLastFour { get; set; }
        [DataMember]
        public String RoutingNumber { get; set; }
        [DataMember]
        public String ToketID { get; set; }
        [DataMember]
        public String DisplayName { get; set; }
    }
    [DataContract]
    public class PaymentHistory
    {
        [DataMember]
        public String Accountid { get; set; }
        [DataMember]
        public String PaymentDate { get; set; }
        [DataMember]
        public String PaymentAmount { get; set; }
        [DataMember]
        public Boolean isVoid { get; set; }
        [DataMember]
        public Boolean isReversal { get; set; }
        [DataMember]
        public String TransactionStatus { get; set; }
        [DataMember]
        public String TransactionNumber { get; set; }
    }
    [DataContract]
    public class Payment
    {
        [DataMember]
        public String Accountid { get; set; }
        [DataMember]
        public String PaymentAmount { get; set; }
        [DataMember]
        public String CreditCard { get; set; }
        [DataMember]
        public String BankAccountNumber { get; set; }
        [DataMember]
        public String RoutingNumber { get; set; }
        [DataMember]
        public String TokenID { get; set; }
    }
}
