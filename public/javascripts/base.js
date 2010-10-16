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

    start: function(event, ui) {
      sortable = $(this);
      sortingBackup = $('li.ticket', sortable).clone();

      if(ui.item.hasClass('ui-selected')) {

        sortingPosition = $('li.ticket.ui-selected', sortable).index(ui.item);

        $('li.ticket.ui-selected:not(.ui-sortable-placeholder)', sortable)
          .not(ui.item)
          .each( function() {
            $(this).data(
              'index-backup',
              $('li.ticket:not(.ui-sortable-placeholder)', sortable)
                .index(this)
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
              if(
                  $('li.ticket:not(.ui-sortable-placeholder)', sortable)
                    .length > $(this).data('index-backup')) {

                $(this).insertBefore(
                  $('li.ticket:not(.ui-sortable-placeholder)', sortable)[$(this).data('index-backup')]
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
          top: (ui.item.offset().top + ui.item.height()) + 'px'
        });
    }

  };

  $('ul.tickets-list').sortable(sortableOptions).disableSelection();

  $('ul.tickets-list').selectable();
});
