class Fuzz
  setOriginal: (@original, @extractor = null) ->
    @original_string = if @extractor then @extractor(@original) else @original
    @score = 0
    @

  quantifyMatch: (@q) ->
    [current, last] = [-1, -1]
    for qchar, qchar_index in @q
      [current, last] = [@original_string.indexOf(qchar), current]
      @score += 1 if current >= 0
      if current >= 0 && qchar_index > 0
        @score += 1  if @original_string.indexOf(@q[qchar_index - 1] + qchar) >= 0
    @

  pushOrSkip: (arr)->
    arr.push @ if @score >= @q.length
    @


class @Fuzzballs
  constructor: (@arr, @options = {}) ->

  setOptions: (@options) ->

  find: (q) ->
    out = []
    for item in @arr
      new Fuzz()
        .setOriginal(item, @options.extractor)
        .quantifyMatch(q)
        .pushOrSkip(out)
    out



