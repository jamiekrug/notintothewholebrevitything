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
		if ( isNull( properties.id ) )
		{
			var abbreviation = getGateway().newAbbreviation();
		}
		else
		{
			var abbreviation = getGateway().getAbbreviation( properties.id, true );
		}

		return populateAndSaveEntity( abbreviation, properties );
	}


	function saveDefinition( required struct properties, string abbreviationID )
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

		return populateAndSaveEntity( definition, properties );
	}


	function saveDefinitionByText( required string abbreviationText, required string definitionText )
	{
		var abbreviation = getGateway().getAbbreviationByText( abbreviationText, true );

		abbreviation.populate( { text = abbreviationText } );

		return saveDefinition( { text = definitionText, abbreviation = abbreviation } );
	}


	/********** PRIVATE *******************************************************/


}