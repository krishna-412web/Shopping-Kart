<cfif NOT (structKeyExists(session,"result") AND session.result.value EQ 1)>
	<cfif structKeyExists(form,"adminSubmit")>
		<cfset obj = createObject('component', 'Components.shoppingkart')>
		<cfset session.result = obj.accessAdmin(data = form)>
		<cfif session.result.value EQ 1>
				<cflocation url="dashboard.cfm" addToken="no">
		<cfelse>
			<cfset errorMessage="*unauthorized user">
		</cfif>
	</cfif>
<cfelse>
	<cflocation  url="dashboard.cfm" addToken="no">
</cfif>
<cfoutput>
<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
  	<head>
    		<meta charset="UTF-8">
    		<meta name="viewport" content="width=device-width, initial-scale=1.0">
    		<meta http-equiv="X-UA-Compatible" content="ie=edge">
    		<title>Shopping cart-Admin</title>
		<link href="../css/bootstrap.min.css" rel="stylesheet" >
    	<script src="../js/bootstrap.min.js"></script>
		<!---<link href="../css/styles.css" rel="stylesheet">11111--->
  	</head>
  	<body class="bg-light">
		<div class="container-fluid">
			<nav class="navbar navbar-expand-sm bg-secondary navbar-dark fixed-top">
  				<div class="container-fluid row">
  					<h1 class="navbar-brand text-center">Shopping Cart-Admin</h1>
  				</div>
			</nav>
			<div class="container-fluid d-flex flex-column flex-start justify-content-center col-xl-4 col-lg-5 col-md-6 col-sm-4 col-xs-4 mt-5">
				<div>
					<form class="login d-flex flex-column justify-content-start bg-secondary was-validated order-primary rounded p-3 m-5 gap-3" action="" method="post">
						<div class="form-floating">
							<input class="form-control" type="text" id="userName" name="userName" placeholder="Username" autofocus required/>
							<label for="userName" class="form-label">Enter Username:</label>
						</div>
						<div class="form-floating">
							<input class="form-control" type="password" id="passWord" name="passWord" pattern="^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*\W).{8,}$" placeholder="Username" required/>
							<label class="form-label" for="passWord">Enter Password:</label>
						</div>
						<input class="btn btn-primary" type="submit" name="adminSubmit" value="Login"/>
					</form>
				</div>
			</div>
		</div>
  	</body>
</html>
</cfoutput>