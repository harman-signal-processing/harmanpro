angular.module("harmanpro")
  .factory 'NewProduct', ['$resource', ($resource) ->
    $resource('/new_products/:id.json?locale=:locale')
  ]
