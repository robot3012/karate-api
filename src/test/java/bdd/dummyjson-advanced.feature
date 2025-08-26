Feature: Pruebas avanzadas DummyJSON

Background:
    * def baseUrl = 'https://dummyjson.com'
    * def ProductUtils = Java.type('utils.ProductUtils')

@testP
Scenario: Loop y condicionales sobre productos con integración Java
    * def ids = [1,2,3]
    * def results = []
    * eval
    """
      karate.forEach(ids, function(x){
        var res = karate.get(baseUrl + '/products/' + x);
        if (res && res.response && res.status == 200 && res.response.price > 50) results.push(res.response.title);
      })
    """
    * print results
    * def processed = ProductUtils.processTitles(results)
    * print 'Procesados:', processed
    Then assert processed.length == results.length

Scenario: Manejo de error HTTP
    Given url baseUrl + '/products/99999'
    When method get
    Then status 404
    And match response.message contains 'Product not found'

Scenario: Prueba de performance básica
    * def start = karate.time()
    Given url baseUrl + '/products'
    When method get
    Then status 200
    * def end = karate.time()
    * print 'Duración:', end - start, 'ms'

  @mock
  Scenario: Simulación de servicio (Mocking)
    * def mockResponse = { id: 1, title: 'Mocked Product', price: 999 }
    Given url 'http://localhost:8080/products/1'
    When method get
    Then status 200
    And match mockResponse == { id: 1, title: 'Mocked Product', price: 999 }