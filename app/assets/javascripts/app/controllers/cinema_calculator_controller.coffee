angular.module("harmanpro")
  .controller 'CinemaCalculatorCtrl',
    ['$attrs', '$scope', 'CinemaSpeaker', 'Product', ($attrs, $scope, CinemaSpeaker, Product) ->

      subwoofer_models = ["jbl-5628", "jbl-4642"]
      screen_speaker_models = ["jbl-3730", "jbl-3732", "jbl-3732d2", "jbl-5732", "jbl-5742"]
      side_speaker_models = ["jbl-9300", "jbl-9310", "jbl-9320", "jbl-9350"]
      all_models = [side_speaker_models..., screen_speaker_models..., subwoofer_models...]

      products = {}
      for model in all_models
        products[model] = Product.get {
          id: model
          locale: $attrs.locale
        }

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

      $scope.type_of_side_speakers = ->
        side_index = switch
          when $scope.screen() < 43 * $scope.type_mult() then 0
          when $scope.screen() < 52 * $scope.type_mult() then 1
          when $scope.screen() < 63 * $scope.type_mult() then 2
          else 3
        model = side_speaker_models[side_index]
        products[model].product

      $scope.number_of_rear_speakers = -> switch
        when $scope.screen() < 48 * $scope.type_mult() then 2
        when $scope.screen() < 65 * $scope.type_mult() * 1.15 then 4
        else 6

      $scope.type_of_rear_speakers = ->
        model = side_speaker_models[side_speaker_models.length - 1]
        products[model].product

      $scope.distance_between_rear_speakers = ->
        "#{ Math.round($scope.screen() / $scope.number_of_rear_speakers()) } #{ $scope.unit_type } apart"

      $scope.number_of_subs = ->
        divisor = switch
          when $scope.screen() <= 42 then 22
          else 15
        Math.round($scope.screen() / divisor / $scope.type_mult() * $scope.sr()) * 2

      $scope.type_of_subs = ->
        subwoofer_index = switch
          when $scope.system_type == "1" then 0
          when $scope.screen() < 60 * $scope.type_mult() then 1
          else 0
        model = subwoofer_models[ subwoofer_index ]
        products[model].product

      $scope.screen_type = ->
        screen_index = switch
          when $scope.screen_const() < 1 then 0
          when $scope.screen_const() > 5 then 4
          else $scope.screen_const() - 1
        model = screen_speaker_models[ screen_index ]
        products[model].product

      true
    ]

