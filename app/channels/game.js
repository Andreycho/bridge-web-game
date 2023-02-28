App.game = App.cable.subscriptions.create("GameChannel", {
    connected: function() {
      // Called when the subscription is ready for use on the server
    },
  
    disconnected: function() {
      // Called when the subscription has been terminated by the server
    },
  
    received: function(data) {
      // Called when there's incoming data on the websocket for this channel
      var card_template = Handlebars.compile($('#card_template').html());
      var hand = data.hand;
      var hand_html = '';
      for (var i = 0; i < hand.length; i++) {
        hand_html += card_template({card: hand[i]});
      }
      $('#hand').html(hand_html);
    }
  });