component extends="tests.unit.BaseTestCase"
{


	/********** PUBLIC ********************************************************/


	function addDefinition_Should_HandleBiDirectionalRelationship()
	{
		var definition = entityNew( 'Definition' );

		var abbreviation = entityNew( 'Abbreviation' );
		abbreviation.addDefinition( definition );

		assertSame( abbreviation, definition.getAbbreviation() );

		assertSame( definition, abbreviation.getDefinitions()[ 1 ] );
	}


	function validation_Valid()
	{
		var definition = entityNew( 'Definition' );
		definition.setText( 'TEST definition' );

		var abbreviation = entityNew( 'Abbreviation' );
		abbreviation.setText( 'TEST' );
		abbreviation.addDefinition( definition );

		var result = getBeanFactory().getBean( 'validationService' ).validate( abbreviation );

		assertTrue( result.getIsSuccess(), "Validation success should be true." );
	}


	function validation_Fail_onDefinitionsEmpty()
	{
		var abbreviation = entityNew( 'Abbreviation' );
		abbreviation.setText( 'TEST' );

		var result = getBeanFactory().getBean( 'validationService' ).validate( abbreviation );

		assertFalse( result.getIsSuccess(), "Validation success should be false." );

		var failures = result.getFailures();

		assertTrue( arrayLen( failures) == 1, "There should be only one validation failure." );

		assertEquals( 'definitions', failures[ 1 ].propertyName, "The failure property name should be 'definitions'." );
	}


	function validation_Fail_onTextAboveRange()
	{
		var definition = entityNew( 'Definition' );
		definition.setText( 'TEST definition' );

		var abbreviation = entityNew( 'Abbreviation' );
		abbreviation.setText( repeatString( 'X', 11 ) );
		abbreviation.addDefinition( definition );

		var result = getBeanFactory().getBean( 'validationService' ).validate( abbreviation );

		assertFalse( result.getIsSuccess(), "Validation success should be false." );

		var failures = result.getFailures();

		assertTrue( arrayLen( failures) == 1, "There should be only one validation failure." );

		assertEquals( 'text', failures[ 1 ].propertyName, "The failure property name should be 'text'." );
	}


	function validation_Fail_onTextBelowRange()
	{
		var definition = entityNew( 'Definition' );
		definition.setText( 'TEST definition' );

		var abbreviation = entityNew( 'Abbreviation' );
		abbreviation.setText( 'X' );
		abbreviation.addDefinition( definition );

		var result = getBeanFactory().getBean( 'validationService' ).validate( abbreviation );

		assertFalse( result.getIsSuccess(), "Validation success should be false." );

		var failures = result.getFailures();

		assertTrue( arrayLen( failures) == 1, "There should be only one validation failure." );

		assertEquals( 'text', failures[ 1 ].propertyName, "The failure property name should be 'text'." );
	}


	function validation_Fail_onTextMissing()
	{
		var definition = entityNew( 'Definition' );
		definition.setText( 'TEST definition' );

		var abbreviation = entityNew( 'Abbreviation' );
		abbreviation.addDefinition( definition );

		var result = getBeanFactory().getBean( 'validationService' ).validate( abbreviation );

		assertFalse( result.getIsSuccess(), "Validation success should be false." );

		var failures = result.getFailures();

		for ( var failure in failures )
		{
			assertEquals( 'text', failure.propertyName, "Each failure property name should be 'text'." );
		}
	}


	/********** PRIVATE *******************************************************/


}