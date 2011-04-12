<cfset rc.title = "Undefined: #rc.abbreviation_text#" />
<cfoutput>
	<h1>Undefined: #rc.abbreviation_text#</h1>

	<h2>Add a Definition</h2>
	#view( 'abbreviation/submit_form' )#

	<h2>Find Another Abbreviation</h2>
	#view( 'abbreviation/define_form' )#
</cfoutput>