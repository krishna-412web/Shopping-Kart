<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Shopping Cart Home Page</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    /* Additional custom styles */
    .navbar-main {
      background-color: #5a67d8;
    }

    .navbar-main .navbar-text, .navbar-main .nav-link {
      color: white;
    }

    .category-menu {
      background-color: #718096;
    }

    .category-menu a {
      color: white;
      font-size: 14px;
    }

    .banner {
      background: url('https://via.placeholder.com/1600x400/007bff/fff?text=Shopping+Kart') no-repeat center center;
      background-size: cover;
      height: 200px;
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 36px;
      font-weight: bold;
    }

    .product-item {
      background-color: #f7fafc;
      width: 150px;
      height: 150px;
      display: flex;
      align-items: center;
      justify-content: center;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      color: #4a5568;
      font-size: 18px;
    }
  </style>
</head>
<body>

  <!-- Main Navigation Bar -->
  <nav class="navbar navbar-expand-lg navbar-main">
    <div class="container">
      <!-- Brand text in the center -->
      <span class="navbar-text mx-auto">SHOPPING CART-HOME PAGE</span>
      
      <!-- Navigation links -->
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link" href="#">Search</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Menu</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Cart</a>
        </li>
      </ul>
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link" href="#">Login</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Signup</a>
        </li>
      </ul>
    </div>
  </nav>

  <!-- Category Menu -->
  <div class="category-menu py-2">
    <div class="container d-flex justify-content-between">
      <a href="#" class="text-white">category1</a>
      <a href="#" class="text-white">category2</a>
      <a href="#" class="text-white">category3</a>
      <a href="#" class="text-white">category4</a>
      <a href="#" class="text-white">category5</a>
      <a href="#" class="text-white">category6</a>
      <a href="#" class="text-white">category7</a>
    </div>
  </div>

  <!-- Banner Section -->
  <div class="banner">
    <div class="container text-center">
    </div>
  </div>

  <!-- Products Section -->
  <section class="py-5">
    <div class="container text-center">
      <h2 class="mb-4">Our Products</h2>
      <div class="row g-4">
        <div class="col-md-4 d-flex justify-content-center">
          <div class="product-item">Item 1</div>
        </div>
        <div class="col-md-4 d-flex justify-content-center">
          <div class="product-item">Item 2</div>
        </div>
        <div class="col-md-4 d-flex justify-content-center">
          <div class="product-item">Item 3</div>
        </div>
      </div>
    </div>
  </section>

  <!-- Bootstrap JS Bundle -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
