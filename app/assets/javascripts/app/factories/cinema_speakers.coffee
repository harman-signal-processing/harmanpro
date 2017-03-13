angular.module("harmanpro")
  .factory 'CinemaSpeaker', ['$resource', ($resource) ->
    $resource('/cinema/calculator/speakers/:id.json?locale=:locale')
  ]

