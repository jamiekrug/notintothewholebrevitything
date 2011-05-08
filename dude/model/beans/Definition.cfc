component hint="Definition" extends="dude.model.orm.AbstractPersistentEntity" persistent="true"
{
	property name="text" ormtype="string" length="100" notnull="true";

	property name="abbreviation" fieldtype="many-to-one" fkcolumn="abbreviationID" cfc="Abbreviation" notnull="true" cascade="save-update";


	/********** CONSTRUCTOR ***************************************************/


	function init()
	{
		super.init();

		return this;
	}


	/********** PUBLIC ********************************************************/


	function isUnique()
	{
		if ( isNull( getAbbreviation() ) )
		{
			return false;
		}

		for ( var definition in getAbbreviation().getDefinitions() )
		{
			if ( definition.getText() == this.getText() && definition.getID() != this.getID() )
			{
				return false;
			}
		}

		return true;
	}


	function populate( required struct properties )
	{
		if ( !isNull( properties.text ) )
		{
			setText( properties.text );
		}

		if ( !isNull( properties.abbreviation ) )
		{
			setAbbreviation( properties.abbreviation );
		}
	}


	function setAbbreviation( abbreviation )
	{
		if ( !isNull( arguments.abbreviation ) )
		{
			variables.abbreviation = arguments.abbreviation;

			if ( !arguments.abbreviation.hasDefinition( this ) )
			{
				arrayAppend( arguments.abbreviation.getDefinitions(), this );
			}
		}
	}


	/********** PRIVATE *******************************************************/


}