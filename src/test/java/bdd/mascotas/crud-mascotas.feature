
@todo 
Feature:CRUD API Mascotas


  Background: Configuración inicial
    Given url BaseUrl
    * def requests = read('classpath:requests/request-pet.json')

  @AddPet 
  Scenario: Agregar una nueve mascota
    Given path '/v2/pet'
    And header Content-Type = 'application/json'
    And request
    """
    {
      "id": 0,
      "category": {
        "id": 0,
        "name": "string"
      },
      "name": "doggie",
      "photoUrls": [
        "string"
      ],
      "tags": [
        {
          "id": 0,
          "name": "perro"
        }
      ],
      "status": "available"
    }
    """
    When method post
    Then status 200
    * print 'Mascota agregada: ',response
    * print 'ID de la mascota: ', response.id
    And match $.id == '#number'

  @UpdatePet @ignore
  Scenario Outline: Actualizar la mascota agregada
      Given path '/v2/pet'
      And header Content-Type = 'application/json'
      And request requests.updatePet
      When method put
      Then status 200
      And print 'Mascota actualizada: ', response
      * def petId = response.id
      Examples:
        |name|
        | 'JACK' |

  @getPet
  Scenario: Consultar las mascotas
    # Para ejecutar este escenario, primero debes ejecutar el escenario de actualización de mascota
    * call read('classpath:bdd/mascotas/crud-mascotas.feature@UpdatePet')
    * print 'ID de la mascota: ', petId
    Given path '/v2/pet', petId
    And header Content-Type = 'application/json'
    When method get
    Then status 200

    @get_token
    Scenario: obtener Tokden
      Given url 'https://bensg.com/test-qalab/login/token.php'
      And header Content-Type = 'application/json'
      And param username = 'st30001'
      And param password = 'Password2!'
      And param service = 'moodle_mobile_app'
      When method get
      Then status 200
      * def token = response.token

      Given url 'https://bensg.com/test-qalab/webservice/rest/server.php'
      And param wstoken = token
      And param moodlewsrestformat = 'json'
      And param wsfunction = 'core_calendar_create_calendar_events'
      And form field events[0][name] = 'Evento de prueba'
      And form field events[0][description] = 'Este es un evento de prueba'
      And form field events[0][format] = 1
      And form field events[0][courseid] = 0
      And form field events[0][groupid] = 0
      And form field events[0][repeats] = 0
      And form field events[0][eventtype] = 'user'
      And form field events[0][timestart] = 1755698400
      And form field events[0][timeduration] = 0
      And form field events[0][visible] = 1
      And form field events[0][sequence] = 1

      When method post
      Then status 200
      * print 'Respuesta eventos:', response


