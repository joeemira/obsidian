
happens when the verification  happens in server side 
OTP bypass
- intercept the response of the request of login  and change the the response
- change the error code to success 
- use default OTP master  0000
- or you can try to put any thing in the body of response
- we can check for OPT exposure in the response of the request 

User name enumeration 
- we can enumerate the user name by sending wordlist and lock for the length  or  the request length  or response time 
 - if there is a `X-Forwarded-For` header you can spoof the **IP** `X-Forwarded-For:2`
 - check the time of authentication of user name or passwords to (that will help you t better understand the mechanism of the authentication of the program )
 - 