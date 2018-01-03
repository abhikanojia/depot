function ProductRating(data) {
  this.rateButton = $(data.rateButton);
}

ProductRating.prototype.update = function(data) {
  var _this = this;
  $.ajax({
    url: _this.url,
    type: 'PATCH',
    data: data,
    success: function(response) {
      alert('Thanks for rating !!');
    },
    error: function(xhr) {
      alert(xhr.statusText);
    }
  });
};

ProductRating.prototype.ratingsHandler = function(event) {
  event.preventDefault();
  this.url = event.target.form.action;
  this.serializedData = $(event.target.form).serialize();
  this.update(this.serializedData);
};

ProductRating.prototype.init = function() {
  var _this = this;
  this.rateButton.on('click', function(event){ _this.ratingsHandler(event); });
};

$(document).ready(function(){
  var data = {
    rateButton: '.ratings .submit-ratings',
  };

  var rating = new ProductRating(data);
  rating.init();
});
