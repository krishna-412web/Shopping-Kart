<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bootstrap 5 Fixed Open Accordion</title>
  <link href="../css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

    <div class="container my-5">
        <div class="d-flex justify-content-center">
            <div class="card w-50"> 
                <div class="card-header bg-primary text-white">Order Details</div>
                <div class="card-body">
                    <div class="d-flex flex-column justify-content-center">
                        <div class="card h-100 mb-2 p-2">
                            <div class="card-body">
                                <div class="row">
                                    <h6 class="col-6 card-title">Productname</h6>
                                    <h6 class="col-6 card-title">Productprice</h6>
                                </div>
                                <div class="row">
                                    <h6 class="card-text small col-7">Quantity</h6>
                                    <button class="btn btn-info col-1">+</button>
                                    <input class="col-2" type="text" value="3"/>
                                    <button class="btn btn-secondary col-1">-</button>
                                </div>
                            </div>
                        </div>

                        <div class="card h-100 mb-2 p-2">
                            <div class="card-body">
                                <h6 class="card-title">Card 2</h6>
                                <p class="card-text small">This is the description for card 2.</p>
                            </div>
                        </div>

                        <div class="card h-100 mb-2 p-2">
                            <div class="card-body">
                                <h6 class="card-title">Card 3</h6>
                                <p class="card-text small">This is the description for card 3.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer d-flex justify-content-end">
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
    <button class="btn btn-sm btn-outline-secondary">Cancel</button>
    <button class="btn btn-sm btn-outline-primary">Place Order</button>



<script src="../js/popper.min.js"></script>
<script src="../js/bootstrap.bundle.min.js"></script>
</body>
</html>