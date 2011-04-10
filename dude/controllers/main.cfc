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
		rc.title = 'Chat/IM/SMS/Texting Acronyms';
	}


	/********** PRIVATE *******************************************************/


}