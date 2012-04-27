# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
@updateLocation = ()->
	currentLocation = JSON.parse(localStorage["userLocation"])
	navigator.geolocation.getCurrentPosition (location) ->
		coords = location.coords
		lngLat = [coords.longitude, coords.latitude]
		userLocation = 
			lngLat : lngLat
			updatedAt : (new Date).getTime()
		if( (new Date).getTime() - Number(currentLocation["updatedAt"]) > 300000 || (currentLocation["lngLat"] != lngLat))
			$.post '/update_location', 
				coordinates : lngLat
		localStorage["userLocation"] = JSON.stringify userLocation
	
@initializeGeo = ()->
	navigator.geolocation.getCurrentPosition (location) ->
		coords = location.coords
		lngLat = [coords.longitude, coords.latitude]
		userLocation = 
			lngLat : lngLat
			updatedAt : (new Date).getTime()
		localStorage["userLocation"] = JSON.stringify userLocation
		$.post '/update_location', 
				coordinates : lngLat