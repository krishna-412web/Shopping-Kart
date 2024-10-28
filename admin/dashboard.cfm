<cfif NOT (structKeyExists(session,"result") AND session.result.value EQ 1)>
	<cflocation url="index.cfm" addToken="no">	
</cfif>
<cfif structKeyExists(url,"logout")>
	<cfset structClear(session)>
	<cflocation url="index.cfm" addToken="no">
</cfif>
<cfset obj = createObject('component', 'Components.shoppingkart')>
<cfif structKeyExists(form,"categorySubmit")>
	<cfset message = obj.updateCategory(
										categoryName = form.categoryName,
										categoryid = form.categoryId
										)>
<cfelseif structKeyExists(form,"subCategorySubmit")>
	<cfset message = obj.updateSubCategory(data = form)>
<cfelseif structKeyExists(form,"productSubmit")>
	<cfif structKeyExists(form,"productpicture") AND len(trim(form.productpicture)) GT 0>
			<cfset uploadDir = expandPath('./images/')>        
			<cfif not directoryExists(uploadDir)>
      			<cfdirectory action="create" directory="#uploadDir#">
			</cfif>
			<cffile action="upload"
        			filefield="productpicture"
        			destination="#uploadDir#"
        			nameConflict="makeunique">
			<cfset uploadedFileName = cffile.serverFile>
			<cfset imgPath="./images/#uploadedFileName#">
	<cfelseif structKeyExists(form,"productid")>
			<cfset imgPath="">
	</cfif>
	<cfset productid = structKeyExists(form, "productid")? form.productid: 0>
	<cfset message = obj.updateProduct( subcategoryid = form.productsubcategory,
											productname   = form.productname,
											productdesc = form.productdesc,
											productimage = imgPath,
											price = form.price,
											productid = productid)>
</cfif>
<cfset categories = obj.listCategory()>
<cfdump var="#form#">
<!DOCTYPE html>
<html lang="en">
<head>
  	<title>Admin-Dashboard</title>
  	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
 	<link href="../css/bootstrap.min.css" rel="stylesheet">
  	<script src="../js/bootstrap.bundle.min.js"></script>
  	<script src="../js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="../css/print.css" media="print">
