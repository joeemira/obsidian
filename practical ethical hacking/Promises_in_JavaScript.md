
# Promises in JavaScript

**Promises** are objects used to handle asynchronous operations in JavaScript. A **Promise** represents a value that may be available now, in the future, or never. Promises are commonly used for operations like fetching data, reading files, or making API requests.

## States of a Promise
A Promise has three states:
1. **Pending**: The initial state, where the operation is not yet complete.
2. **Fulfilled**: The operation is successful, and the Promise has a resolved value.
3. **Rejected**: The operation failed, and the Promise has a reason for the failure.

Once a Promise transitions from **pending** to either **fulfilled** or **rejected**, it becomes **settled** and cannot change states again.

---

## Creating a Promise
Use the `Promise` constructor, which takes a function (executor) with two parameters: `resolve` and `reject`.

```javascript
const myPromise = new Promise((resolve, reject) => {
  // Perform an asynchronous operation
  const success = true; // Simulate success or failure
  if (success) {
    resolve("Operation was successful!"); // Fulfilled state
  } else {
    reject("Operation failed."); // Rejected state
  }
});
```

---

## Using Promises
Handle the result of a Promise using `.then()`, `.catch()`, and `.finally()` methods.

- **`then()`**: Executes when the Promise is resolved.
- **`catch()`**: Executes when the Promise is rejected.
- **`finally()`**: Executes after the Promise is settled, regardless of the outcome.

```javascript
myPromise
  .then((result) => {
    console.log(result); // "Operation was successful!"
  })
  .catch((error) => {
    console.error(error); // "Operation failed."
  })
  .finally(() => {
    console.log("Promise settled."); // Runs no matter what
  });
```

---

## Chaining Promises
Promises can be chained to handle sequences of asynchronous operations.

```javascript
fetch("https://api.example.com/data")
  .then((response) => response.json())
  .then((data) => {
    console.log("Data:", data);
  })
  .catch((error) => {
    console.error("Error:", error);
  });
```

---

## Promise Utility Methods

### `Promise.all()`
Resolves when all promises in an array resolve, or rejects if any promise rejects.

```javascript
const promise1 = Promise.resolve(10);
const promise2 = Promise.resolve(20);
const promise3 = Promise.resolve(30);

Promise.all([promise1, promise2, promise3])
  .then((values) => {
    console.log(values); // [10, 20, 30]
  })
  .catch((error) => {
    console.error(error);
  });
```

### `Promise.race()`
Resolves or rejects as soon as the first promise settles.

### `Promise.allSettled()`
Waits for all promises to settle, regardless of the outcome.

### `Promise.any()`
Resolves as soon as the first promise resolves; rejects if all promises reject.

---

## Why Use Promises?
- **Simplify Async Code**: Promises prevent "callback hell," making code easier to read and maintain.
- **Better Error Handling**: Centralized error handling with `.catch()`.

---

## Bonus: Using `async/await`
For even more concise syntax, use `async/await` to work with Promises in a synchronous style.
```javascript
async function fetchData() {
  try {
    const response = await fetch("https://api.example.com/data");
    const data = await response.json();
    console.log("Data:", data);
  } catch (error) {
    console.error("Error:", error);
  }
}
```
