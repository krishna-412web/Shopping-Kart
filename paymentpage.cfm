<cftry>
<cfset obj = createObject('component', 'Components.shoppingkart')>
<cfif structKeyExists(session,"user") AND session.user.value EQ 1 >
        <cfif structKeyExists(url, "select") 
            AND structKeyExists(url, "id")
            AND len(trim(url.id)) GT 0>
            <cfset session.addressid = Val(url.id)>
            <cfif structKeyExists(url,"pro")>
                <cflocation  url="paymentpage.cfm?pro=#url.pro#" addToken="no">
            <cfelseif structKeyExists(url,"cart")>
                <cflocation  url="paymentpage.cfm?cart=1" addToken="no">
            </cfif>
        </cfif>
        <cfif structKeyExists(url, "pro") AND len(trim(url.pro))>
                <cfset variables.product = obj.listProducts(productid = url.pro)>
        </cfif>
        <cfif structKeyExists(url, "cart") AND len(trim(url.cart))>
                <cfset variables.cart = obj.listCart()>
                <cfif Arraylen(variables.cart.cartitems) EQ 0>
                    <cfset structDelete(variables,"cart")>
                </cfif>
        </cfif>
        <cfif structKeyExists(form,"saveaddress")>
            <cfset addressid = structKeyExists(form, "addressid")?form.addressid : 0>
            <cfset userid = structKeyExists(form, "addressid")? 0: session.user.userid>
            <!---Validate Address--->
            <cfset variables.errors = arrayNew(1)>
            <cfif len(trim(form.name)) EQ 0>
                <cfset arrayAppend(variables.errors, "*Name required")>
            </cfif>
            <cfif len(trim(form.phone)) EQ 0>
                <cfset arrayAppend(variables.errors, "*Phone required")>
            </cfif>
            <cfif len(trim(form.housename)) EQ 0>
                <cfset arrayAppend(variables.errors, "*House required")>
            </cfif>
            <cfif len(trim(form.street)) EQ 0>
                <cfset arrayAppend(variables.errors, "*Street required")>
            </cfif>
            <cfif len(trim(form.city)) EQ 0>
                <cfset arrayAppend(variables.errors, "*City required")>
            </cfif>
            <cfif len(trim(form.state)) EQ 0>
                <cfset arrayAppend(variables.errors, "*State required")>
            </cfif>
            <cfif len(trim(form.pincode)) EQ 0>
                <cfset arrayAppend(variables.errors, "*Pincode required")>
            </cfif>
            <cfif Arraylen(variables.errors) EQ 0>
                <cfset obj.updateAddress(addressid = addressid,
                                            userid = userid,
                                            name = form.name,
                                            phoneno = form.phone,
                                            housename = form.houseName,
                                            street = form.street,
                                            city = form.city,
                                            state = form.state,
                                            pincode = form.pincode)>
            </cfif>
        <cfelseif structKeyExists(form,"paymentproduct")>
            <cfif structKeyExists(session,"addressid")>
                <cfset variables.addressid = session.addressid>
                <cfset structdelete(session,"addressid")>
            <cfelse>
                <cfset variables.addressid = session.user.address>
            </cfif>
            <cfset result=obj.makepayment(cardnumber=form.cardnumber,
                                    expirationdate=form.expirydate,
                                    cvv=form.cvv,
                                    cardholdername=form.cardholdername)>
            <cfif result.value EQ 1>
                <cfset productid = structKeyExists(form,"productid")?obj.decryptData(form.productid):0>
                <cfset orderid = obj.addOrder(productid = productid,
                                    quantity = form.productquantity,
                                    address = variables.addressid)>
                <cfset obj.sendmail(orderid = orderid)>
                <cflocation url="paymentsuccess.cfm?orderid=#orderid#" addToken="no">
            <cfelse>
                <cflocation url="paymentsuccess.cfm" addToken="no">
            </cfif>
        <cfelseif structKeyExists(form,"paymentcart")>
            <cfif structKeyExists(session,"addressid")>
                <cfset variables.addressid = session.addressid>
                <cfset structdelete(session,"addressid")>
            <cfelse>
                <cfset variables.addressid = session.user.address>
            </cfif>
            <cfset result=obj.makepayment(cardnumber=form.cardnumber,
                        expirationdate=form.expirydate,
                        cvv=form.cvv,
                        cardholdername=form.cardholdername)>
            <cfif result.value EQ 1>
                <cfset orderid = obj.addOrder(address = variables.addressid)>
                <cfset obj.sendmail(orderid = orderid)>
                <cfset obj.deleteCart()>
                <cflocation url="paymentsuccess.cfm?orderid=#orderid#" addToken="no">
            <cfelse>
                <cflocation url="paymentsuccess.cfm" addToken="no">
            </cfif>
        </cfif>

