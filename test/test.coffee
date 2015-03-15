
assert = require "assert"
describe 'Pid Creation', ->
	it 'should create a pid file', (done)->
		console.log "here..."
		require('child_process').exec __dirname + '/../index.coffee', (err, stdout, sdterr)->
			console.log "process exited ..", err, stdout
			done()
		setTimeout ->
			console.log "waited for process.."
			require('fs').exists __dirname + '/../index.coffee.pid', (exists)->
				console.log "exits", exists
				assert.equal true, exists
		,500
	it 'should create a pid with arguments', (done)->
		argument_base64 = (new Buffer("--testargument").toString('base64'))
		done()
		
  describe '#indexOf()', ->
    it 'should return -1 when the value is not present', ->
      assert.equal -1, [1,2,3].indexOf(5)
      assert.equal -1, [1,2,3].indexOf(0)

