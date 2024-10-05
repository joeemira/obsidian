# SSL certificate
1. **Digital Certificate**: A digital certificate is an electronic document used to prove the ownership of a public key. Certificates are issued by trusted entities known as Certificate Authorities (CAs) and typically include information about the certificate holder, the public key, the issuing CA, and a validity period.
2. **Hash Function**: A cryptographic hash function (e.g., SHA-256, SHA-1, MD5) is applied to the certificate's binary data. Hash functions take an input and produce a fixed-size string of characters, which appears random. Even a small change in the input results in a significantly different hash.
3. **Fingerprint**: The resulting hash value is the certificate's fingerprint. This fingerprint is a unique identifier for the certificate.

### Use Cases

1. **Certificate Verification**: Fingerprints can be used to verify that a certificate is authentic and hasn't been tampered with. By comparing the fingerprint of a certificate received from a website with the expected fingerprint (published by a trusted source), users can ensure they are communicating with the intended party.
2. **Trust Establishment**: Fingerprints help in establishing trust in scenarios where certificates are exchanged or verified manually. For example, administrators can use fingerprints to verify certificates in secure communication setups.
3. **Security Audits**: During security audits, fingerprints are used to ensure that the correct certificates are in place and have not been replaced or altered.
4. **TLS/SSL**: In Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols, fingerprints are used to verify the identity of servers and clients during the handshake process.

### Example

Suppose you receive a digital certificate from a website. To ensure its authenticity:

1. Obtain the certificate's fingerprint using a tool or command (e.g., `openssl x509 -noout -fingerprint -sha256 -in certificate.crt`).
2. Compare this fingerprint with the one published by the website or the issuing CA.
3. If the fingerprints match, the certificate is authentic and can be trusted.

### Benefits

- **Security**: Fingerprinting helps detect and prevent man-in-the-middle attacks by ensuring the integrity and authenticity of certificates.
- **Simplicity**: Fingerprints provide a straightforward way to verify certificates without needing to analyze the entire certificate content.

By using certificate fingerprints, organizations can enhance the security of their communications and ensure that digital certificates are valid and trustworthy.  


# response Code 
![[Pasted image 20240711235635.png]]

 
# DNS records 
 1. A Record:
    
    - Maps a domain name to an IPv4 address.
    - Example: `google.com (FQDN) --> a_record --> 172.253.115.139 (IPAddress)`
2. **AAAA Record**:
    
    - Maps a domain name to an IPv6 address.
    - Example: `health.google.com (FQDN) --> aaaa_record --> 2607:f8b0:4004:c06::64 (IPAddress)`
3. **MX Record**:
    
    - Specifies the mail servers responsible for receiving email for a domain.
    - Example: `google.com (FQDN) --> mx_record --> smtp.google.com (FQDN)`
4. **NS Record**:
    
    - Indicates the name servers for a domain.
    - Example: `google.com (FQDN) --> ns_record --> ns1.google.com (FQDN)`
5. **CNAME Record**:
    
    - Creates an alias for a domain name, mapping one domain to another.
    - Example: `productforums.google.com (FQDN) --> cname_record --> groups.l.google.com (FQDN)`

# same site cookie 
### Strict

If a cookie is set with the `SameSite=Strict` attribute, browsers will not send it in any cross-site requests. In simple terms, this means that if the target site for the request does not match the site currently shown in the browser's address bar, it will not include the cookie.

This is recommended when setting cookies that enable the bearer to modify data or perform other sensitive actions, such as accessing specific pages that are only available to authenticated users.

Although this is the most secure option, it can negatively impact the user experience in cases where cross-site functionality is desirable.

### Lax

`Lax` SameSite restrictions mean that browsers will send the cookie in cross-site requests, but only if both of the following conditions are met:

- The request uses the `GET` method.
    
- The request resulted from a top-level navigation by the user, such as clicking on a link.
    

This means that the cookie is not included in cross-site `POST` requests, for example. As `POST` requests are generally used to perform actions that modify data or state (at least according to best practice), they are much more likely to be the target of CSRF attacks.

Likewise, the cookie is not included in background requests, such as those initiated by scripts, iframes, or references to images and other resources.

### None

If a cookie is set with the `SameSite=None` attribute, this effectively disables SameSite restrictions altogether, regardless of the browser. As a result, browsers will send this cookie in all requests to the site that issued it, even those that were triggered by completely unrelated third-party sites.

With the exception of Chrome, this is the default behavior used by major browsers if no `SameSite` attribute is provided when setting the cookie.

There are legitimate reasons for disabling SameSite, such as when the cookie is intended to be used from a third-party context and doesn't grant the bearer access to any sensitive data or functionality. Tracking cookies are a typical example.

If you encounter a cookie set with `SameSite=None` or with no explicit restrictions, it's worth investigating whether it's of any use. When the "Lax-by-default" behavior was first adopted by Chrome, this had the side-effect of breaking a lot of existing web functionality. As a quick workaround, some websites have opted to simply disable SameSite restrictions on all cookies, including potentially sensitive ones.

When setting a cookie with `SameSite=None`, the website must also include the `Secure` attribute, which ensures that the cookie is only sent in encrypted messages over HTTPS. Otherwise, browsers will reject the cookie and it won't be set.

`Set-Cookie: trackingId=0F8tgdOhi9ynR1M9wa3ODa; SameSite=None; Secure`