###
Controls all aspects of managing listings
@name listingApp
@author   Antonio Mendes <webaholicson@gmail.com>
@returns
###

ListingApp = angular.module('ListingApp', [])

###
@inheritdoc
###
ListingApp.controller('ListingCtrl', [
  '$scope','$http',($scope, $http) ->

    ###
    List of all the listings
    @type {Object}
    ###
    $scope.fields = {}

    ###
    List of steps to complete the listing
    @type {Array}
    ###
    $scope.steps = []

    ###
    Current step in the process
    @type {Number}
    ###
    $scope.currentStep = 0

    ###
    Current step in the process
    @type {Object}
    ###
    $scope.result = { type: null, message: ''}

    ###
    Create a new listing
    @type {Function}
    ###
    $scope.saveListing = ($event) ->
      console.log($scope.fields)
      $event.preventDefault()
      return
      $http.post(
        $('sell-car-form').attr('action'),
        {
          data: $scope.fields,
          responseType: 'json'
        }
      ).success((data) ->
        $scope.successMsg = data.message
      )

    this
])
