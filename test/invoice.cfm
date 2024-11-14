<cfset obj = createObject('component', 'Components.shoppingkart')>
<cfif structKeyExists(session,"user") AND session.user.value EQ 1 AND structKeyExists(url, "orderid")>
    <cfset variables.details = obj.listOrderDetails(orderid=url.orderid)>
<cfelse>
    <cflocation url="userlogin.cfm" addtoken="no">
</cfif>
<cfheader name="Content-Disposition" value="attachment; filename=invoice.pdf">
	<cfheader name="Content-Type" value="application/pdf">

	<cfcontent type="application/pdf" reset="true">

	<cfdocument format="PDF" orientation="portrait">
        <cfoutput>
        <h1 style="text-align:center;">Order Invoice</h1>
		<p>Order Id:#variables.details.orderdetails.orderid#</p>
        <p>Order Date:#variables.details.orderdetails.orderdate#</p>
        <p>Tax Deducted:#variables.details.orderdetails.totaltax#</p>
        <p>Amount paid:#variables.details.orderdetails.amount#</p>
        <p>Payment mode:By card</p>
        <p>
            Shipping address:<br>
            #variables.details.orderdetails.name#|#variables.details.orderdetails.phoneno#<br>
            #variables.details.orderdetails.housename#<br>
            #variables.details.orderdetails.street#, #variables.details.orderdetails.city#<br>
            #variables.details.orderdetails.state#,#variables.details.orderdetails.pincode#
        </p>


		<table border="1" cellpadding="5" cellspacing="0">	
			<thead>
				<tr>
					<th>ProductName</th>
					<th>Quantity</th>
                    <th>Product Tax</th>
					<th>Amount</th>
				</tr>
			</thead>
			<tbody>
                <cfloop array="#variables.details.orderitems#" index="item">
                    <tr class="row align-items-center">
                        <td>#item.productname#</td>
                        <td>#item.quantity#</td>
                        <td>#item.producttax#</td>
                        <td>#item.totalprice#</td>
                    </tr>
                </cfloop>
			</tbody>
		</table>
        </cfoutput>
	</cfdocument>