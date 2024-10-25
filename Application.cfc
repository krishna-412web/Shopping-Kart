<cfcomponent>
    <cfset this.name = "Shoppingcart">
    <cfset this.sessionManagement = true>
    <cfset this.sessionTimeout = CreateTimeSpan(0,0,15,0)>
    <cfset this.datasource = "shoppingcart">
</cfcomponent>
