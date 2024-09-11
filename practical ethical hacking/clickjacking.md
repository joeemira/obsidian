script to check for clickjacking 
```
import requests

  

def check_clickjacking(url):

    try:

        response = requests.get(url)

        x_frame_options = response.headers.get('X-Frame-Options', None)

        if x_frame_options:

            print(f"X-Frame-Options: {x_frame_options}")

        else:

            print("X-Frame-Options header is missing.")

        csp = response.headers.get('Content-Security-Policy', None)

        if csp:

            frame_ancestors = [directive for directive in csp.split(';') if 'frame-ancestors' in directive]

            if frame_ancestors:

                print(f"Content-Security-Policy: {csp}")

            else:

                print("Content-Security-Policy does not include 'frame-ancestors'.")

        else:

            print("Content-Security-Policy header is missing.")

    except requests.RequestException as e:

        print(f"Error checking {url}: {e}")

  

if __name__ == "__main__":

    target_url = input("Enter the URL to check for clickjacking: ")

    check_clickjacking(target_url)
```

# Common Clickjacking Scenarios (No CSRF Involved):
1. Likejacking (Social Media Clickjacking):

    Scenario: A user is tricked into "liking" a Facebook post or following a Twitter account without realizing it.
    How It Works: The attacker embeds a hidden Facebook Like button or similar social media widget within an iframe and overlays it with fake content on the attacker’s website (e.g., a fake game or video player). When the user clicks to start the game or video, they unknowingly “like” or follow the hidden content.
    Impact: This can be used to artificially boost likes or followers for a page, product, or person.

2. Banking Clickjacking:

    Scenario: A user is tricked into clicking on a “Transfer Funds” button on a banking website.
    How It Works: The attacker embeds the bank’s transfer page in an iframe and hides it under a decoy button like "Submit" or "Win a Prize." The victim, believing they are clicking on something else, actually initiates a bank transfer.
    Impact: The attacker might steal money by transferring funds from the victim’s account.

3. Ad Fraud:

    Scenario: The attacker uses clickjacking to drive fake clicks on advertisements for profit.
    How It Works: Ads are embedded in hidden iframes, and users are tricked into clicking on them while interacting with a decoy page.
    Impact: Advertisers are charged for fake ad clicks, while the attacker profits from ad revenue.

4. Subscription Traps:

    Scenario: A user unknowingly subscribes to a service by clicking on what appears to be a legitimate button on a malicious page.
    How It Works: The attacker overlays the subscription button from the legitimate website (e.g., "Subscribe to a paid service") in an iframe, hiding it under a visible decoy button.
    Impact: The user is subscribed to a service they didn’t intend to sign up for, often leading to financial loss or unwanted emails.

5. Settings Hijacking:

    Scenario: The attacker alters the privacy or security settings of a user on a legitimate website.
    How It Works: The attacker frames the legitimate settings page of a website in an iframe and tricks the user into clicking on areas that change their privacy settings, like making their profile public or enabling unwanted notifications.
    Impact: This can lead to exposure of sensitive information or the user becoming vulnerable to further attacks.

6. Email Hijacking:

    Scenario: A user is tricked into sending emails or performing actions in their email account.
    How It Works: The attacker frames the user’s email account interface and tricks them into clicking on a hidden "Send Email" or "Delete Email" button.
    Impact: Sensitive emails may be deleted, or emails may be sent to unintended recipients, potentially leaking sensitive information.

7. Online Game Exploits:

    Scenario: An attacker exploits an online game's UI to make players perform unintended actions.
    How It Works: In online games with interactive UIs, the attacker frames a game element (like a “sell item” or “spend credits” button) and overlays it with a fake UI. The user clicks to perform what seems like a benign action, but ends up losing items or spending in-game currency.
    Impact: The player loses valuable items or in-game currency without realizing it.
# Account Deletion:

    Scenario: The attacker tricks the user into deleting their own account on a legitimate website.
    How It Works:
        The website uses a CSRF token to protect the account deletion request.
        The attacker uses an iframe to load the account deletion page but overlays it with a "Click here for a prize" button or some other form of decoy.
        When the user clicks, they unknowingly trigger the "delete account" action, which includes the CSRF token from their current session.
    Impact: The user's account is deleted without their knowledge.

Defense:

    CSRF tokens are meant to protect against forged requests, but if the legitimate request is generated through Clickjacking, the CSRF token might still be valid. To prevent this, implementing X-Frame-Options or Content Security Policy (CSP) can block the page from being framed.

2. Money Transfer (Banking):

    Scenario: A user is tricked into transferring money to an attacker’s account.
    How It Works:
        A banking website is embedded within an invisible iframe on a malicious page.
        The attacker creates a decoy button that says “Click to win $100” but positions it over the “Transfer Funds” button in the invisible iframe.
        The legitimate transfer form includes a CSRF token, but the victim’s click submits the form with the token since they are already authenticated.
        As a result, the money is transferred to the attacker's account.
    Impact: The user unknowingly transfers funds from their bank account to the attacker's account.

Defense:

    Besides CSRF tokens, the banking website should use X-Frame-Options: DENY to block framing, and two-factor authentication (2FA) can be added for sensitive actions like fund transfers.

3. Changing Email Address:

    Scenario: An attacker changes the victim's email address on their profile to gain control of the account.
    How It Works:
        The attacker frames the profile page of a website that has a form to change the user’s email address, protected by a CSRF token.
        The attacker positions a decoy button over the “Save Changes” button of the email change form.
        When the user clicks, the form is submitted with the attacker's email address, and the CSRF token is valid since the victim is authenticated.
    Impact: The attacker can now reset passwords and take control of the account.

Defense:

    Implement frame-busting techniques and use CAPTCHA for sensitive actions like changing email addresses.

4. Subscription or Service Activation:

    Scenario: The user unknowingly subscribes to a paid service.
    How It Works:
        The attacker embeds the subscription page of a service provider in a hidden iframe on their malicious page.
        The subscription form requires a CSRF token, but because the victim is authenticated, their session includes a valid token.
        The attacker overlays a fake button that says “Play video,” which triggers the subscription form submission.
    Impact: The victim is subscribed to a paid service without their knowledge.

Defense:

    In addition to CSRF protection, the service provider should require user confirmation (e.g., an email confirmation or re-entering a password) to complete the subscription process, especially for paid services.

5. Voting and Poll Manipulation:

    Scenario: The attacker forces the user to vote for a specific candidate or option in an online poll or election.
    How It Works:
        The attacker embeds the voting form within a hidden iframe and overlays it with a decoy element.
        When the user clicks the decoy, they unknowingly submit the form with the attacker’s preferred option.
        Since the user is authenticated on the voting site, their vote is cast with a valid CSRF token.
    Impact: The attacker can manipulate votes in online polls or elections.

Defense:

    Implement multi-step confirmations for voting and use CAPTCHAs to ensure that each submission is intentional.

6. Password Reset via Email Change:

    Scenario: The attacker changes the victim’s email and uses it to reset the victim’s password.
    How It Works:
        The attacker creates a decoy webpage with a fake button that says “Start Game,” which is positioned over a "Change Email" button in an iframe to the legitimate website.
        When the victim clicks, the attacker's email is submitted along with a valid CSRF token.
        The attacker now has control over the victim's account and can request a password reset.
    Impact: The attacker gains access to the victim’s account by first changing their email.

Defense:

    Websites should require a password re-entry or two-factor authentication (2FA) to change sensitive information like the email address

# techniques 
1. first you need to check if the endpoint allows Iframes  by using the script above 
2. 