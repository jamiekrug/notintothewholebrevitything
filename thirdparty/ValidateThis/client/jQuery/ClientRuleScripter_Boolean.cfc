<!---
	
	Copyright 2008, Bob Silverberg
	
	Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in 
	compliance with the License.  You may obtain a copy of the License at 
	
		http://www.apache.org/licenses/LICENSE-2.0
	
	Unless required by applicable law or agreed to in writing, software distributed under the License is 
	distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or 
	implied.  See the License for the specific language governing permissions and limitations under the 
	License.
	
--->
<cfcomponent output="false" name="ClientRuleScripter_boolean" extends="AbstractClientRuleScripter" hint="I am responsible for generating JS code for the boolean validation.">

	<cffunction name="generateInitScript" returntype="any" access="public" output="false" hint="I generate the validation 'method' function for the client during fw initialization.">
		<cfargument name="defaultMessage" type="string" required="false" default="The value entered must be a boolean">
		<cfset var theCondition="function(value,element,options) { return true; }"/>
		<!--- JAVASCRIPT VALIDATION METHOD --->
		<cfsavecontent variable="theCondition">function(value, element, options) {
			if ( value==null ) 
				{
					return false
				}
			else 
			{
				var tocheck = value.toString().toLowerCase();
				var pattern = /^((-){0,1}[0-9]{1,}(\.([0-9]{1,})){0,1}|(true)|(false)|(yes)|(no))$/;
				return tocheck.match( pattern ) == null ? false : true;
			}
		}</cfsavecontent>
		
		<cfreturn generateAddMethod(theCondition,arguments.defaultMessage)/>
	</cffunction>

	<cffunction name="getDefaultFailureMessage" returntype="any" access="private" output="false">
		<cfargument name="validation" type="any"/>
		<cfreturn createDefaultFailureMessage("#arguments.validation.getPropertyDesc()# must be a valid boolean value.") />
	</cffunction>

</cfcomponent>

