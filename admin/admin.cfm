<cfif NOT (structKeyExists(session,"result") AND session.result.value EQ 1)>
	<cflocation url="index.cfm" addToken="no">	
</cfif>
<cfif structKeyExists(url,"logout")>
	<cfset structClear(session)>
	<cflocation url="index.cfm" addToken="no">
</cfif>
<cfset obj = createObject('component', 'Components.shoppingkart')>

<cfif structKeyExists(form, "deleteSubmit")>
	<cfset obj.deleteItems(
						deleteid = form.deleteid,
						section = form.section
						)>
</cfif>

<cfif structKeyExists(form,"categorySubmit")>
	<cfset categoryid = structKeyExists(form, "categoryId")? form.categoryId: 0>
	<cfset message = obj.updateCategory(
										categoryName = form.categoryName,
										categoryid = categoryId
										)>
<cfelseif structKeyExists(form,"subCategorySubmit")>
	<cfset subcategoryid = structKeyExists(form, "subCategoryId")? form.subCategoryId: 0>
	<cfset message = obj.updateSubCategory(	categorySelect = form.categorySelect,
											subCategoryName = form.subCategoryName,
											subcategoryid = subcategoryid)>
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