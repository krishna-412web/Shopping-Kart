<cfcomponent>
    <cfset variables.key="baiYIM2yvVW258BNOmovjQ==">
    <!---<cfset local.encryptedText= encrypt(toString(local.i.log_id),variables.key,"AES","Hex")>--->
    <cffunction name="decryptData">
		<cfargument name="encryptedText" type="string">
		<cfset local.decryptedText= decrypt(encryptedText,variables.key,"AES","Hex")>
		<cfreturn local.decryptedText/>
	</cffunction>
    <cffunction name="accessAdmin">
		<cfargument name="data" type="struct">
		<cfquery name="local.check" datasource="shoppingcart" result="r">
			SELECT 
				idadmin,adminname,email,password
			FROM 
				admin 
			WHERE 
				adminname= <cfqueryparam value="#arguments.data.userName#" cfsqltype="varchar">;
		</cfquery>
		<cfif r.RECORDCOUNT GT 0>
			<cfif arguments.data.passWord EQ local.check.password>
				<cfset local.result = structNew()>
				<cfset local.result.value = 1 >
				<cfset session.idadmin=local.check.idadmin>
				<cfset session.adminname=local.check.adminname>
				<cfset session.email=local.check.email>
			<cfelse>
				<cfset local.result.value = 0 >
			</cfif>	
		<cfelse> 
			<cfset local.result.value = 0>
		</cfif>
		<cfreturn local.result>
    </cffunction>
    
    <cffunction  name="updateCategory">
        <cfargument name="categoryName" type="string">
        <cfargument name="categoryid" type="numeric">
        <cfset local.updateReturn = {
            "success" : 0,
            "message" : ''
        }>
        <cftry>
            <cfif arguments.categoryid EQ 0>
                <cfquery name="local.insertCategory">
                    INSERT INTO
                        categories(categoryname,status,createdat,createdby)
                    VALUES(<cfqueryparam value="#arguments.categoryName#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="1" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                        <cfqueryparam value="#session.idadmin#" cfsqltype="cf_sql_integer"> 
                    );
                </cfquery>
                <cfset local.updateReturn["success"] = 1>
                <cfset local.updateReturn["message"]="category inserted successfully">
            <cfelse>
                <cfquery name="local.updateCategory">
                    UPDATE categories
                    SET
                        categoryname = <cfqueryparam value="#arguments.categoryName#" cfsqltype="cf_sql_varchar">,
                        updatedat = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                        updatedby = <cfqueryparam value="#session.idadmin#" cfsqltype="cf_sql_integer">
                    WHERE
                        categoryid = <cfqueryparam value="#arguments.categoryid#" cfsqltype="cf_sql_integer">
                </cfquery>
                <cfset local.updateReturn["success"] = 1>
                <cfset local.updateReturn["message"]="category updated successfully">

            </cfif>
        <cfcatch>
            <cfset local.updateReturn["message"] = "Unexpected Error">
        </cfcatch>
        </cftry>
        <cfreturn local.updateReturn>
    </cffunction>

    <cffunction  name="updateSubCategory">
        <cfargument name="categorySelect" type="numeric">
        <cfargument name="subCategoryName" type="string">
        <cfargument name="subcategoryid" type="numeric" required="false">
        <cfset local.updateReturn = {
            "success" : 0,
            "message" : ''
        }>
        <cftry>
            <cfif arguments.subcategoryid EQ 0>
                <cfquery name="local.insertSubCategory">
                    INSERT INTO
                        subcategory(categoryid,subcategoryname,status,createdat,createdby)
                    VALUES(<cfqueryparam value="#arguments.categorySelect#" cfsqltype="cf_sql_integer">,
                            <cfqueryparam value="#arguments.subCategoryName#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="1" cfsqltype="cf_sql_integer">,
                            <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                            <cfqueryparam value="#session.idadmin#" cfsqltype="cf_sql_integer"> 
                    );
                </cfquery>
                <cfset local.updateReturn["success"] = 1>
                <cfset local.updateReturn["message"]= "Subcategory inserted successfully">
            <cfelse>
                <cfquery name="local.updateSubCategory">
                    UPDATE subcategory
                    SET
                        categoryid = <cfqueryparam value="#arguments.categorySelect#" cfsqltype="cf_sql_integer">,
                        subcategoryname = <cfqueryparam value="#arguments.subCategoryName#" cfsqltype="cf_sql_varchar">,
                        updatedat = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                        updatedby = <cfqueryparam value="#session.idadmin#" cfsqltype="cf_sql_integer">
                    WHERE
                        subcategoryid = <cfqueryparam value="#arguments.subcategoryid#" cfsqltype="cf_sql_integer">
                </cfquery>
                <cfset local.updateReturn["success"] = 1>
                <cfset local.updateReturn["message"]="Subcategory updated successfully">
            </cfif>
        <cfcatch>
            <cfset local.updateReturn["message"] = "Unexpected Error">
        </cfcatch>
        </cftry>
        <cfreturn local.updateReturn>
    </cffunction>

    <cffunction  name="updateProduct">
        <cfargument name="subcategoryid" type="numeric">
        <cfargument name="productname" type="string">
        <cfargument name="productdesc" type="string">
        <cfargument name="productimage" type="string">
        <cfargument name="price" type="numeric">
        <cfargument name="productid" type="numeric" required="false">
        <cfset local.updateReturn ={
            "status" : 0,
            "message" : ''
        }>
        <cftry>
            <cfif arguments.productid EQ 0>
                <cfquery name="local.insertProduct">
                    INSERT INTO
                        products(subcategoryid,productname,productdesc,productimage,price,status,createdat,createdby)
                    VALUES(<cfqueryparam value="#arguments.subcategoryid#" cfsqltype="cf_sql_integer">,
                            <cfqueryparam value="#arguments.productname#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#arguments.productdesc#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#arguments.productimage#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#arguments.price#" cfsqltype="cf_sql_decimal">,
                            <cfqueryparam value="1" cfsqltype="cf_sql_integer">,
                            <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                            <cfqueryparam value="#session.idadmin#" cfsqltype="cf_sql_integer"> 
                    );
                </cfquery>
                <cfset local.updateReturn["success"] = 1>
                <cfset local.updateReturn["message"]="Product inserted successfully">
            <cfelse>
                <cfquery name="local.updateProduct">
                    UPDATE products
                    SET
                        subcategoryid = <cfqueryparam value="#arguments.subcategoryid#" cfsqltype="cf_sql_integer">,
                        productname = <cfqueryparam value="#arguments.productname#" cfsqltype="cf_sql_varchar">,
                        productdesc = <cfqueryparam value="#arguments.productdesc#" cfsqltype="cf_sql_varchar">,
                        price = <cfqueryparam value="#arguments.price#" cfsqltype="cf_sql_decimal">,
                        <cfif arguments.productimage NEQ "">
                            productimage = <cfqueryparam value="#arguments.productimage#" cfsqltype="cf_sql_varchar">,
                        </cfif>
                        updatedat = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                        updatedby = <cfqueryparam value="#session.idadmin#" cfsqltype="cf_sql_integer">
                    WHERE
                        productid = <cfqueryparam value="#arguments.productid#" cfsqltype="cf_sql_integer">
                </cfquery>
                <cfset local.updateReturn["success"] = 1>
                <cfset local.updateReturn["message"]="Product updated successfully">
            </cfif>
        <cfcatch>
            <cfset local.updateReturn["message"] = "Unexpected Error">
        </cfcatch>
        </cftry>
        <cfreturn local.updateReturn>
    </cffunction>

    <cffunction name="listCategory" access="remote" returnFormat="JSON">
        <cfargument name="categoryid" type="string" required="false">
        <cfif structKeyExists(arguments, "categoryid")>
            <cfset local.categoryid = Val(decryptData(arguments.categoryid))>
        </cfif>
        <cfquery name="local.getCategories" returnType="struct">
            SELECT
                categoryid,categoryname,status
            FROM
                categories
            WHERE
                status = 1
            <cfif structKeyExists(local,"categoryid")>
            AND
                categoryid=<cfqueryparam value="#local.categoryid#" cfsqltype="cf_sql_integer">
            </cfif>
            ;
        </cfquery>
        <cfloop array="#local.getCategories.RESULTSET#" index="local.row">
            <cfset local.encryptedText= encrypt(toString(local.row.categoryid),variables.key,"AES","Hex")>
            <cfset local.row.categoryid = local.encryptedText>
        </cfloop>
        <cfreturn local.getCategories>
    </cffunction>
    <cffunction name="listSubCategory" access="remote" returnFormat="JSON">
        <cfargument name="subcategoryid" type="string" required="false">
        <cfargument name="categoryid" type="string" required="false">
        <cfif structKeyExists(arguments, "subcategoryid")>
            <cfset local.subcategoryid = Val(decryptData(arguments.subcategoryid))>
        </cfif>
        <cfif structKeyExists(arguments, "categoryid")>
            <cfset local.categoryid = Val(decryptData(arguments.categoryid))>
        </cfif>
        <cfquery name="local.getSubCategories" returnType="struct">
            SELECT
                s.subcategoryid,
                s.categoryid,
                s.subcategoryname,
                s.status
            FROM
                subcategory s
            WHERE
                s.status = 1
            <cfif structKeyExists(local,"categoryid")>
                AND
                s.categoryid = <cfqueryparam value="#local.categoryid#" cfsqltype="cf_sql_integer">
            </cfif>
            <cfif structKeyExists(local,"subcategoryid")>
                AND
                s.subcategoryid = <cfqueryparam value="#local.subcategoryid#" cfsqltype="cf_sql_integer">
            </cfif>
            ;
        </cfquery>
        <cfloop array="#local.getSubCategories.RESULTSET#" index="local.row">
            <cfset local.encryptedText= encrypt(toString(local.row.subcategoryid),variables.key,"AES","Hex")>
            <cfset local.row.subcategoryid = local.encryptedText>
            <cfset local.encryptedText= encrypt(toString(local.row.categoryid),variables.key,"AES","Hex")>
            <cfset local.row.categoryid = local.encryptedText>
        </cfloop>
        <cfreturn local.getSubCategories>
    </cffunction>
    <cffunction name="listProducts" access="remote" returnFormat="JSON">
        <cfargument name="productid" type="string" required="false">
        <cfif structKeyExists(arguments, "productid")>
            <cfset local.productid = Val(decryptData(arguments.productid))>
        </cfif>
        <cfquery name="local.getProducts" returnType="struct">
            SELECT
                p.productid,
                p.subcategoryid,
                s.categoryid,
                p.productname,
                p.productdesc,
                p.productimage,
                p.price
            FROM
                products p
            INNER JOIN
                subcategory s
            ON
                p.subcategoryid = s.subcategoryid
            WHERE
                p.status = 1
            <cfif structKeyExists(local, "productid")>
                AND p.productid = <cfqueryparam value="#local.productid#" cfsqltype="cf_sql_integer">
            </cfif>
            ;
        </cfquery> 
        <cfloop array="#local.getProducts.RESULTSET#" index="local.row">
            <cfset local.encryptedText= encrypt(toString(local.row.productid),variables.key,"AES","Hex")>
            <cfset local.row.productid = local.encryptedText>
            <cfset local.encryptedText= encrypt(toString(local.row.subcategoryid),variables.key,"AES","Hex")>
            <cfset local.row.subcategoryid = local.encryptedText>
            <cfset local.encryptedText= encrypt(toString(local.row.categoryid),variables.key,"AES","Hex")>
            <cfset local.row.categoryid = local.encryptedText>
        </cfloop>
        <cfreturn local.getProducts> 
    </cffunction>
    <cffunction name="deleteItems">
        <cfargument name="deleteid" type="numeric">
        <cfargument name="section" type="string">
        <cfset local.updateReturn = {
            "status": 0,
            "message" : ""
        }>
        <cftry>
            <cfif arguments.section EQ "category">
                <cfquery name="local.softDeleteCategory">
                    UPDATE categories
                    SET
                        status = 0,
                        deletedat = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                        deletedby = <cfqueryparam value="#session.idadmin#" cfsqltype="cf_sql_integer">
                    WHERE
                        categoryid = <cfqueryparam value="#arguments.deleteid#" cfsqltype="cf_sql_integer">
                </cfquery>
                <cfquery name="local.softDeleteSubCategories">
                    UPDATE subcategory
                    SET
                        status = 0,
                        deletedat = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                        deletedby = <cfqueryparam value="#session.idadmin#" cfsqltype="cf_sql_integer">
                    WHERE
                        categoryid = <cfqueryparam value="#arguments.deleteid#" cfsqltype="cf_sql_integer">
                </cfquery>
                <cfquery name="local.softDeleteProducts">
                    UPDATE products
                    SET
                        status = 0,
                        deletedat = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                        deletedby = <cfqueryparam value="#session.idadmin#" cfsqltype="cf_sql_integer">
                    WHERE
                        subcategoryid IN (
                            SELECT subcategoryid
                            FROM subcategory
                            WHERE categoryid = <cfqueryparam value="#arguments.deleteid#" cfsqltype="cf_sql_integer">
                        )
                </cfquery>
                <cfset local.updateReturn["status"] = 1>
                <cfset local.updateReturn["message"] = "category deleted successfully"> 
            <cfelseif arguments.section EQ "subcategory">
                <cfquery name="local.softDeleteSubCategories">
                    UPDATE subcategory
                    SET
                        status = 0,
                        deletedat = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                        deletedby = <cfqueryparam value="#session.idadmin#" cfsqltype="cf_sql_integer">
                    WHERE
                        subcategoryid = <cfqueryparam value="#arguments.deleteid#" cfsqltype="cf_sql_integer">
                </cfquery>
                <cfquery name="local.softDeleteProducts">
                    UPDATE products
                    SET
                        status = 0,
                        deletedat = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                        deletedby = <cfqueryparam value="#session.idadmin#" cfsqltype="cf_sql_integer">
                    WHERE
                        subcategoryid = <cfqueryparam value="#arguments.deleteid#" cfsqltype="cf_sql_integer">
                </cfquery>
                <cfset local.updateReturn["status"] = 1>
                <cfset local.updateReturn["message"] = "subcategory deleted successfully"> 
            <cfelseif arguments.section EQ "product">
                <cfquery name="local.softDeleteProducts">
                    UPDATE products
                    SET
                        status = 0,
                        deletedat = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                        deletedby = <cfqueryparam value="#session.idadmin#" cfsqltype="cf_sql_integer">
                    WHERE
                        productid = <cfqueryparam value="#arguments.deleteid#" cfsqltype="cf_sql_integer">
                </cfquery>
                <cfset local.updateReturn["status"] = 1>
                <cfset local.updateReturn["message"] = "product deleted successfully"> 
            </cfif>
        <cfcatch>
            <cfset local.updateReturn["message"] = "unexpected error">
        </cfcatch>
        </cftry>
        <cfreturn local.updateReturn>
    </cffunction>
</cfcomponent>