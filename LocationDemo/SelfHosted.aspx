﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelfHosted.aspx.cs" Inherits="LocationDemo.SelfHosted" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
  <title>Geolocation</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js" ></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
	<script src="profiler.js"></script>
    <style>
      html, body, #map-canvas {
        height: 100%;
        margin: 0px;
        padding: 0px
      }
    </style>
    <!--
    Include the maps javascript with sensor=true because this code is using a
    sensor (a GPS locator) to determine the user's location.
    See: https://developers.google.com/maps/documentation/javascript/tutorial#Loading_the_Maps_API
    -->
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=true"></script>

    <script>
        // Note: This example requires that you consent to location sharing when
        // prompted by your browser. If you see a blank space instead of the map, this
        // is probably because you have denied permission for location sharing.

        var map;

        var locationInfo = <%= LocationLiteral %>

        function initializeMap() {
            var mapOptions = {
                zoom: 14,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

            var pos = new google.maps.LatLng(locationInfo.Location.location.latitude,
                                                locationInfo.Location.location.longitude);

            var infowindow = new google.maps.InfoWindow({
                map: map,
                position: pos,
                content: 'Located using db in ' + locationInfo.TimeSpent
            });

            map.setCenter(pos);
        }

        function handleNoGeolocation(errorFlag) {
            if (errorFlag) {
                var content = 'Error: The Geolocation service failed.';
            } else {
                var content = 'Error: Your browser doesn\'t support geolocation.';
            }

            var options = {
                map: map,
                position: new google.maps.LatLng(60, 105),
                content: content
            };

            var infowindow = new google.maps.InfoWindow(options);
            map.setCenter(options.position);
        }

        google.maps.event.addDomListener(window, 'load', initializeMap);

    </script>
  </head>
  <body>
    <div class="jumbotron">
      <div class="container">
        <h2>Self hosted DB lookup</h2>
		<div id="map-canvas"  style="min-height:300px;"></div>
      </div>
    </div>
    <div class="container">
      <!-- Example row of columns -->
      <div class="row">
        <div class="col-lg-4">
          <h2>You are here:</h2>
          <p id="your-location"></p>
          <h2>Performance</h2>
          <p>Click this button to display page loading statistics</p>
          <p><a id="Statistics" class="btn btn-default" href="#">View page loading statistics</a></p>
        </div>
        <div class="col-lg-4">
          <h2>Pros</h2>
          <ul>
			<li>No need for user interaction</li>
			<li>Free</li>
			<li>Browser agnostic</li>
			<li>We are in control</li>
			<li>We can upgrade to the paid DB which is more accurate and we only need to change the db.</li>
		  </ul>
       </div>
        <div class="col-lg-4">
          <h2>Cons</h2>
          <ul>
			<li>Uses the free (and not very accurate) database from MaxMind.</li>
			<li>Another piece of code and functionality that need to be tested and maintained</li>
			<li>Monthly DB refresh (probably can be automated)</li>
		  </ul>
        </div>
      </div>
	</div>
  <script>
      var profile = function () { if (!window.__profiler || window.__profiler.scriptLoaded !== true) { var d = document, h = d.getElementsByTagName('head')[0], s = d.createElement('script'), l = d.createElement('div'), c = function () { if (l) { d.body.removeChild(l); }; window.__profiler = window.__profiler || new __Profiler(); window.__profiler.init(); __profiler.scriptLoaded = true; }, t = new Date(); s.type = 'text/javascript'; l.style.cssText = 'z-index:999;position:fixed;top:10px;left:10px;display:inline;width:auto;font-size:14px;line-height:1.5em;font-family:Helvetica,Calibri,Arial,sans-serif;text-shadow:none;padding:3px 10px 0;background:#FFFDF2;box-shadow:0 0 0 3px rgba(0,0,0,.25),0 0 5px 5px rgba(0,0,0,.25); border-radius:1px'; l.innerHTML = 'Just a moment'; s.src = 'http://kaaes.github.com/timing/profiler.js?' + t.getTime(); s.onload = c; s.onreadystatechange = function () { if (this.readyState == 'loaded') { c() } }; d.body.appendChild(l); h.appendChild(s); } else if (window.__profiler instanceof __Profiler) { window.__profiler.init() } };
      window.onload = function () {
          $("#Statistics").click(function () {
              profile();
          });
          $("#your-location").text(locationInfo.Location.Country.Name + ', ' + locationInfo.Location.city.Name + ', ' + locationInfo.Location.MostSpecificSubdivision.Name);
      };
  </script>
  </body>
</html>
