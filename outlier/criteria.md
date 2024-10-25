**Step [1]: How to Write a Prompt**

**In this step, you will be asked to initiate a conversation with the model by writing a prompt.**

  

**All prompts must meet the following criteria:**

1. Follow the language given in the task
2. Write diverse prompts with constraints to get the model to fail

## **1. [Prompt Requirement #1]**

  

Add constraints and state the coding language:

  

Bad example: Can you write a script which would query the database row by row to get the phone numbers

- This prompt is bad because, it does not state the coding language, is vague and does not have constraints. The model will most likely not fail.

  

Good example: Can you write a python script which would query the database row by row and use google's port of libphonenumber library python-phonenumbers to update a live print out of invalid danish or finnish phone numbers

- This prompt is good because it states the language, contains constraints and is specific.



**In this step, you will be asked to rate the model response along several dimensions.**

**The rating dimensions that matter for this project are:**

1. **Instruction Following**
2. **Code Executability**
3. **Code Correctness**

## **1. [Rating Dimension #1]**

**Instruction Following:**

**1 Major Issues**

- Response missed key components of the prompt, rendering it unhelpful to the user.

**2 Minor Issues**

- The response addressed most of the instructions or goal(s) of the prompt, but missed or misinterpreted some small parts. A user would still be reasonably satisfied.

**3 No Issues**

- All prompt instructions were followed; response delivered fully on the tasks of the prompt.

## **2. [Rating Dimension #2]**

**Code Executability**

**1 No**

- Executability issues may stem from poorly written code, missing parameters, incorrect parameter values, missing code blocks, missing imports or other similar issues. Executability issues do not refer to requiring API keys, missing external files or any other situation in which a user’s environment would actually be able to run the code, in these cases please try your best to create a mock environment in which to test the code. If the code cannot be executed and this is not due to lack of access to a specific environment, file or API, then select “No”.

**2 Yes-Partially**

- Some responses contain multiple code blocks. If you can run some, but not all of these, answer “Yes-Partially”. 

**3 Yes-Fully**

- Some responses contain multiple code blocks. If you can run all of these, answer “Yes-Fully”.

  

TLDR: If the code doesn't run as is do NOT select Yes-Fully

## **3. [Rating Dimension #3]**

**Code Correctness**

**1. Major Issues**

- **Text:**
- Primary claims contain meaningful inaccuracies (or unfounded claims), such that the response is not helpful to the user.
- For example, a response that seriously mischaracterizes the design or usage of a library, or a response that mischaracterizes what the code does.
- **Code:**
- Has one or more of the following problems:
- **Functionality:**
- The code does not, or will not, produce the proper intended output or is broken in a logical/functional fashion.
- **Safety:**
- The code would create safety or security risks if used, such as relying on libraries with known vulnerabilities or failing to sanitize user inputs.
- Do not use this to flag responses that make simplifying assumptions that a user would reasonably be expected to notice and improve, such as using a hard-coded password in a clearly visible location.
- **Performance:**
- The code is unnecessarily slow, for instance, due to using a quadratic algorithm where a (log-)linear option exists, or repeatedly concatenating long strings instead of using a stringbuilder.
- **Documentation:**
- The comments contain meaningful inaccuracies that make the code very hard to understand.
- ﻿Keep in mind that the code may be functional for the prompter, even if it does not compile or run on your setup. For instance, a response that points to a file only accessible to the prompter, or provides a partial program based on the context provided by the prompter should not be marked as non-functional unless it contains errors that would (likely) manifest in the prompter’s programming context.

**2. Minor Issues**

- Either or both of the following are true:
- Text: primary claims (central to addressing the prompt) are factual / accurate; secondary claims contain meaningful inaccuracies (or unfounded claims).

Code: has minor problems where the main functionality of the code is correct; e.g., it fails to handle an edge case, or is correct but has misleading comments.

  

**3 No Issues**

All claims in both the explanation and any code comments are factual and accurate; the code (if any) is functional, safe, and useful.



**Step [3]: How to Write a Justification**

**After rating the model response, you will be asked to provide a brief rationale - called a "justification" - for your rating.**

**All justifications must meet the following criteria:**

1. **Evaluate the two responses** 
2. **Provide a side-by-side rating for the two model responses** 
3. **Write the justification: After scoring which of the responses are better, you should provide a justification for why that score was chosen.**

- Keep your justifications concise, yet also as informative as possible for which response is better.
- The justification must adhere to the following guidelines:
- The justification should be between 50-75 words long
- The justification must provide a clear, objective explanation for why response 1 (response 2) is better than response 2 (response 2).
- The justification must be specific and detailed.
- The justification must not use first-person language (“I”) -or- include phrases like. “The AI,” “the chatbot,” “the model,” “the LLM,” etc. (regardless of capitalization). Instead, use @response 1 and @response 2. 
- The justification should be without any grammar or spelling errors. Use the Grammarly extension to help with this.

## **1. [Justification Requirement]**

#### **Ideal Structure**

Please note that depending on the task type, responses can be referred to as "@Response 1" vs "@Response 2" and justifications should be written accordingly.

- **Start with the Verdict****:** Begin with a clear statement about which response is better.
- Example: “Response 1 is much better than Response 2.”

  

- **Address Key Issues****:** Mention if there are any problems with Instruction Following, code execution, or code correctness in the responses. Provide **evidence.**
- Example: “Response 1 follows the instructions, while Response 2 contains factual errors.”

  

- **Consider Other Factors****:** If there are issues with safety, harmfulness, Content Quality, or Writing Style, mention them.
- Example: “Response 1 is concise and well-formatted, while Response 2 is too wordy.”**Step [1]: How to Write a Prompt**

**In this step, you will be asked to initiate a conversation with the model by writing a prompt.**

  

**All prompts must meet the following criteria:**

1. Follow the language given in the task
2. Write diverse prompts with constraints to get the model to fail

## **1. [Prompt Requirement #1]**

  

Add constraints and state the coding language:

  

Bad example: Can you write a script which would query the database row by row to get the phone numbers

- This prompt is bad because, it does not state the coding language, is vague and does not have constraints. The model will most likely not fail.

  

Good example: Can you write a python script which would query the database row by row and use google's port of libphonenumber library python-phonenumbers to update a live print out of invalid danish or finnish phone numbers

- This prompt is good because it states the language, contains constraints and is specific.