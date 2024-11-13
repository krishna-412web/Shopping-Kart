<cfcomponent>
    <cfset this.name = "Shoppingcart">
    <cfset this.sessionManagement = true>
    <cfset this.sessionTimeout = CreateTimeSpan(0,0,15,0)>
    <cfset this.datasource = "shoppingcart">

    <cffunction name="onError">
        <cfargument name="exception" required="true">
        <cfargument name="eventname" required="true">
        <!--- Log the error or send an email --->
        <cftry>
            <cfoutput>
                <cflog file="Application" type="message" text="#arguments.exception.message#">
                <cfmail to="developer@shoppingkart.com"
                        from="noreply@shoppingkart.com"
                        subject="Application Error in ShoppingKart"
                        type="html">
                    <html>
                        <body>
                            <cfdump var="#arguments.exception#">
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
</cfcomponent>
