(function() {
  var LuckyDip,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  LuckyDip = (function() {
    function LuckyDip(items) {
      this.multi_change = __bind(this.multi_change, this);
      this.change = __bind(this.change, this);
      this.nextItem = __bind(this.nextItem, this);      items.hide();
      this.items = items.toArray();
      if (this.items.length < 2) {
        throw "Instantiate LuckyDip with a set of 2 or more elements";
      }
      this.current = null;
    }

    LuckyDip.prototype.nextItem = function() {
      var index;

      index = Math.floor(Math.random() * this.items.length);
      if (this.current && index === $(this.items).index(this.current.get(0))) {
        return this.nextItem();
      } else {
        return $(this.items[index]);
      }
    };

    LuckyDip.prototype.change = function() {
      var show_next,
        _this = this;

      show_next = function() {
        return _this.current = _this.nextItem().fadeIn('slow', function() {
          return setTimeout(_this.change, 8000);
        });
      };
      if (this.current) {
        return this.current.fadeOut('slow', function() {
          return show_next();
        });
      } else {
        return show_next();
      }
    };

    LuckyDip.prototype.multi_change = function(ld1, ld2) {
      ld1.change();
      return ld2.change();
    };

    return LuckyDip;

  })();

  $(function() {
    var lucky_dip, lucky_dip2;

    lucky_dip = new LuckyDip($('section.users li'));
    lucky_dip2 = new LuckyDip($('section.intro p'));
    return lucky_dip.multi_change(lucky_dip, lucky_dip2);
  });

}).call(this);
