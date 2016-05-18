###
Controls all aspects of managing listings
@name     Listing
@author   Antonio Mendes <webaholicson@gmail.com>
###

Listing = angular.module('Listing', [])

###
Register the listing controller
@param {String|Function} constructor
@param {Object} locals
###
Listing.controller('ListingCtrl', [
  '$scope','$http',($scope, $http) ->

    ###
    List of all the listings
    @type {Object}
    ###
    $scope.fields = {}

    ###
    Class attribute for the list creation steps elements
    @type {String}
    ###
    $scope.stepClass = '.step'

    ###
    Class attribute for the active step
    @type {String}
    ###
    $scope.activeTabClass = 'is-active'

    ###
    Id attribute for the form handling the new listing creation
    @type {String}
    ###
    $scope.formId = '#sell-car-form'

    ###
    List of steps to complete the listing
    @type {Array}
    ###
    $scope.steps = (() ->
        result = []
        $($scope.stepClass).each(() ->
          result.push('#'+$(this).attr('id'))
        )
        result
      )()

    ###
    Current step in the process
    @type {Number}
    ###
    $scope.currentStep = $scope.steps[0]

    ###
    Listing ajax call result object
    @type {Object}
    ###
    $scope.result = { type: null, message: '' }

    ###
    Go to the next step in the listing creation process
    @param {MouseEvent} $event
    ###
    $scope.nextStep = ($event) ->
      $event.preventDefault()
      $scope._goToStep($scope.steps.indexOf($scope.currentStep)+1)

    ###
    Go to the previous step in the listing creation process
    @param {MouseEvent} $event
    ###
    $scope.prevStep = ($event) ->
      $event.preventDefault()
      $scope._goToStep($scope.steps.indexOf($scope.currentStep)-1)

    ###
    Go to the specified step
    @param {String} step
    @access protected
    @returns null
    ###
    $scope._goToStep = (step) ->
      $($scope.currentStep).removeClass($scope.activeTabClass)
      $scope.currentStep = $scope.steps[step]
      $($scope.currentStep).addClass($scope.activeTabClass)
      null

    ###
    Create a new listing
    @param {MouseEvent} $event
    @type {Function}
    ###
    $scope.saveListing = ($event) ->
      $event.preventDefault()
      $http.post(
        $(scope.formId).attr('action'),
        {
          data: $scope.fields,
          responseType: 'json'
        }
      ).success((data) ->
        $scope.successMsg = data.message
      )

    this
])
