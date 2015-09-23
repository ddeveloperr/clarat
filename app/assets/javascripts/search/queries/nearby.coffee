class Clarat.Search.Query.Nearby
  NEARBY_RADIUS: 25000 # check later if accurate

  # TODO: geolocation
  constructor: (@geolocation, @exact_location = false) ->
    console.log @geolocation
    @NEARBY_RADIUS = 250 if @exact_location == 'true'

  query_hash: ->
    indexName: Clarat.Algolia.personalIndexName,
    query: ''
    params:
      page: 0
      hitsPerPage: 1
      aroundLatLng: @geolocation
      aroundRadius: @NEARBY_RADIUS
