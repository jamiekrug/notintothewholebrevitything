<cfscript>
	testSuite = new mxunit.framework.TestSuite().TestSuite();
	testSuite.addAll( 'tests.unit.dude.model.beans.AbbreviationTest' );
	testSuite.addAll( 'tests.unit.dude.model.beans.DefinitionTest' );
	testSuite.addAll( 'tests.unit.dude.model.services.AbbreviationServiceTest' );
	results = testSuite.run();
	writeOutput( results.getResultsOutput( 'html' ) );
</cfscript>
