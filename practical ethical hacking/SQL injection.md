## SQL syntax 
-` select * where  from table where user ='joe' limit 0,1  ;   --` limit is here to limit the numbers of the output 
- ![[Pasted image 20240728121425.png]]
- ![[Pasted image 20240728122041.png]]
## classification
- **First-Order SQL Injection:**
    
    - **Definition:** In a first-order SQL injection attack, the malicious payload is directly inserted into the application's database query.
    - **Execution:** The attacker typically injects SQL code through user inputs, such as form fields or URL parameters. When the application processes these inputs without proper validation or sanitization, the injected SQL code gets executed by the database.
    - **Example:** If a web form accepts user input for a username and constructs a SQL query like `SELECT * FROM users WHERE username = '<user_input>';`, an attacker could input `' OR 1=1 --` to manipulate the query to return all records from the `users` table.
- **Second-Order SQL Injection:**
    
    - **Definition:** Second-order SQL injection involves injecting malicious payloads that are stored within the application's database, rather than being directly inserted into a query.
    - **Execution:** The injected data is stored in the database first and then later retrieved and used in a query. When the application retrieves and uses this data in a query without proper validation or sanitization, it inadvertently executes the injected SQL code.
    - **Example:** An attacker might submit malicious input that gets stored in the database (e.g., during registration or profile updates). Later, when another user or administrator views that data, the application constructs a query using the stored, but now malicious, input.
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
