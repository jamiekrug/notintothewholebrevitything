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


	function default( rc )
		hint="Default action."
	{
		param name="rc.abbreviation_text" default='';
		param name='rc.definition_text' default='';

		rc.title = 'Chat/IM/SMS/Texting Acronyms';

		rc.abbreviations = application.abbreviationService.listAbbreviation();
	}


	/********** PRIVATE *******************************************************/


}