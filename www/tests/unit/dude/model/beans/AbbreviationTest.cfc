component extends="tests.unit.BaseTestCase"
{


	/********** PUBLIC ********************************************************/


	function addDefinition_Should_HandleBiDirectionalRelationship()
	{
		var abbreviation = entityNew( 'Abbreviation' );
		var definition = entityNew( 'Definition' );

		abbreviation.addDefinition( definition );

		assertSame( abbreviation, definition.getAbbreviation() );
		assertSame( definition, abbreviation.getDefinitions()[ 1 ] );
	}


	/********** PRIVATE *******************************************************/


}