angular.module("harmanpro")
  .factory 'TseRegion', ['$resource', ($resource) ->
    $resource '/tse/regions/:id.json?locale=:locale'
  ]


