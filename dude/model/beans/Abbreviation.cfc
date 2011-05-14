component hint="Abbreviation" extends="dude.model.orm.AbstractPersistentEntity" persistent="true"
{
	property name="text" ormtype="string" length="10" notnull="true" unique="true";

	property name="definitions" singularname="definition" fieldtype="one-to-many" cfc="Definition" fkcolumn="abbreviationID" orderby="created ASC" inverse="true" cascade="all-delete-orphan";

	property name="abbreviationService" persistent="false";


	/********** CONSTRUCTOR ***************************************************/


	function init()
	{
		super.init();

		variables.definitions = [];

		setAbbreviationService( application.coldspring.getBean( 'abbreviationService' ) );

		return this;
	}


	/********** PUBLIC ********************************************************/


	function addDefinition( definition )
	{
		arguments.definition.setAbbreviation( this );
	}


	function isUnique()
	{
		return getAbbreviationService().isAbbreviationUnique( this );
	}


	function populate( required struct properties )
	{
		if ( !isNull( properties.text ) )
		{
			setText( properties.text );
		}
	}


	function setText( required string text )
	{
		variables.text = uCase( text );
	}


	/********** PRIVATE *******************************************************/


}