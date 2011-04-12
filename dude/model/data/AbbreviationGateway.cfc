component
{

	/********** CONSTRUCTOR ***************************************************/

	function init()
	{
		return this;
	}


	/********** PUBLIC ********************************************************/


	function getAbbreviation( required string id )
	{
		return entityLoadByPK( 'Abbreviation', id );
	}


	function getAbbreviationByText( required string text )
	{
		return entityLoad( 'Abbreviation', { text = text }, true );
	}


	function getDefinition( required string id )
	{
		return entityLoadByPK( 'Definition', id );
	}


	function newAbbreviation()
	{
		return entityNew( 'Abbreviation' );
	}


	function newDefinition()
	{
		return entityNew( 'Definition' );
	}


	function saveAbbreviation( required abbreviation )
	{
		entitySave( abbreviation );
	}


	function saveDefinition( required definition )
	{
		entitySave( definition );
	}


	/********** PRIVATE *******************************************************/


}