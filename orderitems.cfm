<cfset obj = createObject('component', 'Components.shoppingkart')>
<cfif structKeyExists(session,"user") AND session.user.value EQ 1 AND structKeyExists(url, "orderid")>
    <cfset variables.orders = obj.listOrder(search=url.orderid)>
    <!---<cfdump var="#variables.details#"> --->
    <cfif ArrayLen(variables.orders) EQ 0>
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
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/cart.css" rel="stylesheet">
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
        <div id="order-card" class="container m-2 card z-1 bg-light h-100 fw-bold">
        <h1 class="card-header card-title text-white bg-primary">Order History</h1>
        <div class="card-body d-grid gap-5 m-2">
            <cfoutput>
                <cfif structKeyExists(variables,"orders") AND arrayLen(variables.orders) GT 0>
                    <cfloop array="#variables.orders#" index="order">
                        <div class="card">
                            <div class="card-header d-flex justify-content-evenly bg-primary gap-5">
                                <h5 class="flex-grow-1">
                                    <span class="text-white">Order No :</span>
                                    <span class="text-white">#order.orderid#</span>
                                </h5>
                                <a class="btn btn-danger" href="invoice.cfm?orderid=#order.orderid#">pdf</a>
                            </div>
                            <ul class="card-body list-group p-0">
                                <cfloop array="#order.orderitems#" item="product">
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
                                                <span class="text-dark">Total product tax :</span>
                                                <span class="text-muted">
                                                    #chr(8377)#
                                                    #product.producttax#
                                                </span>
                                            </p>
                                            <p class="card-text">
                                                <span class="text-dark">Total price :</span>
                                                <span class="text-muted">
                                                    #chr(8377)#
                                                    #product.productprice#
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
                                        <span class="text-primary">#order.orderdate#</span>
                                    </p>
                                    <p class="card-text">
                                        <span class="text-dark">Tax Deducted:</span>
                                        <span class="text-success">
                                            #chr(8377)#
                                            #order.totaltax#
                                        </span>
                                    </p>
                                    <p class="card-text">
                                        <span class="text-dark">Amount Paid:</span>
                                        <span class="text-success">
                                            #chr(8377)#
                                            #order.amount#
                                        </span>
                                    </p>
                                </div>
                                <p class="card-text d-flex gap-3">
                                    <span class="text-dark">Address :</span>
                                    <span class="col-10 text-primary">
                                        #order.name# #order.phoneno#<br>
                                        #order.housename#, #order.street#,
                                        #order.city#, #order.state#,
                                        PIN - #order.pincode#
                                    </span>
                                </p>
                            </div>
                        </div>
                    </cfloop>
                </cfif>
            </cfoutput>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>   
</body>
</html>