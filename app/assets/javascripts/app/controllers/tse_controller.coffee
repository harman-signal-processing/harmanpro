angular.module("harmanpro")
  .controller 'TseCtrl',
    ['$attrs', '$scope', 'TseCategory', 'TseContact', 'TseRegion', 'TseTechnology', 'TseDomain',
    ($attrs, $scope, TseCategory, TseContact, TseRegion, TseTechnology, TseDomain) ->

      $scope.parent_categories = []
      $scope.contacts = []
      $scope.regions = []
      $scope.technologies = []

      TseCategory.get {
        locale: $attrs.locale
      }, (data) ->
        $scope.parent_categories = data.tse_categories

      TseRegion.get {
        locale: $attrs.locale
        parent: true
      }, (data) ->
        $scope.regions = data.tse_regions

      TseTechnology.get {
        locale: $attrs.locale
      }, (data) ->
        $scope.technologies = data.tse_technologies

      TseContact.get {
        locale: $attrs.locale
      }, (data) ->
        $scope.contacts = data.tse_contacts

      $scope.includeContact = (contact) ->
        tech_filter = true
        region_filter = true
        parent_filter = true

        if $scope.selectedTechnology
          tech_filter = contact.technologies.includes($scope.selectedTechnology.name)
          if $scope.selectedParentCategory
            parent_filter = contact.categories.includes($scope.selectedParentCategory.name)
            if $scope.selectedRegion
              region_filter = contact.regions.includes($scope.selectedRegion.name)

        return (region_filter && tech_filter && parent_filter)

      $scope.startOver = ->
        $scope.selectedTechnology = null
        $scope.selectedParentCategory = null
        $scope.selectedRegion = null
    ]
