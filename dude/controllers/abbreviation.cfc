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
		rc.abbreviation = application.abbreviationService.getAbbreviationByText( rc.abbreviation_text );

		if ( isNull( rc.abbreviation ) )
		{
			variables.fw.redirect( action = 'abbreviation.undefined', append = 'abbreviation_text' );
		}

		rc.title = "Define #rc.abbreviation_text#";
	}


	function submit( rc )
	{
		var abbreviation = application.abbreviationService.saveAbbreviationAndDefinitionByText( rc.abbreviation_text, rc.definition_text );

		rc.successMessage =  "#abbreviation.getText()# definition added!";

		variables.fw.redirect( action = 'abbreviation.define', append = 'abbreviation_text,successMessage' );
	}


	/********** PRIVATE *******************************************************/


}