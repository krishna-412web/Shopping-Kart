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
							<a href="./welcome.cfm?logout=1" name="submit" class="btn btn-light btn-block">Logout</a>
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
                            <button type="button" class="btn btn-success w-25"  data-bs-toggle="modal" data-bs-target="#uploadModal">Add</button>
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
								<td><button type="button" class="btn btn-info btn-sm w-100">Edit</button></td>
                                <td><button type="button" class="btn btn-danger btn-sm w-100">Delete</button></td>
							</tr>
						</tbody>
					</table>
				</div>
                <div class="col-4">
                    <div class="card">
                        <div class="card-body p-1 row">
                            <h3 class="col-8">Subcategories</h3>
                            <button type="button" class="btn btn-success w-25" data-bs-toggle="modal" data-bs-target="#uploadModal">Add</button>
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
								<td><button type="button" class="btn btn-info btn-sm w-100">Edit</button></td>
                                <td><button type="button" class="btn btn-danger btn-sm w-100">Delete</button></td>
							</tr>
						</tbody>
					</table>
				</div>
                <div class="col-4">
                    <div class="card">
                        <div class="card-body p-1 row">
                            <h3 class="col-8">Products</h3>
                            <button type="button" class="btn btn-success w-25" data-bs-toggle="modal" data-bs-target="#myModal">Add</button>
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
								<td><button type="button" class="btn btn-info btn-sm w-100">Edit</button></td>
                                <td><button type="button" class="btn btn-danger btn-sm w-100">Delete</button></td>
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

	
	<div class="modal" id="uploadModal">
  		<div class="modal-dialog ">
    			<div class="modal-content">
      				<div class="modal-header">
        				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      				</div>
           			<div class="modal-body">
					<form action="" method="post" enctype="multipart/form-data">
						<div class="row">
							<h5 class="text-dark text-center">UPLOAD SPREADSHEET</h5>
						</div>
						<div class="row">
							<div class="col-1"></div>
							<div class="col-5">
								<a class="btn btn-info" href="excelFeature.cfm?excelData=1">Template With Data</a>
							</div>
							<div class="col-5">
								<a class="btn btn-info" href="excelFeature.cfm">Plain Template</a>
							</div>
							<div class="col-1"></div>
						</div>
						<div class="mt-1"></div>
						<input type="file" id="spreadsheet" name="spreadsheet" accept=".xls, .xlsx, .csv"/>
						<div class="mt-2"></div>
						<div class="row">
							<div class="col-5"><button type="button" class="btn btn-sm btn-primary w-100" name="close" data-bs-dismiss="modal" data-bs-target="#uploadModal">Cancel</button></div>
							<div class="col-2"></div>
							<div class="col-5"><button type="submit" class="btn btn-sm btn-danger w-100" id="uploadSubmit" name="uploadSubmit">Upload</button></div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>


	<div class="modal" id="myModal">
  		<div class="modal-dialog modal-lg">
    			<div class="modal-content">
      				<div class="modal-header">
        				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      				</div>
           			<div class="modal-body">
					<cfoutput>
        				<div id="addDiv" class="content-div">
                        	<div class="container-fluid">
							<form id="myForm1" class="needs-validation" action="" method="post" enctype="multipart/form-data">
									<h3 class="text-center border-bottom border-primary" id="heading">ADD/EDIT PRODUCTS</h3>
									<h5 class="text-decoration-underline text-primary text-start">Personal Contact</h5>
                                    <div class="form-floating">
                                        <input class="form-control" type="text" id="lastName" name="lastName" placeholder="" required>
                                        <label for="lastName" class="text-dark fw-bold form-label">lastname*</label>
                                    </div>

                                    <div class="form-floating">
                                        <input class="form-control" type="text" id="houseName" name="houseName" placeholder="" required>
                                        <label for="houseName" class="form-label text-dark fw-bold">House name</label>
                                    </div>

                                    <div class="form-floating">
                                        <input class="form-control" type="text" id="productName" name="productName" placeholder="" required>
                                        <label for="productName" class="form-label text-dark fw-bold">Product Namme</label>
                                    </div>

                                    <div class="form-floating">
                                        <input class="form-control" type="text" id="street" name="street" placeholder="" required>
                                        <label for="street" class="form-label text-dark fw-bold">Street</label>
                                    </div>

                                    <div class="form-floating">
                                        <input class="form-control" type="text" id="city" name="city" placeholder="" required>
                                        <label for="city" class="form-label text-dark fw-bold">City</label>
                                    </div>	

                                    <div class="form-floating">
                                        <input class="form-control" type="file" name="profile" id ="profile" accept="image/jpeg, image/png" required>
                                        <label for="profile" class="form-label text-decoration-underline text-primary text-start">Upload Photo</label>	
                                    </div>
									<!---<span class="text-danger">#session.errorMessage#<br></span>--->
									<button class="btn btn-primary w-100" type="submit" name="updateSubmit" id="submit1">Add Product</button>
							</form>
						</div>
                    </div>
					</cfoutput>
      				<!---<div class="modal-footer">
        				<button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      				</div>--->

    			</div>
  		</div>
	</div>
	</div>
	<!---<script src="./js/jQuery.js"></script>
	<script src="./js/modal-script.js"></script>--->
</body>
</html>
