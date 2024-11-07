<cfset obj = createObject('component', 'Components.shoppingkart')>
<cfif structKeyExists(session,"user") AND session.user.value EQ 1 AND structKeyExists(url, "orderid")>
    <cfset variables.details = obj.listOrderDetails(orderid=url.orderid)>
    <cfif ArrayLen(variables.details.orderitems) EQ 0>
        <cflocation url="homepage.cfm" addtoken="no">
    </cfif>
<cfelse>
    <cflocation url="userlogin.cfm" addtoken="no">
</cfif>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart Product Page</title>
    <!-- Bootstrap CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/cart.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/userpage.css">
</head>
<body>
    <!-- Navigation Bar -->
  <nav class="navbar navbar-expand-lg navbar-main">
    <div class="container">
          <a class="nav-item" href="homepage.cfm?search=true">Search</a>
          <a class="nav-item" href=""></a>
          <a class="nav-item text-center" href="homepage.cfm">SHOPPING CART-ORDER PAGE</a>
          <a class="nav-item" href="cart.cfm">Cart</a>
          <cfif structKeyExists(session,"user") AND session.user.value EQ 1>
            <a class="nav-item" href="userpage.cfm"><cfoutput>#session.user.username#</cfoutput></a>
          <cfelse>
            <a class="nav-item" href="userlogin.cfm">Login/Signup</a>
          </cfif>
    </div>
  </nav>
        <div class="container my-4">
        <div class="d-flex justify-content-center">
            <div class="card w-75"> 
                <div class="card-header bg-primary text-white">
                    <div class="row align-items-center">
                        <h6 class="card-text small col-7 text-center">Order Details</h6>
                        <cfoutput>
                            <a class="btn btn-danger btn-sma col-3 text-center" href="invoice.cfm?orderid=#variables.details.orderdetails.orderid#">Download Invoice</a>
                        </cfoutput>
                    </div> 
                </div>
                <div class="card-body">
                    <div class="d-flex flex-column justify-content-center">
                        <div class="card h-100 mb-2 p-2">
                            <cfif structKeyExists(variables,"details")>
                                <div class="card-body">
                                    <cfoutput>
                                            <div class="row align-items-center">
                                                <h6 class="card-text small col-4 text-center">OrderId:</h6>
                                                <h6 class="card-text small col-6 text-center">#variables.details.orderdetails.orderid#</h6>
                                            </div>
                                            <div class="row align-items-center">
                                                <h6 class="card-text small col-4 text-center">Orderdate:</h6>
                                                <h6 class="card-text small col-6 text-center">#variables.details.orderdetails.orderdate#</h6>
                                            </div>
                                            <div class="row align-items-center">
                                                <h6 class="card-text small col-4 text-center">Amount:</h6>
                                                <h6 class="card-text small col-6 text-center">#variables.details.orderdetails.amount#</h6>
                                            </div>
                                            <div class="row align-items-center my-2">
                                                <h6 class="card-text small col-4 text-center">Shipping Address:</h6>
                                                <div class="card-text small col-7">
                                                    <p class="card-text">
                                                        #variables.details.orderdetails.name#|#variables.details.orderdetails.phoneno#<br>
                                                        #variables.details.orderdetails.housename#<br>
                                                        #variables.details.orderdetails.street#, #variables.details.orderdetails.city#<br>
                                                        #variables.details.orderdetails.state#,#variables.details.orderdetails.pincode#
                                                    </p>
                                                </div>
                                            </div>
                                    </cfoutput>
                                </div>
                            </cfif>
                        </div>
                </div>
            </div>
        </div>
    </div>            
    <div class="container my-4">
        <div class="d-flex justify-content-center">
            <div class="card w-75"> 
                <div class="card-header bg-primary text-white">
                    <div class="row align-items-center">
                        <h6 class="card-text small col-4 text-center">ProductName</h6>
                        <h6 class="card-text small col-4 text-center">Quantity</h6>
                        <h6 class="card-text small col-4 text-center">Total Price</h6>
                    </div> 
                </div>
                <div class="card-body">
                    <div class="d-flex flex-column justify-content-center">
                        <div class="card h-100 mb-2 p-2">
                            <cfif structKeyExists(variables,"details")>
                                <div class="card-body">
                                    <cfoutput>
                                        <cfloop array="#variables.details.orderitems#" index="item">
                                            <div class="row align-items-center">
                                                <h6 class="card-text small col-4 text-center">#item.productname#</h6>
                                                <h6 class="card-text small col-4 text-center">#item.quantity#</h6>
                                                <h6 class="card-text small col-4 text-center">#item.totalprice#</h6>
                                            </div>
                                        </cfloop>
                                    </cfoutput>
                                </div>
                            </cfif>
                        </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>   
</body>
</html>