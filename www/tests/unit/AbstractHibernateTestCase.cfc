component extends="tests.unit.AbstractTestCase" hint="Automatically roll back all Hibernate ORM activity in test cases that extend this."
{


	/********** SETUP/TEARDOWN TESTS ************************************************************/


	function setup()
	{
		super.setup();

		ormClearSession();

		ormGetSession().beginTransaction();
	}


	function tearDown()
	{
		super.tearDown();

		if( ormGetSession().getTransaction().isActive() )
		{
			ormGetSession().getTransaction().rollback();

			ormClearSession();
		}
	}


}