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
        <cfargument name="categoryName" type="string">
        <cfargument name="categoryid" type="numeric">
        <cfif NOT structKeyExists(arguments,"categoryid")>
            <cfquery name="insertCategory">
                INSERT INTO
                    categories(categoryname,status,createdat,createdby)
                VALUES(<cfqueryparam value="#arguments.categoryName#" cfsqltype="cf_sql_varchar">,
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
        <cfargument name="data" type="struct">
        <cfif NOT structKeyExists(arguments.data,"subcategoryid")>
            <cfquery name="insertSubCategory">
                INSERT INTO
                    subcategory(categoryid,subcategoryname,status,createdat,createdby)
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
        <cfargument name="subcategoryid" type="numeric">
        <cfargument name="productname" type="string">
        <cfargument name="productdesc" type="string">
        <cfargument name="productimage" type="string">
        <cfargument name="productid" type="numeric" required="false">
        <cfif NOT structKeyExists(arguments,"productid")>
            <cfquery name="insertProduct">
                INSERT INTO
                    products(subcategoryid,productname,productdesc,productimage,status,createdat,createdby)
                VALUES(<cfqueryparam value="#arguments.subcategoryid#" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#arguments.productname#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.productdesc#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.productimage#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="1" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                        <cfqueryparam value="#session.idadmin#" cfsqltype="cf_sql_integer"> 
                );
            </cfquery>
        </cfif>
            <cfset local.message="Product inserted successfully">
            <cfreturn local.message>
    </cffunction>

    <cffunction name="listCategory" access="remote" returnFormat="JSON">
        <cfquery name="local.getCategories" returnType="struct">
            SELECT
                categoryid,categoryname,status
            FROM
                categories
            WHERE
                status = 1;
        </cfquery>
        <cfreturn local.getCategories>
    </cffunction>
    <cffunction name="listSubCategory" access="remote" returnFormat="JSON">
        <cfargument name="categoryid" type="numeric" required="false">
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
            <cfif structKeyExists(arguments,"categoryid")>
                AND
                s.categoryid = <cfqueryparam value="#arguments.categoryid#" cfsqltype="cf_sql_integer">
            </cfif>
            ;
        </cfquery>
        <cfreturn local.getSubCategories>
    </cffunction>
    <cffunction name="listProducts" access="remote" returnFormat="JSON">
        <cfquery name="local.getProducts" returnType="struct">
            SELECT
                p.productid,
                p.subcategoryid,
                p.productname,
                p.productdesc,
                p.productimage,
                p.price
            FROM
                products p
            WHERE
                p.status = 1
        </cfquery> 
        <cfreturn local.getProducts> 
    </cffunction>
</cfcomponent>