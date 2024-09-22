# access  control 
## 1 payment method manipulation
Say that the POST request to submit the order with a saved payment method looks like this, where the payment_id parameter refers to the ID of the user’s saved credit card: 
![[Pasted image 20240920202000.png]] 

Users can also pay with a new credit card for each order. If users pay with a new credit card, the card will be verified at the time of checkout. Say the POST request to submit the order with a new payment method looks like this:
![[Pasted image 20240920202032.png]]

To reiterate, the application will verify the credit card number only if the customer is using a new payment method. But the application also determines whether the payment method is new by the existence of the saved_card parameter in the HTTP request. So a malicious user can submit a request with a saved_card parameter and a fake credit card number. Because of this error in payment verification, they could order unlimited items for free with the unverified card:
![[Pasted image 20240920202103.png]]



# SSRF 
## 1 webhoock redirection 
This report describes a **vulnerability** in how webhooks follow **HTTP redirects**. Specifically, it outlines a scenario where the system prevents following redirects in general but improperly follows **HTTP 303 See Other** redirects. An attacker can exploit this to access sensitive information, such as AWS credentials, from the server’s internal metadata service.

### Breakdown of the vulnerability:

1. **Webhook Behavior**: Normally, webhooks in this system do not follow redirects to prevent them from being used to access unintended resources.
2. **Bypassing Redirect Restrictions**: The system still follows HTTP 303 (See Other) redirects, which can be exploited.
3. **Exploitation Method**:
    - The attacker sets up a webhook URL that points to a malicious server.
    - The malicious server sends a **303 redirect** to the AWS metadata service URL, which hosts sensitive information like IAM role credentials.
4. **Sensitive Information Exposure**: Since the application server follows the 303 redirect, it ends up sending a request to the AWS metadata service at `http://169.254.169.254/latest/meta-data/iam/security-credentials/aws-opsworks-ec2-role`, and the response includes sensitive AWS credentials.
5. **Attacker Control**: The attacker can read these credentials and use them for unauthorized access to the AWS environment.

### Steps to Reproduce:

1. The attacker creates a malicious script (`redir.php`) hosted on their server. This script issues a **303 redirect** to the AWS metadata URL to extract IAM role credentials:
    
    php
    
    Copy code
    
    `<?php header('Location: http://169.254.169.254/latest/meta-data/iam/security-credentials/aws-opsworks-ec2-role', TRUE, 303); ?>`
    
2. They set the webhook endpoint in the application (e.g., at `https://dashboard.omise.co/test/webhooks/edit`) to point to their malicious server (`https://<attacker-server>/redir.php`).
3. They trigger the webhook by making a random API call, such as adding a user, which initiates a request to the attacker's webhook.
4. The webhook follows the **303 redirect** to the AWS metadata URL, exposing sensitive data.
5. The attacker then views the response body, which contains sensitive AWS credentials, in the "Recent Deliveries" section of the webhook.