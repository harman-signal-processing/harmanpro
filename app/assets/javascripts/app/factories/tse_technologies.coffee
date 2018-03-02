angular.module("harmanpro")
  .factory 'TseTechnology', ['$resource', ($resource) ->
    $resource '/tse/technologies/:id.json?locale=:locale'
  ]


