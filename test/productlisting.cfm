<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart Product Page</title>
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

        /* Category menu styling */
        .category-menu {
            background-color: #a2bbc9;
            padding: 0.5em;
            display: flex;
            justify-content: space-around;
        }

        .category-menu a {
            color: white;
            text-decoration: none;
            font-weight: bold;
            padding: 0.5em;
        }

        /* Product section styling */
        .product-section {
            text-align: center;
            padding: 2em 0;
        }

        .product-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 1em;
            padding: 1em;
        }

        /* Product card styling */
        .product-card {
            width: 200px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s;
        }

        .product-card:hover {
            transform: scale(1.05);
        }

        .product-card img {
            width: 100%;
            height: auto;
        }

        .product-info {
            padding: 1em;
        }

        .product-name {
            font-size: 1.1em;
            font-weight: bold;
            margin: 0.5em 0;
            color: #333;
        }

        .product-price {
            font-size: 1em;
            color: #5c83f6;
            margin: 0.5em 0;
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

    <!-- Category Menu -->
    <div class="category-menu">
        <a href="#">Category1</a>
        <a href="#">Category2</a>
        <a href="#">Category3</a>
        <a href="#">Category4</a>
        <a href="#">Category5</a>
        <a href="#">Category6</a>
        <a href="#">Category7</a>
    </div>

    <!-- Product Section -->
    <div class="product-section">
        <h1>Products</h1>
        <div class="product-grid">
            <!-- Product Card 1 -->
            <div class="product-card">
                <img src="/images/background.jpeg" alt="Product Image">
                <div class="product-info">
                    <div class="product-name">Product 1</div>
                    <div class="product-price">$29.99</div>
                </div>
            </div>

            <!-- Product Card 2 -->
            <div class="product-card">
                <img src="/images/background.jpeg" alt="Product Image">
                <div class="product-info">
                    <div class="product-name">Product 2</div>
                    <div class="product-price">$39.99</div>
                </div>
            </div>

            <!-- Product Card 3 -->
            <div class="product-card">
                <img src="/images/background.jpeg" alt="Product Image">
                <div class="product-info">
                    <div class="product-name">Product 3</div>
                    <div class="product-price">$49.99</div>
                </div>
            </div>

            <!-- Product Card 4 -->
            <div class="product-card">
                <img src="/images/background.jpeg" alt="Product Image">
                <div class="product-info">
                    <div class="product-name">Product 4</div>
                    <div class="product-price">$59.99</div>
                </div>
            </div>

            <!-- Add more product cards as needed -->
        </div>
    </div>
</body>
</html>
