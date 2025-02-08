exploitation 


- if the pyload is inserted in a href    you can use `javascript:payload`
- if you found xss try to find falire to invalidate session on logout



##### htmlentities
```html
<a href='/profile/<?php echo htmlentities($user); ?>'></a>
```
the htmlentities doesn't encode  single quote  so the user may add ' and add event handler 

```php
<?php

// Check if the user has submitted the form

if ($_SERVER["REQUEST_METHOD"] === "POST") {

    // Get the user input from the form

    $user = $_POST['username'] ;

}

?>

  

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Profile Page</title>

</head>

<body>

  

<h1>Enter Your Username</h1>

  

<!-- Form to capture the username -->

<form method="POST" action="">

    <label for="username">Username:</label>

    <input type="text" id="username" name="username" required>

    <input type="submit" value="Submit">

</form>

  

<h2>Profile Link</h2>

<!-- Output the username directly in the href link -->

    <a href='/profile/<?php echo htmlentities($user); ?>'>ss</a>

  

</body>

</html>
```

![[Pasted image 20250107194809.png]]
![[Pasted image 20250107194828.png]]

##### in_array
```php
$parts = explode('.', $GET['jwt']);
$algorithms = array('HS256', 'HS384', 'HS512');
if (3 !== count($parts)) {
  throw new \InvalidArgumentException('Invalid or malformed JWT supplied.');
}
$header = jsondecode(self::decode($parts[0]), true);
if (in_array($header['alg'], $algorithms)) {
  ...
}
```
in_array if the attacker sent the algorithm part = 0 then the  check will return valid cuz the comparison is now between INT & string so it will be always true  

**metigate**
in_array(_search, array, type_) the type must be set to <span style="color:rgb(0, 176, 80)">TRUE</span>  to make the search be on type and the content   be === not == 

##### always check the libraries used in the website and search for exploitation in it 
for example for angular JS  if the input field isn't filtered u may use `{{this.constructor.constructor('alert("hack3d")')() }}`


