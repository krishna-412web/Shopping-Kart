<cftry>
  <cfset obj = createObject('component', 'Components.shoppingkart')>
<cfcatch type="exception">
</cfcatch>
</cftry>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Shopping Cart Home Page</title>
  <!-- Bootstrap CSS -->
  <link href="../css/bootstrap.min.css" rel="stylesheet">
  <style>
    /* Additional custom styles */
    .navbar-main {
      background-color: #5a67d8;
    }

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
    .navbar-main .navbar-text, .navbar-main .nav-link {
      color: white;
    }

    .banner {
      background: url('../images/banner.png') no-repeat center center;
      background-size: cover;
      height: 200px;
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 36px;
      font-weight: bold;
    }

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

  </style>
</head>
<body>

  <!-- Main Navigation Bar -->
  <nav class="navbar navbar-expand-lg navbar-main">
    <div class="container">
          <a class="nav-item" href="homepage.cfm?search=true">Search</a>
          <a class="nav-item dropdown-toggle" href="" role="button" data-bs-toggle="dropdown">
              Menu
          </a>
          <ul class="dropdown-menu">
            <cfset categories = obj.listCategory()>
            <cfloop array="#categories.RESULTSET#" item="item">
                <cfoutput>
                    <li>
                        <a id="#item.categoryid#" class="dropdown-item text-dark" href="homepage.cfm?cat=#item.categoryid#">#item.categoryname#</a>
                    </li>
                </cfoutput>
            </cfloop>
          </ul>
          <a class="nav-item" href="homepage.cfm">SHOPPING CART - HOME PAGE</a>
          <a class="nav-item" href="cart.cfm">Cart</a>
          <cfif structKeyExists(session,"user") AND session.user.value EQ 1>
            <a class="nav-item" href="userpage.cfm"><cfoutput>#session.user.username#</cfoutput></a>
          <cfelse>
            <a class="nav-item" href="userlogin.cfm">Login/Signup</a>
          </cfif>
    </div>
  </nav>

 <section>
    <cfif structKeyExists(url,"orderid")>
        <div class="d-flex justify-content-center align-items-center vh-100" style="background-color: #f0f8ff;">
            <div class="text-center p-3 shadow rounded" style="background-color: white; max-width: 400px;">
                <!-- Success Icon -->
                <div class="mb-3">
                    <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="currentColor" class="text-success bi bi-check-circle" viewBox="0 0 16 16">
                        <path d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm3.97-8.03a.75.75 0 0 1 0 1.06l-4 4a.75.75 0 0 1-1.06 0l-2-2a.75.75 0 0 1 1.06-1.06L7.5 10.94l3.47-3.47a.75.75 0 0 1 1.06 0z"/>
                    </svg>
                </div>
                <!-- Success Message -->
                <h3 class="text-success">Payment Successful!</h3>
                <p>Your order has been placed successfully.</p>
                <!-- Buttons -->
                <div class="d-flex justify-content-center gap-2">
                    <a href="homepage.cfm" class="btn btn-outline-primary btn-sm">Go to Homepage</a>
                    <cfoutput>
                        <a href="orderitems.cfm?orderid=#url.orderid#" class="btn btn-outline-success btn-sm">
                            Order Details
                        </a>
                    </cfoutput>
                </div>
            </div>
        </div>
    <cfelse>
        <div class="d-flex justify-content-center align-items-center vh-100" style="background-color: #fff5f5;">
            <div class="text-center p-4 shadow rounded" style="background-color: white; max-width: 400px;">
                <!-- Failure Icon -->
                <div class="mb-3">
                    <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="currentColor" class="text-danger bi bi-x-circle" viewBox="0 0 16 16">
                        <path d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zM4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
                    </svg>
                </div>
                <!-- Failure Message -->
                <h3 class="text-danger">Payment Failed</h3>
                <p>Unfortunately, we couldn't process your payment.</p>
                <!-- Buttons with btn-link styling -->
                <div class="d-flex justify-content-center gap-2">
                    <a href="homepage.cfm" class="btn btn-outline-primary">Go to Homepage</a>
                </div>
            </div>
        </div>
    </cfif>

  </section>


  <!-- Bootstrap JS Bundle -->
  <script src="../js/jQuery.js"></script>
  <script src="../js/search.js"></script>
  <script src="../js/bootstrap.bundle.min.js"></script>
</body>
</html>
