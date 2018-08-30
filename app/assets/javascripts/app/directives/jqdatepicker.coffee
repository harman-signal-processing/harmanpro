angular.module("harmanpro")
  .directive 'jqdatepickerpastonly', ->
    {
      restrict: 'A'
      require: 'ngModel',
      scope: { ngSrc: '@' }
      link: (scope, element) ->
        element.datepicker
          inline: true
          numberOfMonths: 1
          showButtonPanel: true
          dateFormat: "DD, MM d, yy"
          constrainInput: true
          maxDate: 0
    }


