angular.module("harmanpro")
  .controller 'NewProductsCtrl',
    ['$attrs', '$scope', '$filter', '$sce', 'NewProduct', ($attrs, $scope, $filter, $sce, NewProduct) ->

      $scope.no_results = ""

      NewProduct.get {
        locale: $attrs.locale
      }, (data) ->
        $scope.new_products = $filter('orderBy')(data.new_products, 'sortkey', true)

      $scope.includeProduct = (product) ->
        brand_filter = true
        year_filter = true
        product_type_filter = true
        $scope.no_results = "Sorry, there were no matching results."

        if $scope.selectedBrands
          selected_brand_list = []
          for k,v of $scope.selectedBrands
            selected_brand_list.push k if v
          if selected_brand_list.length > 0
            brand_filter = false
            for b in selected_brand_list
              brand_filter = product.brands.includes(b) unless brand_filter == true

        if $scope.selectedYears
          selected_years_list = []
          for k,v of $scope.selectedYears
            selected_years_list.push k if v
          if selected_years_list.length > 0
            year_filter = false
            for y in selected_years_list
              year_filter = (y == "y#{product.year}") unless year_filter == true

        if $scope.selectedProductTypes
          selected_product_type_list = []
          for k,v of $scope.selectedProductTypes
            #k.slice(3) is used to remove the zzz that was prepended to make angular happy because it does not want model ids that begin with numbers
            selected_product_type_list.push k.slice(3) if v
          if selected_product_type_list.length > 0
            product_type_filter = false
            for pt in selected_product_type_list
              product_type_filter = product.product_types.includes(pt) unless product_type_filter == true

        return(brand_filter && year_filter && product_type_filter)

      $scope.getHtml = (html) ->
        $sce.trustAsHtml html

      true
    ]
