# CSRF (Cross-Site Request Forgery)

  

## What is CSRF?

  

**Cross-Site Request Forgery (CSRF)** is a web security vulnerability that allows an attacker to trick users into performing actions they did not intend to, typically without their knowledge. The attack occurs when a user is authenticated and logged into a trusted web application and is then forced to execute unwanted actions, such as submitting forms, changing settings, or making requests to the server, often with the user's authentication tokens.

  

- **Example**: Sending a request to transfer money, change an email address, or modify account details while the user is logged into the target site.

  

### How does CSRF work?

1. The victim is logged into a web application.

2. The attacker tricks the victim into sending a malicious request (through a link, image, or script).

3. The web application accepts the request as legitimate because the victim’s browser automatically sends authentication cookies.

### Why is CSRF dangerous?

If exploited, CSRF can allow unauthorized transactions, data exposure, or privilege escalation. Its impact is heightened in high-privilege accounts (e.g., admins).

  

## Types of CSRF Attacks

  

1. **GET-based CSRF**: Exploits actions that rely on GET requests, such as clicking a malicious link. These requests don't necessarily require user interaction (e.g., visiting a page).

  

2. **POST-based CSRF**: Exploits POST requests where data is submitted to perform an action. It often involves tricking the user into submitting a form that sends harmful data.

  

3. **Login CSRF**: Forces a user to log in with attacker-supplied credentials, which can alter the victim's session state and allow attackers to access the victim’s account or data.  
  

4. **Logout CSRF**: Logs the user out by making an unauthorized logout request, often leading to frustration or setting up future attacks.

  

## Chaining CSRF with Other Vulnerabilities

  

Chaining involves combining CSRF with other vulnerabilities to increase impact. Some common chains include:

- **CSRF + XSS (Cross-Site Scripting)**: Using an XSS vulnerability to execute a CSRF attack by injecting malicious scripts that execute unauthorized actions.

- **CSRF + IDOR (Insecure Direct Object Reference)**: If IDOR allows attackers to manipulate resources belonging to other users, CSRF can exploit this weakness to perform actions on behalf of other users.

- **CSRF + Privilege Escalation**: If a CSRF attack targets administrative functionalities, the attacker could potentially escalate their privileges or access sensitive data.

  

## Escalating the Risk of CSRF

  

To escalate the risk of a CSRF attack:

1. **Target High-Privilege Accounts**: Attacks aimed at admin or superuser accounts can cause severe damage (e.g., altering site configurations, deleting user data).

2. **Sensitive Operations**: Exploiting CSRF in actions like financial transactions, password changes, or deleting resources makes the attack more impactful.

  

3. **Lack of CSRF Tokens**: Applications not using anti-CSRF tokens or other mitigation strategies are more vulnerable. If the application has weak defenses, attackers can easily bypass protections.

  

4. **Multi-Step Actions**: If a CSRF attack can be chained with other vulnerabilities, such as XSS or SQL injection, it can lead to full account compromise, data theft, or privilege escalation.

  

## Vulnerable Code Example

  

```php

// A vulnerable form that lacks CSRF protection

<form action="/change-email" method="POST">

  <input type="email" name="newEmail" placeholder="New Email">

  <button type="submit">Change Email</button>

</form>

```

  

In this code, there is no protection against CSRF attacks. An attacker could trick the user into submitting a request to change their email address without their consent.

  

## CSRF Token Mitigation

  

To mitigate CSRF, the server can generate a unique CSRF token for each user session and embed it in every form or request that requires protection. The server then verifies that the token is present and valid before processing the request.

  

### Mitigated Code Example with CSRF Token

  

```php

// Generating and embedding a CSRF token in the form

session_start();

$token = bin2hex(random_bytes(32));

$_SESSION['csrf_token'] = $token;

?>

  

<form action="/change-email" method="POST">

  <input type="email" name="newEmail" placeholder="New Email">

  <input type="hidden" name="csrf_token" value="<?php echo $token; ?>">

  <button type="submit">Change Email</button>

</form>

  

<?php

// Validating the CSRF token on the server

if ($_POST['csrf_token'] !== $_SESSION['csrf_token']) {

    die('Invalid CSRF token');

}

  

// Process the email change if the token is valid

$newEmail = $_POST['newEmail'];

// Update email logic here...

?>

```

  

### How CSRF Tokens are Stored and Validated

  

- **Token Generation**: The CSRF token is typically generated using a secure random function (e.g., `random_bytes()`) and stored in the user session (`$_SESSION`).

- **Token Storage**: The server stores the generated token in the user’s session and embeds the same token in the form as a hidden input.

- **Token Validation**: When the form is submitted, the server compares the token received in the POST request (`$_POST['csrf_token']`) with the token stored in the session (`$_SESSION['csrf_token']`). If they match, the request is considered legitimate.

### Key Considerations:

- **Token Expiry**: Tokens can be set to expire after a specific period or upon session termination for additional security.

- **Unique per Request**: Ideally, CSRF tokens should be unique per form/request, not just per session.

- **Regeneration**: Upon certain actions like login/logout, CSRF tokens should be regenerated.

  

## Additional CSRF Mitigation Techniques

  

- **SameSite Cookies**: Configure the `SameSite` attribute on cookies to prevent them from being sent in cross-site requests.

- **Referer and Origin Checks**: Validate the `Referer` or `Origin` headers to ensure the request originates from a trusted domain.

- **Re-authentication for Sensitive Actions**: For highly sensitive actions (like changing a password), require users to re-authenticate to further reduce CSRF risks.



































```
<html>
<head>
    <meta name="referrer" content="never">
</head>
<body>
    <form action="https://0a5e0026030b4bec819ea24400d600f5.web-security-academy.net/my-account/change-email" method="POST">
        <input type="hidden" name="email" value="tst@gmail.com" />
        <input type="submit" value="Submit request" />
    </form>
    <script>
        history.pushState('', '', '/?https://0a5e0026030b4bec819ea24400d600f5.web-security-academy.net/my-account?id=wiener');
        document.forms[0].submit();
    </script>
</body>
</html>

``` 
a sample of poc of csrf that checks for refereal header 




tips 
- may be checking for referrer header  [writeup ](https://flex0geek.blogspot.com/2019/04/critical-ibm-bypass-csrf-protection.html)
- or origin 
- if is getting the request as JSON he may be checking the content type 
- or he can accept any content type try to manipulate the content type 
	