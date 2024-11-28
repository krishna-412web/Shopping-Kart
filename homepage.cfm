
<cfset obj = createObject('component', 'Components.shoppingkart')>
<!--- <cfdump var="#session.user#"> --->
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Shopping Cart Home Page</title>
  <!-- Bootstrap CSS -->
  <link href="/css/bootstrap.min.css" rel="stylesheet">
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
  <cftry>
    <nav class="navbar navbar-expand-lg navbar-main">
      <div class="container">
            <a class="nav-item" href="/homepage.cfm?search=true">Search</a>
            <a class="nav-item dropdown-toggle" href="/" role="button" data-bs-toggle="dropdown">
                Menu
            </a>
            <ul class="dropdown-menu">
              <cfset categories = obj.listCategory()>
              <cfloop array="#categories.RESULTSET#" item="item">
                  <cfoutput>
                      <li>
                          <a id="#item.categoryid#" class="dropdown-item text-dark" href="/homepage.cfm?cat=#item.categoryid#">#item.categoryname#</a>
                      </li>
                  </cfoutput>
              </cfloop>
            </ul>
            <a class="nav-item" href="/homepage.cfm">SHOPPING CART - HOME PAGE</a>
            <a class="nav-item" href="/cart">Cart</a>
            <cfif structKeyExists(session,"user") AND session.user.value EQ 1>
              <a class="nav-item" href="/userpage.cfm"><cfoutput>#session.user.username#</cfoutput></a>
            <cfelse>
              <a class="nav-item" href="/userlogin.cfm">Login/Signup</a>
            </cfif>
      </div>
    </nav>

    <cfif structKeyExists(url, "search")>
      <nav class="navbar">
        <div class="container-fluid row">
          <div class="d-flex flex-row justify-content-between align-items-center">
              <div class="d-flex justify-content-center w-100">
                <input class="form-control me-2 search-input" name="searchString" id="searchString" type="search" placeholder="Search for products" aria-label="Search">
                <button class="btn btn-outline-light" id="searchSubmit" name="searchSubmit" type="submit">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                        <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.415l-3.85-3.85a1.007 1.007 0 0 0-.115-.098zm-5.525-9.39a5.5 5.5 0 1 1 0 11 5.5 5.5 0 0 1 0-11z"/>
                    </svg>
                </button>
              </div>
          </div>
        </div>
      </nav>
    </cfif>

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

    <!-- Banner Section -->
    <div class="banner">
      <div class="container text-center">
      </div>
    </div>

    <section>
      <!---<cfdump var="#cgi#">
      <cfset last=ListLast(cgi.HTTP_URL,"?")>
      <cfset key = ListGetAt(last, 1, "=")>
      <cfset value = ListGetAt(last, 2, "=")>
      <cfdump var="#URL#">--->
      <cfset variables.url = cgi.HTTP_URL>
      <!--- Remove both 'order' and 'price' parameters from the URL --->
      <cfset variables.url = REReplace(variables.url, "[&?](order|price|range|min|max)=[^&]*", "", "all")>
      <!--- Check if there is already a query string, to append with '&' or start with '?' --->
      <cfset variables.url = variables.url & (find('?', variables.url) ? '&' : '?')>

      <div class="sort-links d-flex justify-content-start my-2">
        <cfoutput>
          <cfif structKeyExists(url,"cat") OR structKeyExists(url,"sub")>
            <a href="/#variables.url#order=desc" class="btn btn-outline-primary me-2">Price: High to Low</a>
            <a href="/#variables.url#order=asc" class="btn btn-outline-primary me-2">Price: Low to High</a>
            <div class="dropdown">
              <button class="btn btn-outline-primary dropdown-toggle" type="button" data-bs-toggle="dropdown">
              Filter
              </button>
              <ul class="dropdown-menu w-75">
                <div class="d-flex flex-column align-items-center">
                  <li><a href="/#variables.url#price=above" class="btn btn-sm btn-primary">Price above 20,000</a></li>
                  <li class="mt-1"><a href="/#variables.url#price=below" class="btn btn-sm btn-primary">Price below 20,000</a></li>
                  <li>
                    <form id="filterForm" class="mt-1" action="" method="POST">
                        <div class="g-1 d-flex flex-column justify-content-center align-items-center">
                          <div>
                            <input type="number" class="form-control" id="min" name="min" placeholder="MIN">
                          </div>
                          <div>
                            <label for="max" class="form-label mb-0 text-primary">AND</label>
                          </div>
                          <div>
                            <input type="number" class="form-control" id="max" name="max" placeholder="MAX">
                          </div>
                          <button type="submit" name="rangesubmit" class="btn btn-primary btn-sm mt-1">Apply</button>
                        </div>
                    </form>
                  </li>
                </div>
              </ul>
            </div>
          </cfif>
        </cfoutput>
      </div>
          </div>
          <div class="product-section">
              <h1>Products</h1>
              <div class="product-grid">
              <cfif structKeyExists(url,"sub")>
                  <cfif structKeyExists(url,"range") AND (structKeyExists(url,"max") OR structKeyExists(url,"min"))>
                    <cfif structKeyExists(url,"max") AND 
                          structKeyExists(url,"min") AND 
                          url.max GT 0 AND 
                          url.min GT 0 AND 
                          url.max GT url.min>
                      <cfset products = obj.listProducts(subcategoryid = url.sub,
                                                        max = url.max,
                                                        min = url.min)>
                    <cfelseif structKeyExists(url,"min") AND url.min GT 0>
                      <cfset products = obj.listProducts(subcategoryid = url.sub,
                                                        min = url.min)>
                    <cfelseif structKeyExists(url,"max") AND url.max GT 0>
                      <cfset products = obj.listProducts(subcategoryid = url.sub,
                                                        max = url.max)>
                    <cfelse>
                       <cfset products = obj.listProducts(subcategoryid = url.sub)>                     
                    </cfif>
                  <cfelseif structKeyExists(url, 'order') AND structKeyExists(url, 'price')>
                    <cfset products = obj.listProducts(subcategoryid = url.sub,order = url.order,price = url.price)>
                  <cfelseif structKeyExists(url, 'order')>
                    <cfset products = obj.listProducts(subcategoryid = url.sub,order = url.order)>
                  <cfelseif structKeyExists(url, 'price')>
                    <cfset products = obj.listProducts(subcategoryid = url.sub,price = url.price)>
                  <cfelse>
                    <cfset products = obj.listProducts(subcategoryid = url.sub)>
                  </cfif>
                    <cfloop array="#products.RESULTSET#" index="item">
                      <cfoutput>
                          <a href="/product/#item.productid#">
                            <div class="product-card h-100" >
                              <img class="img-fluid" style="height: 135px;width:150px;" src="../admin/images/#ListLast(item.productimage,"/")#" alt="Product Image">
                              <div class="product-info">
                                  <div class="product-name">#item.productname#</div>
                                  <div class="product-price">#item.price#</div>
                              </div>
                            </div>
                          </a>
                      </cfoutput>
                    </cfloop>
                <cfelseif structKeyExists(url,"cat")>
                  <cfif structKeyExists(url,"range") AND (structKeyExists(url,"max") OR structKeyExists(url,"min"))>
                    <cfif structKeyExists(url,"max") AND 
                          structKeyExists(url,"min") AND 
                          url.max GT 0 AND 
                          url.min GT 0 AND 
                          url.max GT url.min>
                      <cfset products = obj.listProducts(categoryid = url.cat,
                                                        max = url.max,
                                                        min = url.min)>
                    <cfelseif structKeyExists(url,"min") AND url.min GT 0>
                      <cfset products = obj.listProducts(categoryid = url.cat,
                                                        min = url.min)>
                    <cfelseif structKeyExists(url,"max") AND url.max GT 0>
                      <cfset products = obj.listProducts(categoryid = url.cat,
                                                        max = url.max)>
                    <cfelse>
                       <cfset products = obj.listProducts(categoryid = url.cat)>                     
                    </cfif>
                  <cfelseif structKeyExists(url, 'order') AND structKeyExists(url, 'price')>
                    <cfset products = obj.listProducts(categoryid = url.cat,order = url.order,price = url.price)>
                  <cfelseif structKeyExists(url, 'order')>
                    <cfset products = obj.listProducts(categoryid = url.cat,order = url.order)>
                  <cfelseif structKeyExists(url, 'price')>
                    <cfset products = obj.listProducts(categoryid = url.cat,price = url.price)>
                  <cfelse>
                    <cfset products = obj.listProducts(categoryid = url.cat)>
                  </cfif>
                    <cfloop array="#products.RESULTSET#" index="item">
                      <cfoutput>
                          <a href="/product/#item.productid#">
                            <div class="product-card h-100">
                              <img class="img-fluid" style="height: 135px;width:150px;" src="../admin/images/#ListLast(item.productimage,"/")#" alt="Product Image">
                              <div class="product-info">
                                  <div class="product-name">#item.productname#</div>
                                  <div class="product-price">#item.price#</div>
                              </div>
                            </div>
                          </a>
                      </cfoutput>
                    </cfloop>
                <cfelseif structKeyExists(url, "search") AND 
                          structKeyExists(url, "string") AND 
                          len(trim(url.string)) GT 0>
                  <cfif structKeyExists(url, 'order') AND structKeyExists(url, 'price')>
                    <cfset products1 = obj.listProducts(search = url.string,order = url.order,price = url.price)>
                  <cfelseif structKeyExists(url, 'order')>
                    <cfset products1 = obj.listProducts(search = url.string,order = url.order)>
                  <cfelseif structKeyExists(url, 'price')>
                    <cfset products1 = obj.listProducts(search = url.string,price = url.price)>
                  <cfelse>
                    <cfset products1 = obj.listProducts(search = url.string)>
                  </cfif>
                    <cfloop array="#products1.RESULTSET#" index="item">
                      <cfoutput>
                          <a href="/product/#item.productid#">
                            <div class="product-card h-100">
                              <img class="img-fluid" style="height: 135px;width:150px;" src="../admin/images/#ListLast(item.productimage,"/")#" alt="Product Image">
                              <div class="product-info">
                                  <div class="product-name">#item.productname#</div>
                                  <div class="product-price">#item.price#</div>
                              </div>
                            </div>
                          </a>
                      </cfoutput>
                    </cfloop>
                <cfelse>
                  <cfset products = obj.listProducts(limit = 5)>
                    <cfloop array="#products.RESULTSET#" index="item">
                      <cfoutput>
                          <a href="/product/#item.productid#">
                            <div class="product-card h-100">
                              <img class="img-fluid" style="height: 135px;width:150px;" src="/admin/images/#ListLast(item.productimage,"/")#" alt="Product Image">
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
  <cfcatch type="any">
    <div class="alert alert-danger alert-dismissible fade show text-center mt-5 z-3 fw-bold">
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        Unexpected Error
    </div>
  </cfcatch>
  </cftry>
  <!-- Main Navigation Bar -->
  


  <!-- Bootstrap JS Bundle -->
  <script src="/js/jQuery.js"></script>
  <script src="/js/search.js"></script>
  <script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>
