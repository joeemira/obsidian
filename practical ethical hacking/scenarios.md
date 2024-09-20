# access  control 
## 1 payment method manipulation
Say that the POST request to submit the order with a saved payment method looks like this, where the payment_id parameter refers to the ID of the user’s saved credit card: 
![[Pasted image 20240920202000.png]] 

Users can also pay with a new credit card for each order. If users pay with a new credit card, the card will be verified at the time of checkout. Say the POST request to submit the order with a new payment method looks like this:
![[Pasted image 20240920202032.png]]

To reiterate, the application will verify the credit card number only if the customer is using a new payment method. But the application also determines whether the payment method is new by the existence of the saved_card parameter in the HTTP request. So a malicious user can submit a request with a saved_card parameter and a fake credit card number. Because of this error in payment verification, they could order unlimited items for free with the unverified card:
![[Pasted image 20240920202103.png]]