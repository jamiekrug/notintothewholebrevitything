/**
 * AbstractGateway.cfc -- generic ORM CRUD methods and dynamic methods by convention via onMissingMethod.
 *
 * See all onMissing* method comments and other method signatures for usage.
 *
 * CREDIT:
 *   Heavily influenced by ColdSpring 2.0-pre-alpha's coldspring.orm.hibernate.AbstractGateway.
 *   So, thank you Mark Mandel and Bob Silverberg :)
 */
component
{

	/********** CONSTRUCTOR ************************************************************/

	function init()
	{
		return this;
	}


	/********** PUBLIC ************************************************************/


	/**
	 * Provides dynamic methods, by convention, on missing method:
	 *
	 *   newXXX()
	 *
	 *   saveXXX( required any xxxEntity )
	 *
	 *   deleteXXX( required any xxxEntity )
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

		if ( lCaseMissingMethodName.startsWith( 'get' ) )
		{
			return onMissingGetMethod( missingMethodName, missingMethodArguments );
		}
		else if ( lCaseMissingMethodName.startsWith( 'new' ) )
		{
			return onMissingNewMethod( missingMethodName, missingMethodArguments );
		}
		else if ( lCaseMissingMethodName.startsWith( 'list' ) )
		{
			return onMissingListMethod( missingMethodName, missingMethodArguments );
		}
		else if ( lCaseMissingMethodName.startsWith( 'save' ) )
		{
			return onMissingSaveMethod( missingMethodName, missingMethodArguments );
		}
		else if ( lCaseMissingMethodName.startsWith( 'delete' ) )
		{
			return onMissingDeleteMethod( missingMethodName, missingMethodArguments );
		}

		throw( 'No matching method for #missingMethodName#().' );
	}


	function delete( required target )
	{
		if ( isArray( target ) )
		{
			for ( var object in target )
			{
				delete( object );
			}
		}

		entityDelete( target );
	}


	function get( required string entityName, required any idOrFilter, boolean isReturnNewOnNotFound = false )
	{
		if ( isSimpleValue( idOrFilter ) && len( idOrFilter ) && idOrFilter != 0 )
		{
			var entity = entityLoadByPK( entityName, idOrFilter );
		}
		else if ( isStruct( idOrFilter ) )
		{
			var entity = entityLoad( entityName, idOrFilter, true );
		}

		if ( !isNull( entity ) )
		{
			return entity;
		}

		if ( isReturnNewOnNotFound )
		{
			return new( entityName );
		}
	}


	function list( required string entityName, struct filterCriteria = {}, string sortOrder = '', struct options = {} )
	{
		return entityLoad( entityName, filterCriteria, sortOrder, options );
	}


	function new( required string entityName )
	{
		return entityNew( entityName );
	}


	function save( required target )
	{
		if ( isArray( target ) )
		{
			for ( var object in target )
			{
				save( object );
			}
		}

		entitySave( target );
	}


	/********** PRIVATE ************************************************************/


	private function onMissingDeleteMethod( required string missingMethodName, required struct missingMethodArguments )
	{
		return delete( missingMethodArguments[ 1 ] );
	}


	/**
	 * Provides dynamic get methods, by convention, on missing method:
	 *
	 *   getXXX( required any ID, boolean isReturnNewOnNotFound = false )
	 *
	 *   getXXXByYYY( required any yyyFilterValue, boolean isReturnNewOnNotFound = false )
	 *
	 * ...in which XXX is an ORM entity name, and YYY is an entity property name.
	 *
	 * NOTE: Ordered arguments only--named arguments not supported.
	 */
	private function onMissingGetMethod( required string missingMethodName, required struct missingMethodArguments )
	{
		var isReturnNewOnNotFound = structKeyExists( missingMethodArguments, '2' ) ? missingMethodArguments[ 2 ] : false;

		var entityName = missingMethodName.substring( 3 );

		if ( entityName.matches( '(?i).+by.+' ) )
		{
			var tokens = entityName.split( '(?i)by', 2 );

			entityName = tokens[ 1 ];

			var filter = { '#tokens[ 2 ]#' = missingMethodArguments[ 1 ] };

			return get( entityName, filter, isReturnNewOnNotFound );
		}
		else
		{
			var id = missingMethodArguments[ 1 ];

			return get( entityName, id, isReturnNewOnNotFound );
		}
	}


	/**
	 * Provides dynamic list methods, by convention, on missing method:
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
	private function onMissingListMethod( required string missingMethodName, required struct missingMethodArguments )
	{
		var listMethodForm = 'listXXX';

		if ( findNoCase( 'FilterBy', missingMethodName ) )
		{
			listMethodForm &= 'FilterByYYY';
		}

		if ( findNoCase( 'OrderBy', missingMethodName ) )
		{
			listMethodForm &= 'OrderByZZZ';
		}

		switch( listMethodForm )
		{
			case 'listXXX':
				return onMissingListXXXMethod( missingMethodName, missingMethodArguments );

			case 'listXXXFilterByYYY':
				return onMissingListXXXFilterByYYYMethod( missingMethodName, missingMethodArguments );

			case 'listXXXOrderByZZZ':
				return onMissingListXXXOrderByZZZMethod( missingMethodName, missingMethodArguments );

			case 'listXXXFilterByYYYOrderByZZZ':
				return onMissingListXXXFilterByYYYOrderByZZZMethod( missingMethodName, missingMethodArguments );
		}
	}


	/**
	 * Provides dynamic list method, by convention, on missing method:
	 *
	 *   listXXX( struct filterCriteria, string sortOrder, struct options )
	 *
	 * ...in which XXX is an ORM entity name.
	 *
	 * NOTE: Ordered arguments only--named arguments not supported.
	 */
	private function onMissingListXXXMethod( required string missingMethodName, required struct missingMethodArguments )
	{
		var listArgs = {};

		listArgs.entityName = missingMethodName.substring( 4 );

		if ( structKeyExists( missingMethodArguments, '1' ) )
		{
			listArgs.filterCriteria = missingMethodArguments[ '1' ];

			if ( structKeyExists( missingMethodArguments, '2' ) )
			{
				listArgs.sortOrder = missingMethodArguments[ '2' ];

				if ( structKeyExists( missingMethodArguments, '3' ) )
				{
					listArgs.options = missingMethodArguments[ '3' ];
				}
			}
		}

		return list( argumentCollection = listArgs );
	}


	/**
	 * Provides dynamic list method, by convention, on missing method:
	 *
	 *   listXXXFilterByYYY( required any yyyFilterValue, string sortOrder, struct options )
	 *
	 * ...in which XXX is an ORM entity name, and YYY is an entity property name.
	 *
	 * NOTE: Ordered arguments only--named arguments not supported.
	 */
	private function onMissingListXXXFilterByYYYMethod( required string missingMethodName, required struct missingMethodArguments )
	{
		var listArgs = {};

		var temp = missingMethodName.substring( 4 );

		var tokens = temp.split( '(?i)FilterBy', 2 );

		listArgs.entityName = tokens[ 1 ];

		listArgs.filterCriteria = { '#tokens[ 2 ]#' = missingMethodArguments[ 1 ] };

		if ( structKeyExists( missingMethodArguments, '2' ) )
		{
			listArgs.sortOrder = missingMethodArguments[ '2' ];

			if ( structKeyExists( missingMethodArguments, '3' ) )
			{
				listArgs.options = missingMethodArguments[ '3' ];
			}
		}

		return list( argumentCollection = listArgs );
	}


	/**
	 * Provides dynamic list method, by convention, on missing method:
	 *
	 *   listXXXFilterByYYYOrderByZZZ( required any yyyFilterValue, struct options )
	 *
	 * ...in which XXX is an ORM entity name, and YYY and ZZZ are entity property names.
	 *
	 * NOTE: Ordered arguments only--named arguments not supported.
	 */
	private function onMissingListXXXFilterByYYYOrderByZZZMethod( required string missingMethodName, required struct missingMethodArguments )
	{
		var listArgs = {};

		var temp = missingMethodName.substring( 4 );

		var tokens = temp.split( '(?i)FilterBy', 2 );

		listArgs.entityName = tokens[ 1 ];

		tokens = tokens[ 2 ].split( '(?i)OrderBy', 2 );

		listArgs.filterCriteria = { '#tokens[ 1 ]#' = missingMethodArguments[ 1 ] };

		listArgs.sortOrder = tokens[ 2 ];

		if ( structKeyExists( missingMethodArguments, '2' ) )
		{
			listArgs.options = missingMethodArguments[ '2' ];
		}

		return list( argumentCollection = listArgs );
	}


	/**
	 * Provides dynamic list method, by convention, on missing method:
	 *
	 *   listXXXOrderByZZZ( struct filterCriteria, struct options )
	 *
	 * ...in which XXX is an ORM entity name, and ZZZ is an entity property name.
	 *
	 * NOTE: Ordered arguments only--named arguments not supported.
	 */
	private function onMissingListXXXOrderByZZZMethod( required string missingMethodName, required struct missingMethodArguments )
	{
		var listArgs = {};

		var temp = missingMethodName.substring( 4 );

		var tokens = temp.split( '(?i)OrderBy', 2 );

		listArgs.entityName = tokens[ 1 ];

		listArgs.sortOrder = tokens[ 2 ];

		if ( structKeyExists( missingMethodArguments, '1' ) )
		{
			listArgs.filterCriteria = missingMethodArguments[ '1' ];

			if ( structKeyExists( missingMethodArguments, '2' ) )
			{
				listArgs.options = missingMethodArguments[ '2' ];
			}
		}

		return list( argumentCollection = listArgs );
	}


	private function onMissingNewMethod( required string missingMethodName, required struct missingMethodArguments )
	{
		var entityName = missingMethodName.substring( 3 );

		return new( entityName );
	}


	private function onMissingSaveMethod( required string missingMethodName, required struct missingMethodArguments )
	{
		return save( missingMethodArguments[ 1 ] );
	}


}