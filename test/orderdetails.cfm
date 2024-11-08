<cfset obj = createObject('component', 'Components.shoppingkart')>
<cfif structKeyExists(session,"user") AND session.user.value EQ 1 >
    <cfif structKeyExists(form, "searchSubmit") AND len(trim(form.searchString)) GT 0>
        <cfset variables.orders = obj.listOrder(search = form.searchString)>
    <cfelse>
        <cfset variables.orders = obj.listOrder()>
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
          <a class="nav-item" href="orderdetails.cfm?search=true">Search</a>
          <a class="nav-item" href="homepage.cfm">home</a>
          <a class="nav-item text-center" href="orderdetails.cfm">SHOPPING CART-ORDER PAGE</a>
          <a class="nav-item" href="cart.cfm">Cart</a>
          <cfif structKeyExists(session,"user") AND session.user.value EQ 1>
            <a class="nav-item" href="userpage.cfm"><cfoutput>#session.user.username#</cfoutput></a>
          <cfelse>
            <a class="nav-item" href="userlogin.cfm">Login/Signup</a>
          </cfif>
    </div>
  </nav>
    <cfif structKeyExists(url, "search")>
        <nav class="navbar">
            <div class="container-fluid row">
            <div class="d-flex flex-row justify-content-between align-items-center">
                <div class="d-flex justify-content-center w-100">
                    <form class="d-flex justify-content-center w-100" action="" method="POST">
                        <input class="form-control me-2 search-input" name="searchString" id="searchString" type="search" placeholder="Search for order" aria-label="Search">
                        <button class="btn btn-outline-light" id="searchSubmit" name="searchSubmit" type="submit">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.415l-3.85-3.85a1.007 1.007 0 0 0-.115-.098zm-5.525-9.39a5.5 5.5 0 1 1 0 11 5.5 5.5 0 0 1 0-11z"/>
                            </svg>
                        </button>
                    </form>
                </div>
            </div>
            </div>
        </nav>
    </cfif>            
    <div class="container my-5">
        <div id="order-card" class="container m-2 card z-1 bg-light h-100 fw-bold">
        <h1 class="card-header card-title text-white bg-primary">Order History</h1>
        <div class="card-body d-grid gap-5 m-2">
            <cfif structKeyExists(variables,"orders")>
                <cfoutput query="variables.orders">
                    <cfset items = obj.listOrderDetails(orderid=variables.orders.orderid)>
                    <div class="card">
                        <div class="card-header d-flex justify-content-evenly bg-primary gap-5">
                            <h5 class="flex-grow-1">
                                <span class="text-white">Order No :</span>
                                <span class="text-muted">#variables.orders.orderid#</span>
                            </h5>
                            <a class="btn btn-danger" href="invoice.cfm?orderid=#variables.orders.orderid#">pdf</a>
                        </div>
                        <ul class="card-body list-group p-0">
                            <cfloop array="#items.orderitems#" item="product">
                                <li class="list-group-item d-flex justify-content-between">
                                    <img src="../admin/images/#ListLast(product.productimage,"/")#" class="col-3 img-fluid" alt="Login" style="height: 135px;width:150px;">
                                    <div class="col-7 d-flex flex-column">
                                        <p class="card-text">
                                            <span class="text-dark">Item :</span>
                                            <span class="text-muted">#product.productname#</span>
                                        </p>
                                        <p class="card-text">
                                            <span class="text-dark">Quantity :</span>
                                            <span class="text-muted">#product.quantity#</span>
                                        </p>
                                        <p class="card-text">
                                            <span class="text-dark">Total price :</span>
                                            <span class="text-muted">
                                                #chr(8377)#
                                                #product.totalprice#
                                            </span>
                                        </p>
                                    </div>
                                </li>
                            </cfloop>
                        </ul>
                        <div class="card-footer">
                            <div class="d-flex justify-content-between">
                                <p class="card-text">
                                    <span class="text-dark">Date of Purchase :</span>
                                    <span class="text-muted">#variables.orders.orderdate#</span>
                                </p>
                                <p class="card-text">
                                    <span class="text-dark">Amount :</span>
                                    <span class="text-muted">
                                        #chr(8377)#
                                        #variables.orders.amount#
                                    </span>
                                </p>
                            </div>
                            <p class="card-text d-flex gap-3">
                                <span class="text-dark">Address :</span>
                                <span class="col-10 text-muted">
                                    #items.orderdetails.name# #items.orderdetails.phoneno#<br>
                                    #items.orderdetails.housename#, #items.orderdetails.street#,
                                    #items.orderdetails.city#, #items.orderdetails.state#,
                                    PIN - #items.orderdetails.pincode#
                                </span>
                            </p>
                        </div>
                    </div>
                </cfoutput>
            <cfelse>
                <!---Add div to make user to order--->
            </cfif>
        </div>
    </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>   
</body>
</html>