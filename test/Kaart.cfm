<cfset obj = createObject('component', 'Components.shoppingkart')>
<cfif structKeyExists(session,"user") AND session.user.value EQ 1 >
        <cfif structKeyExists(url, "select") 
            AND structKeyExists(url, "id")
            AND len(trim(url.id)) GT 0>
            <cfset obj.setaddress(addressid = Val(url.id),
                                userid = session.user.userid )>
            <cfset session.user.address = Val(url.id)>
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
                <cfset variables.cart = obj.listCart(userid = session.user.userid)>
                <cfif variables.cart.RECORDCOUNT EQ 0>
                    <cfset structDelete(variables,"cart")>
                </cfif>
        </cfif>
        <cfif structKeyExists(form,"saveaddress")>
            <cfset addressid = structKeyExists(form, "addressid")?form.addressid : 0>
            <cfset userid = structKeyExists(form, "addressid")? 0: session.user.userid>
            <cfset obj.updateAddress(addressid = addressid,
                                        userid = userid,
                                        name = form.name,
                                        phoneno = form.phone,
                                        housename = form.houseName,
                                        street = form.street,
                                        city = form.city,
                                        state = form.state,
                                        pincode = form.pincode)>
        <cfelseif structKeyExists(form,"paymentproduct")>
            <cfset result=obj.makepayment(cardnumber=form.cardnumber,
                                    expirationdate=form.expirydate,
                                    cvv=form.cvv,
                                    cardholdername=form.cardholdername)>
            <cfif result.value EQ 1>
                <cfset productid = structKeyExists(form,"productid")?obj.decryptData(form.productid):0>
                <cfset obj.addOrder(productid=productid,
                                    quantity=form.productquantity)>
                <cflocation url="userpage.cfm" addToken="no">
            <cfelse>
                <cflocation url="homepage.cfm" addToken="no">
            </cfif>
        <cfelseif structKeyExists(form,"paymentcart")>
            <cfset result=obj.makepayment(cardnumber=form.cardnumber,
                        expirationdate=form.expirydate,
                        cvv=form.cvv,
                        cardholdername=form.cardholdername)>
            <cfif result.value EQ 1>
                <cfset obj.addOrder()>
                <cfset obj.emptycart()>
                <cflocation url="userpage.cfm" addToken="no">
            <cfelse>
                <cflocation url="homepage.cfm" addToken="no">
            </cfif>
        </cfif>

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
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.min.js"></script>
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
                                                <h6 class="card-title text-danger fw-bold" id="productprice">#product.RESULTSET[1].price#</h6>
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
                                        <cfset address = obj.listAddress(addressid = session.user.address)>
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
                                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addressModal1"> SELECT</button>
                                    </div>
                                </div>
                        </div>
                        <div class="card-footer d-flex justify-content-around">
                            <cfoutput><h4 class="card-text fw-bold" id="finalprice">Final Price:#product.RESULTSET[1].price#</h4></cfoutput>
                            <cfif StructKeyExists(CGI, "HTTP_REFERER") AND 
                                len(trim(CGI.HTTP_REFERER)) NEQ 0>
                                <cfset previousPage = CGI.HTTP_REFERER>
                            <cfelse>
                                <cfset previousPage="/test/homepage.cfm" >
                            </cfif>
                            <cfoutput>
                                <a href="#previouspage#" class="btn btn-sm btn-outline-secondary me-2">Cancel</a>
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
                                    <cfoutput query="variables.cart">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="card-title fw-bold">#variables.cart.productname#</h6>
                                                <h6 class="card-title text-danger fw-bold" id="productprice">#variables.cart.price#</h6>
                                            </div>
                                            <div class="row align-items-center">
                                                <h6 class="card-text small col-3 text-center">Quantity</h6>
                                                <input class="col-2 text-center" name="quantity1" type="text" value="#variables.cart.quantity#" 
                                                style="max-width: 60px;" disabled/>
                                            </div>
                                        </div>
                                    </cfoutput>
                                    <div class="text-center mt-4">
                                        <p class="fw-bold">SELECTED ADDRESS</p>
                                        <cfset address = obj.listAddress(addressid = session.user.address)>
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
                                        
                                    </div>
                                </div>
                        </div>
                        <div class="card-footer d-flex justify-content-around">
                            <!--- <cfoutput><h4 class="card-text fw-bold" id="finalprice">Final Price:#obj.getPrice()#</h4></cfoutput> --->
                            <cfif StructKeyExists(CGI, "HTTP_REFERER") AND 
                                len(trim(CGI.HTTP_REFERER)) NEQ 0>
                                <cfset previousPage = CGI.HTTP_REFERER>
                            <cfelse>
                                <cfset previousPage="/test/homepage.cfm" >
                            </cfif>
                            <cfoutput>
                                <a href="#previouspage#" class="btn btn-sm btn-outline-secondary me-2">Cancel</a>
                            </cfoutput>
                            <button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#fakeAdd"> SELECT</button>
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
        <div class="modal fade" id="paymentModal" tabindex="-1" aria-labelledby="paymentModalLabel" aria-hidden="true">
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

        <div class="modal fade" id="fakeAdd" tabindex="1" aria-labelledby="paymentModalLabel1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="paymentModalLabel1">Card Payment</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <cfoutput>
                        <form id="paymentform1" name="paymentform" action="" method="POST">
                            <!-- Card Number -->
                            <div class="mb-3">
                                <label for="cardNumber" class="form-label">Card Number</label>
                                <input type="text" class="form-control" id="cardNumber1" name="cardnumber1" placeholder="1234 5678 9012 3456" value="" required>
                            </div>
                            <!---  Expiration Date -->
                            <div class="mb-3">
                                <label for="expiryDate" class="form-label">Expiration Date</label>
                                <input type="text" class="form-control" id="expiryDate1" name="expirydate" placeholder="MM/YY" required>
                            </div>
                            <!-- CVV -->
                            <div class="mb-3">
                                <label for="cvv" class="form-label">CVV</label>
                                <input type="text" class="form-control" id="cvv1" name="cvv" placeholder="123" required>
                            </div> --->
                            <!-- Cardholder Name -->
                            <!--- <div class="mb-3">
                                <label for="cardholderName" class="form-label">Cardholder Name</label>
                                <input type="text" class="form-control" id="cardholderName1" name="cardholdername" placeholder="John Doe" required>
                            </div>
                                <cfif structKeyExists(variables,"product")>
                                    <input class="form-control" type="hidden" name="productid" value="#product.RESULTSET[1].productid#">
                                    <input class="form-control" type="hidden" id="productquantity1" name="productquantity" value="1">
                                </cfif>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <cfif structKeyExists(variables,"cart")>
                                    <button type="submit" id="paymentSubmit1" name="paymentcart" class="btn btn-primary">Pay Now</button>
                                <cfelseif structKeyExists(variables,"product")>
                                    <button type="submit" id="paymentSubmit1" name="paymentproduct" class="btn btn-primary">Pay Now</button>
                                </cfif> --->
                        </form>
                        </cfoutput>
                </div>
            </div>
        </div>

        <div class="modal fade" id="addressModal1" tabindex="-1" aria-labelledby="addressModalLabel" aria-hidden="true">
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
                                <p>sss</p>
                                    <!--- <cfset address1 = obj.listAddress(userid = session.user.userid)>
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
                                                        <a class="btn btn-primary" href="/test/userpage.cfm?select=1&id=#item.addressid#">Select</a>
                                                        <button class="btn btn-info edit" id="#item.addressid#" data-bs-toggle="modal" data-bs-target="#chr(35)#addAddress">Edit</button>
                                                    </div>
                                                </div>
                                            </cfloop>
                                        </cfoutput>
                                    </cfif> --->
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
        <div class="modal fade" id="addAddress" tabindex="-1" aria-labelledby="addAddressLabel" aria-hidden="true">
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
    <!--- <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script> --->
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/jQuery.js"></script>
    <script src="../js/address.js"></script>
    <script src="../js/productadd.js"></script>
    
</body>
</html>