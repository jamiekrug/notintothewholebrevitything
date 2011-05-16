component extends="mxunit.framework.TestCase"
{


	/********** PUBLIC ********************************************************/


	/*
	 * Invoked by MXUnit prior to any test methods and run once per TestCase.
	 * Override in your testcase.
	 */
	function beforeTests()
	{
		// override as needed
	}


	/*
	 * Invoked by MXUnit after all test methods and run once per TestCase.
	 * Override in your testcase.
	 */
	function afterTests()
	{
		// override as needed
	}


	/*
	 * Invoked by MXUnit prior to each test method.
	 * Override in your testcase.
	 */
	function setup()
	{
		// override as needed
	}


	/*
	 * Invoked by MXUnit after each test method.
	 * Override in your testcase.
	 */
	function teardown()
	{
		// override as needed
	}


	/********** PRIVATE *******************************************************/


	private function getBeanFactory( isReload = false )
	{
		return application.coldspring;
	}


}