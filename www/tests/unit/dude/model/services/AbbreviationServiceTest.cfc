import dude.model.services.AbbreviationService;

component extends="tests.unit.BaseTestCase"
{


	/********** PUBLIC ********************************************************/


	function beforeTests()
	{
		variables.abbreviationService = new AbbreviationService();
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


	/********** PRIVATE *******************************************************/


}