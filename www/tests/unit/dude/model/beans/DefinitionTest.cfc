component extends="tests.unit.AbstractTestCase"
{


	/********** PUBLIC ********************************************************/


	function isUnique_Should_BeTrue_ForSingleDefinition()
	{
		var abbreviation = entityNew( 'Abbreviation' );
		abbreviation.setText( 'TEST' );

		var definition = entityNew( 'Definition' );
		definition.setText( 'Test definition' );
		definition.setAbbreviation( abbreviation );

		assertTrue( definition.isUnique() );
	}


	function isUnique_Should_BeFalse_ForDuplicate()
	{
		var abbreviation = entityNew( 'Abbreviation' );
		abbreviation.setText( 'TEST' );

		var definition = entityNew( 'Definition' );
		definition.setText( 'Test definition' );
		definition.setAbbreviation( abbreviation );

		var definition2 = entityNew( 'Definition' );
		definition2.setText( 'Test definition' );
		definition2.setAbbreviation( abbreviation );

		assertFalse( definition2.isUnique() );
	}


	function setAbbreviation_Should_HandleBiDirectionalRelationship()
	{
		var definition = entityNew( 'Definition' );
		var abbreviation = entityNew( 'Abbreviation' );

		definition.setAbbreviation( abbreviation );

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

		var result = getBeanFactory().getBean( 'validationService' ).validate( definition );

		assertTrue( result.getIsSuccess(), "Validation success should be true." );
	}


	function validation_Fail_onAbbreviationMissing()
	{
		var definition = entityNew( 'Definition' );
		definition.setText( 'TEST definition' );

		var result = getBeanFactory().getBean( 'validationService' ).validate( definition );

		assertFalse( result.getIsSuccess(), "Validation success should be false." );

		var hasAbbreviationRequiredFailure = false;

		for ( failure in result.getFailures() )
		{
			if ( failure.propertyName == 'abbreviation' && failure.type == 'required' )
			{
				hasAbbreviationRequiredFailure = true;
			}
		}

		assertTrue( hasAbbreviationRequiredFailure, "There should be a failure with property name 'abbreviation' and type 'required'." );
	}



	function validation_Fail_onTextAboveRange()
	{
		var definition = entityNew( 'Definition' );
		definition.setText( repeatString( 'X', 101 ) );

		var abbreviation = entityNew( 'Abbreviation' );
		abbreviation.setText( 'TEST' );
		abbreviation.addDefinition( definition );

		var result = getBeanFactory().getBean( 'validationService' ).validate( definition );

		assertFalse( result.getIsSuccess(), "Validation success should be false." );

		var failures = result.getFailures();

		assertTrue( arrayLen( failures) == 1, "There should be only one validation failure." );

		assertEquals( 'text', failures[ 1 ].propertyName, "The failure property name should be 'text'." );
	}


	function validation_Fail_onTextBelowRange()
	{
		var definition = entityNew( 'Definition' );
		definition.setText( 'X' );

		var abbreviation = entityNew( 'Abbreviation' );
		abbreviation.setText( 'TEST' );
		abbreviation.addDefinition( definition );

		var result = getBeanFactory().getBean( 'validationService' ).validate( definition );

		assertFalse( result.getIsSuccess(), "Validation success should be false." );

		var failures = result.getFailures();

		assertTrue( arrayLen( failures) == 1, "There should be only one validation failure." );

		assertEquals( 'text', failures[ 1 ].propertyName, "The failure property name should be 'text'." );
	}


	function validation_Fail_onTextMissing()
	{
		var definition = entityNew( 'Definition' );

		var abbreviation = entityNew( 'Abbreviation' );
		abbreviation.setText( 'TEST' );
		abbreviation.addDefinition( definition );

		var result = getBeanFactory().getBean( 'validationService' ).validate( definition );

		assertFalse( result.getIsSuccess(), "Validation success should be false." );

		var failures = result.getFailures();

		for ( var failure in failures )
		{
			assertEquals( 'text', failure.propertyName, "Each failure property name should be 'text'." );
		}
	}


	/********** PRIVATE *******************************************************/


}