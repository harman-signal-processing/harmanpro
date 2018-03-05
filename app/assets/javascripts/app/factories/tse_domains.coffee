angular.module("harmanpro")
  .factory 'TseDomain', ['$resource', ($resource) ->
    $resource '/tse/domains/:id.json?locale=:locale'
  ]



