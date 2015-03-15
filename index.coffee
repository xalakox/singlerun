#!/usr/bin/env coffee

doPid = ([killother, includeparams]..., callback)->
	killother ?= false
	includeparams ?= false
	# process and stuff (stick to 1 instance per execution)
	delpid = true
	fs = require "fs"
	leargs = ""
	leargs+=i+":"+arg for arg,i in process.argv when arg isnt "coffee" and arg isnt "node" and arg isnt __filename 
	pidfile = __dirname + "/" + __filename.split('/').pop() + (new Buffer(leargs).toString('base64')) + '.pid'

	console.log "args : ", leargs
	process.on 'exit', (code) ->
		if fs.existsSync(pidfile) and delpid
			console.log 'Removing pid file..'
			fs.unlinkSync pidfile
			return

	isrunning = (pid, callback)->
		require('child_process').exec 'ps -A -o pid', (error, stdout, stderr)->
			if error
				#console.log cmdline, error, stdout, stderr
				throw new Error (error)
			callback (stdout.split("\n").indexOf(pid) isnt -1)

	check = (cback)->
		if fs.existsSync(pidfile)
			#there is already a process running
			delpid = false
			console.log "Pid file exists"
			data = fs.readFileSync pidfile, "utf8"
			if data?
				isrunning data,(isit)->
					if isit
						console.log 'Yuma IS already running'
						process.exit 1
					else
						console.log '%s Process not found, running it (and removing pid in proces)', data
						cback()
			else
				console.log "Pid file found but no data in it, erasing pid"
				cback()
		else
			cback()
	check ()->
		#create a pid file and run main
		fs.unlink pidfile, (err) ->
			# just in case
			fs.writeFile pidfile, process.pid, { encoding: 'utf8' }, (err) ->
				throw err if err
				console.log 'created ', pidfile
				callback()



if !module.parent
	doPid false,true,->
		console.log "running"
		setTimeout ->
			console.log "not anymore"
			process.exit 0
		,1000
else
    exports = doPid