exploitation 


- if the payload is inserted in a href    you can use `javascript:payload`
- if you found xss try to find failure to invalidate session on logout
- 



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

##### Custom Tags

1. **Custom HTML Tags**: Unlike standard HTML tags (e.g., `<script>`, `<h1>`), custom tags are user-defined and typically include a hyphen (e.g., `<custom-tag>`). These tags are not blocked by the WAF in this lab, allowing them to be injected into the DOM.
    
2. **Injecting Custom Tags**: By injecting a custom tag (e.g., `<custom-tag>`), the attacker can add attributes like `onmouseover` or `onfocus` to execute JavaScript when specific events occur.

##### Making the Payload Auto-Execute

To make the XSS payload execute automatically without user interaction (e.g., hovering or clicking), the attacker uses the following techniques:

1. **`onfocus` Event**: Instead of `onmouseover`, the attacker uses the `onfocus` event, which triggers when the element gains focus.
    
2. **`id` Attribute**: The custom tag is given an `id` (e.g., `id="x"`) so it can be targeted directly from the URL using a hashtag (e.g., `#x`).
    
3. **`tabindex` Attribute**: To make the custom tag focusable, the attacker adds the `tabindex` attribute (e.g., `tabindex="1"`). This allows the element to be focused automatically when the page loads.
    
4. **URL Crafting**: The final malicious URL includes the `#x` fragment, which causes the browser to focus on the custom tag with `id="x"` as soon as the page loads, triggering the `onfocus` event and executing the JavaScript payload (e.g., `alert(document.cookie)`).

##### notes 
- what if you want to to make the severity of you xss  high and not demand user interaction but only a few tags are allowed like `onresize` so we need auto resize script so if we found that the page allows me to use it in `iframes` so we can use code like that 1. `<iframe src="https://vulnerablePage?search=%22%3E%3Cbody%20onresize=print()%3E" onload=this.style.width='100px'>`
- 