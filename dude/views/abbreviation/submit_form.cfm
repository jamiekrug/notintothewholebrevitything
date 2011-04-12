<cfoutput>
	<form action="#buildURL( 'abbreviation.submit' )#" method="post">
		<input type="text" name="abbreviation_text" value="#rc.abbreviation_text#" size="8" /> =
		<input type="text" name="definition_text" value="#rc.definition_text#" size="20" />
		<input type="submit" value="Add!" />
	</form>
</cfoutput>