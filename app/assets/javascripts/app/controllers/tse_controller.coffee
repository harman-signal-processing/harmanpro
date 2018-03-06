angular.module("harmanpro")
  .controller 'TseCtrl',
    ['$attrs', '$scope', 'TseCategory', 'TseContact', 'TseRegion', 'TseTechnology', 'TseDomain',
    ($attrs, $scope, TseCategory, TseContact, TseRegion, TseTechnology, TseDomain) ->

      $scope.parent_categories = []
      $scope.child_categories = []
      $scope.contacts = []
      $scope.regions = []
      $scope.technologies = []
      $scope.domains = []

      TseCategory.get {
        locale: $attrs.locale
      }, (data) ->
        $scope.parent_categories = data.tse_categories

      TseRegion.get {
        locale: $attrs.locale
      }, (data) ->
        $scope.regions = data.tse_regions

      TseTechnology.get {
        locale: $attrs.locale
      }, (data) ->
        $scope.technologies = data.tse_technologies

      TseDomain.get {
        locale: $attrs.locale
      }, (data) ->
        $scope.domains = data.tse_domains

      TseContact.get {
        locale: $attrs.locale
      }, (data) ->
        $scope.contacts = data.tse_contacts

      $scope.includeContact = (contact) ->
        tech_filter = true
        region_filter = true
        domain_filter = true
        parent_filter = true
        child_filter = true

        if $scope.selectedTechnology
          tech_filter = contact.technologies.includes($scope.selectedTechnology.name)
          if $scope.selectedRegion
            region_filter = contact.regions.includes($scope.selectedRegion.name)
          if $scope.selectedDomain
            domain_filter = contact.domains.includes($scope.selectedDomain.name)
          if $scope.child_categories.length > 0
            if $scope.selectedChildCategory
              child_filter = contact.categories.includes($scope.selectedChildCategory.name)
          else if $scope.selectedParentCategory
            parent_filter = contact.categories.includes($scope.selectedParentCategory.name)

        return (region_filter && tech_filter && domain_filter && child_filter && parent_filter)

      $scope.updateChildCategories = ->
        if $scope.selectedParentCategory
          TseCategory.get {
            locale: $attrs.locale
            parent_id: $scope.selectedParentCategory.id
          }, (data) ->
            $scope.child_categories = data.tse_categories

      $scope.resetFilters = ->
        $scope.selectedDomain =  null
        $scope.selectedParentCategory = null
        $scope.selectedChildCategory = null
        $scope.child_categories = []

      $scope.startOver = ->
        $scope.resetFilters
        $scope.selectedRegion = null
        $scope.selectedTechnology = null
    ]
