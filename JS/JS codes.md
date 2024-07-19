# **code for generating passwords**



```
function generatePasswd(lenght, lowercase, uppercase, Numbers, symbols) {

  

  const lowercsechars = "abcdefghijklmnopqrstuvwxyz";

  const uppercaseChars = "ABCDEFHIJKLMNOPQRSTUVWXYZ"

  const numbersChars = "0123456789";

  const symbolsChars = "@#!~$%^&*?/\"())_-+=><,.";

  
  numbersChars

  let allowdChars = "";

  let password = "";

  allowdChars += lowercase ? lowercsechars : "";

  allowdChars += uppercase ? uppercaseChars : "";

  allowdChars += Numbers ? numbersChars : "";

  allowdChars += symbols ? symbolsChars : "";

  
  if (lenght <= 0) {

    return `(password length must be at least 1 )`;

  }

  if (allowdChars.length === 0) {

    return `(atleast 1 set of chars must be selected  )`;

  }

  for (let i = 0; i <= lenght; i++){

    const randowindex = Math.floor(Math.random() * allowdChars.length);

    password += allowdChars[randowindex];

  }

  return password;

}

const passWordLenght = 12;

const includeLowerCase = true;

const includeUpperCase = true;

const includeNumber = true;

const includesymbols = true;

const passWWD= generatePasswd(

                            passWordLenght,

                            includeLowerCase,

                            includeUpperCase,

                            includeNumber,

                            includesymbols);

console.log(`generated password is ${passWWD}`);  
```
# call back 
![[Pasted image 20240609114657.png]]
```
function sum (callback , x, y){
  let result = x+ y ;
  callback(result);
}
function displaySum(result){
  console.log(result);
}
sum(displaySum, 1, 2);

```
code for promis  
![[Pasted image 20240626134117.png]]
 ![[Pasted image 20240626134404.png]]
 