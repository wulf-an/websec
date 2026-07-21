# Directory Enumeration Methodology

---

## 1. Scope Definition & Initial Target Identification

* **Action:** Define strict boundaries (IPs, subdomains, URLs) and review authorization constraints before launching any scans.
* **Reasoning:** Active enumeration generates heavy network traffic. Defining scope upfront prevents accidental scanning of out-of-scope assets, avoiding legal issues or unwanted service disruptions.

---

## 2. High-Speed Surface Scanning

* **Action:** Execute multi-threaded brute-force scans using curated wordlists (e.g., *SecLists*) to uncover hidden paths and directories.

### Tool Analysis

* **Gobuster:**
  * *Tech Stack:* Built in Go.
  * *Capabilities:* Performs fast, parallelized HTTP request handling without the overhead of rendering pages.
  * *Use Case:* Ideal for rapidly mapping out standard paths on large targets.

* **Feroxbuster:**
  * *Tech Stack:* Written in Rust.
  * *Capabilities:* Features automatic recursive scanning.
  * *Use Case:* Automatically scans deeper into newly discovered sub-paths, eliminating the need to manually configure secondary scans.

---

## 3. Misconfiguration & Asset Discovery

* **Action:** Run targeted scans specifically aimed at detecting administrative panels, old backups, and server configuration files.

### Tool Analysis

* **Open Door:**
  * *Capabilities:* Uses specialized heuristics to detect specific server misconfigurations, swap files (`.swp`), old archives (`.bak`, `.zip`), and hidden admin interfaces.
  * *Advantage:* Finds exposed sensitive assets that generic directory wordlists often miss.

---

## 4. Deep Manual Analysis & Request Manipulation

* **Action:** Route browser traffic through a proxy to manually interact with discovered endpoints, inspect headers, and test input handling.

### Tool Analysis

* **Burp Suite:**
  * *Capabilities:* Offers granular control via Proxy, Repeater, and Intruder modules to inspect raw HTTP/S requests, bypass client-side controls, and analyze application responses in real time.
  * *Advantage:* Fills the gap of automated scanners, which cannot understand complex application logic or session state.
