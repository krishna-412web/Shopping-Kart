<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - Product Page</title>
    <style>
        /* Reset some default styling */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
        }

        /* Navbar styling */
        .navbar {
            background-color: #5c83f6;
            color: white;
            padding: 1em;
            display: flex;
            justify-content: space-around;
            align-items: center;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        /* Cart container styling */
        .cart-container {
            background: linear-gradient(to right, #c9f4db, #a2bbc9);
            border-radius: 15px;
            width: 80%;
            margin: 2em auto;
            padding: 1em;
            text-align: center;
        }

        /* Cart title */
        .cart-title {
            font-size: 2em;
            color: #5c83f6;
            margin-bottom: 1em;
        }

        /* Cart table styling */
        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin: 0 auto;
        }

        .cart-table th, .cart-table td {
            border: 1px solid black;
            padding: 1em;
            text-align: center;
        }

        .cart-table th {
            color: #5c83f6;
            font-weight: bold;
        }

        /* Checkout button styling */
        .checkout-button {
            background-color: #5c83f6;
            color: white;
            padding: 0.8em 1.5em;
            border: none;
            border-radius: 25px;
            font-weight: bold;
            font-size: 1em;
            cursor: pointer;
            margin-top: 1em;
            transition: background-color 0.3s ease;
        }

        .checkout-button:hover {
            background-color: #4a6dd6;
        }

        /* Total price bar styling */
        .total-price-bar {
            background-color: #5c83f6;
            color: white;
            font-weight: bold;
            font-size: 1.2em;
            padding: 1em;
            border-radius: 10px;
            margin-top: 1em;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <div class="navbar">
        <a href="#">Search</a>
        <a href="#">Menu</a>
        <span>SHOPPING CART - PRODUCT PAGE</span>
        <a href="#">Cart</a>
        <a href="#">Login/Signup</a>
    </div>

    <!-- Cart Container -->
    <div class="cart-container">
        <div class="cart-title">CART</div>
        
        <!-- Cart Table -->
        <table class="cart-table">
            <thead>
                <tr>
                    <th>ITEM</th>
                    <th>QUANTITY</th>
                    <th>PRICE</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Product 1</td>
                    <td>1</td>
                    <td>$499</td>
                </tr>
                <tr>
                    <td>Product 2</td>
                    <td>2</td>
                    <td>$599</td>
                </tr>
                <tr>
                    <td>Product 3</td>
                    <td>1</td>
                    <td>$699</td>
                </tr>
            </tbody>
        </table>

        <!-- Total Price and Checkout Button -->
        <div class="total-price-bar">
            TOTAL PRICE: $2990
        </div>
        <button class="checkout-button">CHECKOUT</button>
    </div>
</body>
</html>