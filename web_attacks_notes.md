# Web Security Notes & Prevention Cheat Sheet

> Cleaned, organized, and enhanced with remediation strategies.

---

## 1. Cross-Site Scripting (XSS)

### Types
* **Stored XSS:** Malicious script is permanently stored on the target server (e.g., in a database).
* **Reflected XSS:** Malicious script is bounced off a web server onto a victim's browser (e.g., via a link).
* **DOM-based XSS:** Vulnerability exists entirely within the client-side JavaScript processing.

### Where to Inspect
* URL parameters
* POST data body

### What to Look For
* Decode encoded input before analysis.
* Search logs for XSS-related keywords.
* Suspicious characters: `<`, `>`, `"`, `'`, `(`, `)`

### 🛡️ Prevention Methods
* **Context-Aware Output Encoding:** Encode user-controlled data before rendering it on the page (e.g., convert `<` to `&lt;`). Ensure the encoding matches the context (HTML body, JavaScript, CSS, or URL attributes).
* **Implement Content Security Policy (CSP):** Use HTTP headers to restrict where scripts can be loaded from and block the execution of inline scripts.
* **Use Safe APIs:** Utilize modern frameworks (like React or Angular) that automatically encode output by default, and avoid risky attributes like `innerHTML`.
* **Set HttpOnly Flags:** Mark session cookies as `HttpOnly` so they cannot be accessed or stolen via malicious JavaScript.

---

## 2. SQL Injection (SQLi)

### Types
* **In-band:** The attacker uses the same channel of communication to both launch the attack and gather results.
* **Out-of-band:** The attacker receives data via a separate channel (e.g., DNS or HTTP requests triggered by the database server).
* **Blind:** The application does not return data directly, forcing the attacker to infer structure via true/false conditions or time delays.

### Where to Inspect
* URL parameters
* POST data

### Detection Tips
* Decode requests.
* Search for SQL keywords (`SELECT`, `UNION`, `OR 1=1`, `--`, etc.).
* Identify automation by examining:
  * User-Agent anomalies
  * Request frequency (high-velocity bursts)
  * Sequential payload patterns

### 🛡️ Prevention Methods
* **Prepared Statements (Parameterized Queries):** Pre-compile the SQL query structure on the server side so that user input is strictly treated as a literal parameter, never executable code.
* **Stored Procedures:** When implemented correctly, these abstract SQL statements and strictly parameterize inputs.
* **Allow-list Input Validation:** Reject any input that does not match a strict expected format (e.g., ensuring an ID parameter contains only digits).
* **Principle of Least Privilege:** Configure database permissions so the web app's service account only has access to the tables and actions it explicitly requires (e.g., denying `DROP TABLE`).

---

## 3. Command Injection

### Where to Inspect
* URL parameters
* POST data
* HTTP headers
* Any user-controlled input routed to system wrappers

### Detection Tips
* Decode requests.
* Search for system command names (`cat`, `whoami`, `ping`, `sh`, `bash`).
* Look for shell metacharacters (`|`, `;`, `&&`, `||`, `` ` ``, `$()`).
* Watch for automated command probes (e.g., curl/wget patterns, Python scripts, unusual User-Agents).

### 🛡️ Prevention Methods
* **Avoid Built-in Shell Execution:** Avoid passing user input directly to system shells (`exec()`, `system()`, `eval()`). Use language-native APIs instead (e.g., utilizing a programming language's built-in file-handling functions rather than invoking `rm` or `mkdir` via shell execution).
* **Strict Input Validation:** Use an explicit allow-list of permissible characters or values if system commands are completely unavoidable.
* **Argument Parameterization:** If a system command must be run, pass user arguments as separate array elements to the execution API rather than a single concatenated string, preventing shell command chaining.

---

## 4. IDOR (Insecure Direct Object Reference)

### Where to Inspect
* URL parameters
* POST data
* API requests / JSON endpoints

### Detection Tips
* Repeated requests targeting varied resources from the same client session.
* Sequential or predictable object IDs (`?id=1001`, `?id=1002`).
* Discrepancies between User-Agent values and cookie origins.
* Rapid scanning across source IP addresses.

### 🛡️ Prevention Methods
* **Object-Level Access Control:** Implement strict, server-side authorization checks on *every single request* to verify if the active session user owns or possesses the explicit right to access the requested object ID.
* **Use Indirect References (GUIDs/UUIDs):** Replace predictable database keys with long, complex, non-sequential identifiers (e.g., `?id=f81d4fae-7dec-11d0-a765-00a0c91e6bf6`), making enumeration attacks impractical.
* **Avoid Exposing Internal IDs:** Keep raw internal database IDs completely masked from URLs, hidden form elements, and client-facing API structures.

---

## 5. LFI / RFI (Local / Remote File Inclusion)

* **LFI:** Local File Inclusion — forcing the app to run or display internal server files.
* **RFI:** Remote File Inclusion — forcing the app to load external, attacker-hosted files.

### Where to Inspect
* URL parameters
* POST data
* Cookies
* HTTP headers

### Detection Tips
* Look for path traversal sequences (`../`, `..\\`, `%2e%2e%2f`).
* Watch for explicit attempts to access known system configurations (`/etc/passwd`, `/etc/shadow`, `boot.ini`).
* For RFI, flag any inputs containing external URI protocols (`http://`, `https://`, `ftp://`).

### 🛡️ Prevention Methods
* **Avoid Dynamic File Inclusion:** Never pass raw user inputs directly into runtime file-inclusion paths or functions (such as `include`, `require`, or `file_get_contents`).
* **Use a Static Allow-list:** If files must be dynamically referenced, map benign user tokens to a predefined, hardcoded dictionary of safe files on the server (e.g., parameter `page=1` translates strictly to `home.php`).
* **Path Canonicalization & Sanity Checks:** Use native path resolution mechanisms to explicitly confirm that the absolute target path remains trapped within the designated, safe base directory.
* **Disable Remote Resource Loading:** Turn off remote streaming options within server configuration files (e.g., ensuring `allow_url_include = Off` is configured in `php.ini`).

---

## General Incident Response & Investigation Workflow

1. **Identify Input Sources:** Locate entry vectors across query strings, headers, cookies, and bodies.
2. **Decode Values:** Normalize obfuscation formats (URL encoding, Base64, Hex, Unicode) before evaluation.
3. **Keyword Scan:** Cross-reference strings against known signature parameters and malicious patterns.
4. **User-Agent Fingerprinting:** Flag suspicious headers or automated/headless browser scripts.
5. **Rate & Frequency Analysis:** Pinpoint automated brute-forcing or systemic scraping attempts.
6. **IP Correlation:** Map suspicious requests back to originating infrastructure or VPN/Proxy endpoints.
7. **Defense-in-Depth Implementation:** Ensure validation occurs on entry, strict constraints govern data state processing, and rigorous context encoding safeguards structural outputs.



&lt;script&gt;alert(3)&lt;/script&gt;
