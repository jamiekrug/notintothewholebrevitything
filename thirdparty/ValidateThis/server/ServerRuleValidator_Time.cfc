<!---
	
	Copyright 2010, Bob Silverberg, John Whish
	
	Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in 
	compliance with the License.  You may obtain a copy of the License at 
	
		http://www.apache.org/licenses/LICENSE-2.0
	
	Unless required by applicable law or agreed to in writing, software distributed under the License is 
	distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or 
	implied.  See the License for the specific language governing permissions and limitations under the 
	License.
	
--->
<cfcomponent output="false" name="ServerRuleValidator_Time" extends="AbstractServerRuleValidator" hint="I am responsible for performing the Time validation.">

	<cffunction name="validate" returntype="any" access="public" output="false" hint="I perform the validation returning info in the validation object.">
		<cfargument name="validation" type="any" required="yes" hint="The validation object created by the business object being validated." />
			<cfif shouldTest(arguments.validation) AND (ReFind("^(([01][0-9])|(2[0123])):([0-5])([0-9])$",arguments.validation.getObjectValue()) EQ 0)>
				<cfset fail(arguments.validation,createDefaultFailureMessage("#arguments.validation.getPropertyDesc()# must be a valid time, between 00:00 and 23:59.")) />
			</cfif>
	</cffunction>
	
</cfcomponent>
	
