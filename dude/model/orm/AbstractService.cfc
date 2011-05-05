component
		accessors="true"
		hint="AbstractService provides dynamic methods, by convention, on missing method."
{

	property gateway;
	property invoker;
	property validationService;


	/********** CONSTRUCTOR ***************************************************/

	function init()
	{
		return this;
	}


	/********** PUBLIC ********************************************************/


	/**
	 * Provides dynamic methods, by convention, on missing method:
	 *
	 *   newXXX()
	 *
	 *   getXXX( required any ID, boolean isReturnNewOnNotFound = false )
	 *
	 *   getXXXByYYY( required any yyyFilterValue, boolean isReturnNewOnNotFound = false )
	 *
	 *   listXXX( struct filterCriteria, string sortOrder, struct options )
	 *
	 *   listXXXFilterByYYY( required any yyyFilterValue, string sortOrder, struct options )
	 *
	 *   listXXXOrderByZZZ( struct filterCriteria, struct options )
	 *
	 *   listXXXFilterByYYYOrderByZZZ( required any yyyFilterValue, struct options )
	 *
	 * ...in which XXX is an ORM entity name, and YYY and ZZZ are entity property names.
	 *
	 * NOTE: Ordered arguments only--named arguments not supported.
	 */
	function onMissingMethod( required string missingMethodName, required struct missingMethodArguments )
	{
		var lCaseMissingMethodName = lCase( missingMethodName );

		if ( lCaseMissingMethodName.startsWith( 'get' )
				|| lCaseMissingMethodName.startsWith( 'list' )
				|| lCaseMissingMethodName.startsWith( 'new' )
			)
		{
			return getInvoker().invoke( getGateway(), missingMethodName, missingMethodArguments );
		}

		throw( 'No matching method for #missingMethodName#().' );
	}


	/********** PRIVATE *******************************************************/


	private function populateAndSaveEntity( required any entity, required struct properties )
	{
		entity.populate( properties );

		return save( entity );
	}


	private function save( required any entity )
	{
		var result = getValidationService().validate( entity );

		if ( result.getIsSuccess() )
		{
			getGateway().save( entity );
		}
		else
		{
			ormClearSession();
		}

		return result;
	}


}