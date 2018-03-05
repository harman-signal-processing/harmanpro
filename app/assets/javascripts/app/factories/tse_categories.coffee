angular.module("harmanpro")
  .factory 'TseCategory', ['$resource', ($resource) ->
    $resource '/tse/categories/:id.json?locale=:locale'
  ]

