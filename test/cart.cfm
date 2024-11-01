<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flipkart Page Recreation</title>
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
<nav class="navbar p-2">
    <div class="container-fluid">
        <!-- Logo and Brand Name -->
        <a class="navbar-brand" href="#">Shoppingcart</a>

        <!-- Search Bar -->
        <form class="d-flex search-bar">
            <input class="form-control me-2 search-input" type="search" placeholder="Search for products, brands and more" aria-label="Search">
            <button class="btn btn-outline-light" type="submit">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.415l-3.85-3.85a1.007 1.007 0 0 0-.115-.098zm-5.525-9.39a5.5 5.5 0 1 1 0 11 5.5 5.5 0 0 1 0-11z"/>
                </svg>
            </button>
        </form>

        <!-- Login Button -->
        <button class="btn login-btn">Login</button>
    </div>
</nav>

<!-- Middle Section -->
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

<script src="../js/bootstrap.bundle.min.js"></script>
</body>
</html>
