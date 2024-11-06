<cfset obj = createObject('component', 'Components.shoppingkart')>
    <html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart Product Page</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/cart.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/userpage.css">
</head>
<body>
        <buton type="button" class="btn-btn-primary" data-bs-toggle="modal" data-bs-target="#addressModal">open modal</button>
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
                                                        <a class="btn btn-primary" href="/test/userpage.cfm?select=1&id=#item.addressid#">Select</a>
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
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
    <script src="../js/jQuery.js"></script>
    <script src="../js/address.js"></script>
    
</body>
</html>