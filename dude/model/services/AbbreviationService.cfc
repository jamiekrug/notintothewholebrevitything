component hint="AbbreviationService" extends="dude.model.orm.AbstractService" accessors="true"
{


	/********** CONSTRUCTOR ***************************************************/


	function init()
	{
		return super.init();
	}


	/********** PUBLIC ********************************************************/


	function isAbbreviationUnique( required abbreviation )
	{
		if ( isNull( abbreviation.getText() ) )
		{
			return false;
		}

		var existingAbbreviation = getGateway().getAbbreviationByText( abbreviation.getText() );

		if ( !isNull( existingAbbreviation ) && existingAbbreviation.getID() != abbreviation.getID() )
		{
			return false;
		}

		return true;
	}


	function saveAbbreviation( required struct properties )
	{
		transaction
		{
			if ( isNull( properties.id ) )
			{
				var abbreviation = getGateway().newAbbreviation();
			}
			else
			{
				var abbreviation = getGateway().getAbbreviation( properties.id, true );
			}

			var result = populateAndSaveEntity( abbreviation, properties );
		}

		return result;
	}


	function saveDefinition( required struct properties, string abbreviationID )
	{
		transaction
		{
			if ( isNull( properties.abbreviation ) && !isNull( arguments.abbreviationID ) )
			{
				properties.abbreviation = getGateway().getAbbreviation( abbreviationID, true );
			}

			if ( isNull( properties.id ) )
			{
				var definition = getGateway().newDefinition();
			}
			else
			{
				var definition = getGateway().getDefinition( properties.id, true );
			}

			var result = populateAndSaveEntity( definition, properties );
		}

		return result;
	}


	function saveDefinitionByText( required string abbreviationText, required string definitionText )
	{
		transaction
		{
			var abbreviation = getGateway().getAbbreviationByText( abbreviationText, true );

			abbreviation.populate( { text = abbreviationText } );

			var result = saveDefinition( { text = definitionText, abbreviation = abbreviation } );
		}

		return result;
	}


	/********** PRIVATE *******************************************************/


}