<cfif isDefined( 'rc.failureMessage' )>
	<p style="font-weight:bold; color:red;">
		<cfoutput>#rc.failureMessage#</cfoutput>
	</p>
</cfif>

<cfif isDefined( 'rc.successMessage' )>
	<p style="font-weight:bold; color:green;">
		<cfoutput>#rc.successMessage#</cfoutput>
	</p>
</cfif>