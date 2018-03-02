angular.module("harmanpro")
  .factory 'TseContact', ['$resource', ($resource) ->
    $resource '/tse/contacts/:id.json?locale=:locale'
  ]

