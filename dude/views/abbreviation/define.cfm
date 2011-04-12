<cfoutput>
	<h1>#rc.abbreviation.getText()#</h1>
	<ul>
		<cfloop array="#rc.abbreviation.getDefinitions()#" index="local.definition">
			<li>#local.definition.getText()#</li>
		</cfloop>
	</ul>

	<h2>Add Another Definition</h2>
	#view( 'abbreviation/submit_form' )#

	<h2>Find Another Abbreviation</h2>
	#view( 'abbreviation/define_form' )#
</cfoutput>