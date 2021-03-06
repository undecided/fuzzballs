// Generated by CoffeeScript 1.7.1
(function() {
  var Fuzz;

  Fuzz = (function() {
    function Fuzz() {}

    Fuzz.prototype.setOriginal = function(original, extractor) {
      this.original = original;
      this.extractor = extractor != null ? extractor : null;
      this.original_string = this.extractor ? this.extractor(this.original) : this.original;
      this.score = 0;
      return this;
    };

    Fuzz.prototype.quantifyMatch = function(q) {
      var current, last, qchar, qchar_index, _i, _len, _ref, _ref1, _ref2;
      this.q = q;
      _ref = [-1, -1], current = _ref[0], last = _ref[1];
      _ref1 = this.q;
      for (qchar_index = _i = 0, _len = _ref1.length; _i < _len; qchar_index = ++_i) {
        qchar = _ref1[qchar_index];
        _ref2 = [this.original_string.indexOf(qchar), current], current = _ref2[0], last = _ref2[1];
        if (current >= 0) {
          this.score += 1;
        }
        if (current >= 0 && qchar_index > 0) {
          if (this.original_string.indexOf(this.q[qchar_index - 1] + qchar) >= 0) {
            this.score += 1;
          }
        }
      }
      return this;
    };

    Fuzz.prototype.pushOrSkip = function(arr) {
      if (this.score >= this.q.length) {
        arr.push(this);
      }
      return this;
    };

    return Fuzz;

  })();

  this.Fuzzballs = (function() {
    function Fuzzballs(arr, options) {
      this.arr = arr;
      this.options = options != null ? options : {};
    }

    Fuzzballs.prototype.setOptions = function(options) {
      this.options = options;
    };

    Fuzzballs.prototype.find = function(q) {
      var item, out, _i, _len, _ref;
      out = [];
      _ref = this.arr;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        new Fuzz().setOriginal(item, this.options.extractor).quantifyMatch(q).pushOrSkip(out);
      }
      return out;
    };

    return Fuzzballs;

  })();

}).call(this);
