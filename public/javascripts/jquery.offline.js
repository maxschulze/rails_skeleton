(function($) {

  var prefix = "offline.jquery:",
    mostRecent = null,
    requesting = {};

  // Allow the user to explicitly turn off localStorage
  // before loading this plugin
  if (typeof $.support.localStorage === "undefined") {
    $.support.localStorage = !!window.localStorage;
  }

  // modified getJSON which uses ifModified: true
  function getJSON(url, data, fn) {
    if (jQuery.isFunction(data)) {
      fn = data;
      data = null;
    }

    requestingKey = url + "?" + data;
    if (requestingKey[requestingKey]) {
      return false;
    }

    requesting[requestingKey] = true;

    return jQuery.ajax({
      type: "GET",
      url: url,
      data: data,
      success: function(data, text) {
        requesting[requestingKey] = false;
        fn(data, text);
      },
      dataType: "json",
      ifModified: true
    });
  }

  if ($.support.localStorage) {
    // If localStorage is available, define jQuery.retrieveJSON
    // and jQuery.clearJSON to operate in terms of the offline
    // cache
    // If the user comes online, run the most recent request
    // that was queued due to the user being offline
    $(window).bind("online", function() {
      if (mostRecent) {
        mostRecent();
      }
    });

    // If the user goes offline, hide any loading bar
    // the user may have created
    $(window).bind("offline", function() {
      jQuery.event.trigger("ajaxStop");
    });

    $.retrieveJSON = function(url, data, fn) {
      // allow jQuery.retrieveJSON(url, fn)
      if ($.isFunction(data)) {
        fn = data;
        data = {};
      }

      // remember when this request started so we can report
      // the time when a follow-up Ajax request completes.
      // this is especially important when the user comes
      // back online, since retrieveDate may be minutes,
      // hours or even days before the Ajax request finally
      // completes
      var retrieveDate = new Date;

      // get a String value for the data passed in, and then
      // use it to calculate a cache key
      var param = $.param(data),
          key   = prefix + url + ":" + param,
          text  = localStorage[key],
          date  = localStorage[key + ":date"];

      date = new Date( Date.parse(date) );

      // create a function that will make an Ajax request and
      // store the result in the cache. This function will be
      // deferred until later if the user is offline
      function getData() {
        getJSON(url, param, function(json, status) {
          localStorage[key] = JSON.stringify(json);
          localStorage[key + ":date"] = new Date;

          // If this is a follow-up request, create an object
          // containing both the original time of the cached
          // data and the time that the data was originally
          // retrieved from the cache. With this information,
          // users of jQuery Offline can provide the user
          // with improved feedback if the lag is large
          var data = text && { cachedAt: date, retrievedAt: retrieveDate };
          fn(json, status, data);
        });
      }

      // If there is anything in the cache, call the callback
      // right away, with the "cached" status string
      if( text ) {
        var response = fn( $.parseJSON(text), "cached", { cachedAt: date } );
        if( response === false ) return false;
      }

      // If the user is online, make the Ajax request right away;
      // otherwise, make it the most recent callback so it will
      // get triggered when the user comes online
      if (window.navigator.onLine) {
        getData();
      } else {
        mostRecent = getData;
      }

      return true;
    };

    // jQuery.clearJSON is simply a wrapper around deleting the
    // localStorage for a URL/data pair
    $.clearJSON = function(url, data) {
      var param = $.param(data || {});
      delete localStorage[prefix + url + ":" + param];
      delete localStorage[prefix + url + ":" + param + "date"];
    };
  } else {
    // If localStorage is unavailable, just make all requests
    // regular Ajax requests.
    $.retrieveJSON = getJSON;
    $.clearJSON = $.noop;
  }

})(jQuery);