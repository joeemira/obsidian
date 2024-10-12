# Open Redirects Hunting Checklist

## What is an Open Redirect?

An open redirect occurs when a website allows a user-supplied URL to control its redirection process without sufficient validation. This can be exploited by attackers to redirect users to malicious sites.
### Mechanisms Behind Open Redirects:

- **Redirect Parameters**: Sites often use URL parameters (e.g., `?redirect=`, `?next=`, etc.) to specify redirect locations, commonly used after a login attempt or access denial to a certain page.

## 1. Identify Redirect Parameters

- **Search for URL Parameters**:

  - Look for common redirect parameter names like `redirect`, `redir`, `next`, `RelayState`, `forward`, etc.

  - Check URLs such as:

    - `https://example.com/login?redirect=https://example.com/dashboard`

    - `https://example.com/login?next=/dashboard`

  - Note: Not all parameters are explicitly named. Record any parameter used for redirection.

  
- **Look for Referer-Based Redirects**:

  - Identify pages that redirect without explicit URL parameters.

  - Watch for **3XX HTTP response codes** (301, 302), which often indicate redirections.

  

## 2. Use Google Dorks for Further Discovery

- **Dorking Parameters**:

  - Use Google dorks to find additional redirect parameters on the target site.

    - `inurl:%3Dhttp site:example.com` - Finds absolute URL parameters.

    - `inurl:%3D%2F site:example.com` - Finds relative URL parameters.

  - Try searching for parameter names directly:

    - `inurl:redirect site:example.com`

    - `inurl:forward site:example.com`

    - `inurl:next site:example.com`

  

## 3. Test for Parameter-Based Open Redirects

- **Inject External Hostnames**:

  - Replace redirect parameter values with external domains:

    - `https://example.com/login?redirect=http://attacker.com`

    - `https://example.com/login?next=http://google.com`

  - Test whether the site redirects to the external hostname immediately or after an action (like login/logout).

  

## 4. Test for Referer-Based Open Redirects

- **Create a Referrer Link**:

  - Set up an HTML link pointing to the target site:

    ```html
    <html>
      <a href="https://example.com/login">Click to log in</a>
    </html>
    ```

  - Host this page on a test domain. When clicked, the referer should point to your domain, allowing you to observe redirection behavior.

  

## 5. Bypass Open-Redirect Protections

- **Browser Autocorrect Techniques**:

  - Test alternative URL formats:

    - `https:attacker.com`

    - `https;attacker.com`

    - `https:\attacker.com`

- **Exploit Encoding and Special Characters**:

  - Use non-ASCII characters or double/triple encoding:

    - `https://example.com%2f@attacker.com`

    - `https://example.com%25252f@attacker.com`

  - Test URLs with characters like `ÿ` (`%ff`), which may confuse validators.

  

- **Data URLs**:

  - Use data schemes with base64 encoding:

    - `data:text/html;base64,PHNjcmlwdD5sb2NhdGlvbj0iaHR0cHM6Ly9leGFtcGxlLmNvbSI8L3NjcmlwdD4=`

  

- **Complex URL Structures**:

  - Experiment with URLs that start and end with the legitimate domain but redirect offsite:

    - `https://example.com/login?redir=https://example.com.attacker.com/example.com`

  

## 6. Escalate and Chain Vulnerabilities

- **Phishing Attacks**:

  - Craft URLs with open redirects to legitimate domains that ultimately lead to malicious sites.

  - Example: `https://example.com/login?next=https://attacker.com/fake_login.html`

  

- **Token/Credential Theft**:

  - If sensitive information is passed in the referer, use open redirects to capture data like authentication tokens.

  

- **Bypass Allowlist/Blocklist**:

  - In cases like SSRF, use open redirects to bypass restrictions and access otherwise protected URLs.

  

## Prevention Methods

- **URL Validation**:

  - **Allowlists**: Only allow redirection to specified, trusted domains.

  - **Blocklists**: Block known malicious indicators, though they are less effective due to bypass techniques.

  - Avoid referer-based redirects, and instead use safer mechanisms like specific redirect tokens.

  

## Final Steps

1. **Review All Findings**: Document all discovered redirect parameters and successful bypass techniques.

2. **Check Potential Impact**: Analyze if the open redirects could lead to credential theft, phishing, or other serious consequences.

3. **Verify in Bug Chains**: Identify other vulnerabilities that could be exploited in combination with open redirects for maximum impact.