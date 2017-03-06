angular.module("harmanpro")
  .controller 'CinemaCalculatorCtrl',
    ['$attrs', '$scope', ($attrs, $scope) ->
      $scope.units = ->
        if $scope.unit_type == "meters"
          3.281
        else
          1

      $scope.screen = ->
        $scope.units() * $scope.screen_size

      $scope.type_mult = ->
        if $scope.system_type == "1"
          1.15
        else if $scope.system_type == "3"
          0.85
        else
          1

      $scope.row_mult = ->
        multiplier = 1.9
        multipler = 3 if $scope.row_type == "2"
        multiplier * $scope.type_mult()

      $scope.sr = ->
        multiplier = 2.5
        multiplier = 4.6 if $scope.row_type == "2"
        Math.round($scope.number_of_rows / $scope.screen() * multiplier * 10) / 10

      $scope.screen_const = ->
        Math.round($scope.number_of_rows / (3 / $scope.row_type) + $scope.system_type - 5)

      $scope.number_of_side_speakers = ->
        if $scope.number_of_rows * $scope.row_type <= 10
          8
        else
          Math.round(($scope.number_of_rows - 1) / $scope.row_mult()) * 2

      $scope.type_of_side_speakers = ->
        if $scope.screen() < 43 * $scope.type_mult()
          9300
        else if $scope.screen() < 52 * $scope.type_mult()
          9310
        else if $scope.screen() < 63 * $scope.type_mult()
          9320
        else
          9350

      $scope.number_of_rear_speakers = ->
        if $scope.screen() < 48 * $scope.type_mult()
          2
        else if $scope.screen() < 65 * $scope.type_mult() * 1.15
          4
        else
          6

      $scope.type_of_rear_speakers = ->
        9350

      $scope.distance_between_rear_speakers = ->
        "#{ Math.round($scope.screen() / $scope.number_of_rear_speakers()) } #{ $scope.unit_type } apart"

      $scope.number_of_subs = ->
        divisor = 15
        divisor = 22 if $scope.screen() <= 42
        Math.round($scope.screen() / divisor / $scope.type_mult() * $scope.sr()) * 2

      $scope.type_of_subs = ->
        if $scope.system_type == "1"
          5628
        else if $scope.screen() < 60 * $scope.type_mult()
          4642
        else
          5628

      $scope.screen_type = ->
        screen_opts = ["3730", "3732", "3732D2", "5732", "5742"]
        screen_index = $scope.screen_const()
        screen_index = 1 if $scope.screen_const() < 1
        screen_index = 5 if $scope.screen_const() > 5
        screen_opts[ screen_index - 1 ]

      true
    ]

