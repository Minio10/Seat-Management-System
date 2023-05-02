$(document).ready(function() {

// Set authenticity token as default header for all AJAX requests
  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });

  var selectedSeats = [];

  // Handle seat click event for free seats
  $(document).on('click', '.seat.free', function(e) {

    if ($(this).hasClass('reserved') || $(this).hasClass('selected')) {
      return; // Exit the event handler if seat is reserved or selected
    }
    
    e.stopImmediatePropagation();

    var seatId = parseInt($(this).attr('id').split('-')[1]);
    var seat = $(this);

      // Select the seat
      seat.removeClass('free');
      seat.addClass('selected current-visitor');
      selectedSeats.push(seatId);

    // Update selected seats for the current visitor in the session
    $.ajax({
      url: '/seats/update_selected_seats',
      method: 'POST',
      data: { seat: seatId, task: 'select' },
      success: function() {
        console.log('Selected seats updated successfully.');
        },
      error: function() {
        console.log('Error occurred while updating selected seats.');
      }
    });
  });

  // Handle seat click event for seats selected by the current visitor
  $(document).on('click', '.seat.selected.current-visitor', function(e) {
    
    e.stopImmediatePropagation();

    var seatId = parseInt($(this).attr('id').split('-')[1]);
    var seat = $(this);

      // Select the seat
    seat.removeClass('selected current-visitor');
    seat.addClass('free');
    selectedSeats.push(seatId);

    // Update selected seats for the current visitor in the session
    $.ajax({
      url: '/seats/update_selected_seats',
      method: 'POST',
      data: { seat: seatId, task: 'unselect' },
      success: function() {
        console.log('Unselected seats updated successfully.');
        },
      error: function() {
        console.log('Error occurred while updating unselected seats.');
      }
    });
  });

  // Event listener for the "Confirm Reservation" button
$('#confirm-reservation').click(function(e) {
    
  e.stopImmediatePropagation();
  // Get the selected seats
  var selectedSeats = $('.seat.current-visitor').map(function() {
    return $(this).attr('id').replace('seat-', '');
  }).get();

  // Submit the selected seats to the server
  $.ajax({
    url: '/seats/reserve_selected_seats',
    method: 'POST',
    data: { selected_seats: selectedSeats},
    success: function() {
      // Success callback
      console.log('Reservation confirmed successfully.');
    },
    error: function() {
      // Error callback
      console.log('Error occurred while confirming reservation.');
    }
  });
});
});
