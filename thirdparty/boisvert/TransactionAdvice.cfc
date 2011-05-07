<!---
To use this component, set up your ColdSpring beans.xml file as you normally would:

	<!-- a bean (must be a singleton) -->
	<bean id="imageprocessor" class="sorter.cfcs.imageprocessor">
		<!-- properties -->
	</bean>

add another bean definition for the advice:

	<bean id="imageprocessor" class="sorter.cfcs.imageprocessor">
		<!-- properties -->
	</bean>

	<!-- transaction advice -->
	<bean id="transactionAdvice"
		class="sorter.cfcs.transactionadvice" />

and then for all objects that require transactionality, wrap the existing beans in
a ProxyFactoryBean, which will apply the transaction advice:

	<!-- ProxyFactoryBean wrapping the original bean (now an inner bean) -->
	<bean id="imageprocessor" class="coldspring.aop.framework.ProxyFactoryBean">
		<property name="target">
			<bean class="sorter.cfcs.imageprocessor">
				<!-- properties -->
			</bean>
		</property>
		<property name="interceptorNames">
			<list>
				<value>transactionAdvice</value>
			</list>
		</property>
	</bean>

	<!-- transaction advice -->
	<bean id="transactionAdvice"
		class="sorter.cfcs.transactionadvice" />

Now all methods on the 'imageprocessor' bean will be called in a transactional context.
Note, however, that they will not necessarily be called in their OWN transactional
context, as nested and/or reentrant calls will inherit the transactional context of
the outer/parent invocation.

If you just need to make selected methods transactional (rather than all of them),
you can use a NamedMethodPointcutAdvisor or a RegexMethodPointcutAdvisor to do so.  By
default, ColdSpring uses a DefaultPointcutAdvisor (which matches all methods) when one
is not explicitly configured.

If you would like to monitor the transactional method call stack, you can uncomment
the five CFTRACE tags inside the invokeMethod method that indicate when a transactional
method is entered or exited (including whether it was nested or not and whether it
completed normally or raised an exception).

This component has only been tested with the current CVS version of ColdSpring (as of
Oct 22, 2006).

------------------------------------------------------------------------
$Id: transactionadvice.cfc 1600 2006-12-10 04:20:48Z barneyb $

Copyright 2006 Barney Boisvert (bboisvert@gmail.com).

Licensed under the Apache License, Version 2.0 (the "License"); you may
not use this file except in compliance with the License. You may obtain
a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--->
<cfcomponent extends="coldspring.aop.MethodInterceptor"
	hint="I am an 'around' advice for ColdSpring that will apply a transactional context
		to the invoked method, inheriting from a previous method's transactional context
		if one already exists.  I can be parameterized with an isolation level that will
		be used for ALL transactions, or it may be omitted to use the default level (per
		your database's configuration settings">

	<!---
	With no ThreadLocal-style support (except from the underlying JVM, if there is one)
	we'll fake it with a request variable
	--->
	<cfset this.REQUEST_KEY = "__transactionadvice_invocation_depth" />

	<cffunction name="init" access="public" output="false" returntype="transactionadvice">
		<cfset variables.my = structNew() />
		<cfreturn this />
	</cffunction>

	<cffunction name="setIsolation" access="public" output="false" returntype="void">
		<cfargument name="isolation" type="string" required="true" />
		<cfset variables.my.isolation = isolation />
	</cffunction>

	<cffunction name="getIsolation" access="public" output="false" returntype="string">
		<cfreturn variables.my.isolation />
	</cffunction>


	<cffunction name="invokeMethod" access="public" output="false" returntype="any">
		<cfargument name="methodInvocation" type="coldspring.aop.MethodInvocation" required="true" />

		<cfset var local = structNew() />

		<cfset var name = "#getMetaData(methodInvocation.getTarget()).name#.#methodInvocation.getMethod().getMethodName()#" />

		<cfif NOT structKeyExists(request, this.REQUEST_KEY)>
			<cfset request[this.REQUEST_KEY] = 0 />
		</cfif>

		<cfset request[this.REQUEST_KEY] = request[this.REQUEST_KEY] + 1 />

		<!---
		With no 'finally' support in cftry..cfcatch, we have to do it this way
		--->
		<cftry>
			<cfif request[this.REQUEST_KEY] EQ 1>
				<!--- We should never begin a transaction with a dirty Hibernate ORM session --->
				<cfif ormGetSession().isDirty()>
					<cfthrow message="ORM session is dirty when about to open a transaction." />
				</cfif>

				<!--- first entry of a transactional method --->
				<cfif structKeyExists(variables.my, "isolation")>
					<cftransaction isolation="#variables.my.isolation#">
						<cfset local.result = methodInvocation.proceed() />
					</cftransaction>
				<cfelse>
					<cftransaction>
						<cfset local.result = methodInvocation.proceed() />
					</cftransaction>
				</cfif>
			<cfelse>
				<!--- nested/reentrant call to a transactional method --->
				<cfset local.result = methodInvocation.proceed() />
			</cfif>

			<cfset request[this.REQUEST_KEY] = request[this.REQUEST_KEY] - 1 />

			<cfcatch type="any">
				<cfset request[this.REQUEST_KEY] = request[this.REQUEST_KEY] - 1 />
				<cfrethrow />
			</cfcatch>
		</cftry>

		<cfif structKeyExists(local, "result")>
			<cfreturn local.result />
		<cfelse>
			<cfreturn />
		</cfif>
	</cffunction>

<cfoutput></cfoutput>
</cfcomponent>