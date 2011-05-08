component extends="dude.model.orm.AbstractPersistentEntity" persistent="true"
{
	property foo;


	/********** CONSTRUCTOR ***************************************************/


	function init()
	{
		super.init();

		return this;
	}


	/********** PUBLIC ********************************************************/


	function populate( required struct properties )
	{
		if ( structKeyExists( properties, 'foo' ) )
		{
			setFoo( properties.foo );
		}
	}


	/********** PRIVATE *******************************************************/


}