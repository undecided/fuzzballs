describe 'Fuzzballs', ->
  describe "default configuration", ->
    [input, fuzz, found] = []

    beforeEach ->
      input = FuzzFactory.small()
      fuzz = new Fuzzballs(input)

    describe "matching all items", ->
      beforeEach ->
        found = fuzz.find "s"

      it "contains the original string in each result", ->
        expect(item.original_string).toEqual input[index] for item, index in found

      it "contains the number of characters in the query string", ->
        expect(item.score).toEqual 1 for item in found

    describe "matching some items", ->
      beforeEach ->
        found = fuzz.find "sh"

      it "should give appropriate scores based on matches and proximity", ->
        expect(found[0].score).toEqual 3
        expect(found[2].score).toEqual 2

      it "should exclude items with a score less than the query length", ->
        expect(found.length).toEqual 4
        expect(item.score).toBeGreaterThan 1 for item in found

      it "should order items by score descending", ->
        scores = (item.score for item in found)
        sorted = scores.sort (a,b)-> a.score - b.score
        console.log sorted
        expect(scores[i]).toEqual sortedScore for sortedScore, i in sorted

  describe "with extractor", ->
    [input, fuzz, found] = []

    beforeEach ->
      input = FuzzFactory.complex()

    describe "using the extractor", ->
      beforeEach ->
        fuzz = new Fuzzballs input,
          extractor: (obj)-> obj.extractable
        found = fuzz.find "s"

      it "should keep the original object", ->
        expect(item.original).toEqual input[index] for item, index in found

      it "should get a string to compare against", ->
        expect(item.original_string).toEqual input[index].extractable for item, index in found



  describe "performance", ->
    input = null

    describe "with large datasets", ->
      beforeEach ->
        input = FuzzFactory.large()

      it "should take less than a second to search 10000 items", ->
        t = new Date()
        fuzz = new Fuzzballs(input)
        fuzz.find([0..100].join())
        expect(new Date() - t).toBeLessThan(1000)






