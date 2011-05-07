component extends="framework"
{
	// CFML application configuration
	this.name = 'notintothewholebrevitything';
	this.datasource = 'notintothewholebrevitything';
	this.mappings[ '/dude' ] = expandPath( '/../dude' );
	this.mappings[ '/boisvert' ] = expandPath( '/../thirdparty/boisvert' );
	this.mappings[ '/coldspring' ] = expandPath( '/../thirdparty/coldspring' );
	this.mappings[ '/ValidateThis' ] = expandPath( '/../thirdparty/ValidateThis' );


	// hack in a development environment flag
	variables.isDev = ( cgi.server_name == 'localhost' ) ? true : false;


	// ORM configuration
	this.ormEnabled = true;
	this.ormSettings = {
		cfclocation = './../dude/model/beans',
		dbcreate = variables.isDev ? 'dropcreate' : 'none',
		dialect = 'MySQLwithInnoDB',
		flushatrequestend = false,
		eventhandling = true,
		sqlscript = '#expandPath( "/../data/init-data.sql" )#',
		logsql = variables.isDev
	};


	// Framework One configuration
	variables.framework = {
		// the URL variable to reload the controller/service cache:
		reload = 'reload_fw1_bizznizz',
		// the value of the reload variable that authorizes the reload:
		password = 'you_know_it',
		// debugging flag to force reload of cache on each request:
		reloadApplicationOnEveryRequest = variables.isDev,
		// location used to find layouts / views:
		base = '/dude',
		// whether FW/1 implicit service call should be suppressed:
		suppressImplicitService = true,
		//paths which shouldn't be handled by FW/1
		unhandledPaths = '/tests',
		// set this to true to cache the results of fileExists for performance:
		cacheFileExists = ( !variables.isDev )
	};


	function setupApplication()
	{
		var defaultProperties = {
			validateThisConfig_JSRoot = '/thirdparty/js/validatethis/',
			validateThisConfig_definitionPath = '/dude/model/beans/',
			validateThisConfig_defaultFailureMessagePrefix = ''
		};

		application.coldspring = createObject( 'component','coldspring.beans.DefaultXmlBeanFactory' ).init( defaultProperties = defaultProperties );

		application.coldspring.loadBeans( '/dude/config/beans.xml' );

		setBeanFactory( application.coldspring ); // set bean factory in framework
	}


}