<cfset obj = createObject('component', 'Components.shoppingkart')>
<cfif structKeyExists(session,"user") AND session.user.value EQ 1 >
    <cfset variables.orders = obj.listOrder()>
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
    <div class="container my-5">
        <div class="d-flex justify-content-center">
            <div class="card w-100"> 
                <div class="card-header bg-primary text-white">Order Details</div>
                <div class="card-body">
                    <div class="d-flex flex-column justify-content-center">
                        <div class="card h-100 mb-2 p-2">
                            <cfif structKeyExists(variables,"orders")>
                                <div class="card-body">
                                    <cfoutput query="variables.orders">
                                        <div class="row align-items-center">
                                            <h6 class="card-text small col-3 text-center">#variables.orders.orderid#</h6>
                                            <h6 class="card-text small col-3 text-center">#variables.orders.orderdate#</h6>
                                            <h6 class="card-text small col-3 text-center">#variables.orders.amount#</h6>
                                            <a class="btn btn-sm btn-info col-1" href="orderitems.cfm?orderid=#variables.orders.orderid#">List Items</a>
                                        </div>
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