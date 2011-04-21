component hint="Definition" persistent="true"
{
	property name="id" fieldtype="id" generator="assigned" ormtype="string" length="32" notnull="true";

	property name="created" ormtype="timestamp" notnull="true";

	property name="lastModified" ormtype="timestamp" notnull="true";

	property name="text" ormtype="string" length="100" notnull="true";

	property name="abbreviation" fieldtype="many-to-one" fkcolumn="abbreviationID" cfc="Abbreviation" notnull="true" cascade="save-update";


	/********** CONSTRUCTOR ***************************************************/


	function init()
	{
		if ( isNull( getID() ) )
		{
			setID( getNewID() );
		}

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


	function preInsert()
	{
		setCreated( now() );
		setLastModified( now() );
	}


	function preUpdate()
	{
		setLastModified( now() );
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


	private function getNewID()
	{
		return replace( createUUID(), '-', '', 'all' );
	}


}