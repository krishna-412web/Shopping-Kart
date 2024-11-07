<cfif structKeyExists(url,"emptycart")>
    
</cfif>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping cart-Cart</title>
    <link href="../css/bootstrap.min.css" rel="stylesheet">
<style>
    /* Custom styling for the header */
    .navbar {
        background-color: #2874f0;
    }
    .navbar-brand {
        color: white;
        font-weight: bold;
        display: flex;
        align-items: center;
    }
    .navbar-brand img {
        width: 24px;
        height: 24px;
        margin-right: 8px;
    }
    .search-bar {
        width: 60%;
    }
    .search-input {
        width: 100%;
        padding: 8px;
        border: none;
        border-radius: 4px;
    }
    .search-input:focus {
        outline: none;
    }
    .login-btn {
        background-color: white;
        color: #2874f0;
        border: none;
        padding: 6px 16px;
        font-weight: bold;
    }

    /* Middle portion styling */
    .content-container {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 60vh;
    }
    .cart-message-box {
        text-align: center;
        max-width: 400px;
        background-color: #f7f7f7; /* Add a light gray background color */
        padding: 20px; /* Add padding for spacing */
        border-radius: 8px; /* Optional: add rounded corners */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Optional: add a subtle shadow */
    }
    .cart-message-box img {
        width: 100px;
        height: auto;
        margin-bottom: 16px;
    }
    .cart-message-title {
        font-size: 1.25rem;
        font-weight: bold;
        margin-bottom: 8px;
    }
    .cart-login-btn {
        background-color: #ff5722;
        color: white;
        font-weight: bold;
        padding: 10px 24px;
        border: none;
        border-radius: 4px;
    }
    .cart-login-btn:hover {
        background-color: #e64a19;
    }
</style>
</head>
<body>

<!-- Navbar Section -->
<nav class="navbar">
    <div class="container-fluid row">
        <!-- Logo and Brand Name -->
        <div class="d-flex flex-row justify-content-between">
            <a class="navbar-brand" href="homepage.cfm">Shoppingcart</a>

        <!-- Search Bar -->
        <!---<form class="d-flex search-bar">
            <input class="form-control me-2 search-input" type="search" placeholder="Search for products, brands and more" aria-label="Search">
            <button class="btn btn-outline-light" type="submit">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.415l-3.85-3.85a1.007 1.007 0 0 0-.115-.098zm-5.525-9.39a5.5 5.5 0 1 1 0 11 5.5 5.5 0 0 1 0-11z"/>
                </svg>
            </button>
        </form>--->
        <!-- Login Button -->
        <cfif structKeyExists(session, "user")>
            <cfoutput><a class="btn btn-info w-25" href="userpage.cfm">#session.user.username#</a></cfoutput>            
        <cfelse>
            <a href="userlogin.cfm" class="btn w-25 login-btn">Login</a>
        </cfif>
        </div>
    </div>
</nav>
<h2 class="text-center mb-3">Cart Page</h2>
<cfif NOT structKeyExists(session,"user")>
    <div class="content-container">
        <div class="cart-message-box">
            <!-- Message Title -->
            <div class="cart-message-title">Missing Cart items?</div>
            
            <!-- Message Text -->
            <p>Login to see the items you added previously</p>
            
            <!-- Login Button -->
            <button class="cart-login-btn">Login</button>
        </div>
    </div>
<cfelse>
    <cfset obj = createObject('component', 'Components.shoppingkart')>
    <div class="container-fluid">
        <div class="row">
            <div class="col-9 col-md-9">
                <table id="cartTable" class="table table-bordered table-sm p-1">
                    <thead>
                        <tr>
                        <th>#</th>
                        <th>List Name</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <cfset cartitems = obj.listCart()>
                        <cfset i=1>
                        <cfoutput query="cartitems">
                            <tr class="#cartitems.cartid#">
                            <td>#i#</td>
                            <td>#cartitems.productname#</td>
                            <td>#cartitems.price#</td>
                            <td>
                                <button class="btn btn-success btn-sm" data-bs-type="increase">+</button>
                                <button class="btn btn-warning btn-sm" data-bs-type="decrease">-</button>
                                <span class="quantity-display">#cartitems.quantity#</span>
                            </td>
                            <td>
                                <button class="btn btn-danger btn-sm" data-bs-type="delete">Delete</button>
                            </td>
                            </tr>
                            <cfset i=i+1>
                        </cfoutput>
                        <!-- Add more rows as needed -->
                    </tbody>
                </table>
            </div>
            <div class="col-3 col-md-3 text-center"> <!-- Centered column -->
                <cfset cartitems = obj.getPrice()>
                <cfoutput><h3>Total Price: <span id="totalPrice">#cartitems#</span></h3></cfoutput> <!-- Placeholder for total price -->
                <a class="btn btn-primary btn-lg" id="checkoutButton" href="paymentpage.cfm?cart=1">Checkout</a>
                <button class="btn btn-secondary btn-lg" id="emptyCartButton">Empty Cart</button>
            </div>
        </div>
    </div>
</cfif>
<script src="../js/jQuery.js"></script>
<script src="../js/cart.js"></script>
<script src="../js/bootstrap.bundle.min.js"></script>
</body>
</html>
