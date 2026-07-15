# ACTIVE RECONNAISSANCE

- Active reconnaissance means you are interacting directly with the target's system to see what is running. Because you have to send packets and connect to their services to get this data, it's highly visible. Defensive tools like firewalls, IDS systems, and honeypots will easily spot this traffic and log it.

- Active reconnaissance involves making direct contact by visiting websites, pinging hosts, tracing routes, and connecting to ports. This can reveal live services, open ports, banners, and network paths, but it leaves footprints.

### From a red team perspective:
From a red team perspective, the goal is to blend in. A web browser visiting a website looks identical to normal traffic among thousands of legitimate users, and crafted requests with realistic User-Agent strings and slow timing can sometimes evade basic detection. 

### From a blue team perspective:
From a blue team perspective, active probes surface in access logs, firewall logs, WAF events, and IDS alerts. Monitoring your own exposure helps catch reconnaissance early.

### Active Recon Notes
  - Easy to Catch:
        Active scanning is louder and riskier than ever.
  - Stronger Firewalls:
        Web protectors (like Cloudflare) and strict security rules easily spot and block weird traffic.
  - Network Changes:
        IPv6: Newer IP addresses might answer to pings while older ones (ICMPv4) block them.

        HTTPS: Almost all web traffic is encrypted now; old plaintext methods don't work.
  -  Smart Alarms:
        Modern security software (SIEM/EDR) automatically catches and reports scanning behavior right away.




# 1. Web Browser
The web browser is one of the most convenient and least suspicious tools for active reconnaissance. It is present on virtually every system, and its traffic blends in with normal user activity. This makes it difficult for defenders to distinguish reconnaissance from legitimate browsing.

* Many modern sites also support HTTP/3, which uses the QUIC protocol,we can identify HTTP/3 traffic in the browser's Network tab, where the protocol column displays h3.
* We can access non-standard ports by specifying them in the URL.If the web server is listening, the page will load. Ex: https://target.com:8080/

##Developer Tools

### Network tab:
Network tab displays all request and responses in real time.It include headers such as Server,X-Powered-By, and Content-Security-Policy.

### Console tab:
The Console tab allows you to execute JavaScript snippets directly in the page context, view errors, and interact with the DOM.

### Sources or Dbugger tab:
The Dbugger tab lets you browse JavaScript, CSS, and HTML files loaded by the page. 

- Exposes Hidden Infrastructure:
Developers often leave hardcoded API endpoints, paths to internal backend servers, and staging environments inside the JavaScript code. The rendered webpage won't show these, but the code in the Debugger will.

- Reveals the Directory Structure:
The Debugger displays a visual file tree of how the website's assets are organized. This gives you a massive head start on directory brute-forcing because it explicitly shows you folder names and paths (/js/admin/, /api/v2/).

