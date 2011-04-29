component hint="Example FW/1 controller."
{

	/********** CONSTRUCTOR ***************************************************/

	function init( fw )
		hint="Constructor, passed in the FW/1 instance."
	{
		variables.fw = fw;

		return this;
	}


	/********** PUBLIC ********************************************************/


	function before( rc )
	{
		param name="rc.abbreviation_text" default='';
		param name='rc.definition_text' default='';
	}


	function define( rc )
		hint="Default action."
	{
		rc.abbreviation = variables.abbreviationService.getAbbreviationByText( rc.abbreviation_text );

		if ( isNull( rc.abbreviation ) )
		{
			variables.fw.redirect( action = 'abbreviation.undefined', append = 'abbreviation_text' );
		}

		rc.title = "Define #rc.abbreviation_text#";
	}


	function submit( rc )
	{
		var result = variables.abbreviationService.saveDefinitionByText( rc.abbreviation_text, rc.definition_text );

		if ( result.getIsSuccess() )
		{
			rc.successMessage =  "Definition added! (#result.getTheObject().getAbbreviation().getText()#: #result.getTheObject().getText()#)";

			variables.fw.redirect( action = 'abbreviation.define', append = 'abbreviation_text,successMessage' );
		}
		else
		{
			rc.failureMessage =  "Oops! There was a problem adding your abbreviation/definition...<br /><br />#result.getFailuresAsString()#";

			variables.fw.redirect( action = 'abbreviation.new', append = 'abbreviation_text,failureMessage' );
		}
	}


	/********** PRIVATE *******************************************************/


	/********** BEANS (DI) ****************************************************/

	function setAbbreviationService( abbreviationService )
	{
		variables.abbreviationService = arguments.abbreviationService;
	}

}