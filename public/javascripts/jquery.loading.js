/**************************************************************************|
   ____
  —|   \______________________
  —|___/                      \
            __________________/
           /
           \_______________________ jQuery plugin to display loading process

                                        by Aleksandr Koss (http://nocorp.ru)

|***************************************************************************/

jQuery.fn.extend({
  __load: jQuery.fn.load,
  load: function(url, params, callback) {
    jQuery(this).trigger('loading-start');

    if(typeof url !== 'string') {

      return jQuery(this).__load(function() {
        jQuery(this).trigger('loading-complete');
        url();
      });

    } else {

      return jQuery(this).__load(url, params, function(responseText, status, res) {
        jQuery(this).trigger('loading-complete');
        callback(responseText, status, res);
      });
    }
  }
});

jQuery.fn.loading = function(userOptions) {
  var count = 0,
      obj = $(this),
      options = jQuery.extend({
        speed: 300,
        start: function() {
          $(this).fadeIn(this.speed);
        },
        complete: function() {
          $(this).fadeOut(this.speed);
        }
      }, userOptions);

  obj.loadingStart = options.start;
  obj.loadingComplete = options.complete;

  function loadingStart() { if(++count == 1) obj.loadingStart(); };
  function loadingComplete() { if(--count == 0) obj.loadingComplete(); };

  jQuery('body')
    .ajaxStart(loadingStart)
    .bind('loading-start', loadingStart)
    .ajaxComplete(loadingComplete)
    .bind('loading-complete', loadingComplete)
    .bind('load', loadingStart);
};
