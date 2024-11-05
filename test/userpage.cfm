<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart Product Page</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/userpage.css">
</head>
<body>
    <!-- Navigation Bar -->
  <nav class="navbar navbar-expand-lg navbar-main">
    <div class="container">
          <a class="nav-item" href="homepage.cfm?search=true">Search</a>
          <a class="nav-item dropdown-toggle" href="" role="button" data-bs-toggle="dropdown">
              Menu
          </a>
          <a class="nav-item" href="homepage.cfm">SHOPPING CART - HOME PAGE</a>
          <a class="nav-item" href="cart.cfm">Cart</a>
          <cfif structKeyExists(session,"user") AND session.user.value EQ 1>
            <a class="nav-item" href="userpage.cfm"><cfoutput>#session.user.username#</cfoutput></a>
          <cfelse>
            <a class="nav-item" href="userlogin.cfm">Login/Signup</a>
          </cfif>
    </div>
  </nav>

    <!-- Main Content -->
    <div class="container d-flex flex-column align-items-center mt-5">
        <div class="card p-4" style="max-width: 400px; background-color: #f9fafb; border-radius: 10px;">
            <h2 class="text-center">KRISHNA RENJITH</h2>
            
            <!-- Profile Picture Section -->
            <div class="profile mt-4 text-center">
                <img src="../images/profile.jpg" alt="Profile Picture" class="img-fluid" style="max-width: 200px;">
            </div>

            <!-- Selected Address Section -->
            <div class="text-center mt-4">
                <p class="fw-bold">SELECTED ADDRESS</p>
                <button class="btn btn-primary" style="background-color: #5c83f6;">SELECT</button>
            </div>

            <!-- Order Details Button -->
            <button class="btn mt-3" style="background-color: #f6555c; color: white;">ORDER DETAILS</button>
        </div>
    </div>

    <!-- Bootstrap JS (for components that require JavaScript) -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>