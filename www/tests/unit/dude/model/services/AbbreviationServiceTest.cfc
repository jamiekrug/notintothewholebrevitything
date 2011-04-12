import dude.model.services.AbbreviationService;

component extends="tests.unit.BaseTestCase"
{


	/********** PUBLIC ********************************************************/


	function beforeTests()
	{
		variables.abbreviationService = new AbbreviationService();
	}


	function TODO()
	{
		fail( 'NOT YET IMPLEMENTED!' );
	}


	/********** PRIVATE *******************************************************/


}