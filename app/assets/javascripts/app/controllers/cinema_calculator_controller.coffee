angular.module("harmanpro")
  .controller 'CinemaCalculatorCtrl',
    ['$attrs', '$scope', ($attrs, $scope) ->

      $scope.units = -> switch $scope.unit_type
        when "meters" then 3.281
        else 1

      $scope.screen = -> $scope.units() * $scope.screen_size

      $scope.type_mult = -> switch $scope.system_type
        when "1" then 1.15
        when "3" then 0.85
        else 1

      $scope.row_mult = ->
        multiplier = switch $scope.row_type
          when "2" then 1.9
          else 3
        multiplier * $scope.type_mult()

      $scope.sr = ->
        multiplier = switch $scope.row_type
          when "2" then 4.6
          else 2.5
        Math.round($scope.number_of_rows / $scope.screen() * multiplier * 10) / 10

      $scope.screen_const = ->
        Math.round($scope.number_of_rows / (3 / $scope.row_type) + $scope.system_type - 5)

      $scope.number_of_side_speakers = -> switch
        when $scope.number_of_rows * $scope.row_type <= 10 then 8
        else Math.round(($scope.number_of_rows - 1) / $scope.row_mult()) * 2

      $scope.type_of_side_speakers = -> switch
        when $scope.screen() < 43 * $scope.type_mult() then "9300"
        when $scope.screen() < 52 * $scope.type_mult() then "9310"
        when $scope.screen() < 63 * $scope.type_mult() then "9320"
        else "9350"

      $scope.number_of_rear_speakers = -> switch
        when $scope.screen() < 48 * $scope.type_mult() then 2
        when $scope.screen() < 65 * $scope.type_mult() * 1.15 then 4
        else 6

      $scope.type_of_rear_speakers = -> "9350"

      $scope.distance_between_rear_speakers = ->
        "#{ Math.round($scope.screen() / $scope.number_of_rear_speakers()) } #{ $scope.unit_type } apart"

      $scope.number_of_subs = ->
        divisor = switch
          when $scope.screen() <= 42 then 22
          else 15
        Math.round($scope.screen() / divisor / $scope.type_mult() * $scope.sr()) * 2

      $scope.type_of_subs = ->
        switch
          when $scope.system_type == "1" then "5628"
          when $scope.screen() < 60 * $scope.type_mult() then "4642"
          else "5628"

      $scope.screen_type = ->
        screen_index = switch
          when $scope.screen_const() < 1 then 0
          when $scope.screen_const() > 5 then 4
          else $scope.screen_const() - 1
        screen_opts = ["3730", "3732", "3732D2", "5732", "5742"]
        screen_opts[ screen_index ]

      true
    ]

