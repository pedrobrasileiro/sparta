$(function() {
  var sortingHelper = $('#ui-sorting-helper'),
      sortable,
      sortingPosition,
      sortingCancel,
      sortableOptions;

  sortableOptions = {
    distance: 10,
    handle: 'span.drag-mate',
    axis: 'y',
    connectWith: 'ul.tickets-list',

    start: function(event, ui) {
      sortable = $(this);
      sortingBackup = $('li.ticket', sortable).clone();

      if(ui.item.hasClass('ui-selected')) {

        sortingPosition = $('li.ticket.ui-selected', sortable).index(ui.item);

        $('ul.tickets-list li.ticket.ui-selected:not(.ui-sortable-placeholder)')
          .not(ui.item)
          .each(function() {
            var parent = $(this).parent();

            $(this)
              .data(
                'index-backup',
                $('li.ticket:not(.ui-sortable-placeholder)', parent).index(this)
              )
              .data(
                'parent-backup',
                parent
              );
          })
          .appendTo(sortingHelper);

        $(sortable).sortable('refresh');

        $(sortingHelper).width(sortable.width()).show();

        $('.ui-sortable-placeholder').css({
          height: (
                    ($('li.ticket', sortingHelper).length + 1) *
                    ui.item.outerHeight()
                  ) + 'px'
        });

        sortingCancel = function(event) {
          if(event.keyCode == 27) {

            $('li.ticket', sortingHelper).each(function() {
              var parent = $(this).data('parent-backup');
              console.log(parent);

              if(
                  $('li.ticket:not(.ui-sortable-placeholder)', parent)
                    .length > $(this).data('index-backup')) {

                $(this).insertBefore(
                  $('li.ticket:not(.ui-sortable-placeholder)', parent)[$(this).data('index-backup')]
                );
              } else {
                sortable.append(this);
              }
            });

            $('.ui-sortable-placeholder').css('height', ui.item.height());

            $(window).unbind('keyup', sortingCancel);
            sortable
              .sortable('cancel')
              .sortable('refresh');
          }
        };

        $(window).bind('keyup', sortingCancel);
      }
    },

    stop: function(event, ui) {
      if($('li', sortingHelper).length) {
        $(sortingHelper).hide();

        ui.item.after($('li.ticket', sortingHelper));

        if(sortingPosition > 0)
          ui.item.insertAfter($('li.ticket.ui-selected', $(this))[sortingPosition]);

         $(this).sortable('refresh');

        $(window).unbind('keyup', sortingCancel);
      }
    },

    sort: function(event, ui) {
      if($('li.ticket', sortingHelper).length)
        $(sortingHelper).css({
          top: (ui.item.offset().top + 26) + 'px'
        });
    }
  };

  $('ul.tickets-list').sortable(sortableOptions).disableSelection();

  $('ul.tickets-list').selectable();

  $('.drag-mate a').live('click', function() { return false; });
});
