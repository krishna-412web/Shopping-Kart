<cfif structKeyExists(url, "logout")>
    <cfset structDelete(session, "user")>
    <cflocation  url="homepage.cfm" addToken="no">
</cfif>
<cfset obj = createObject('component', 'Components.shoppingkart')>
<cfif structKeyExists(session,"user") AND session.user.value EQ 1 >
    <cfif structKeyExists(url, "select") 
            AND structKeyExists(url, "id")
            AND len(trim(url.id)) GT 0>
            <cfset obj.setaddress(addressid = Val(url.id),
                                userid = session.user.userid )>
            <cfset session.user.address = Val(url.id)>
            <cflocation  url="userpage.cfm" addToken="no">
    </cfif>
    <cfif structKeyExists(form,"saveaddress")>
        <cfset addressid = structKeyExists(form, "addressid")?form.addressid : 0>
        <cfset userid = structKeyExists(form, "addressid")? 0: session.user.userid>
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
    </cfif>
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
    <link rel="stylesheet" href="/css/userpage.css">
</head>
<body>
    <!-- Navigation Bar -->
  <nav class="navbar navbar-expand-lg navbar-main">
    <div class="container">
          <a class="nav-item" href="homepage.cfm?search=true">Search</a>
          <a class="nav-item" href=""></a>
          <a class="nav-item text-center" href="homepage.cfm">SHOPPING CART</a>
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
 <!-- Main Content -->
    <cfif structKeyExists(session,"user") AND session.user.value EQ 1 >
        <div class="container d-flex flex-column align-items-center mt-5">
            <div class="card p-4" style="max-width: 400px; background-color: #f9fafb; border-radius: 10px;">
                <cfoutput>
                    <h2 class="text-center">#session.user.name#</h2>
                    
                    <div class="profile mt-4 text-center">
                        <img src="../images/#session.user.userimage#" alt="Profile Picture" class="img-fluid" style="max-width: 200px;">
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
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addressModal"> SELECT</button>
                </div>

                <!-- Order Details Button -->
                <a class="btn btn-success mt-3" href="orderdetails.cfm">ORDER DETAILS</a>
                <a class="btn btn-info mt-2" href="userpage.cfm?logout=1" >Logout</a>
            </div>
        </div>
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
                                                        <a class="btn btn-primary" href="userpage.cfm?select=1&id=#item.addressid#">Select</a>
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
                        <button class="btn btn-success add" id="add" data-bs-toggle="modal" data-bs-target="#addAddress">Add New Address</button>
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
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/jQuery.js"></script>
    <script src="/js/address.js"></script>
    
</body>
</html>