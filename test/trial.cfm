<cfset obj = createObject('component', 'Components.shoppingkart')>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bootstrap 5 Fixed Open Accordion</title>
  <link href="../css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

    <div id="order-card" class="container card z-1 bg-light h-100 fw-bold">
        <h1 class="card-header card-title text-white bg-primary">Order History</h1>
        <div class="card-body overflow-y-scroll d-grid gap-5 m-2">
            <cfif structKeyExists(url, 'searchWord')>
            <cfelse>
                <cfset variables.orders = obj.listOrder()>
            </cfif>
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
                                    <img src="../admin/images/#ListLast(product.productimage,"/")#" class="col-3 img-fluid" alt="Login" width="80" height="80">
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



<script src="../js/popper.min.js"></script>
<script src="../js/bootstrap.bundle.min.js"></script>
</body>
</html>