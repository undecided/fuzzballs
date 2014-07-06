class FuzzFactory
  @small: ->
    [
      "fishes",
      "dishes",
      "mats",
      "cats",
      "hats",
      "switch"
    ]

  @large: ->
    [0..1000].join() for i in [0..10000]

  @complex: ->
    {'extractable': str} for str in @small()