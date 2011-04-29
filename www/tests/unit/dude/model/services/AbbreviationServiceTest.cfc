component extends="tests.unit.BaseTestCase"
{


	/********** PUBLIC ********************************************************/


	function beforeTests()
	{
		variables.abbreviationService = getBeanFactory().getBean( 'abbreviationService' );
	}


	function isAbbreviationUnique_Should_BeTrueForFirst()
	{
		var abbreviation = entityNew( 'Abbreviation' );

		abbreviation.setText( 'TEST' );

		assertTrue( variables.abbreviationService.isAbbreviationUnique( abbreviation ) );
	}


	function isAbbreviationUnique_Should_BeFalseForDuplicate()
	{
		try
		{
			var definition = variables.abbreviationService.saveDefinitionByText( 'TEST', 'TEST definition' ).getTheObject();

			assertTrue( variables.abbreviationService.isAbbreviationUnique( definition.getAbbreviation() ) );

			var abbreviation2 = entityNew( 'Abbreviation' );

			abbreviation2.setText( 'TEST' );

			assertFalse( variables.abbreviationService.isAbbreviationUnique( abbreviation2 ) );
		}
		finally
		{
			entityDelete( definition.getAbbreviation() );
			ormFlush();
			ormClearSession();
		}
	}


	function saveAbbreviation_Should_Update()
	{
		try
		{
			var createDefinitionResult = variables.abbreviationService.saveDefinitionByText( 'TEST', 'TEST definition' );

			assertTrue( createDefinitionResult.getIsSuccess(), "Guard: initial create result should be successful." );

			var abbreviation = createDefinitionResult.getTheObject().getAbbreviation();

			var updateResult = variables.abbreviationService.saveAbbreviation( { id = abbreviation.getID(), text = 'TESTCHG' } );

			var updatedAbbreviation = updateResult.getTheObject();

			assertTrue( updateResult.getIsSuccess(), "Save result for updated abbreviation should be successful." );

			assertEquals( abbreviation.getID(), updatedAbbreviation.getID(), "Updated abbreviation should have same ID as original." );
		}
		finally
		{
			entityDelete( updatedAbbreviation );
			ormFlush();
			ormClearSession();
		}
	}


	function saveDefinition_Should_addDefinition()
	{
		try
		{
			var createResult = variables.abbreviationService.saveDefinitionByText( 'TEST', 'TEST definition' );

			assertTrue( createResult.getIsSuccess(), "Guard: initial create result should be successful." );

			var definition1 = createResult.getTheObject();

			var abbreviation = definition1.getAbbreviation();

			var addDefinitionResult = variables.abbreviationService.saveDefinition( { text = 'TEST definition 2' }, abbreviation.getID() );

			assertTrue( addDefinitionResult.getIsSuccess(), "Save result for second definition should be successful." );

			var definition2 = addDefinitionResult.getTheObject();

			assertTrue( abbreviation.hasDefinition( definition2 ), "Abbreviation should have second definition." );
		}
		finally
		{
			entityDelete( abbreviation );
			ormFlush();
			ormClearSession();
		}
	}


	function saveDefinitionByText_Success()
	{
		try
		{
			var result = variables.abbreviationService.saveDefinitionByText( 'TEST', 'TEST definition' );

			assertTrue( result.getIsSuccess(), "Save result should be successful." );
		}
		finally
		{
			entityDelete( result.getTheObject().getAbbreviation() );
			ormFlush();
			ormClearSession();
		}
	}


	/********** PRIVATE *******************************************************/


}