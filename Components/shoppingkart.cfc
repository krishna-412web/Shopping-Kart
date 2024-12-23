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
    
    <cffunction name="accessUser">
		<cfargument name="data" type="struct">
        <cfset local.user = structnew()>
		<cfquery name="local.check" datasource="shoppingcart" result="r">
			SELECT 
				userid,username,name,email,password,userimage,address
			FROM 
				users 
			WHERE 
				username= <cfqueryparam value="#arguments.data.userName#" cfsqltype="varchar">
            AND
                status=1
            ;
		</cfquery>
		<cfif r.RECORDCOUNT GT 0>
			<cfif arguments.data.passWord EQ local.check.password>
				<cfset local.user = {
                                    "value" : 1,
                                    "userid" : local.check.userid,
                                    "username" : local.check.username,
                                    "useremail" : local.check.email,
                                    "userimage" : local.check.userimage,
                                    "name" : local.check.name,
                                    "address" : local.check.address
                                    }>
			<cfelse>
				<cfset local.user["value"] = 0 >
			</cfif>	
		<cfelse> 
			<cfset local.user["value"] = 0>
		</cfif>
		<cfreturn local.user>
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
        <cfargument  name="tax" type="numeric">
        <cfargument name="productid" type="numeric" required="false">
        <cfargument name="imagearray" type="array" required="false">
        <cfset local.updateReturn ={
            "status" : 0,
            "message" : ''
        }>
        <cftry>
            <cfif arguments.productid EQ 0>
                <cfquery name="local.insertProduct" result="local.insertrow">
                    INSERT INTO
                        products(subcategoryid,productname,productdesc,productimage,price,tax,status,createdat,createdby)
                    VALUES(<cfqueryparam value="#arguments.subcategoryid#" cfsqltype="cf_sql_integer">,
                            <cfqueryparam value="#arguments.productname#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#arguments.productdesc#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#arguments.productimage#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#arguments.price#" cfsqltype="cf_sql_decimal">,
                            <cfqueryparam value="#arguments.tax#" cfsqltype="cf_sql_double">,
                            <cfqueryparam value="1" cfsqltype="cf_sql_integer">,
                            <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                            <cfqueryparam value="#session.idadmin#" cfsqltype="cf_sql_integer"> 
                    );
                </cfquery>
                <cfif structKeyExists(arguments, "imagearray") AND ArrayLen(arguments.imagearray) GT 0>
                    <cfquery name="insertimages">
                        INSERT INTO
                            images(productid,imagename,status)
                        VALUES
                            <cfloop array="#arguments.imagearray#" index="i" item="local.item">
                                (<cfqueryparam value="#local.insertrow.GENERATEDKEY#" cfsqltype="cf_sql_integer">,
                                <cfqueryparam value="#local.item#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="1" cfsqltype="cf_sql_integer">)
                                <cfif i NEQ ArrayLen(arguments.imagearray)>,</cfif>
                            </cfloop>
                        ;
                    </cfquery>
                </cfif>
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
                        tax = <cfqueryparam value="#arguments.tax#" cfsqltype="cf_sql_double">,
                        <cfif arguments.productimage NEQ "">
                            productimage = <cfqueryparam value="#arguments.productimage#" cfsqltype="cf_sql_varchar">,
                        </cfif>
                        updatedat = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                        updatedby = <cfqueryparam value="#session.idadmin#" cfsqltype="cf_sql_integer">
                    WHERE
                        productid = <cfqueryparam value="#arguments.productid#" cfsqltype="cf_sql_integer">
                </cfquery>
                <cfif structKeyExists(arguments, "imagearray") AND ArrayLen(arguments.imagearray) GT 0>
                    <cfquery name="insertimages">
                        INSERT INTO
                            images(productid,imagename,status)
                        VALUES
                            <cfloop array="#arguments.imagearray#" index="i" item="local.item">
                                (<cfqueryparam value="#arguments.productid#" cfsqltype="cf_sql_integer">,
                                <cfqueryparam value="#local.item#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="1" cfsqltype="cf_sql_integer">)
                                <cfif i NEQ ArrayLen(arguments.imagearray)>,</cfif>
                            </cfloop>
                        ;
                    </cfquery>
                </cfif>
                <cfset local.updateReturn["success"] = 1>
                <cfset local.updateReturn["message"]="Product updated successfully">
            </cfif>
        <cfcatch>
            <cfset local.updateReturn["message"] = cfcatch.message>
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
        <cfargument name="subcategoryid" type="string" required="false">
        <cfargument name="categoryid" type="string" required="false">
        <cfargument  name="search" type="string" required="false">
        <cfargument  name="limit" type="numeric" required="false">
        <cfargument name="order" type="string" required="false">
        <cfargument name="price" type="string" required="false">
        <cfargument  name="max" type="numeric" required="false">
        <cfargument  name="min" type="numeric" required="false">
        <cfif structKeyExists(arguments, "productid")>
            <cfset local.productid = Val(decryptData(arguments.productid))>
        <cfelseif structKeyExists(arguments, "categoryid")>
            <cfset local.categoryid = Val(decryptData(arguments.categoryid))>
        <cfelseif structKeyExists(arguments, "subcategoryid")>
            <cfset local.subcategoryid = Val(decryptData(arguments.subcategoryid))>
        </cfif>
        <cfquery name="local.getProducts" returnType="struct">
            SELECT
                p.productid,
                p.subcategoryid,
                p.productname,
                p.productdesc,
                p.productimage,
                p.price,
                p.tax,
                s.subcategoryname,
                s.categoryid,
                c.categoryname
            FROM
                products p
            INNER JOIN
                subcategory s
            ON
                p.subcategoryid = s.subcategoryid
            INNER JOIN
                categories c
            ON
                s.categoryid = c.categoryid
            WHERE
                p.status = 1
             <cfif structKeyExists(arguments, "search")>
                AND p.productname LIKE <cfqueryparam value="%#arguments.search#%" cfsqltype="cf_sql_varchar">
            </cfif>           
            <cfif structKeyExists(local, "productid")>
                AND p.productid = <cfqueryparam value="#local.productid#" cfsqltype="cf_sql_integer">
            </cfif>
            <cfif structKeyExists(local, "subcategoryid")>
                AND p.subcategoryid = <cfqueryparam value="#local.subcategoryid#" cfsqltype="cf_sql_integer">
            </cfif>
            <cfif structKeyExists(local, "categoryid")>
                AND p.subcategoryid IN (
                    SELECT
                        subcategoryid
                    FROM
                        subcategory
                    WHERE
                        categoryid = <cfqueryparam value="#local.categoryid#" cfsqltype="cf_sql_integer">)
            </cfif>
            <cfif structKeyExists(arguments,"price") AND arguments.price EQ "above">
                AND
                    p.price>20000
            <cfelseif structKeyExists(arguments,"price") AND arguments.price EQ "below" >
                AND
                    p.price<20000
            </cfif>
            <cfif   structKeyExists(arguments,"max") AND 
                    structKeyExists(arguments,"min") AND 
                    arguments.max GT 0 AND 
                    arguments.max GT arguments.min>
                AND price BETWEEN <cfqueryparam value="#arguments.min#" cfsqltype="cf_sql_integer"> 
                AND <cfqueryparam value="#arguments.max#" cfsqltype="cf_sql_integer">
            <cfelseif structKeyExists(arguments,"min") AND arguments.min neq 0>
                AND price > <cfqueryparam value="#arguments.min#" cfsqltype="cf_sql_integer">
            <cfelseif structKeyExists(arguments,"max") AND arguments.max neq 0>
                AND price < <cfqueryparam value="#arguments.max#" cfsqltype="cf_sql_integer">
            </cfif>
            <cfif structKeyExists(arguments,"limit")>
                ORDER BY rand()
                LIMIT <cfqueryparam value="#arguments.limit#" cfsqltype="cf_sql_integer">
            </cfif>
            <cfif structKeyExists(arguments,"order") AND arguments.order EQ "asc">
                ORDER BY p.price ASC
            <cfelseif structKeyExists(arguments,"order") AND arguments.order EQ "desc">
                ORDER BY p.price DESC
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

    <cffunction name="insertCart" access="public" returntype="void">
        <cfargument name="productid" type="numeric" required="true">
        <cfargument name="mode" type="string" required="false">

        <!--- Check if the item is already in the cart and active --->
        <cfquery name="local.existingItem">
            SELECT cartid 
            FROM shoppingcart 
            WHERE productid = <cfqueryparam value='#arguments.productid#' cfsqltype='cf_sql_integer'> 
            AND status = 1
            AND userid = <cfqueryparam value='#session.user.userid#' cfsqltype='cf_sql_integer'>
              ;
        </cfquery>

        <!--- If item exists, update the quantity --->
        <cfif local.existingItem.recordCount EQ 0>
            <cfquery>
                INSERT INTO 
                    shoppingcart (productid, quantity, userid,status) 
                VALUES (<cfqueryparam value='#arguments.productid#' cfsqltype='cf_sql_integer'>, 
                        1,
                        <cfqueryparam value="#session.user.userid#" cfsqltype='cf_sql_integer'>,  
                        1) 
            </cfquery>
        <cfelse>
            <cfquery>
                UPDATE 
                    shoppingcart 
                SET
                    quantity=quantity+1
                WHERE 
                    productid = <cfqueryparam value='#arguments.productid#' cfsqltype='cf_sql_integer'> 
                AND 
                    status = 1
                AND 
                    userid = <cfqueryparam value='#session.user.userid#' cfsqltype='cf_sql_integer'>
                
            </cfquery>
        </cfif>
    </cffunction>

    <cffunction name="listCart" access="remote" returnFormat="JSON">
        <cfargument  name="productid" type="string" required="false">
        <cfif structKeyExists(arguments,"productid")>
            <cfset local.productid = Val(decryptData(arguments.productid))>
        </cfif>
        <cfset local.cart = {
            "cartitems": [],
            "amount": 0,
            "totaltax" : 0
        }>
        <cfquery name="local.getCart">
            SELECT 
                s.cartid,
                s.productid,
                s.quantity,
                p.productname,
                p.productdesc,
                p.price,
                p.tax,
                p.productimage,
                (s.quantity*p.price*p.tax)/100 AS producttax,
                ((s.quantity*p.price)+(s.quantity*p.price*p.tax)/100) AS productprice
            FROM 
                shoppingcart s
            INNER JOIN
                products p
            ON
                s.productid = p.productid
            AND
                s.status = 1
            AND 
                s.userid = <cfqueryparam value="#session.user.userid#" cfsqltype="cf_sql_integer">
            <cfif structKeyExists(local,"productid")>
                AND
                    s.productid = <cfqueryparam value="#local.productid#" cfsqltype="cf_sql_varchar">
            </cfif>
            ;        
        </cfquery>
        <cfloop query="local.getCart">
            <cfset local.item = {
                "cartid":local.getCart.cartid,
                "productid":local.getCart.productid,
                "quantity":local.getCart.quantity,
                "productname":local.getCart.productname,
                "productdesc":local.getCart.productid,
                "productimage":local.getCart.productimage,
                "rate":local.getCart.price,
                "producttax":local.getCart.producttax,
                "productprice":local.getCart.productprice
            }>
            <cfset local.cart["totaltax"] = local.cart["totaltax"] + local.getCart.producttax>
            <cfset local.cart["amount"] = local.cart["amount"] + local.getCart.productprice>
            <cfset arrayAppend(local.cart.cartitems,local.item)>
        </cfloop>
        <cfif structKeyExists(arguments,"productid")>
            <cfset local.cart["amount"] = getAmount()>
        </cfif>
        <cfreturn local.cart/>
    </cffunction>

    <cffunction name="updateCart" access="remote" returnFormat="JSON">
        <cfargument  name="productid" type="string">
        <cfargument name="mode" type="numeric">
        <cfif structKeyExists(arguments,"productid")>
            <cfset local.productid = decryptData(arguments.productid)>
        </cfif>
        <cfif arguments.mode EQ 1>
            <cfquery name="updateQuantity">
                UPDATE
                    shoppingcart
                SET
                    quantity = quantity+1
                WHERE
                    status = 1
                AND
                    userid = <cfqueryparam value="#session.user.userid#" cfsqltype="cf_sql_integer">
                AND
                    productid = <cfqueryparam value="#local.productid#" cfsqltype="cf_sql_integer">
                ;
            </cfquery>
        <cfelseif arguments.mode EQ 0>
            <cfquery name="updateQuantity">
                UPDATE
                    shoppingcart
                SET
                    quantity = quantity-1
                WHERE
                    status = 1
                AND
                    userid = <cfqueryparam value="#session.user.userid#" cfsqltype="cf_sql_integer">
                AND
                    productid = <cfqueryparam value="#local.productid#" cfsqltype="cf_sql_integer">
                ;
            </cfquery>        
        </cfif>
        <cfset local.productinfo = listCart(productid = arguments.productid)>
        <cfreturn local.productinfo>
    </cffunction>

    <cffunction name="deleteCart" access="remote" returnFormat="JSON">
        <cfargument  name="productid" type="string">
        <cfif structKeyExists(arguments,"productid")>
            <cfset local.productid = decryptData(arguments.productid)>
        </cfif>
        <cfquery name="local.deleteItem">
            UPDATE
                shoppingcart
            SET
                status = 0
            WHERE
                status = 1
            AND
                <cfif structKeyExists(local,"productid")>
                    productid = <cfqueryparam value="#local.productid#" cfsqltype="cf_sql_integer">
                <cfelse>
                    userid = <cfqueryparam value="#session.user.userid#" cfsqltype="cf_sql_integer">
                </cfif>
            ;
        </cfquery>
        <cfreturn 1>
    </cffunction>

    <cffunction  name="getAmount" access="remote" returnFormat="JSON">
        <cfquery name="local.getTotalPrice">
            SELECT 
                SUM((sc.quantity * p.price)+((sc.quantity * p.price*p.tax)/100)) AS totalamount
            FROM 
                shoppingcart sc
            INNER JOIN 
                products p ON sc.productid = p.productid
            WHERE
                sc.status = 1
            AND 
                sc.userid = 1;
        </cfquery>
        <cfreturn local.getTotalPrice.totalamount/>
    </cffunction>

    <cffunction name="listAddress" access="remote" returnFormat="JSON">
        <cfargument name="addressid" required="false" type="numeric">
        <cfargument name="userid" required="false" type="numeric">
        <cfquery name="local.getAddress" returnType="struct">
            SELECT
                addressid,
                name,
                phoneno,
                housename,
                street,
                city,
                state,
                pincode
            FROM
                shippingaddress
            WHERE
                status = 1
            <cfif structKeyExists(arguments, "addressid")>
            AND
                addressid= <cfqueryparam value="#arguments.addressid#" cfsqltype="cf_sql_integer">
            </cfif>
            <cfif structKeyExists(arguments, "userid")>
            AND
                userid= <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer">
            </cfif>
            ;
        </cfquery>
        <cfreturn local.getAddress/>
    </cffunction>

    <cffunction name="setaddress">
        <cfargument name="addressid" required="false" type="numeric">
        <cfargument name="userid" required="false" type="numeric">
        <cfquery name="local.set" result="r">
            UPDATE
                users
            SET
                address = <cfqueryparam value="#arguments.addressid#" cfsqltype="cf_sql_integer">
            WHERE
                userid = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer">;
        </cfquery>
    </cffunction>

    <cffunction name="updateAddress">
        <cfargument name="addressid" required="false" type="numeric">
        <cfargument name="name" required="false" type="string">
        <cfargument name="phoneno" required="false" type="numeric">
        <cfargument name="housename" required="false" type="string">
        <cfargument name="street" required="false" type="string">
        <cfargument name="city" required="false" type="string">
        <cfargument name="pincode" required="false" type="string">
        <cfargument name="userid" required="false" type="numeric">
        <cfif arguments.addressid NEQ 0 AND arguments.userid EQ 0>
            <cfquery name="updateadd">
                UPDATE
                    shippingaddress
                SET
                    name = <cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar">,
                    phoneno = <cfqueryparam value="#arguments.phoneno#" cfsqltype="cf_sql_decimal">,
                    housename =<cfqueryparam value="#arguments.housename#" cfsqltype="cf_sql_varchar">,
                    street =<cfqueryparam value="#arguments.street#" cfsqltype="cf_sql_varchar">,
                    city =<cfqueryparam value="#arguments.city#" cfsqltype="cf_sql_varchar">,
                    state =<cfqueryparam value="#arguments.state#" cfsqltype="cf_sql_varchar">,
                    pincode =<cfqueryparam value="#arguments.pincode#" cfsqltype="cf_sql_varchar">
                WHERE
                    addressid = <cfqueryparam value="#arguments.addressid#" cfsqltype="cf_sql_integer">
            </cfquery>
        <cfelse>
            <cfquery name="insertadd">
                INSERT INTO
                    shippingaddress(userid,
                                    name,
                                    phoneno,
                                    housename,
                                    street,
                                    city,
                                    state,
                                    pincode,
                                    status)
                    VALUES
                        (<cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer">,
                            <cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#arguments.phoneno#" cfsqltype="cf_sql_decimal">,
                            <cfqueryparam value="#arguments.housename#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#arguments.street#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#arguments.city#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#arguments.state#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#arguments.pincode#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="1" cfsqltype="cf_sql_integer">
                        );
            </cfquery>
        </cfif>
    </cffunction>

    <cffunction  name="addOrder">
        <cfargument name="productid" required="false" type="numeric">
        <cfargument name="quantity" required="false" type="numeric">
        <cfargument name="address" required="false" type="numeric">
        <cfset local.orderid = createUUID()>
        <cftry>
        <cfif structKeyExists(arguments,"productid") AND structKeyExists(arguments,"quantity")>
            <cfquery name="getProduct">
                SELECT
                    productid,
                    price,
                    tax
                FROM
                    products
                WHERE
                    productid = <cfqueryparam value="#arguments.productid#" cfsqltype="cf_sql_integer">
                ;
            </cfquery>
            <cfquery name="local.createorder">
                INSERT INTO
                    orders(orderid,userid,orderdate,addressid)
                VALUES(
                        <cfqueryparam value="#local.orderid#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#session.user.userid#" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                        <cfqueryparam value="#arguments.address#" cfsqltype="cf_sql_integer">
                    );
            </cfquery>
            <cfset local.producttax = (getProduct.price*arguments.quantity*getProduct.tax)/100>
            <cfset local.totalprice = (getProduct.price*arguments.quantity)+local.producttax>
            <cfquery name="local.createitems">
                INSERT INTO
                    orderitems(orderid,productid,quantity,producttax,totalprice)
                VALUES
                    (
                        <cfqueryparam value="#local.orderid#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.productid#" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#arguments.quantity#" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#local.producttax#" cfsqltype="cf_sql_decimal">,
                        <cfqueryparam value="#local.totalprice#" cfsqltype="cf_sql_decimal">
                    );
            </cfquery>
            <cfquery name="local.gettax">
                SELECT
                    sum(producttax) as totaltax
                FROM
                    orderitems
                WHERE 
                    orderid = <cfqueryparam value="#local.orderid#" cfsqltype="cf_sql_varchar">;
            </cfquery>
            <cfquery name="local.getfinalprice">
                SELECT
                    sum(totalprice) as totalprice
                FROM
                    orderitems
                WHERE 
                    orderid = <cfqueryparam value="#local.orderid#" cfsqltype="cf_sql_varchar">;
            </cfquery>
            <cfquery name="local.settotalprice">
                UPDATE
                    orders
                SET
                    totaltax = <cfqueryparam value="#local.gettax.totaltax#" cfsqltype="cf_sql_decimal">,
                    amount = <cfqueryparam value="#local.getfinalprice.totalprice#" cfsqltype="cf_sql_decimal">
                WHERE 
                    orderid = <cfqueryparam value="#local.orderid#" cfsqltype="cf_sql_varchar">;
            </cfquery>
        <cfelse>
            <cfset local.cart = listCart()>
            <cfquery name="local.createorder">
                INSERT INTO
                    orders(orderid,userid,orderdate,totaltax,amount,addressid)
                VALUES(
                        <cfqueryparam value="#local.orderid#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#session.user.userid#" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                        <cfqueryparam value="#local.cart.totaltax#" cfsqltype="cf_sql_integer">,                       
                        <cfqueryparam value="#local.cart.amount#" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#arguments.address#" cfsqltype="cf_sql_integer">
                    );
            </cfquery>
            <cfoutput>
                <cfquery name="local.createitems">
                    INSERT INTO
                        orderitems(orderid,productid,quantity,producttax,totalprice)
                    VALUES
                        <cfloop array="#local.cart.cartitems#" index="local.index" item="local.item">
                            (
                                <cfqueryparam value="#local.orderid#" cfsqltype="cf_sql_varchar">,
                                <cfqueryparam value="#local.item.productid#" cfsqltype="cf_sql_integer">,
                                <cfqueryparam value="#local.item.quantity#" cfsqltype="cf_sql_integer">,
                                <cfqueryparam value="#local.item.producttax#" cfsqltype="cf_sql_decimal">,
                                <cfqueryparam value="#local.item.productprice#" cfsqltype="cf_sql_decimal">
                            )<cfif local.index NEQ ArrayLen(local.cart.cartitems)>,</cfif>
                        </cfloop>
                        ;
                </cfquery>
            </cfoutput>
        </cfif>
        <cfcatch>
            <cfdump var="#cfcatch#">
        </cfcatch>
        </cftry>
        <cfreturn local.orderid>
    </cffunction>

    <cffunction name="listOrder">
        <cfargument name="search" required="false" type="string">
        <cfquery name="local.getorders">
            SELECT
                o.orderid,
                o.orderdate,
                o.totaltax,
                o.amount,
                o.addressid,
                s.name,
                s.phoneno,
                s.housename,
                s.street,
                s.city,
                s.state,
                s.pincode,
                oi.itemid,
                oi.productid,
                oi.quantity,
                oi.producttax,
                oi.totalprice AS productprice,
                p.productname,
                p.productimage
            FROM
                orders o
            INNER JOIN
                shippingaddress s
            ON
                o.addressid = s.addressid
            INNER JOIN
                orderitems oi
            ON
                o.orderid = oi.orderid
            INNER JOIN
                products p
            ON
                oi.productid = p.productid
            WHERE
                o.userid = <cfqueryparam value="#session.user.userid#" cfsqltype="cf_sql_integer">
            <cfif structKeyExists(arguments,"search")>
                AND
                    o.orderid LIKE <cfqueryparam value="%#arguments.search#%" cfsqltype="cf_sql_varchar">
            </cfif>
            ORDER BY
                o.orderdate DESC, o.orderid ASC
            ;
        </cfquery>
        <cfset local.orders = arrayNew(1)>
        <cfloop query="local.getorders" group="orderid">
            <cfset local.orderrow = {
                "orderid":local.getorders.orderid,
                "orderdate":local.getorders.orderdate,
                "totaltax":local.getorders.totaltax,
                "amount":local.getorders.amount,
                "addressid":local.getorders.addressid,
                "name":local.getorders.name,
                "phoneno":local.getorders.phoneno,
                "housename":local.getorders.housename,
                "street":local.getorders.street,
                "city":local.getorders.city,
                "state":local.getorders.state,
                "pincode":local.getorders.pincode,
                "orderitems":[]
            }>
            <!---Space to add rest of function--->
            <cfloop>
                <cfset local.productinfo = {
                    "productid": local.getorders.productid,
                    "quantity": local.getorders.quantity,
                    "producttax": local.getorders.producttax,
                    "productprice": local.getorders.productprice,
                    "productname": local.getorders.productname,
                    "productimage": local.getorders.productimage
                }>
                <!-- Add the product to the current order -->
                <cfset arrayAppend(local.orderrow["orderitems"], local.productinfo)>
            </cfloop>
            <cfset arrayAppend(local.orders, local.orderrow)>
        </cfloop>
        <cfreturn local.orders>
    </cffunction>

    <cffunction  name="makePayment">
        <cfargument name="cardnumber" required="true" type="string">
        <cfargument name="expirationdate" required="true" type="string">
        <cfargument name="cvv" required="true" type="string">
        <cfargument name="cardholdername" required="true" type="string">
        <cfset local.result = {
            "value" : 1,
            "message" : []
        }>
        <cfif arguments.cardnumber NEQ "5196080964602432">
            <cfset local.result["value"]=0>
            <cfset arrayAppend(local.result.message, "*incorrect card no")>
        </cfif>
        <cfif arguments.expirationdate NEQ "06/27">
            <cfset local.result["value"]=0>
            <cfset arrayAppend(local.result.message, "*incorrect expiration date")>
        </cfif>
        <cfif arguments.cvv NEQ "213">
            <cfset local.result["value"]=0>
            <cfset arrayAppend(local.result.message, "*incorrect cvv")>
        </cfif>
        <cfif arguments.cardholdername NEQ "KRISHNA RENJITH">
            <cfset local.result["value"]=0>
            <cfset arrayAppend(local.result.message, "*incorrect holder name")>
        </cfif>
        <cfreturn local.result>
    </cffunction>

    <cffunction name="sendmail">
        <cfargument name="orderid" type="string">
        <cfset local.order = listOrder(orderid = arguments.orderid)>
        <cftry>
            <cfoutput>
                <cfmail to="#session.user.useremail#"
                        from="noreply@shoppingkart.com"
                        subject="Order Placed Successfully"
                        type="html">
                    <!---<cfdump var="#arguments.exception#">--->
                    <html>
                        <body>
                            <h3>OrderId: #local.order[1].orderid#</h3>
                            <h3>Orderdate: #local.order[1].orderdate#</h3>
                            <h3>Tax deducted: #local.order[1].totaltax#</h3>
                            <h3>Amount: #local.order[1].amount#</h3>
                            <h3>Shipping Address: <br>
                                #local.order[1].name#|#local.order[1].phoneno#<br>
                                #local.order[1].housename#<br>
                                #local.order[1].street#, #local.order[1].city#<br>
                                #local.order[1].state#,#local.order[1].pincode#
                            </h3>
                            <h3>Product Details<br>----------------------------</h3>
                            <cfloop array="#local.order[1].orderitems#" index="item">
                                <p>Product name: #item.productname#</p>
                                <p>Product Quantity: #item.quantity#</p>
                                <p>Product Tax: #item.producttax#</p>
                                <p>Total Price: #item.productprice#</p>
                                <h3>----------------------------</h3>
                            </cfloop>
                        </body>
                    </html>
                </cfmail>
            </cfoutput>
            <cfcatch type="any">
                <!--- If there's an error in sending the email, log it to a file or take alternative action --->
                <cflog file="Application" type="error" text="Failed to send error email: #cfcatch.message#">
            </cfcatch>
        </cftry>
    </cffunction>

    <cffunction  name="getimages" access="remote" returnFormat="JSON">
        <cfargument name="productid" type="string">
        <cfif structKeyExists(arguments, "productid")>
            <cfset local.productid = decryptData(arguments.productid)>
        </cfif>
        <cfif structKeyExists(local, "productid")>
            <cfquery name="local.imageselect">
                SELECT
                    imageid,
                    imagename
                FROM
                    images
                WHERE
                    status = 1
                AND
                    productid = <cfqueryparam value="#local.productid#" cfsqltype="cf_sql_varchar">
            </cfquery>
            <cfif local.imageselect.RECORDCOUNT GT 0>
                    <cfset local.listimage = ValueArray(local.imageselect,"imagename") >
                    <cfset local.arrayimage = arraynew(1)>
                    <cfoutput query="local.imageselect">
                        <cfset local.row = {
                            "imageid" : local.imageselect.imageid,
                            "imagename" : local.imageselect.imagename
                        }>
                        <cfset arrayAppend(local.arrayimage,local.row)>
                    </cfoutput>
                    <cfset local.images = {
                        "imagelist" : local.listimage,
                        "imagearray" : local.arrayimage
                    }>     
            <cfelse>
                <cfset local.images = {
                    "value": 0
                }>
            </cfif>
        </cfif>
        <cfreturn local.images>
    </cffunction>

    <cffunction  name="deleteimage" access="remote" returnFormat="JSON">
        <cfargument name="imageid" type="numeric">
        <cfquery name="local.imagedelete">
            UPDATE
                images
            SET
                status = 0
            WHERE
                imageid = <cfqueryparam value="#arguments.imageid#" cfsqltype="cf_sql_integer"> 
        </cfquery>
        <cfreturn 1>
    </cffunction>

    <cffunction name="encryptText">
        <cfargument name="inputtext" type="string">
        <cfset local.encryptedText= encrypt(toString(arguments.inputtext),variables.key,"AES","Hex")>
        <cfreturn local.encryptedText>
    </cffunction>
</cfcomponent>