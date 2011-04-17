<!---
	
	Copyright 2010, Adam Drew
	
	Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in 
	compliance with the License.  You may obtain a copy of the License at 
	
		http://www.apache.org/licenses/LICENSE-2.0
	
	Unless required by applicable law or agreed to in writing, software distributed under the License is 
	distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or 
	implied.  See the License for the specific language governing permissions and limitations under the 
	License.
	
--->
<cfcomponent output="false" name="ServerRuleValidator_DateRange" extends="AbstractServerRuleValidator" hint="I am responsible for performing the DateRange validation.">

	<cffunction name="validate" returntype="any" access="public" output="false" hint="I perform the validation returning info in the validation object.">
		<cfargument name="validation" type="any" required="yes" hint="The validation object created by the business object being validated." />
		<cfset var fromDate = arguments.validation.getParameterValue("from")/>
		<cfset var untilDate = arguments.validation.getParameterValue("until")/>
		<cfset var theDate = arguments.validation.getObjectValue()/>
		
		<cfif shouldTest(arguments.validation) AND ((theDate lt fromDate) or (theDate gt untilDate))>
			<cfset fail(arguments.validation,createDefaultFailureMessage("#arguments.validation.getPropertyDesc()# must be a date between #fromDate# and #untilDate#.")) />
		</cfif>
	</cffunction>
	
</cfcomponent>
