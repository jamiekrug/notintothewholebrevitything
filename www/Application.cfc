component extends="framework"
{
	// CFML application configuration
	this.name = 'notintothewholebrevitything';
	this.datasource = 'notintothewholebrevitything';
	this.mappings[ '/dude' ] = expandPath( '/../dude' );


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
		//sqlscript = '#expandPath( "/../data/init-data.sql" )#',
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


}