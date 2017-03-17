angular.module("harmanpro")
  .factory 'Product', ['$resource', ($resource) ->
    $resource('/products/:id.json?locale=:locale')
  ]
