component mappedsuperclass="true"
{
	property name="id" fieldtype="id" generator="assigned" ormtype="string" length="32" notnull="true";

	property name="created" ormtype="timestamp";

	property name="lastModified" ormtype="timestamp";


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


	function preInsert()
	{
		setCreated( now() );
		setLastModified( now() );
	}


	function preUpdate()
	{
		setLastModified( now() );
	}


	/********** PRIVATE *******************************************************/


	private function getNewID()
	{
		return replace( createUUID(), '-', '', 'all' );
	}


}