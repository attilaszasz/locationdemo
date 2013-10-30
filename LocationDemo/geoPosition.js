//
// javascript-mobile-desktop-geolocation
// https://github.com/estebanav/javascript-mobile-desktop-geolocation
//
// Copyright J. Esteban Acosta Villafañe
// Licensed under the MIT licenses.
//
// Based on Stan Wiechers > geo-location-javascript v0.4.8 > http://code.google.com/p/geo-location-javascript/
//
// Revision: $Rev: 01 $: 
// Author: $Author: estebanav $:
// Date: $Date: 2012-09-07 23:03:53 -0300 (Fri, 07 Sep 2012) $:    

var bb = { 
        success: 0,
        error: 0,
        blackberryTimeoutId : -1
    };

function handleBlackBerryLocationTimeout()
{
        if(bb.blackberryTimeoutId!=-1) {
                bb.error({ message:     "Timeout error", 
                   code:        3
               });
        }
}
function handleBlackBerryLocation()
{
                clearTimeout(bb.blackberryTimeoutId);
                bb.blackberryTimeoutId=-1;
        if (bb.success && bb.error) {
                if(blackberry.location.latitude==0 && blackberry.location.longitude==0) {
                        //http://dev.w3.org/geo/api/spec-source.html#position_unavailable_error
                        //POSITION_UNAVAILABLE (numeric value 2)
                        bb.error({message:"Position unavailable", code:2});
                }
                else
                {  
                        var timestamp=null;
                        //only available with 4.6 and later
                        //http://na.blackberry.com/eng/deliverables/8861/blackberry_location_568404_11.jsp
                        if (blackberry.location.timestamp)
                        {
                                timestamp = new Date( blackberry.location.timestamp );
                        }
                        bb.success( { timestamp:    timestamp , 
                                      coords: { 
                                            latitude:  blackberry.location.latitude,
                                            longitude: blackberry.location.longitude
                                        }
                                    });
                }
                //since blackberry.location.removeLocationUpdate();
                //is not working as described http://na.blackberry.com/eng/deliverables/8861/blackberry_location_removeLocationUpdate_568409_11.jsp
                //the callback are set to null to indicate that the job is done

                bb.success = null;
                bb.error = null;
        }
}

var geoPosition=function() {

        var pub = {};
        var provider=null;
                var u="undefined";
        var ipGeolocationSrv = 'http://freegeoip.net/json/?callback=JSONPCallback';

        pub.getCurrentPosition = function(success,error,opts)
        {
                provider.getCurrentPosition(success, error,opts);
        }

        pub.jsonp = {
            callbackCounter: 0,

            fetch: function(url, callback) {
                var fn = 'JSONPCallback_' + this.callbackCounter++;
                window[fn] = this.evalJSONP(callback);
                url = url.replace('=JSONPCallback', '=' + fn);

                var scriptTag = document.createElement('SCRIPT');
                scriptTag.src = url;
                document.getElementsByTagName('HEAD')[0].appendChild(scriptTag);
            },

            evalJSONP: function(callback) {
                return function(data) {
                    callback(data);
                }
            }
        };
                        
        pub.confirmation = function()
        {
            return true; //confirm('This Webpage wants to track your physical location.\nDo you allow it?');
        };

        pub.init = function()
        {                                                
            try
            {
						var start = new Date().getTime();
                        pub.getCurrentPosition = function(success, error, opts) {
                                pub.jsonp.fetch(ipGeolocationSrv, 
                                        function( p ){ 
												var end = new Date().getTime();
												var time = end - start;
												success( { timestamp: p.timestamp,
															timespent: time,
                                                                   coords: { 
                                                                        latitude:   p.latitude, 
                                                                        longitude:  p.longitude,
                                                                        heading:    p.heading
                                                                    }
                                                                });});
                        }
                        provider = true;
            }
            catch (e){ 
                                if( typeof(console) != u ) console.log(e);                                        
                                return false;
                        }
            return  provider!=null;
        }
        return pub;
}();