<cfcomponent>

    <cffunction name="accessAdmin">
		<cfargument name="data" type="struct">
		<cfquery name="local.check" result="r">
			SELECT 
				uid,name,email,password,salt
			FROM 
				user 
			WHERE 
				username= <cfqueryparam value="#arguments.userName#" cfsqltype="varchar">;
		</cfquery>
		<cfif r.RECORDCOUNT GT 0>
			<cfset local.hashedPassword=local.check.password>
			<cfset local.salt=local.check.salt>
			<cfset local.checkPassword=HashPassword(arguments.passWord,local.salt)>
			<cfif local.checkPassword EQ local.hashedPassword>
				<cfset local.result = structNew()>
				<cfset local.result.value = 1 >
				<cfset session.uid=local.check.uid>
				<cfset session.user=local.check.name>
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
    </cffunction>

    <cffunction  name="updateSubCategory">
    </cffunction>

    <cffunction  name="updateProduct">
    </cffunction>
</cfcomponent>