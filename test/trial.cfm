<cftry>
    <!--- Code that may cause an error --->
    <cfset x = 1 / 0> <!-- Division by zero to trigger an error --->
<cfcatch type="any">
    <!--- Dump the entire exception structure --->
    <cfdump var="#cfcatch#" label="Exception Details">
    
    <!--- Optionally, you can output specific parts of the exception --->
    <cfoutput>
        <p>Error Message: #cfcatch.message#</p>
        <p>Error Type: #cfcatch.type#</p>
        <p>Stack Trace: #cfcatch.stackTrace#</p>
    </cfoutput>
    
    <!--- Optionally, log the exception details to a log file --->
    <cflog file="Application" type="error" text="Error occurred: #cfcatch.message#; Type: #cfcatch.type#; Line: #cfcatch.line#; Detail: #cfcatch.detail#">
</cfcatch>
</cftry>