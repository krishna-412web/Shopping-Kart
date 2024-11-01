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

  <!-- Main Navigation Bar -->
  <nav class="navbar navbar-expand-lg navbar-main">
    <div class="container">
          <a class="nav-item" href="#">Search</a>
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
          <a class="nav-item" href="homepage.cfm">SHOPPING CART - PRODUCT PAGE</a>
          <a class="nav-item" href="#">Cart</a>
          <a class="nav-item" href="#">Login/Signup</a>
    </div>
  </nav>

  <!-- Category Menu -->
  <cfif structKeyExists(url,"cat") OR structKeyExists(url,"sub")>
    <cfset subcategories = obj.listSubCategory(categoryid = url.cat)>
    <div class="category-menu">
      <div class="container d-flex justify-content-between">
        <cfloop array="#subcategories.RESULTSET#" index="item">
          <cfoutput><a id="#item.subcategoryid#" class="dropdown-item text-white" href='homepage.cfm?cat=#item.categoryid#&sub=#item.subcategoryid#'>#item.subcategoryname#</a></cfoutput>
        </cfloop>
      </div>
    </div>
  </cfif>

  <section>

    <div class="product-section">
        <h1>PRODUCT</h1>
        <div class="product-grid">
        <cfif structKeyExists(url,"sub")>
            <cfset products = obj.listProducts(subcategoryid = url.sub)>
              <cfloop array="#products.RESULTSET#" index="item">
                <cfoutput>
                    <a href="homepage.cfm?pro=#item.productid#">
                      <div class="product-card">
                        <img class="img-fluid" src="../admin/images/#ListLast(item.productimage,"/")#" alt="Product Image">
                        <div class="product-info">
                            <div class="product-name">#item.productname#</div>
                            <div class="product-price">#item.price#</div>
                        </div>
                      </div>
                    </a>
                </cfoutput>
              </cfloop>
          </cfif>
        </div>

  </section>


  <!-- Bootstrap JS Bundle -->
  <script src="../js/bootstrap.bundle.min.js"></script>
</body>
</html>
