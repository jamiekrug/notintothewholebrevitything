component extends="tests.unit.BaseTestCase"
{


	/********** PUBLIC ********************************************************/


	function setAbbreviation_Should_HandleBiDirectionalRelationship()
	{
		var definition = entityNew( 'Definition' );
		var abbreviation = entityNew( 'Abbreviation' );

		definition.setAbbreviation( abbreviation );

		assertSame( abbreviation, definition.getAbbreviation() );
		assertSame( definition, abbreviation.getDefinitions()[ 1 ] );
	}


	/********** PRIVATE *******************************************************/


}