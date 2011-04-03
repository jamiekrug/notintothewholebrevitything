component hint="Example FW/1 controller."
{

	/********** CONSTRUCTOR ***************************************************/

	function init()
		hint="Constructor, passed in the FW/1 instance."
	{
		return this;
	}


	/********** PUBLIC ********************************************************/


	function default( rc )
		hint="Default action."
	{
		rc.when = dateFormat( now() ) & ' ' & timeFormat( now() );
	}


	/********** PRIVATE *******************************************************/


}