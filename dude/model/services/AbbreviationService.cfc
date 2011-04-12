component hint="AbbreviationService" accessors="true"
{
	property abbreviationGateway;


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


	function newAbbreviation()
	{
		return getAbbreviationGateway().newAbbreviation();
	}


	function newDefinition()
	{
		return getAbbreviationGateway().newDefinition();
	}


	function saveAbbreviationAndDefinitionByText( required string abbreviationText, required string definitionText )
	{
		transaction
		{
			var abbreviation = getAbbreviationByText( abbreviationText );

			if ( isNull( abbreviation ) )
			{
				var abbreviation = newAbbreviation();

				abbreviation.populate( { text = abbreviationText } );
			}

			var definition = saveDefinition( { text = definitionText, abbreviation = abbreviation } );
		}

		return abbreviation;
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

			// TODO: validate

			getAbbreviationGateway().saveAbbreviation( abbreviation );
		}

		return abbreviation;
	}


	function saveDefinition( required struct properties, string abbreviationID )
	{
		transaction
		{
			if ( isNull( properties.abbreviation ) )
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

			// TODO: validate

			getAbbreviationGateway().saveDefinition( definition );
		}

		return definition;
	}


	/********** PRIVATE *******************************************************/


	private function getAbbreviationGateway()
	{
		return variables.abbreviationGateway;
	}


}