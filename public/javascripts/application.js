var debug = true;

function log(msg, obj) {
  if(window.console && window.console.log && debug) {
    window.console.log("Debug: " + msg);
    
    if(obj) {
      window.console.log(obj);
    }
  }
}

require(
  ["jquery", "lib/jquery.mobile"], 
  function($) {
  
    $(function() {
    });
    
});