<cfset application.obj = createObject('component', 'Components.shoppingkart')>
<cfif structKeyExists(session,"user") AND session.user.value EQ 1 AND structKeyExists(url, "orderid")>
    <cfset variables.details = application.obj.listOrder(search=url.orderid)>
<cfelse>
    <cflocation url="userlogin.cfm" addtoken="no">
</cfif>
<cfheader name="Content-Disposition" value="attachment; filename=invoice.pdf">
	<cfheader name="Content-Type" value="application/pdf">

	<cfcontent type="application/pdf" reset="true">

	<cfdocument format="PDF" orientation="portrait">
        <cfoutput>
        <h1 style="text-align:center;">Order Invoice</h1>
		<p>Order Id:#variables.details[1].orderid#</p>
        <p>Order Date:#variables.details[1].orderdate#</p>
        <p>Tax Deducted:#variables.details[1].totaltax#</p>
        <p>Amount paid:#variables.details[1].amount#</p>
        <p>Payment mode:By card</p>
        <p>
            Shipping address:<br>
            #variables.details[1].name#|#variables.details[1].phoneno#<br>
            #variables.details[1].housename#<br>
            #variables.details[1].street#, #variables.details[1].city#<br>
            #variables.details[1].state#,#variables.details[1].pincode#
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
                <cfloop array="#variables.details[1].orderitems#" index="item">
                    <tr class="row align-items-center">
                        <td>#item.productname#</td>
                        <td>#item.quantity#</td>
                        <td>#item.producttax#</td>
                        <td>#item.productprice#</td>
                    </tr>
                </cfloop>
			</tbody>
		</table>
        </cfoutput>
	</cfdocument>