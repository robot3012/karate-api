Feature: plan de pruebas

  Scenario: caso de prueba tipo GET
    Given url 'https://reqres.in/api/users/2'
    When header 'Content-Type'='Application/json'
    * configure connectTimeout = 120000
    * configure readTimeout = 120000
    When method GET
    And match response.data.id == 2
    Then status 200

  Scenario: caso de prueba tipo post
    Given url 'https://reqres.in/api/users'
    When request {"name": "morpheus", "job": "leader"}
    And method POST
    Then status 201

  Scenario: caso de prueba de tipo PUT
    Given url 'https://reqres.in/api/users/2'
    When request
    """
    {
        "name": "morpheus",
        "job": "zion resident"
    }
    """
    And method PUT
    Then status 200

  Scenario: caso de prueba tipo DELETE
    Given url 'https://reqres.in/api/users/2'
    When method DELETE
    Then status 204
