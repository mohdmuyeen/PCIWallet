<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PaymentDashboard.aspx.cs" Inherits="PaymentsPCI.PaymentDashboard" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Payment Dashboard</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"/>
    <script src="j.js"></script>
    <script src="ui.js"></script>
    <script>
        $(function () {
            $("#accordion").accordion();
            $("#accordionpayment").accordion();
        });
        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvWallet.ClientID%>");
            var rbs = gv.getElementsByTagName("input");
            var row = rb.parentNode.parentNode;
            for (var i = 0; i < rbs.length; i++) {
                if (rbs[i].type == "radio") {
                    if (rbs[i].checked && rbs[i] != rb) {
                        rbs[i].checked = false;
                        break;
                    }
                }
            }
        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
        <span>Account Number</span>
        <asp:TextBox ID="txtaccountno" runat="server"></asp:TextBox>
        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"></asp:Button>
        <div id="accordion">
            <h3>Payment History</h3>
            <div>
                <asp:GridView runat="server" ID="gvPmtHistory" AutoGenerateColumns="false" OnRowCommand="gvPmtHistory_RowCommand">
                    <EmptyDataTemplate>
                        <div style="text-align: center">
                            No Payments Found
                        </div>
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:BoundField HeaderText="Account#" DataField="AccountID" />
                        <asp:BoundField HeaderText="Payment Date" DataField="PaymentDate" DataFormatString="{0:MM/dd/yyyy}" />
                        <asp:BoundField HeaderText="Payment Amount" DataField="PaymentAmount" DataFormatString="{0:C}" />
                        <asp:BoundField HeaderText="Transaction Status" DataField="TransactionStatus" />
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="lbVoid" runat="server" Visible='<%# Eval("Void") %>' CommandName="Void" Text='Void|' OnClientClick="return confirm('Do you want to void this payment?');" ForeColor="#0099FF"></asp:LinkButton>
                                <asp:LinkButton ID="lbReverse" runat="server" Visible='<%# Eval("Reversal") %>' CommandName="Reverse" Text='Reverse|' OnClientClick="return confirm('Do you want to Reverse this payment?');" ForeColor="#0099FF"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblTransactionNumber" runat="server" Text='<%# Eval("TransactionNumber") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
            <h3>Make Payment</h3>
            <div id="accordionpayment">
                <h3>Payment from Wallet</h3>
                <div id="divwallet">
                    <asp:GridView runat="server" ID="gvWallet" AutoGenerateColumns="false" Width="100%">
                        <EmptyDataTemplate>
                            <div style="text-align: center">
                                No Wallet Found
                            </div>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:RadioButton ID="rbAccountInfo" data-rbaccount="" runat="server" onclick = "RadioCheck(this);" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Payment Account">
                                <ItemTemplate>
                                    <%# string.Format("{0} - {1}", Eval("DisplayName ") ,Eval("PaymentAccountLastFour"))%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="Routing#" DataField="RoutingNumber" />
                            <asp:TemplateField Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblwalletTokenid" runat="server" Text='<%# Eval("ToketID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <br />
                    <span>Payment Amount</span>
                    <asp:TextBox runat="server" ID="txtPaymentAmountWallet" Width="150px" MaxLength="16"></asp:TextBox><br />
                    <asp:Button runat="server" ID="btnwallet" Text="Add" OnClick="btnwallet_Click" />
                </div>
                <h3>Payment from Credit/Debit card   </h3>
                <div id="divCard">
                    <span>Payment Amount</span>
                    <asp:TextBox runat="server" ID="txtPaymentAmountCard" Width="150px" MaxLength="16"></asp:TextBox><br />
                    <span>Credit/Debit Card Number</span>
                    <asp:TextBox runat="server" ID="txtcardnbr" Width="250px" MaxLength="16"></asp:TextBox><br />
                    <span>Security Code</span>
                    <asp:TextBox runat="server" ID="txtSecCode" Width="75px" MaxLength="4"></asp:TextBox><br />
                    <span>Expiration Date (MM/YExpiration Date (MM/YY)</span><asp:TextBox runat="server" Width="50px" ID="txtMM"></asp:TextBox>&nbsp;
                        <asp:TextBox runat="server" Width="50px" ID="txtYY"></asp:TextBox><br />
                    <asp:Button runat="server" ID="btnCard" Text="Add" OnClick="btnCard_Click" />
                </div>
                <h3>Payment from Bank Account   </h3>
                <div id="divBankinfo">
                    <span>Payment Amount</span>
                    <asp:TextBox runat="server" ID="txtPaymentAmountBankAccount" Width="150px" MaxLength="16"></asp:TextBox><br />
                    <span>Routing Number</span><asp:TextBox ID="txtroutingnbr" runat="server" MaxLength="9" Width="100px"></asp:TextBox><br />
                    <span>Bank Account Number</span><asp:TextBox ID="txtBankacctnbr" Width="150px" runat="server"></asp:TextBox><br />
                    <asp:Button runat="server" ID="btnBank" Text="Add" OnClick="btnBank_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
<script>
    setTimeout(function () { document.getElementById('divBankinfo').style.height = '200px' },
        2000);
    setTimeout(function () { document.getElementById('divCard').style.height = '200px' },
        2000);
    setTimeout(function () { document.getElementById('divwallet').style.height = '200px' },
        2000);

</script>
</html>
