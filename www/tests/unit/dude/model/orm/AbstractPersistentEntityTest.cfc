component extends="tests.unit.AbstractHibernateTestCase"
{


	/********** PUBLIC ************************************************************/


	function init_Should_SetID()
	{
		var entity = createObject( 'component', 'dude.model.beans.TestPersistentEntity' );

		assertTrue( isNull( entity.getID() ), "Guard: ID should be null prior to init." );

		entity.init();

		assertFalse( isNull( entity.getID() ), "ID should not be null after init." );

		assert( len( entity.getID() ) == 32, "ID should have a length of 32 after init." );
	}


	function insert_Should_SetCreatedAndLastModified()
	{
		var entity = entityNew( 'TestPersistentEntity' );

		assertTrue( isNull( entity.getCreated() ), "Guard: TestPersistentEntity.created should be null prior to saving new entity." );

		assertTrue( isNull( entity.getLastModified() ), "Guard: TestPersistentEntity.lastModified should be null prior to saving new entity." );

		entity.setFoo( 'bar' );

		entitySave( entity );

		assertFalse( isNull( entity.getCreated() ), "TestPersistentEntity.created should not be null after saving new entity." );

		assertFalse( isNull( entity.getLastModified() ), "TestPersistentEntity.lastModified should not be null after saving new entity." );
	}


	function update_Should_SetLastModified()
	{
		var entity = entityNew( 'TestPersistentEntity' );

		entity.setFoo( 'bar' );

		entitySave( entity );
		ormFlush();

		var lastModifiedAtInsert = entity.getLastModified();

		assertFalse( isNull( lastModifiedAtInsert ), "TestPersistentEntity.lastModified should not be null after saving new entity." );

		sleep( 1100 );

		var id = entity.getID();

		entity = entityLoadByPK( 'TestPersistentEntity', id );

		entity.setFoo( 'bar2' );

		entitySave( entity );
		ormFlush();

		assertNotEquals( lastModifiedAtInsert, entity.getLastModified(), "TestPersistentEntity.lastModified should change after an updated entity save." );
	}


	/********** PRIVATE ************************************************************/


}