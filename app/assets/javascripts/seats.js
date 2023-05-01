$(document).ready(function() {

// Set authenticity token as default header for all AJAX requests
  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });

  var selectedSeats = [];

  // Handle seat click event
  $('.seat.free').click(function(e) {
    
    e.stopImmediatePropagation();

    var seatId = parseInt($(this).attr('id').split('-')[1]);
    var seat = $(this);

    // Check if seat is already selected by the current visitor
    var isAlreadySelected = seat.hasClass('selected') && seat.data('visitor-id') === visitorId;

    // Toggle seat selection
    if (isAlreadySelected) {
      // Unselect the seat
      seat.removeClass('selected current-visitor');
      selectedSeats = selectedSeats.filter(function(id) {
        return id !== seatId;
      });
    } else {
      // Select the seat
      seat.removeClass('free');
      seat.addClass('selected current-visitor');
      selectedSeats.push(seatId);
    }

    // Update selected seats for the current visitor in the session
    $.ajax({
      url: '/seats/update_selected_seats',
      method: 'POST',
      data: { selected_seats: selectedSeats, task: 'select' },
      success: function() {
        console.log('Selected seats updated successfully.');
        },
      error: function() {
        console.log('Error occurred while updating selected seats.');
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
    url: '/seats/update_selected_seats',
    method: 'POST',
    data: { selected_seats: selectedSeats, task: 'reserve' },
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
