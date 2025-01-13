-- if you want to monitor  function just type in the console `monitor(name of the function);`
whenever the function is called it will notify you with the arguments 

-- but if the function is taking the arguments as JSON object the monitor function will only notify you but without the argument , you just overwrite the function to make it print in the console the arguments  use the code 
```js
let old = wantedfunction ; 
wantedfunction = function(arg){
console.log("the function called with argument "+JSON.stringify(ar));
return old(arg);
}
```

-- what if you want to check what to monitor property or variable we can't use monitor we
every variable have it's setter and getter the setter the one who changes the value of the variable and the getter the one who read the value of the variable  how we monitor then ?
		for example we want to to monitor the document.hash property :if we want to check the setter `debug(location.__lookupSetter__("hash"));`
		the Getter `debug(location.__lookupGetter__("hash"));


ok , what if the function get called when the document is loaded 
we can't use debug or monitor we have to use breakpoints 