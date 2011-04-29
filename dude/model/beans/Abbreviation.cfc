component hint="Abbreviation" persistent="true"
{
	property name="id" fieldtype="id" generator="assigned" ormtype="string" length="32" notnull="true";

	property name="created" ormtype="timestamp";

	property name="lastModified" ormtype="timestamp";

	property name="text" ormtype="string" length="10" notnull="true" unique="true";

	property name="definitions" singularname="definition" fieldtype="one-to-many" cfc="Definition" fkcolumn="abbreviationID" orderby="created ASC" inverse="true" cascade="all-delete-orphan";


	/********** CONSTRUCTOR ***************************************************/


	function init()
	{
		variables.definitions = [];

		if ( isNull( getID() ) )
		{
			setID( getNewID() );
		}

		return this;
	}


	/********** PUBLIC ********************************************************/


	function addDefinition( definition )
	{
		arguments.definition.setAbbreviation( this );
	}


	function isUnique()
	{
		return application.coldspring.getBean( 'abbreviationService' ).isAbbreviationUnique( this );
	}


	function populate( required struct properties )
	{
		if ( !isNull( properties.text ) )
		{
			setText( properties.text );
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


	function setText( required string text )
	{
		variables.text = uCase( text );
	}


	/********** PRIVATE *******************************************************/


	private function getNewID()
	{
		return replace( createUUID(), '-', '', 'all' );
	}


}