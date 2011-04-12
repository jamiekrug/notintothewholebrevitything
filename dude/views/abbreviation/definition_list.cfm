<cfif arrayLen( rc.abbreviations )>
	<dl>
		<cfoutput>
			<cfloop array="#rc.abbreviations#" index="local.abbreviation">
				<dt>#local.abbreviation.getText()#</dt>
				<cfif arrayLen( local.abbreviation.getDefinitions() )>
					<dd>
						<cfloop array="#local.abbreviation.getDefinitions()#" index="local.definition">
							#local.definition.getText()#<br />
						</cfloop>
					</dd>
				</cfif>
			</cfloop>
		</cfoutput>
	</dl>
<cfelse>
	<p>No abbreviations found.</p>
</cfif>