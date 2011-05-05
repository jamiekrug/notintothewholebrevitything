<cfcomponent output="false" hint="Utility to allow scripted calls to cfinvoke.">

	<cffunction name="init" output="false">
		<cfreturn this />
	</cffunction>


	<cffunction name="invoke" output="false">
		<cfargument name="component" type="any" required="true" hint="CFC name or instance." />
		<cfargument name="method" type="string" required="true" hint="Method name to be invoked." />
		<cfargument name="theArgumentCollection" type="struct" default="#structNew()#" hint="Argument collection to pass to method invocation." />

		<cfset var returnVariable = 0 />

		<cfinvoke
			component="#arguments.component#"
			method="#arguments.method#"
			argumentcollection="#arguments.theArgumentCollection#"
			returnvariable="returnVariable"
		/>

		<cfif not isNull( returnVariable )>
			<cfreturn returnVariable />
		</cfif>
	</cffunction>


</cfcomponent>