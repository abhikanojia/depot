function Slider(options) {
  this.loop = options.loop;
  this.delay = options.delay;
  this.speed = options.speed;
  this.sliderItems = options.sliderItems;
  this.mainContainer = options.mainContainer;
  this.sliderContainer = options.sliderContainer;
}

Slider.prototype.getNext = function(current) {
  return ((current + 1) == this.sliderItems.length) ? 0 : (current + 1);
};

Slider.prototype.changeImage = function(current) {
  var _this = this;
  var nextElement = this.getNext(current);
  setTimeout(function(){
    $(_this.sliderItems[current]).fadeOut(_this.speed);
    $(_this.sliderItems[nextElement]).fadeIn(_this.speed, function(){
    });
    _this.changeImage(nextElement);
  }, this.delay);
};

Slider.prototype.init = function() {
  var current = 0;
  this.sliderContainer.prependTo(this.mainContainer);
  this.sliderItems.eq(current).nextAll().hide();
  this.changeImage(current);
};

$(document).ready(function(){
  var options = {
    delay: 5000,
    speed: 3000,
    mainContainer: $("#main"),
    sliderContainer: $("[data-slider=slideshow]"),
    sliderItems: $("[data-slider=slideshow] > li")
  }

  var slider = new Slider(options);
  slider.init();
});
