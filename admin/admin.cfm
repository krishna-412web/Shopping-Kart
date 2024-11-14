<cfif NOT (structKeyExists(session,"result") AND session.result.value EQ 1)>
	<cflocation url="index.cfm" addToken="no">	
</cfif>
<cfif structKeyExists(url,"logout")>
	<cfset structClear(session)>
	<cflocation url="index.cfm" addToken="no">
</cfif>
<cfset obj = createObject('component', 'Components.shoppingkart')>

<cftry>
	<cfif structKeyExists(form, "deleteSubmit")>
		<cfset deleteid = Val(obj.decryptData(form.deleteid))>
		<cfset variables.result = obj.deleteItems(
							deleteid = deleteid,
							section = form.section
							)>
	</cfif>

	<cfif structKeyExists(form,"categorySubmit")>
		<cfset categoryid = structKeyExists(form, "categoryId")? Val(obj.decryptData(form.categoryId)) : 0>
		<cfset variables.result = obj.updateCategory(
											categoryName = form.categoryName,
											categoryid = categoryId
											)>
	<cfelseif structKeyExists(form,"subCategorySubmit")>
		<cfset subcategoryid = structKeyExists(form, "subCategoryId")? Val(obj.decryptData(form.subCategoryId)): 0>
		<cfset categorySelect = structKeyExists(form, "categorySelect")? Val(obj.decryptData(form.categorySelect)): 0>
		<cfset variables.result = obj.updateSubCategory(	categorySelect = categorySelect,
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
		<cfif structKeyExists(form,"images") AND Len(Trim(form.images)) GT 0>
			<cfset uploadDir = expandPath('./images/')>        
			<cfif not directoryExists(uploadDir)>
				<cfdirectory action="create" directory="#uploadDir#">
			</cfif>
			<cffile action="uploadall"
					filefield="images"
					destination="#uploadDir#"
					nameConflict="makeunique">
			<cfset variables.imgArray = Arraynew(1)>
			<cfif ArrayLen(cffile.uploadallresults) GT 0>
				<cfloop array="#cffile.uploadallresults#" index="item">
					<cfset arrayAppend(variables.imgArray, item.SERVERFILE)>
				</cfloop>
			</cfif>
			<!---<cfdump var="#variables.imgArray#"> --->
		</cfif>
		<cfset productid = structKeyExists(form, "productid")? Val(obj.decryptData(form.productid)): 0>
		<cfset productsubcategory = structKeyExists(form, "productsubcategory")? Val(obj.decryptData(form.productsubcategory)): 0>
		<cfif structKeyExists(variables, "imgArray") AND ArrayLen(variables.imgArray) GT 0>
			<cfset imagearray = variables.imgArray>
		<cfelse>
			<cfset imagearray = arraynew(1)>
		</cfif>
		<cfset variables.result = obj.updateProduct( subcategoryid = productsubcategory,
												productname   = form.productname,
												productdesc = form.productdesc,
												productimage = imgPath,
												tax = form.taxrate,
												price = form.price,
												productid = productid,
												imagearray = imagearray)>
	</cfif>
<cfcatch type="any">
	<cfdump var="#cfcatch#">
	<cfset variables.result = {
		"status" : 0,
		"message" : ''
	}>
	<cfif cfcatch.message CONTAINS "An error occurred while trying to encrypt">
		<cfset variables.result["message"] = "Decryption failed:corrupted data.">
	<cfelse>
		<cfset variables.result["message"] = "An unexpected error occured">
	</cfif>
</cfcatch>
</cftry>