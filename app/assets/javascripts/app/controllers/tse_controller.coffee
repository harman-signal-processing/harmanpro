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

      $scope.updateParentResults = ->
        $scope.contacts = []
        $scope.selectedChildCategory = null

        if $scope.selectedParentCategory
          TseCategory.get {
            locale: $attrs.locale
            parent_id: $scope.selectedParentCategory
          }, (data) ->
            $scope.child_categories = data.tse_categories

            # Load the contacts for the parent
            if $scope.child_categories.length == 0
              TseContact.get {
                locale: $attrs.locale
                category_id: $scope.selectedParentCategory
              }, (data) ->
                $scope.contacts = data.tse_contacts

      $scope.updateChildResults = ->
        if $scope.selectedChildCategory
          # Load the contacts for the child
          TseContact.get {
            locale: $attrs.locale
            category_id: $scope.selectedChildCategory
          }, (data) ->
            $scope.contacts = data.tse_contacts

      $scope.includeContact = (contact) ->
        tech_filter = true
        region_filter = true
        domain_filter = true

        if $scope.selectedTechnology
          tech_filter = contact.technologies.includes($scope.selectedTechnology.name)
          if $scope.selectedRegion
            region_filter = contact.regions.includes($scope.selectedRegion.name)
            if $scope.selectedDomain
              domain_filter = contact.domains.includes($scope.selectedDomain.name)

        return (region_filter && tech_filter && domain_filter)

      $scope.resetFilters = ->
        $scope.selectedTechnology = null
        $scope.selectedRegion = null
        $scope.selectedDomain =  null

        if $scope.selectedChildCategory
          $scope.updateChildResults()
        else if $scope.selectedParentCategory
          $scope.updateParentResults()

    ]
