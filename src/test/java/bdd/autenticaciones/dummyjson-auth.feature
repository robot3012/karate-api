@test1
Feature: Obtener token


  Background: Login y guardar token
    Given url 'https://dummyjson.com/auth/login'
    * header Content-Type = 'application/json'
    And request { username: 'emilys', password: 'emilyspass', expiresInMins: 60 }
    When method post
    Then status 200
    And print 'Token obtenido: ', response
    * def accessToken = response.accessToken
    * def refreshToken = response.refreshToken

  Scenario: Obtener usuario autorizado actual
    Given url 'https://dummyjson.com/auth/me'
    And header Authorization = 'Bearer ' + accessToken
    When method get
    Then status 200
    And match response.username == 'emilys'

  Scenario: Refrescar el token y validar acceso
    Given url 'https://dummyjson.com/auth/refresh'
    * header Content-Type = 'application/json'
    And request { refreshToken: refreshToken, expiresInMins: 30 }
    When method post
    Then status 200
    * def newAccessToken = response.accessToken

    Given url 'https://dummyjson.com/auth/me'
    And header Authorization = 'Bearer ' + newAccessToken
    When method get
    Then status 200
    And match response.username == 'emilys'