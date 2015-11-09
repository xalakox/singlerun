# singlerun
	Make sure an instance of the currently running script is only instanced once.

## singlerun(killother, includeparams, mainProc)

Runs the mainProc if killother is true and is not currently running a script with the same name.

**Arguments**

* `killother` boolean that specifies what to do if the script is already running, if true it will send a kill segterm to the other proc.
* `includeparams` boolean that tells singlerung to consider the arguments of the script as part of the search of a process already running, if false it will just consider the script name; i.e. `myscript.js` and `myscript.js --help` would be different if includeparams is true.


### examples

```javascript
singlerun = require("singlerun")

// run script and kill any other instance of same script witouth considering the parameters for uniqueness
singlerun(true, false, function(){
	console.log "hello planet!"
});

// run script if not already running considering the parameters of the script
singlerun(false, false, function(){
	console.log "hello planet!"
});
```

