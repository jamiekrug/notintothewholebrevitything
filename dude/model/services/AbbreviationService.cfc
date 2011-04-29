component hint="AbbreviationService" accessors="true"
{
	property name="abbreviationGateway" getter="false";
	property name="validationService" getter="false";


	/********** CONSTRUCTOR ***************************************************/


	function init()
	{
		return this;
	}


	/********** PUBLIC ********************************************************/


	function getAbbreviation( required string id )
	{
		return variables.abbreviationGateway.getAbbreviation( id );
	}


	function getAbbreviationByText( required string text )
	{
		return variables.abbreviationGateway.getAbbreviationByText( text );
	}


	function getDefinition( required string id )
	{
		return variables.abbreviationGateway.getDefinition( id );
	}


	function isAbbreviationUnique( required abbreviation )
	{
		if ( isNull( abbreviation.getText() ) )
		{
			return false;
		}

		var existingAbbreviation = getAbbreviationByText( abbreviation.getText() );

		if ( !isNull( existingAbbreviation ) && existingAbbreviation.getID() != abbreviation.getID() )
		{
			return false;
		}

		return true;
	}


	function listAbbreviation()
	{
		return variables.abbreviationGateway.listAbbreviation();
	}


	function newAbbreviation()
	{
		return variables.abbreviationGateway.newAbbreviation();
	}


	function newDefinition()
	{
		return variables.abbreviationGateway.newDefinition();
	}


	function saveAbbreviation( required struct properties )
	{
		transaction
		{
			if ( isNull( properties.id ) )
			{
				var abbreviation = newAbbreviation();
			}
			else
			{
				var abbreviation = getAbbreviation( properties.id );
			}

			abbreviation.populate( properties );

			var result = variables.validationService.validate( abbreviation );

			if ( result.getIsSuccess() )
			{
				variables.abbreviationGateway.saveAbbreviation( abbreviation );
			}
			else
			{
				transactionRollback();
			}
		}

		return result;
	}


	function saveDefinition( required struct properties, string abbreviationID )
	{
		transaction
		{
			if ( isNull( properties.abbreviation ) && !isNull( arguments.abbreviationID ) )
			{
				properties.abbreviation = getAbbreviation( abbreviationID );
			}

			if ( isNull( properties.id ) )
			{
				var definition = newDefinition();
			}
			else
			{
				var definition = getDefinition( properties.id );
			}

			definition.populate( properties );

			var result = variables.validationService.validate( definition );

			if ( result.getIsSuccess() )
			{
				variables.abbreviationGateway.saveDefinition( definition );
			}
			else
			{
				transactionRollback();
			}
		}

		return result;
	}


	function saveDefinitionByText( required string abbreviationText, required string definitionText )
	{
		transaction
		{
			var abbreviation = getAbbreviationByText( abbreviationText );

			if ( isNull( abbreviation ) )
			{
				var abbreviation = newAbbreviation();

				abbreviation.populate( { text = abbreviationText } );
			}

			var result = saveDefinition( { text = definitionText, abbreviation = abbreviation } );
		}

		return result;
	}


	/********** PRIVATE *******************************************************/


}