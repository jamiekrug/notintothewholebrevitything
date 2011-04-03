component extends="framework"
{
	this.name = 'notintothewholebrevitything';

	this.mappings[ '/dude' ] = expandPath( '/../dude' );

	variables.isDev = ( cgi.server_name == 'localhost' ) ? true : false;

	// Framework One configuration
	variables.framework = {
		// the name of the URL variable:
		action = 'action',
		// whether or not to use subsystems:
		usingSubsystems = false,
		// default section name:
		defaultSection = 'main',
		// default item name:
		defaultItem = 'default',
		// the URL variable to reload the controller/service cache:
		reload = 'reload',
		// the value of the reload variable that authorizes the reload:
		password = 'true',
		// debugging flag to force reload of cache on each request:
		reloadApplicationOnEveryRequest = variables.isDev,
		// location used to find layouts / views:
		base = '/dude',
		// whether FW/1 implicit service call should be suppressed:
		suppressImplicitService = true,
		// list of file extensions that FW/1 should not handle:
		unhandledExtensions = 'cfc',
		// list of (partial) paths that FW/1 should not handle:
		unhandledPaths = '/flex2gateway,/tests',
		// flash scope magic key and how many concurrent requests are supported:
		preserveKeyURLKey = 'fw1pk',
		maxNumContextsPreserved = 10,
		// set this to true to cache the results of fileExists for performance:
		cacheFileExists = ( !variables.isDev ),
		// change this if you need multiple FW/1 applications in a single CFML application:
		applicationKey = 'org.corfield.framework'
	};

}