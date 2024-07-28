## SQL syntax 
-` select * where  from table where user ='joe' limit 0,1  ;   --` limit is here to limit the numbers of the output 
- ![[Pasted image 20240728121425.png]]
- ![[Pasted image 20240728122041.png]]

## injection 
- union cannot work if  the query calls  different numbers of columns 
- so we check for the number of columns in the query by `order by ***`
- if the number you gave  is work increase until it didn't work so the last number worked is the correct number  
- and then u need to know what number is interpreted in the page 
- by using `jeremy 'union select 1,2,3 #`
- after checking for numbers of calls  then you should use this 
- ` jeremy 'union select 1,2,table_name from information_schema.tables where table_schema =database() ; #`
- you use a valid syntax and then u inject the payload 
- portswigger sql cheat sheet 

==try to search for any thing injectable like cookies validation or any thing 
