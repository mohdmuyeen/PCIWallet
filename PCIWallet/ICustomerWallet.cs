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
}