</head>
<body>
	<div class="container-fluid p-0">
		<div class="container-fluid p-0 no-print">
			<nav class="navbar navbar-expand-sm bg-primary navbar-dark container-fluid ">
  				<div class="container-fluid row">
  						<h1 class="navbar-brand text-center col-10 m-0">Shopping Kart-Admin Dashboard</h1>
						<form class="col-1" action="" method="POST">
							<a href="./dashboard.cfm?logout=1" name="submit" class="btn btn-light btn-bloc  k">Logout</a>
						</form>
  				</div>
			</nav>
		</div>
		<div class="container-fluid mt-1">
			<div class="row">
				<div class="col-4">
                    <div class="card">
                        <div class="card-body p-1 row">
                            <h3 class="col-8">Categories</h3>
                            <button type="button" class="btn btn-success w-25 add"  data-bs-toggle="modal" data-bs-target="#CategoryModal">Add</button>
                        </div>
                    </div>
					<table class="table table-bordered table-sm" id="categoryList">	
						<thead>
							<th>#</th>
							<th>Name</th>
							<th>Edit</th>
                            <th>Delete</th>
						</thead>
						<tbody  id="categoryDisplay">
							<tr>
								<td>1</td>
								<td>Anand Vishnu</td>
								<td><button type="button" class="btn btn-info btn-sm w-100 edit" data-bs-toggle="modal" data-bs-target="#CategoryModal">Edit</button></td>
                                <td><button type="button" class="btn btn-danger btn-sm w-100 delete">Delete</button></td>
							</tr>
						</tbody>
					</table>
				</div>
                <div class="col-4">
                    <div class="card">
                        <div class="card-body p-1 row">
                            <h3 class="col-8">Subcategories</h3>
                            <button type="button" class="btn btn-success w-25 add" data-bs-toggle="modal" data-bs-target="#subCategoryModal">Add</button>
                        </div>
                    </div>
					<table class="table table-bordered table-sm" id="subCategoryList">	
						<thead>
							<th>#</th>
							<th>Name</th>
							<th>Edit</th>
                            <th>Delete</th>
						</thead>
						<tbody  id="subCategoryDisplay">
							<tr>
								<td>1</td>
								<td>Anand Vishnu</td>
								<td><button type="button" class="btn btn-info btn-sm w-100 edit">Edit</button></td>
                                <td><button type="button" class="btn btn-danger btn-sm w-100 delete">Delete</button></td>
							</tr>
						</tbody>
					</table>
				</div>
                <div class="col-4">
                    <div class="card">
                        <div class="card-body p-1 row">
                            <h3 class="col-8">Products</h3>
                            <button type="button" class="btn btn-success w-25 add" data-bs-toggle="modal" data-bs-target="#productModal">Add</button>
                        </div>
                    </div>
					<table class="table table-bordered table-sm" id="productList">	
						<thead>
							<th>#</th>
							<th>Name</th>
							<th>Edit</th>
                            <th>Delete</th>
						</thead>
						<tbody  id="productDisplay">
							<tr>
								<td>1</td>
								<td>Anand Vishnu</td>
								<td><button type="button" class="btn btn-info btn-sm w-100 edit">Edit</button></td>
                                <td><button type="button" class="btn btn-danger btn-sm w-100 delete">Delete</button></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		<div>
	</div>

	<div class="modal" id="delModal">
  		<div class="modal-dialog ">
    			<div class="modal-content">
      				<div class="modal-header">
        				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      				</div>
           			<div class="modal-body">
					<form action="" method="post">
						<div class="row">
							<h5 class="text-dark">Do you wish to delete the contact?</h5>
						</div>
						<input type="hidden" id="delInp" name="logId" />
						<div class="row">
							<div class="col-4"><button type="submit" class="btn btn-sm btn-danger w-100" name="deleteSubmit">Yes</button></div>
							<div class="col-4"></div>
							<div class="col-4"><button type="button" class="btn btn-sm btn-primary w-100" name="close" data-bs-dismiss="modal" data-bs-target="#delModal">No</button></div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>


	<div class="modal" id="CategoryModal">
  		<div class="modal-dialog modal-md">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<div id="addCategory" class="content-div">
						<div class="container-fluid">
							<form id="CategoryForm" class="needs-validation" action="" method="post" enctype="multipart/form-data">
									<h3 class="text-center border-bottom border-primary" id="categoryHeading">ADD/EDIT CATEGORY</h3>
									<h5 class="text-decoration-underline text-primary text-start">Category Details</h5>
									<div class="form-floating mt-1">
										<input class="form-control" type="text" id="categoryName" name="categoryName" placeholder="" required>
										<label for="categoryName" class="form-label text-dark fw-bold">Category Name</label>
									</div>
									<!---<span class="text-danger">#session.errorMessage#<br></span>--->
									<button class="btn btn-primary mt-1 w-100" type="submit" name="categorySubmit" id="categorySubmit">Add Category</button>
							</form>
						</div>
					</div>
				</div>
			</div>
  		</div>
	</div>

	<div class="modal" id="subCategoryModal">
  		<div class="modal-dialog modal-md">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<div id="addSubCategory" class="content-div">
						<div class="container-fluid">
							<form id="subCategoryForm" class="needs-validation" action="" method="post" enctype="multipart/form-data">
									<h3 class="text-center border-bottom border-primary" id="subCategoryHeading">ADD/EDIT SUBCATEGORY</h3>
									<h5 class="text-decoration-underline text-primary text-start">Subcategory Details</h5>
									<div class="form-floating">
										<select id="categorySelect" name="categorySelect" class="form-select" placeholder="" required>
												<option value="" selected></option>
												<cfoutput>
													<cfloop array="#categories.RESULTSET#" index="row">
														<option value="#row.categoryid#">#row.categoryname#</option>
													</cfloop>
												</cfoutput>
										</select>
										<label for="categorySelect" class="text-dark fw-bold form-label">Category</label>
									</div>
									<div class="form-floating mt-1">
										<input class="form-control" type="text" id="subCategoryName" name="subCategoryName" placeholder="" required>
										<label for="subCategoryName" class="form-label text-dark fw-bold">Subcategory Name</label>
									</div>
									<!---<span class="text-danger">#session.errorMessage#<br></span>--->
									<button class="btn btn-primary mt-1 w-100" type="submit" name="subcategorySubmit" id="subcategorySubmit">Add Subcategory</button>
							</form>
						</div>
					</div>
				</div>
			</div>
  		</div>
	</div>

	<div class="modal" id="productModal">
  		<div class="modal-dialog modal-md">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<div id="addDiv" class="content-div">
						<div class="container-fluid">
							<form id="productForm" class="needs-validation" action="" method="post" enctype="multipart/form-data">
									<h3 class="text-center border-bottom border-primary" id="productHeading">ADD/EDIT PRODUCTS</h3>
									<h5 class="text-decoration-underline text-primary text-start mt-1">Product Details</h5>
									<div class="form-floating mt-1">
										<select id="productCategory" name="productCategory" class="form-select" placeholder="" required>
												<option value="" selected></option>
												<cfoutput>
													<cfloop array="#categories.RESULTSET#" index="row">
														<option value="#row.categoryid#">#row.categoryname#</option>
													</cfloop>
												</cfoutput>
										</select>
										<label for="productCategory" class="text-dark fw-bold form-label">Category</label>
									</div>

									<div class="form-floating mt-1">
										<select id="productSubCategory" name="productSubCategory" class="form-select" placeholder="" required>
													<option value="" selected></option>
													<option value="1">Mobile Phones</option>
										</select>
										<label for="productCategory" class="text-dark fw-bold form-label">Subcategory</label>
									</div>

									<div class="form-floating mt-1">
										<input class="form-control" type="text" id="productName" name="productName" placeholder="" required>
										<label for="productName" class="form-label text-dark fw-bold">Product Name</label>
									</div>

									<div class="form-floating mt-1">
										<input class="form-control" type="text" id="productDesc" name="productDesc" placeholder="" required>
										<label for="productDesc" class="form-label text-dark fw-bold">Product Description</label>
									</div>

									<div class="form-floating mt-1">
										<input class="form-control" type="text" id="price" name="price" placeholder="" required>
										<label for="price" class="form-label text-dark fw-bold">Price</label>
									</div>	

									<div class="form-floating mt-1">
										<input class="form-control" type="file" name="productPicture" id ="productPicture" accept="image/jpeg, image/png" required>
										<label for="productPicture" class="form-label text-decoration-underline text-primary text-start">Product Picture</label>	
									</div>
									<!---<span class="text-danger">#session.errorMessage#<br></span>--->
									<button class="btn btn-primary w-100 mt-1" type="submit" name="productSubmit" id="productSubmit">Add Product</button>
							</form>
						</div>
					</div>
				</div>
			</div>
  		</div>
	</div>

	<script src="../js/jQuery.js"></script>
	<script src="../js/admin-dashboard.js"></script>
</body>
</html>
