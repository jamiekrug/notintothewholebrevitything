component hint="AbbreviationService" accessors="true"
{
	property abbreviationGateway;
	property validationService;


	/********** CONSTRUCTOR ***************************************************/


	function init()
	{
		setAbbreviationGateway( new dude.model.data.AbbreviationGateway() );

		return this;
	}


	/********** PUBLIC ********************************************************/


	function getAbbreviation( required string id )
	{
		return getAbbreviationGateway().getAbbreviation( id );
	}


	function getAbbreviationByText( required string text )
	{
		return getAbbreviationGateway().getAbbreviationByText( text );
	}


	function getDefinition( required string id )
	{
		return getAbbreviationGateway().getDefinition( id );
	}


	function listAbbreviation()
	{
		return getAbbreviationGateway().listAbbreviation();
	}


	function newAbbreviation()
	{
		return getAbbreviationGateway().newAbbreviation();
	}


	function newDefinition()
	{
		return getAbbreviationGateway().newDefinition();
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

			var result = getValidationService().validate( abbreviation );

			if ( result.getIsSuccess() )
			{
				getAbbreviationGateway().saveAbbreviation( abbreviation );
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

			var result = getValidationService().validate( definition );

			if ( result.getIsSuccess() )
			{
				getAbbreviationGateway().saveDefinition( definition );
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


	private function getAbbreviationGateway()
	{
		return variables.abbreviationGateway;
	}


	private function getValidationService()
	{
		return application.validationService;
	}


}