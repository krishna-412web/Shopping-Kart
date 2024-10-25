<cfcomponent>

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
        <cfif NOT structKeyExists(arguments.data,"categoryid")>
            <cfquery name="insertCategory">
                INSERT INTO
                    categories(categoryname,status,createdat,createdby)
                VALUES(<cfqueryparam value="#arguments.data.categoryName#" cfsqltype="cf_sql_varchar">,
                       <cfqueryparam value="1" cfsqltype="cf_sql_integer">,
                       <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                       <cfqueryparam value="#session.idadmin#" cfsqltype="cf_sql_integer"> 
                );
            </cfquery>
            <cfset local.message="category inserted successfully">
            <cfreturn local.message>
        </cfif>

    </cffunction>

    <cffunction  name="updateSubCategory">
        <cfif NOT structKeyExists(arguments.data,"subcategoryid")>
            <cfquery name="insertSubCategory">
                INSERT INTO
                    categories(categoryid,subcategoryname,status,createdat,createdby)
                VALUES(<cfqueryparam value="#arguments.data.categorySelect#" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#arguments.data.subCategoryName#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="1" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                        <cfqueryparam value="#session.idadmin#" cfsqltype="cf_sql_integer"> 
                );
            </cfquery>
        </cfif>
        <cfset local.message="Subcategory inserted successfully">
        <cfreturn local.message>
    </cffunction>

    <cffunction  name="updateProduct">
        <cfif NOT structKeyExists(arguments.data,"productid")>
            <cfquery name="insertProduct">
                INSERT INTO
                    categories(subcategoryid,productname,productdesc,productimage,status,createdat,createdby)
                VALUES(<cfqueryparam value="#arguments.data.productSubCategory#" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#arguments.data.productName#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.data.productDesc#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.data.productPicture#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="1" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                        <cfqueryparam value="#session.idadmin#" cfsqltype="cf_sql_integer"> 
                );
            </cfquery>
        </cfif>
            <cfset local.message="Product inserted successfully">
            <cfreturn local.message>
    </cffunction>

    <cffunction name="listCategory">
        <cfquery name="getCategories">
            SELECT
                categoryid,categoryname,status
            FROM
                category
            WHERE
                status = 1;
        </cfquery>
    </cffunction>
    <cffunction name="listSubCategory">
        <cfquery name="getSubCategories">
            SELECT
                s.subcategoryid,
                s.categoryid,
                s.subcategoryname,
                s.status
            FROM
                subcategory s,category c
            WHERE
                s.status = 1
                AND
                s.categoryid = c.categoryid;
        </cfquery>
    </cffunction>
    <cffunction name="listProducts">
        <cfquery name="getProducts">
            SELECT
                s.subcategoryid,
                s.categoryid,
                s.subcategoryname,
                s.status
            FROM
                product p,subcategory s
            WHERE
                p.status = 1
                AND
                p.categoryid = s.categoryid;
        </cfquery>  
    </cffunction>
</cfcomponent>