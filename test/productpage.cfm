<cftry>
  <cfset obj = createObject('component', 'Components.shoppingkart')>
  <cfif structKeyExists(url, "pro") AND structKeyExists(url, "add") AND url.add EQ 1
    AND structKeyExists(session,"user") AND session.user.value EQ 1>
    <!---update cart --->
    <cfset productid = structKeyExists(url,"pro")? Val(obj.decryptData(url.pro)) : 0>
    <cfset obj.insertCart(productid = productid)>
    <cflocation url="productpage.cfm?pro=#url.pro#" addToken="no">
  </cfif>
<cfcatch type="exception">
  <cfdump var="#cfcatch#">
</cfcatch>
</cftry>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Shopping Cart- Product Page</title>
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
                        <a id="#item.categoryid#" class="dropdown-item text-dark" href="#cgi.HTTP_URL#&cat=#item.categoryid#">#item.categoryname#</a>
                    </li>
                </cfoutput>
            </cfloop>
          </ul>
          <a class="nav-item" href="homepage.cfm">SHOPPING CART</a>
          <a class="nav-item" href="cart.cfm">Cart</a>
          <a class="nav-item" href="userlogin.cfm">Login/Signup</a>
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
        <cftry>
          <cfif structKeyExists(url,"pro")>
            <cfset variables.products = obj.listProducts(productid = url.pro)>
            <cfset variables.images = obj.getimages(productid = url.pro)>
          </cfif>
        <cfcatch type="any">
          <div class="content-container">
              <div class="cart-message-box">
                  <!-- Message Title -->
                  <div class="cart-message-title">Oops,something went wrong</div>
                  
                  <!-- Message Text -->
                  <p>product details are unavailable or corrupted</p>
                  
                  <!-- Login Button -->
                  <a class="btn btn-outline-primary" href="homepage.cfm">Browse</a>
              </div>
       		</div>
        </cfcatch>
        </cftry>
        <cfif structKeyExists(variables,"products")>
          <h1>PRODUCT</h1>
          <cfoutput>
            <nav aria-label="breadcrumb">
              <ol class="breadcrumb ms-2">
                <li class="breadcrumb-item"><a href="homepage.cfm?cat=#variables.products.RESULTSET[1].categoryid#">#variables.products.RESULTSET[1].categoryname#</a></li>
                <li class="breadcrumb-item"><a href="homepage.cfm?cat=#variables.products.RESULTSET[1].categoryid#&sub=#variables.products.RESULTSET[1].subcategoryid#">#variables.products.RESULTSET[1].subcategoryname#</a></li>
                <li class="breadcrumb-item active" aria-current="page">#variables.products.RESULTSET[1].productname#</li>
              </ol>
            </nav>
          </cfoutput>
  
          <div class="product-grid">
              <cfloop array="#variables.products.RESULTSET#" index="item">
                <cfoutput>
                  <div class="container mt-3">
                      <div class="row">
                          <!-- Product Image Section -->
                          <div class="col-md-6">
                              <div class="container d-flex flex-row justify-content-center align-items-center">
                                <div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
                                    <!-- Carousel Items -->
                                    <div class="carousel-inner" style="height:300px;width:300px;">
                                        <div class="carousel-item active">
                                            <img src="../admin/images/#ListLast(item.productimage,"/")#" alt="First Slide" class="d-block w-100" style="width:180px;height:300px;">
                                        </div>
                                        <cfif NOT structKeyExists(variables.images,"value")>
                                          <cfloop array="#variables.images.imagelist#" index="imageitem">
                                            <div class="carousel-item">
                                                <img src="../admin/images/#imageitem#" alt="next slide" class="d-block w-100" style="width:180px;height:300px;">
                                            </div>
                                          </cfloop>
                                        </cfif>
                                    </div>

                                    <!-- Controls -->
                                    <button class="carousel-control-prev" type="button" data-bs-target="##carouselExample" data-bs-slide="prev">
                                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Previous</span>
                                    </button>
                                    <button class="carousel-control-next" type="button" data-bs-target="##carouselExample" data-bs-slide="next">
                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Next</span>
                                    </button>
                                </div>
                              </div>
                          </div>
                          
                          <!-- Product Information Section -->
                          <div class="col-md-6">
                              <!-- Product Name -->
                              <h1 class="display-5 font-weight-bold text-primary">#item.productname#</h1>
                              
                              <!-- Product Price -->
                              <h3 class="text-success font-weight-bold">#item.price#</h3>
                              
                              <!-- Product Description -->
                              <p class="text-muted mt-3">
                                  #item.productdesc#
                              </p>
                              
                              <!-- Call-to-Action Button -->
                              <a href="" class="btn btn-primary btn-lg mt-4" id="addCart">Add to Cart</a>
                              <a href="paymentpage.cfm?pro=#item.productid#" class="btn btn-info btn-lg mt-4" id="buyNow">Buy now</a>
                          </div>
                      </div>
                  </div>
                </cfoutput>
              </cfloop>
          </div>
        </cfif>
      </div>

  </section>


  <!-- Bootstrap JS Bundle -->
  <script src="../js/jQuery.js"></script>
  <script src="../js/cart.js"></script>
  <script src="../js/bootstrap.bundle.min.js"></script>
</body>
</html>
