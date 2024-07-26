# how it works 
When you type `http://example.com/index.php?page=../../../etc/passwd` into your browser, you're attempting a type of attack known as a **Directory Traversal Attack** (or Path Traversal Attack). This attack aims to access files and directories that are stored outside the web root folder. Here's what happens in the background:

1. **Browser Request**:
    
    - The browser sends an HTTP request to the web server. The URL you typed translates to a request for the `index.php` file on the server, with a query parameter `page` set to `../../../etc/passwd`.
    
    bash
    
    Copy code
    
    `GET /index.php?page=../../../etc/passwd HTTP/1.1 Host: example.com`
    
2. **Server Processing**:
    
    - The web server receives the request and passes it to the PHP interpreter because the requested resource is a PHP file (`index.php`).
    - The PHP script (`index.php`) retrieves the value of the `page` parameter. If the script is vulnerable and does not properly validate or sanitize this input, it may use this parameter directly in file operations.
3. **File Inclusion**:
    
    - If the PHP script uses the `page` parameter in a file inclusion function like `include()`, `require()`, `include_once()`, or `require_once()`, it will attempt to include the specified file.
    - Due to the `../../../etc/passwd` path, the script attempts to navigate up the directory tree from the web root and access the `/etc/passwd` file, which is a common file in Unix-like operating systems that contains user account information.
4. **File Access**:
    
    - If the web server's configuration and the PHP script's logic allow it, the `/etc/passwd` file will be read and its contents will be included or outputted by the PHP script.
    - The content of `/etc/passwd` is then sent back to the browser as part of the HTTP response.
5. **Response**:
    
    - The browser receives the HTTP response from the server and displays the content of the `/etc/passwd` file.

### Example Scenario

Here’s a hypothetical example of a vulnerable PHP script:

php

Copy code

`<?php $page = $_GET['page']; include($page); ?>`

In this case, the `include` statement is directly using user input without any validation or sanitization. If you pass `../../../etc/passwd` as the `page` parameter, the script will include the `/etc/passwd` file.

### Mitigation

To prevent such attacks, web applications should:

- **Validate and sanitize user input**: Ensure that input does not contain any traversal characters (`../`).
- **Use predefined lists of allowed files**: Instead of accepting arbitrary input, only allow specific, known-good files.
- **Use proper access controls**: Ensure that sensitive files are not accessible to the web server.
- **Use PHP's built-in functions safely**: Functions like `realpath()` can help resolve the true path and prevent directory traversal.

By understanding and mitigating these vulnerabilities, you can enhance the security of web applications against directory traversal attacks.


# payloads 
- we can use ../../../../../etc/passwd   and pass it to any query parameter    
- we can check for encoding
- we can check for recursively filter if it's not properly implemented by usin ..././..././..././..././..././etc/passwd 
- or `.\..\..\windows\win.ini` `../../../../../../windows/system32/win.ini` `../../../../../../windows/system32/drivers/etc/hosts` on windows
- we can use NULLBYTE %00  to bybass any fixed extension .jpg .txt 
- to improve the severity of LFI we can show the php code  by using php encoding 
- if he is checking if there extension in the query parameters we can use `../../../etc/passwd%00.jpg`



