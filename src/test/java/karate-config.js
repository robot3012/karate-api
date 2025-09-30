function fn() {
  karate.configure('ssl', true); // enable
  var BaseUrl = 'https://petstore.swagger.io/'
  var baseUrlAut =''
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }

  if (env == 'dev') {
    baseUrlAut = 'https://dummyjson.com'
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  }

   var config = {
      env: env,
      BaseUrl: BaseUrl,
      myVarName: 'someValue',
      baseUrlAut:baseUrlAut

   }
  return config;
}