</cfif>
<cfcatch type="any">
    <cfdump var="#cfcatch#">
</cfcatch>
</cftry>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart Product Page</title>
    <!-- Bootstrap CSS -->
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/cart.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/userpage.css"><!--- 
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.min.js"></script> --->
</head>
<body>
    <!-- Navigation Bar -->  
  <nav class="navbar navbar-expand-lg navbar-main">
    <div class="container">
          <a class="nav-item" href="homepage.cfm?search=true">Search</a>
          <a class="nav-item" href=""></a>
          <a class="nav-item text-center" href="homepage.cfm">SHOPPING CART-ORDER PAGE</a>
          <a class="nav-item" href="cart">Cart</a>
          <cfif structKeyExists(session,"user") AND session.user.value EQ 1>
            <a class="nav-item" href="userpage.cfm"><cfoutput>#session.user.username#</cfoutput></a>
          <cfelse>
            <a class="nav-item" href="userlogin.cfm">Login/Signup</a>
          </cfif>
    </div>
  </nav>
  <cfif structKeyExists(variables,"errors") AND arrayLen(variables.errors) NEQ 0>
        <div class="alert alert-danger alert-dismissible fade show text-center mt-5 z-3 fw-bold">
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            <cfoutput>
                #arrayToList(variables.errors)#
            </cfoutput>
        </div>
  </cfif>
    <cfif structKeyExists(variables, "message")>
        <div class="container my-2">
            <div class="d-flex justify-content-center">
                <div class="card w-50">
                    <cfoutput><p>#variables.message#</p></cfoutput>
                </div>
            </div>
        </div> 
    </cfif>
 <!-- Main Content -->
    <cfif structKeyExists(session,"user") AND session.user.value EQ 1 >
        <cfif structKeyExists(variables, "product")>
            <div class="container my-5">
                <div class="d-flex justify-content-center">
                    <div class="card w-50"> 
                        <div class="card-header bg-primary text-white">Order Details</div>
                        <div class="card-body">
                            <div class="d-flex flex-column justify-content-center">
                                <div class="card h-100 mb-2 p-2">
                                    <cfoutput>
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="card-title fw-bold">#product.RESULTSET[1].productname#</h6>
                                                <div class="d-flex flex-column">
                                                    <h6 class="card-title text-danger fw-bold" id="productprice">Price: <span id="price">#product.RESULTSET[1].price#</span></h6>
                                                    <h6 class="card-title text-danger fw-bold" id="producttax">Tax: <span id="tax">#product.RESULTSET[1].tax#</span>%</h6>
                                                </div>
                                            </div>
                                            <div class="row align-items-center">
                                                <h6 class="card-text small col-3 text-center">Quantity</h6>
                                                <button class="btn btn-sm btn-info col-1" data-bs-type="increase">+</button>
                                                <input class="col-2 text-center" id="quantity" type="text" value="1" style="max-width: 60px;"/>
                                                <button class="btn btn-sm btn-secondary col-1" data-bs-type="decrease">-</button>
                                            </div>
                                        </div>
                                    </cfoutput>
                                    <div class="text-center mt-4">
                                        <p class="fw-bold">SELECTED ADDRESS</p>
                                        <cfif structKeyExists(session,"addressid")>
                                            <cfset address = obj.listAddress(addressid = session.addressid)>
                                        <cfelse>
                                            <cfset address = obj.listAddress(addressid = session.user.address)>
                                        </cfif>
                                        <cfif address.recordCount>
                                            <cfset selectedAddress = address.RESULTSET[1]>
                                            <cfoutput> <!--- Get the first address --->
                                                <div class="address-info text-center">
                                                    <p>
                                                        <strong>#selectedAddress.name#</strong> | <strong>#selectedAddress.phoneno#</strong>
                                                    </p>
                                                    <p>
                                                        #selectedAddress.housename#, #selectedAddress.street#, #selectedAddress.city#, #selectedAddress.state#, #selectedAddress.pincode#
                                                    </p>
                                                </div>
                                            </cfoutput>
                                        <cfelse>
                                            <p>No addresses found.</p>
                                        </cfif>
                                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addressModal"> SELECT</button>
                                    </div>
                                </div>
                        </div>
                        <div class="card-footer d-flex justify-content-around">
                            <cfoutput><h4 class="card-text fw-bold" id="finalprice">Final Price:#product.RESULTSET[1].price+
                                ((product.RESULTSET[1].price*product.RESULTSET[1].tax)/100)#</h4></cfoutput>
                            <cfoutput>
                                <a href="/product/#url.pro#" class="btn btn-sm btn-outline-secondary me-2">Cancel</a>
                            </cfoutput>
                            <button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#paymentModal">Place Order</button>
                        </div>
                    </div>
                </div>
            </div>
        <cfelseif structKeyExists(variables, "cart")>
            <div class="container my-5">
                <div class="d-flex justify-content-center">
                    <div class="card w-50"> 
                        <div class="card-header bg-primary text-white">Order Details</div>
                        <div class="card-body">
                            <div class="d-flex flex-column justify-content-center">
                                <div class="card h-100 mb-2 p-2">
                                    <cfoutput>
                                        <cfloop array="#variables.cart.cartitems#" index="item">
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between">
                                                    <h6 class="card-title fw-bold">#item.productname#</h6>
                                                    <div class="d-flex flex-column">
                                                        <h6 class="card-title text-danger fw-bold" name="productrate">Rate: #item.rate#</h6>
                                                        <h6 class="card-title text-danger fw-bold" name="producttax">Tax: #item.producttax#</h6>
                                                        <h6 class="card-title text-danger fw-bold" name="productprice">Price: #item.productprice#</h6>
                                                    </div>
                                                </div>
                                                <div class="row align-items-center">
                                                    <h6 class="card-text small col-3 text-center">Quantity</h6>
                                                    <input class="col-2 text-center" name="quantity1" type="text" value="#item.quantity#" 
                                                    style="max-width: 60px;" disabled/>
                                                </div>
                                            </div>
                                        </cfloop>
                                    </cfoutput>
                                    <div class="text-center mt-4">
                                        <p class="fw-bold">SELECTED ADDRESS</p>
                                        <cftry>
                                            <cfif structKeyExists(session,"addressid")>
                                                <cfset address = obj.listAddress(addressid = session.addressid)>
                                            <cfelse>
                                                <cfset address = obj.listAddress(addressid = session.user.address)>
                                            </cfif>
                                        <cfcatch type="exception">
                                            <cfdump var="#cfcatch#">
                                        </cfcatch>
                                        </cftry>
                                        <cfif address.recordCount>
                                            <cfset selectedAddress = address.RESULTSET[1]>
                                            <cfoutput> <!--- Get the first address --->
                                                <div class="address-info text-center">
                                                    <p>
                                                        <strong>#selectedAddress.name#</strong> | <strong>#selectedAddress.phoneno#</strong>
                                                    </p>
                                                    <p>
                                                        #selectedAddress.housename#, #selectedAddress.street#, #selectedAddress.city#, #selectedAddress.state#, #selectedAddress.pincode#
                                                    </p>
                                                </div>
                                            </cfoutput>
                                        <cfelse>
                                            <p>No addresses found.</p>
                                        </cfif>
                                        <button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#addressModal"> SELECT</button>
                                    </div>
                                </div>
                                <div>
                                    <cfoutput><h4 class="card-text text-danger fw-bold" id="finalamount" name="finalamount">Payable Amount:#obj.getAmount()#</h4></cfoutput>
                                </div>
                        </div>
                        <div class="card-footer mt-1 d-flex justify-content-around">
                            <!--- <cfoutput><h4 class="card-text fw-bold" id="finalprice">Final Price:#obj.getPrice()#</h4></cfoutput> --->
                            <cfoutput>
                                <a href="/cart" class="btn btn-sm btn-outline-secondary me-2">Cancel</a>
                            </cfoutput>
                            <button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#paymentModal">Place Order</button>
                        </div>
                    </div>
                </div>
            </div>
        <cfelse>
            <div class="content-container">
                <div class="cart-message-box">
                    <!-- Message Title -->
                    <div class="cart-message-title">No items added?</div>
                    
                    <!-- Message Text -->
                    <p>Go to homepage</p>
                    
                    <!-- Login Button -->
                    <a class="cart-login-btn" href="homepage.cfm">Homepage</a>
                </div>
            </div>
        </cfif>
        <div class="modal fade" id="addressModal" tabindex="-1" aria-labelledby="addressModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addressModalLabel">Select an Address</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="container">
                            <!-- Address List -->
                            <div class="d-flex flex-column">
                                <!-- Example Address 1 -->
                                <div>
                                    <cfset address1 = obj.listAddress(userid = session.user.userid)>
                                    <cfif address1.recordCount NEQ 0>
                                        <cfoutput>
                                            <cfloop array="#address1.RESULTSET#" index="item">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <h6 class="card-title">#item.name#|#item.phoneno#</h6>
                                                        <p class="card-text">
                                                            #item.housename#<br>
                                                            #item.street#, #item.city#<br>
                                                            #item.state#,#item.pincode#
                                                        </p>
                                                        <cfif structKeyExists(url,"pro")>
                                                            <a class="btn btn-primary" href="paymentpage.cfm?pro=#url.pro#&select=1&id=#item.addressid#">Select</a>
                                                        <cfelseif structKeyExists(url,"cart")>
                                                            <a class="btn btn-primary" href="paymentpage.cfm?cart=1&select=1&id=#item.addressid#">Select</a>
                                                        </cfif>
                                                        <button class="btn btn-info edit" id="#item.addressid#" data-bs-toggle="modal" data-bs-target="#chr(35)#addAddress">Edit</button>
                                                    </div>
                                                </div>
                                            </cfloop>
                                        </cfoutput>
                                    </cfif> 
                                </div>
                                <!-- Add More Address Cards Here -->
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-success add" id="addrs" data-bs-toggle="modal" data-bs-target="#addAddress">Add New Address</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
                <div class="modal fade" id="addAddress" tabindex="0" aria-labelledby="addAddressLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addressHeading">Add/Edit Address</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div> 
                    <form id="addressForm" action="" method="POST">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="name" class="form-label">Name</label>
                                <input type="text" class="form-control" id="name" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="phone" class="form-label">Phone Number</label>
                                <input type="tel" class="form-control" id="phone" name="phone" required>
                            </div>
                            <div class="mb-3">
                                <label for="houseName" class="form-label">House Name</label>
                                <input type="text" class="form-control" id="houseName" name="houseName" required>
                            </div>
                            <div class="mb-3">
                                <label for="street" class="form-label">Street</label>
                                <input type="text" class="form-control" id="street" name="street" required>
                            </div>
                            <div class="mb-3">
                                <label for="city" class="form-label">City</label>
                                <input type="text" class="form-control" id="city" name="city" required>
                            </div>
                            <div class="mb-3">
                                <label for="state" class="form-label">State</label>
                                <input type="text" class="form-control" id="state" name="state" required>
                            </div>
                            <div class="mb-3">
                                <label for="pincode" class="form-label">Pincode</label>
                                <input type="text" class="form-control" id="pincode" name="pincode" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary" name="saveaddress">Save</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="modal fade" id="paymentModal" tabindex="1" aria-labelledby="paymentModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="paymentModalLabel">Card Payment</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <cfoutput>
                        <form id="paymentform" name="paymentform" action="" method="POST">
                            <!-- Card Number -->
                            <div class="mb-3">
                                <label for="cardNumber" class="form-label">Card Number</label>
                                <input type="text" class="form-control" id="cardNumber" name="cardnumber" placeholder="1234 5678 9012 3456" value="" required>
                            </div>
                            <!-- Expiration Date -->
                            <div class="mb-3">
                                <label for="expiryDate" class="form-label">Expiration Date</label>
                                <input type="text" class="form-control" id="expiryDate" name="expirydate" placeholder="MM/YY" required>
                            </div>
                            <!-- CVV -->
                            <div class="mb-3">
                                <label for="cvv" class="form-label">CVV</label>
                                <input type="text" class="form-control" id="cvv" name="cvv" placeholder="123" required>
                            </div>
                            <!-- Cardholder Name -->
                            <div class="mb-3">
                                <label for="cardholderName" class="form-label">Cardholder Name</label>
                                <input type="text" class="form-control" id="cardholderName" name="cardholdername" placeholder="John Doe" required>
                            </div>
                                <cfif structKeyExists(variables,"product")>
                                    <input class="form-control" type="hidden" name="productid" value="#product.RESULTSET[1].productid#">
                                    <input class="form-control" type="hidden" id="productquantity" name="productquantity" value="1">
                                </cfif>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <cfif structKeyExists(variables,"cart")>
                                    <button type="submit" id="paymentSubmit" name="paymentcart" class="btn btn-primary">Pay Now</button>
                                <cfelseif structKeyExists(variables,"product")>
                                    <button type="submit" id="paymentSubmit" name="paymentproduct" class="btn btn-primary">Pay Now</button>
                                </cfif>
                        </form>
                        </cfoutput>
                </div>
            </div>
        </div>

    <cfelse>
        <div class="content-container">
            <div class="cart-message-box">
                <!-- Message Title -->
                <div class="cart-message-title">Not a User?</div>
                
                <!-- Message Text -->
                <p>Login to accesss</p>
                
                <!-- Login Button -->
                <a class="cart-login-btn" href="userlogin.cfm">Login</a>
            </div>
        </div>
    </cfif>

    <!-- Bootstrap JS (for components that require JavaScript) -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/jQuery.js"></script>
    <script src="/js/address.js"></script>
    <script src="/js/productadd.js"></script>
    
</body>
</html>