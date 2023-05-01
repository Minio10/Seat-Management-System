import consumer from "channels/consumer"

consumer.subscriptions.create("SeatReservationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Update the frontend with the new seats data
    var updatedSeats = data.updated_seats;

    updatedSeats.forEach(function(seat) {
      var seatElement = $('#seat-' + seat.id);
      seatElement.removeClass();
      seatElement.addClass('seat reserved');
    }
)}
});
