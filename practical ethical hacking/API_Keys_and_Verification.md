
# Understanding APIs and API Key Verification

## What Are APIs?

APIs (Application Programming Interfaces) allow software systems to communicate and interact with each other. They provide a set of defined rules and protocols for this interaction.

### Types of APIs
1. **REST APIs**: Use HTTP methods and URLs to interact with resources.
2. **GraphQL APIs**: Allow flexible queries by specifying the data structure.
3. **SOAP APIs**: Use XML-based messaging protocols.
4. **Webhooks**: Push-based APIs triggered by events.

---

## Using an External API for Money Transactions

### Example: Integrating Stripe API

1. **Frontend Flow:**
   - The user enters payment details securely via Stripe Elements.
   - The frontend sends these details to Stripe using a **public API key**, generating a `paymentMethod.id`.

2. **Backend Flow:**
   - The `paymentMethod.id` is sent to the backend.
   - The backend uses a **secret API key** to validate and process the payment.

3. **Webhook Flow:**
   - Stripe sends event notifications (e.g., successful payment) to your server's webhook URL.
   - Your server verifies the event using Stripe's signature.

---

## API Keys and Their Verification

### Types of API Keys

| **Type**          | **Usage**                               | **Scope**              |
|--------------------|-----------------------------------------|------------------------|
| **Public Key**     | Used in frontend, exposed in the browser | Tokenization, safe operations |
| **Secret Key**     | Backend only, must be secure            | Full access to the API |
| **Restricted Key** | Backend, limited to specific actions    | Scoped operations      |

### Verification Process

1. **Frontend Verification:**
   - Public API keys are verified indirectly via tokenization (e.g., `paymentMethod.id`).
   - Sensitive details like card numbers are not exposed.

2. **Backend Verification:**
   - The secret API key is sent with requests to authenticate them.
   - Stripe validates the key’s validity and permissions.

3. **Webhook Verification:**
   - Webhook events are signed with a secret key.
   - The server computes a signature and matches it against the webhook signature.

---

## Security Best Practices

- **Keep Secret Keys Confidential:** Use environment variables or secret managers.
- **Use Restricted Keys:** Limit access for third-party integrations.
- **Validate Tokens:** Ensure the backend validates all data from the frontend.
- **Rate-Limit Requests:** Prevent abuse by throttling API calls.
- **Monitor Activity:** Regularly check API usage logs for anomalies.

---

## Risks of Changing the Public API Key

### Potential Scenarios
1. **Valid Key from Another Account:** Breaks functionality as tokens won’t match your backend.
2. **Invalid Key:** API calls from the frontend fail, disrupting operations.

### Security Implications
- Public API keys alone **cannot compromise backend security**.
- Risks arise only if backend validation is inadequate.

---

## Conclusion

Public API keys are safe for their intended scope but must be combined with proper backend validation and security measures. Always ensure sensitive operations use the secret key securely.

