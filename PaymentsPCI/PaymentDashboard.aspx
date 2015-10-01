<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PaymentDashboard.aspx.cs" Inherits="PaymentsPCI.PaymentDashboard" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Payment Dashboard</title>




    <style type="text/css">
        .divStyle {
            background-color: #D3DEEF;
            border: 1px solid Black;
            color: #2E4D7B;
            cursor: pointer;
            font-family: Arial,Sans-Serif;
            margin-top: 5px;
            padding: 5px;
            width: 80%;
        }

        .accordionContent {
            background-color: #D3DEEF;
            border-color: -moz-use-text-color #2F4F4F #2F4F4F;
            border-right: 1px dashed #2F4F4F;
            border-style: none dashed dashed;
            border-width: medium 1px 1px;
            padding: 10px 5px 5px;
            width: 80%;
        }

        .accordionHeaderSelected {
            background-color: #5078B3;
            border: 1px solid #2F4F4F;
            color: white;
            cursor: pointer;
            font-family: Arial,Sans-Serif;
            font-size: 12px;
            font-weight: bold;
            margin-top: 5px;
            padding: 5px;
            width: 80%;
        }

        .accordionHeader {
            background-color: #2E4D7B;
            border: 1px solid #2F4F4F;
            color: white;
            cursor: pointer;
            font-family: Arial,Sans-Serif;
            font-size: 12px;
            font-weight: bold;
            margin-top: 5px;
            padding: 5px;
            width: 80%;
        }

        .accordionSubContent {
            background-color: #D3DEEF;
            border-color: -moz-use-text-color #2F4F4F #2F4F4F;
            border-right: 1px dashed #2F4F4F;
            border-style: none dashed dashed;
            border-width: medium 1px 1px;
            padding: 10px 5px 5px;
            width: 70%;
        }

        .accordionHeaderSubSelected {
            background-color: #5078B3;
            border: 1px solid #2F4F4F;
            color: white;
            cursor: pointer;
            font-family: Arial,Sans-Serif;
            font-size: 12px;
            font-weight: bold;
            margin-top: 5px;
            padding: 5px;
            width: 70%;
        }

        .accordionSubHeader {
            background-color: #2E4D7B;
            border: 1px solid #2F4F4F;
            color: white;
            cursor: pointer;
            font-family: Arial,Sans-Serif;
            font-size: 12px;
            font-weight: bold;
            margin-top: 5px;
            padding: 5px;
            width: 70%;
        }

        .href {
            color: White;
            font-weight: bold;
            text-decoration: none;
        }

        .hrefSub {
            color: White;
            font-weight: bold;
            text-decoration: none;
        }

        .page-wrap {
            width: 1200px;
            margin: 0 auto;
        }
    </style>
    <script>
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
        <div class="page-wrap">
            <div class="divStyle">
                <h3>
                    <center>PCI Tokenization</center>
                </h3>
            </div>
            <div class="accordionHeader">
                Search Criteria
            </div>
            <div class="accordionContent">
                <span>Account Number</span>
                <asp:TextBox ID="txtaccountno" runat="server"></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"></asp:Button>
            </div>
            <asp:Accordion ID="UserAccordion" runat="server" SelectedIndex="0" HeaderCssClass="accordionHeader"
                HeaderSelectedCssClass="accordionHeaderSelected" ContentCssClass="accordionContent" FadeTransitions="true" SuppressHeaderPostbacks="true" TransitionDuration="250" FramesPerSecond="40" RequireOpenedPane="false" AutoSize="None">
                <Panes>
                    <asp:AccordionPane ID="AccordionPane1" runat="server">

                        <Header><a href="#" class="href">Payment History</a></Header>

                        <Content>
                            <asp:Panel ID="pnlHistory" runat="server">
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
                                                    <asp:LinkButton ID="lbVoid" runat="server" Visible='<%# Eval("Void") %>' CommandName="Void" Text='|Void|' OnClientClick="return confirm('Do you want to void this payment?');" ForeColor="#0099FF"></asp:LinkButton>
                                                    <asp:LinkButton ID="lbReverse" runat="server" Visible='<%# Eval("Reversal") %>' CommandName="Reverse" Text='|Reverse|' OnClientClick="return confirm('Do you want to Reverse this payment?');" ForeColor="#0099FF"></asp:LinkButton>
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
                            </asp:Panel>
                        </Content>
                    </asp:AccordionPane>
                    <asp:AccordionPane ID="AccordionPane2" runat="server">

                        <Header><a href="#" class="href">Make Payment</a></Header>

                        <Content>
                            <asp:Panel ID="Panel1" runat="server">
                                <asp:Accordion ID="Accordion1" runat="server" SelectedIndex="0" HeaderCssClass="accordionSubHeader"
                                    HeaderSelectedCssClass="accordionHeaderSubSelected" ContentCssClass="accordionSubContent" FadeTransitions="true" SuppressHeaderPostbacks="true" TransitionDuration="250" FramesPerSecond="40" RequireOpenedPane="false" AutoSize="None">
                                    <Panes>
                                        <asp:AccordionPane ID="AccordionPane3" runat="server">

                                            <Header><a href="#" class="href">Pay using Wallet</a></Header>

                                            <Content>
                                                <asp:Panel ID="Panel2" runat="server">
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
                                                                        <asp:RadioButton ID="rbAccountInfo" data-rbaccount="" runat="server" onclick="RadioCheck(this);" />
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
                                                        <asp:Button runat="server" ID="btnwallet" Text="Submit" OnClick="btnwallet_Click" />
                                                    </div>
                                                </asp:Panel>
                                            </Content>
                                        </asp:AccordionPane>
                                        <asp:AccordionPane ID="AccordionPane4" runat="server">

                                            <Header><a href="#" class="href">Pay using Credit/Debit Card</a></Header>

                                            <Content>
                                                <asp:Panel ID="Panel3" runat="server">
                                                    <div id="divCard">
                                                        <table>
                                                            <tr>
                                                                <td><span>Payment Amount</span></td>
                                                                <td>
                                                                    <asp:TextBox runat="server" ID="txtPaymentAmountCard" Width="150px" MaxLength="16"></asp:TextBox></td>
                                                            </tr>
                                                            <tr>
                                                                <td><span>Credit/Debit Card Number</span></td>
                                                                <td>
                                                                    <asp:TextBox runat="server" ID="txtcardnbr" Width="250px" MaxLength="16"></asp:TextBox></td>
                                                            </tr>
                                                            <tr>
                                                                <td><span>Security Code</span></td>
                                                                <td>
                                                                    <asp:TextBox runat="server" ID="txtSecCode" Width="75px" MaxLength="4"></asp:TextBox></td>
                                                            </tr>
                                                            <tr>
                                                                <td><span>Expiration Date (MM/YExpiration Date (MM/YY)</span></td>
                                                                <td>
                                                                    <asp:TextBox runat="server" Width="50px" ID="txtMM"></asp:TextBox>&nbsp;<asp:TextBox runat="server" Width="50px" ID="txtYY"></asp:TextBox></td>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button runat="server" ID="btnCard" Text="Submit" OnClick="btnCard_Click" /></td>
                                                            </tr>
                                                        </table>


                                                        <br />

                                                    </div>
                                                </asp:Panel>
                                            </Content>
                                        </asp:AccordionPane>
                                        <asp:AccordionPane ID="AccordionPane5" runat="server">

                                            <Header><a href="#" class="href">Pay using Bank Account</a></Header>

                                            <Content>
                                                <asp:Panel ID="Panel4" runat="server">
                                                    <div id="divBankinfo">
                                                        <table>
                                                            <tr>
                                                                <td><span>Payment Amount</span></td>
                                                                <td>
                                                                    <asp:TextBox runat="server" ID="txtPaymentAmountBankAccount" Width="150px" MaxLength="16"></asp:TextBox></td>
                                                            </tr>
                                                            <tr>
                                                                <td><span>Routing Number</span></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtroutingnbr" runat="server" MaxLength="9" Width="150px"></asp:TextBox></td>
                                                            </tr>
                                                            <tr>
                                                                <td><span>Bank Account Number</span></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtBankacctnbr" Width="150px" runat="server"></asp:TextBox></td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button runat="server" ID="btnBank" Text="Submit" OnClick="btnBank_Click" /></td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </asp:Panel>
                                            </Content>
                                        </asp:AccordionPane>
                                    </Panes>
                                </asp:Accordion>
                            </asp:Panel>
                        </Content>
                    </asp:AccordionPane>
                </Panes>
            </asp:Accordion>
        </div>
    </form>
</body>

</html>