- Uncovers Leaked Credentials & Comments:
Developers sometimes accidentally leave sensitive items in the source code before pushing it live—such as test API keys, hardcoded passwords, or developer comments (// TODO: fix authentication bypass on this endpoint).

- Allows Dynamic Logic Tampering:
The Debugger isn't just a text viewer; it lets you pause the website's execution in real-time (using breakpoints). You can manipulate variables, bypass front-end validation checks, or see exactly how data is being encrypted or processed before it hits the network.

### Storage tab:
The Application tab, under the Storage section, lets you inspect cookies, Local Storage, and Session Storage. These storage areas sometimes contain session tokens,API keys accidentally exposed client-side, tracking IDs, or authentication data.

### Security tab or padlock icon:
The Security tab provides certificate details including the issuer, validity period, and Subject Alternative Names (SANs). SANs frequently reveal additional subdomains or related domains belonging to the same organisation.




## Browser Extensions
1. FoxyProxy:
FoxyProxy (opens in new tab) allows you to switch between proxies such as , , and SOCKS5 tunnels. This is useful when intercepting or routing traffic through different tools during an engagement.
2. User-Agent Switcher and Manager:
User-Agent Switcher and Manager (opens in new tab) changes the User-Agent string to emulate different browsers, operating systems, or devices. You can present as mobile Safari or an older browser version to discover mobile-specific endpoints or version-specific behaviour. However, many modern WAFs and CDNs detect suspicious or rapid User-Agent changes.
3. Wappalyzer:
Wappalyzer (opens in new tab) automatically identifies technologies used on the site, including CMS platforms, web servers, JavaScript frameworks, analytics tools, CDNs, and databases. It runs passively while you browse and is one of the most widely used extensions for quick technology fingerprinting.
4. Wappalyzer alternatives:
BuiltWith Technology Profiler, which is similar to Wappalyzer but sometimes detects different technologies, WhatRuns as a lightweight alternative, and Library Detector for Chrome/Firefox, which focuses specifically on JavaScript libraries and frameworks.

Common active activities include:

    Sending packets to discover live hosts (e.g., ICMP pings,ARP requests).
    Port scanning or service enumeration (Nmap, masscan).
    Interacting with web applications or APIs (fuzzing endpoints, directory brute-forcing).
    Social engineering attempts (phishing, vishing, pretexting phone calls).
    Physical approaches (tailgating, posing as a vendor).


Because active reconnaissance is detectable (IDS/IPS, WAFs, logging), it carries a higher risk of alerting the target. Without explicit authorisation (e.g., bug bounty scope or pentest contract), it can lead to legal issues. Passive recon is far stealthier and is often the practical first step.




Note that any direct interaction with a person affiliated with the target also counts as active reconnaissance, even when no packets are involved. For example, attending a social event and asking an employee about their company's technology stack is active reconnaissance because you are directly engaging with the target organisation.






# 2. Ping
The name ping comes from the sound of a sonar pulse. You send out a signal and listen for the echo to come back. In networking, the ping command does the same thing. It sends a small test packet to a remote host and waits for a reply. 

## How Ping Works:
Ping uses the ICMP protocol (Internet Control Message Protocol). It sends an ICMP Echo Request packet (type 8). If the target receives the packet and is permitted to answer, it sends back an ICMP Echo Reply (type 0). This exchange is very lightweight and fast, which is why ping became the standard first check before spending time on more detailed scanning.

## TTL (Time To Live)
Think of TTL as a life countdown timer for a network packet, measured in the number of routers it is allowed to cross before it expires. Every time a packet passes through a router, that router subtracts one from the TTL number to keep lost packets from looping forever. Because Linux starts its countdown at 64 and Windows starts at 128, you can easily guess a target's operating system just by checking how close the final number is to those defaults.

## Why Ping is Getting No Reply:
If your ping receives no reply, it usually means the target machine is offline, crashed, or still booting up. Alternatively, security defenses are likely blocking the traffic: Windows Firewall blocks pings by default, while corporate firewalls, cloud providers (like AWS, Azure, and GCP), CDNs, and NAT configurations frequently drop ICMP packets entirely. Lastly, the issue could be on your end, as your own machine or local network might be blocking outgoing requests.






# 3. traceroute
The traceroute command traces the route that packets take from your system to a target host. Its purpose is to discover the IP addresses of the routers (hops) along the path and to determine how many of them sit between you and the destination. This information is useful for understanding network topology, identifying where filtering or latency occurs, and mapping infrastructure.

Syntax: traceroute MACHINE_IP

## How Traceroute Works
There is no direct way to discover the full path from your system to a target. Instead, traceroute exploits the TTL (Time To Live) field in the IP header. Each router that handles a packet decrements the TTL by one before forwarding it. When the TTL reaches 0, the router drops the packet and sends an ICMP Time-to-Live Exceeded message back to the sender.

By sending packets with incrementally increasing TTL values starting at 1, traceroute forces each successive router along the path to reveal its IP address. A of 1 causes the first router to drop the packet and respond. A of 2 reaches the second router before being dropped. This continues until the packet reaches the destination.

Some routers are configured not to send ICMP Time-to-Live Exceeded messages. This is common in secure environments intended to prevent reconnaissance. These routers appear as * in the traceroute output.



# 4. Telnet :
telnet MACHINE_IP 80
* Telnet banner grabbin only work with http websites.

Developed in 1969 for remote command-line administration, TELNET connects to systems over default port 23 but is highly insecure because it transmits all data—including usernames and passwords—in unencrypted cleartext. This allows anyone sniffing the network to easily steal credentials, which is why it has been completely replaced by SSH (Secure Shell), the modern industry standard that encrypts all traffic for secure remote access.

## How telnet useful for reconnaissance: 
The Telnet client is highly useful for active reconnaissance because it can connect to any TCP port to perform banner grabbing. Since it displays raw text directly from the target service, it forces the server to leak its initial greeting response, which frequently reveals the exact software name, version, and operating system running on that port.


 
 

# Netcat 
nc MACHINE_IP PORT

Netcat (nc) is a versatile networking utility that handles both TCP and UDP protocols. Operating as either a client or a server, it is widely used for banner grabbing, port probing, and file transfers.
### Listening with Netcat
nc -vnlp 1234 to start listening on port 1234.

Netcat can also act as a server, listening on a specified port. This is useful for testing connectivity, transferring simple data, or setting up basic communication channels during an engagement.

## Ncat
Modern variants, like Nmap's ncat, upgrade these legacy telnet-like capabilities by adding support for IPv6 and SSL encryption.

ncat --ssl example.com 443



# mtr (My Traceroute)
- mtr is a more powerful, modern tool that combines the functionality of tracert and ping.
- Instead of taking a single snapshot, mtr constantly refreshes the connection. It keeps sending packets to every hop along the route in real-time.
- It shows you a dynamic table that updates every second, displaying the percentage of packet loss and the average/best/worst latency for every single router along the path.


# Open ssl 

OpenSSL is an open-source software library used to secure communication over computer networks against eavesdropping and impersonation. It is the backbone of security for the modern internet.

## The Two Main Components of OpenSSL
- A Cryptographic Library:
        Developers build this library into software (like web servers, operating systems, and applications) to enable SSL/TLS encryption.

- A Command-Line Tool:
        System administrators and security engineers use it manually to manage certificates, test connections, and encrypt data.

openssl s_client -connect example.com:443


# Curl (Client URL)
curl is a command-line tool used to transfer data to or from a server. It supports a massive list of protocols, including HTTP, HTTPS, FTP, SFTP, and SCP, making it an absolute staple for developers, system administrators, and security professionals.

* Curl used for : Downloading files,Testing API's, Troubleshooting, Automation
curl -I https://example.com


-------------------------------------------------------------------------------------
#     LEVEL TWO ACTIVE RECON:
-------------------------------------------------------------------------------------

# 1.  DIRB
Dirb tutorial : https://gitlab.com/kalilinux/packages/dirb/-/tree/kali/master

DIRB is a Web Content Scanner. It looks for existing (and/or hidden) Web 
Objects. It basically works by launching a dictionary based attack against 
a web server and analizing the response.

DIRB comes with a set of preconfigured attack wordlists for easy usage but 
you can use your custom wordlists. Also DIRB sometimes can be used as a 
classic CGI scanner, but remember is a content scanner not a vulnerability 
scanner.

## DIRB Usage :
DIRB takes 2 main parameters, the base URL for testing and a list of wordlist 
files used for the attack. 
- Example:
        dirb http://example.com /usr/share/dirb/wordlists/small.txt

common flags : -x : extensions , -i : case sensitives

### DIRB Wordlists and its Usage:
--------------------------------------------------------------------------
Wordlist	            Purpose
---------------------------------------------------------------------------
common.txt          	- General directory and file discovery (best starting point)
small.txt       	    - Quick scans
big.txt     	        - More comprehensive enumeration
extensions_common.txt	- Common file extensions
mutations_common.txt	- Backup and temporary file suffixes
indexes.txt	            - Common index filenames
---------------------------------------------------------------------------



# 2. OpenDoor 
Tutorial : https://opendoor.readthedocs.io/?utm_source=chatgpt.com

OpenDoor is an open-source CLI scanner for authorized web reconnaissance, directory discovery, exposure assessment and subdomain discovery.

* OpenDoor (the web content discovery tool) is less used today because newer tools do the same job faster, with more features, and better performance.

- opendoor can scan subdomain and directories:
        opendoor --host https://example.com --scan directories
        opendoor --host example.com --scan subdomains
- opendoor can scan single target and a target file:
        opendoor --host https://example.com
        opendoor --hostlist targets.txt
- It can use built in dictionaries or local or remote wordlists:
        opendoor --host https://example.com --wordlist ./paths.txt
        opendoor --host https://example.com --wordlist https://example.com/wordlists/paths.txt
- Header Injection Bypass:
        OpenDoor can optionally probe blocked 401 and 403 paths with controlled Header Injection Bypass variants.
        opendoor \
          --host https://example.com \
          --method GET \
          --waf-detect \
          --header-bypass \
          --header-bypass-limit 32
- Its Support Network Transports:
    OpenDoor supports direct, proxy, OpenVPN, and WireGuard transport modes.
        opendoor --host https://example.com --transport direct
        opendoor --host https://example.com --transport proxy --proxy socks5://127.0.0.1:9050
        opendoor --host https://example.com --transport openvpn --transport-profile ./profile.ovpn
- Reports:
    OpenDoor can write results in multiple formats.    
        Formats: std, txt, json, csv, html, sqlite, sarif.
          opendoor --host https://example.com --reports std,json,html,sarif
          
          
| Flag                   | Used for                                                                                           |
| ---------------------- | -------------------------------------------------------------------------------------------------- |
| `--include-status`     | Show **only** responses with the specified HTTP status codes (e.g., 200, 301, 403).                |
| `--exclude-size-range` | Ignore responses whose content size falls within a specified byte range to reduce false positives. |
| `--extensions`         | Test files with specified extensions during enumeration (e.g., `.php`, `.html`, `.bak`, `.txt`).   |
| `--fingerprint`        | Identify the target's technologies (web server, CMS, framework, programming language, etc.).       |
| `--waf-detect`         | Detect whether a Web Application Firewall (WAF) is protecting the target.                          |
| `--waf-safe-mode`      | Reduce scan aggressiveness to minimize triggering or blocking by a WAF.                            |
| `--waf-guard`          | Automatically adjust scanning behavior when a WAF is detected to improve scan reliability.         |






# 3. Feroxbuster :
feroxbuster is a tool designed to perform Forced Browsing.
  Forced browsing is an attack where the aim is to enumerate and
  access resources that are not referenced by the web application,
  but are still accessible by an attacker.

feroxbuster uses brute force combined with a wordlist to search for unlinked content in target directories. 
This attack is also known as Predictable Resource Location, File Enumeration, Directory Enumeration, and Resource Enumeration.

- Feroxbuster uses SecLists by default if it's installed or we can use custom wordlists.
/usr/share/SecLists/Discovery/Web-Content/common.txt













### Active Reconnaissance Tools Summary

| Tool                       | Category           | Status / Lifespan         | Primary Recon Utility                                                                                        |
| -------------------------- | ------------------ | ------------------------- | ------------------------------------------------------------------------------------------------------------ |
| **Web Browser (DevTools)** | Web Interface      | **Modern / Standard**     | Path discovery, endpoint identification, JavaScript analysis, cookies, local/session storage inspection.     |
| **Browser Extensions**     | Web Interface      | **Modern / Standard**     | Technology fingerprinting (Wappalyzer), proxy switching (FoxyProxy), user-agent switching, helper utilities. |
| **Ping**                   | Network            | **Essential Built-In**    | Host discovery and connectivity testing (ICMP).                                                              |
| **Traceroute / Tracert**   | Network            | **Legacy but Active**     | Discover routing path and network hops.                                                                      |
| **MTR**                    | Network            | **Modern / Standard**     | Continuous traceroute with latency and packet loss analysis.                                                 |
| **Telnet**                 | Port/Service       | ❌ **Deprecated / Legacy** | Plain-text service testing and basic banner grabbing (mainly historical).                                    |
| **Netcat (nc)**            | Port/Service       | **Modern / Standard**     | Banner grabbing, manual TCP/UDP connections, port testing, simple data transfer.                             |
| **Ncat**                   | Port/Service       | **Modern / Standard**     | Enhanced Netcat with SSL/TLS, IPv6, proxy support, and scripting features.                                   |
| **OpenSSL**                | Encryption/Service | **Modern / Standard**     | TLS/SSL banner grabbing, certificate inspection, protocol testing.                                           |
| **Curl**                   | Web/API            | **Modern / Standard**     | HTTP requests, header inspection, API interaction, downloading resources, automation.                        |




##Current popularity
Approximate usage in penetration testing today:

⭐⭐⭐⭐⭐ Feroxbuster — one of the most popular for directory enumeration.
⭐⭐⭐⭐⭐ FFUF — excellent for fuzzing and content discovery.
⭐⭐⭐⭐ Gobuster — simple, reliable, and supports DNS/vhost enumeration.
⭐⭐⭐ DIRB — still used in labs and older tutorials, but less common in real engagements.
⭐ OpenDoor — rarely used today.






Gobuster, Dirsearch, or Feroxbuster,
urlextractor,gau (GetAllURLs), Katana (ProjectDiscovery)


Directory Enumeration - DIRB, DirBuster, OpenDoor, Burp Suite,  gobuster
Web Crawling & Interception - OWASP ZAP, HTTrack, Burp Suite
Vulnerability Scanning - Nikto, OpenVAS, Vega, Acunetix
Exploitation -  (XSS & SQLi) -	XSSer, Sqlmap

subdomain - amass ,

https://ginandjuice.shop/
https://duck-store.escape.tech/
https://dvaib.com/
https://pentest-ground.com/
