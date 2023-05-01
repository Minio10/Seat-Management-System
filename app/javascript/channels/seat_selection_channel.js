import consumer from "channels/consumer"

consumer.subscriptions.create("SeatSelectionChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Update the frontend with the new seats data
    var seat = data.updated_seats;
    var task = data.task;

    var seatElement = $('#seat-' + seat.id);
    if (task === "select") {
      seatElement.removeClass('free');
      seatElement.addClass('selected');

      if (seat.visitor_id === visitorId) {
        seatElement.addClass('current-visitor');
      }
    }
    else if (task === "unselect"){
      seatElement.removeClass();
      seatElement.addClass('seat free');
    }
  }
});
