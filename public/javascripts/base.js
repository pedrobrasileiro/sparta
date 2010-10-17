$(function() {
  var metaPanel = $('.columns .column.meta-column .column-wrapper'),
      metaPanelContainer = $('.columns .column.meta-column'),
      metaPanelContent;

  //
  // Actions
  //

  // Delete selected tickets

  function deleteSelectedTickets() {
    if( confirm('You really want to delete selected tickets?') ) {
      var selected = $('li.ticket.ui-selected');
      $.post(
        '/projects/' + projectId + '/tickets/bulk_delete',
        serializeObjects(selected),
        null,
        'json'
      );

      selected.remove();
    }

    return false;
  }

  $(document).bind('keypress', 'd', deleteSelectedTickets);

  // Movements

  function moveCursorUp() {
    var selected = $('li.ticket.ui-selected:first');
    $('li.ticket.ui-selected').removeClass('ui-selected');
    selected.prev('li.ticket').addClass('ui-selected');
  }

  function moveCursorDown() {
    var selected = $('li.ticket.ui-selected:first');
    $('li.ticket.ui-selected').removeClass('ui-selected');
    selected.next('li.ticket').addClass('ui-selected');
  }

  $(document).bind('keypress', 'k', moveCursorUp);
  $(document).bind('keypress', 'j', moveCursorDown);

  // New ticket

  function openNewTicket() {
    ''
  }

  $(document).bind('keypress', 'n', openNewTicket);

  function onContentChange() {
    metaPanel.jScrollPane();
  }

  function onWindowResize() {
    metaPanel.height(metaPanelContainer.height() - 40);
    onContentChange();
  }

  onWindowResize();

  $(window).resize(onWindowResize);

  metaPanelContent = $('.jspPane', metaPanel);

  function setMetapanelContent(html) {
    metaPanelContent.html(html);
    onContentChange();
  }

  //
  // Ticket selecteble and sortable
  //

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
    },

    update: function(event, ui) {
      var ul = $(this);
      setTimeout(function() {
        $.post(
          '/projects/' + projectId + '/tickets/sort',
          ul.sortable('serialize'),
          null,
          'json'
        );
      }, 0);
    }
  };

  $('ul.tickets-list').sortable(sortableOptions).disableSelection();

  $('ul.tickets-list').selectable({
    filter: 'li.ticket',
    cancel: 'a.delete-ticket,input',

    selected: function(event, ui) {
      var selected = $('.ticket.ui-selected');
      if(selected.length > 1) {
        setMetapanelContent('Goo');
      } else if (selected.length === 1) {
        $.get($('span.number a', selected).attr('href'), function(html){
          setMetapanelContent(html);
        });
      }
    }
  });

  $('.drag-mate a').live('click', function() { return false; });

  $('a.add-ticket').bind('ajax:success', function(_, data) {
    metaPanel.html(data).find('textarea').focus();
  });

  $('a.delete-ticket').live('ajax:success', function() {
    $(this).parents('li.ticket').slideUp(300).remove();
  });

  // Comments

  $('#new_comment').live('ajax:success', function(_, data) {
    $(this).siblings('.comments').append(data);
    $(this).find('textarea').val('');
  });

  // Serialize

  function serializeObjects(objects) {

    var str = [];

    $(objects).each(function() {
      var res = $(this).attr('id').match(/(.+)[-=_](.+)/);
      if(res) str.push((res[1]+'[]')+'='+(res[2]));
    });

    return str.join('&');
  }

  $('.select-project').toggle(
    function() {
      $(this)
        .parent()
        .find('ul')
        .show()
        .css({
          top: '0',
          left: $(this).innerWidth(),
          margin: '-' + ($.browser.webkit ? '9' : '7') + 'px 0 0 -5px'
        });

      return false;
    },

    function() {
      $(this).parent().find('ul').hide();
      return false;
    }
  );

  var popupWindow = $('<div class="popup-window"></div>');

  $('.menu-popup.menu-popup-window').bind('ajax:success', function(_, data) {
    popupWindow
      .clone()
      .insertAfter($(this))
      .addClass('green')
      .append(data)
      .css({
        top: $(this).top(), // $(this).offset().top,
        left: $(this).innerWidth(), //$(this).offset().left + $(this).innerWidth(),
        margin: '0 0 0 -5px'
      });
  });

  $('#new_project').live('ajax:success', function(_, data) {
    window.location = data;
  });
});
