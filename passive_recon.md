
# PASSIVE RECONNAISSANCE 


Sun Tzu wrote in The Art of War: "If you know the enemy and know yourself, your victory will not stand in doubt."

In cybersecurity, this principle maps to two roles. As an attacker (or ethical hacker), you gather intelligence about the target to find weaknesses. As a defender, you must understand what an adversary can discover about your systems from public sources and minimise that exposure.



## Passive reconnaissance
 Passive reconnaissance refers to gathering intelligence from public sources without contacting the target. This stands in contrast to active reconnaissance, where you interact with the target directly and risk detection.

Passive recon remains one of the most powerful and lowest-risk phases in penetration testing, bug bounties, and threat hunting. Even with stronger privacy laws (GDPR, CCPA), large amounts of useful data remain publicly exposed through DNS, WHOIS, certificate logs, search engines, and device census platforms.



### Objectives
   - Use whois to query domain registration details.
   - Use dig (and nslookup for compatibility) to query DNS records.
   - Understand why querying public WHOIS and DNS servers is considered passive.
   - Discover subdomains using DNSDumpster and Certificate Transparency logs.
   - Gather intelligence on exposed services using Shodan.io.



### Common passive activities include:

   - Querying public DNS records from open resolvers (A, MX, TXT, etc.).
   - Searching certificate transparency logs (e.g., crt.sh) for subdomains and issued certificates.
   - Reviewing job postings on LinkedIn or company career pages for tech stack hints.
   - Reading public news, press releases, or leaked documents on paste sites.
   - Checking exposed devices via search engines like Shodan or Censys.
   - Scanning public GitHub repositories for hardcoded credentials or configuration files.
   
   



## Whois

WHOIS is a simple query and response protocol defined by RFC 3192 that operates over TCP port 43 to look up ownership and registration information about a domain name or an IP block. By querying databases maintained by domain registrars like Namecheap or GoDaddy, it allows network administrators and security analysts to identify who is responsible for a specific piece of internet infrastructure.


### WHOIS response may be contain:
- Registrar: The company (e.g., Namecheap, GoDaddy) that registered the domain.
- Registrant contact information: Name, organisation, address, phone, and email. However, privacy services (standard since GDPR 2018) usually replace this with "Withheld for Privacy" or similar.
- Dates: Creation (registration), Updated (last change), and Expiration (renewal deadline).
- Name servers: The DNS servers authoritative for the domain.
- Status codes: For example, clientTransferProhibited indicates the domain is locked against unauthorised transfers.
- Abuse contacts: The registrar's email and phone for reporting issues. 



### Privacy updates and historical records
Although privacy laws like GDPR hide personal names and phone numbers today, attackers still get plenty of useful clues from WHOIS records.

Instead of looking for people, they focus on structural details. They check domain dates to see how old a site is or to plan scams right when a domain is about to expire. They look at the registrar to figure out what kind of phishing trick might work best, and they inspect the name servers to spot weak links in the network setup.

By using special tracking sites like whoxy.com, attackers can even look at old, historical snapshots from before the privacy laws took effect. These old records show past owners, server changes, and moves that reveal exactly how a company's network has shifted over time.



### WHOIS Is Being Replaced By RDAP   (  curl -s https://rdap.verisign.com/com/v1/domain/tryhackme.com | jq . )

The old WHOIS system is outdated because it sends information in plain, unencrypted text and returns a messy wall of words that is hard for computers to read. To fix this, the internet governing body (ICANN) began phasing out old WHOIS setups for standard domains in favor of RDAP.

### RDAP is a major upgrade for a few simple reasons:

   - It is secure: It uses HTTPS to encrypt data, keeping lookups safe from eavesdroppers.
   - It is tidy: It answers in JSON format, which means the data comes back perfectly organized so security tools and scripts can read it automatically without errors.
   - It handles languages better: It supports different languages and character sets from all over the world.
   - It protects privacy: It allows domain providers to hide sensitive personal data while still showing technical details to authorized security researchers.
   
   
### Online alternatives :
- https://whois.icann.org/ (legacy WHOIS)
- https://lookup.icann.org/ (modern RDAP-focused lookup)
- https://www.whoxy.com/ (historical WHOIS snapshots, free limited use)




# nslookup and dig (querying DNS records) :

Querying DNS  records, which is still fully passive because the queries go to public or open resolvers, not to the target's servers directly.

* These tools translate domain names to IP addresses, find mail servers, reveal TXT records (SPF,DMARC, verification strings), and more.


### Why prefer dig over nslookup
nslookup and dig both check DNS, but dig is the modern, better choice. It gives cleaner results, shows TTL values automatically (so you see how long data stays cached), and works perfectly for automation. nslookup is only used for compatibility since you still see it in old guides and on Windows, but dig should be your go-to tool.



### nslookup :

nslookup -type=A tryhackme.com 1.1.1.1

nslookup (Name Server Lookup) is the older of the two tools.

Here is the complete list of DNS record types you can query using nslookup:
    Syntax:  nslookup -type=TYPE DOMAIN_NAME [SERVER]
     
  -  A (Address): Maps a hostname to its standard IPv4 address.
  -  AAAA (IPv6 Address): Maps a hostname to its 128-bit IPv6 address.
  -  CNAME (Canonical Name): Creates an alias pointing one subdomain to another domain name.
  -  MX (Mail Exchange): Identifies the servers responsible for receiving email for the domain.
  -  NS (Name Server): Specifies the authoritative servers managing the DNS zone.
  -  TXT (Text): Contains descriptive text strings, used heavily for security verification like SPF, DKIM, and DMARC policies.
  -  SOA (Start of Authority): Provides administrative data about the DNS zone, including the primary name server and refresh timers.
  -  PTR (Pointer): Used for reverse lookups to resolve an IP address back to a hostname.
  - SRV (Service): Defines the location (hostname and port number) of specific servers for services like VoIP or directory lookups.
  -  CAA (Certification Authority Authorization): Dictates which specific certificate authorities are allowed to issue SSL/TLS certificates for the domain.
  -  ANY: Requests a combined transfer of all available records matching the domain.
  
  
### dig
dig @1.1.1.1 tryhackme.com MX

dig is the modern, preferred DNS query tool.

Syntax: dig [@SERVER] DOMAIN_NAME [TYPE]   Ex: dig @1.1.1.1 tryhackme.com MX

Privacy tip: Use public resolvers like 1.1.1.1 (which supports DNS over HTTPS and DNS over TLS) to avoid your ISP logging your queries.



## DNSDumpster (dnsdumpster.com)
Using DNSDumpster is incredibly straightforward because it is a completely web-based tool. Since it operates entirely on pre-collected historical data, you can use it to investigate any domain without sending a single packet to the target company.

 It aggregates public DNS data from sources such as search engine caches, zone transfer databases, and certificate records. It does not perform brute-force enumeration, which means it remains fully passive. The results include subdomains and hosts, resolved IPs with geolocation, MX, TXT, and CNAME records, and visual maps showing the relationships between these.



## Certificate Transparency (CT) Logs

* The most effective passive subdomain discovery method today is Certificate Transparency logs, accessible through crt.sh (opens in new tab).
* crt.sh is fully passive, operates in real time, and has no rate limits for basic use.

Certificate Transparency is a public logging framework (mandatory since approximately 2015) that records every SSL/TLS certificate issued by participating Certificate Authorities. Each certificate contains a Subject Alternative Name (SAN) field listing the domains and subdomains it covers. By searching these logs, you can discover subdomains without sending any traffic to the target.


### Web Alternatives 
Censys.io
Facebook certificate transparency monitoring

### Command Line Alternatives 
- subfinder
subfinder -d tryhackme.com

- amass
amass enum -passive -d tryhackme.com








## Shodan.io

Shodan is a search engine for internet-connected devices. It continuously scans the public internet, collects banners and responses from open ports and services, and indexes them for search. Unlike Google, which indexes web pages, Shodan focuses on devices: servers,IoT equipment, cameras, routers, industrial control systems, and more.

* During passive reconnaissance, tools like Shodan.io (opens in new tab) allow you to gather intelligence on a target's internet-facing assets without sending any traffic to them.
* Defensive value: Organisations monitor Shodan (via alerts or manual checks) to identify unintended exposures such as rogue servers, forgotten test machines, or vulnerable services.

1. IP Address & ASN
   - What it means:
    The ASN (Autonomous System Number) is essentially the zip code of the internet. It tells you which massive network entity routes that specific IP address.
   - Recon value:
    If you find that a target uses an ASN owned entirely by themselves (e.g., Apple or Google), you know they manage their own physical data centers.

2. Hosting Provider / Organisation
   - What it means:
    Identifies the third-party infrastructure company processing the traffic (e.g., Amazon Web Services, DigitalOcean, Cloudflare).
   - Recon value:
    It tells you what rules apply. If a target is behind Cloudflare, your active scans will hit Cloudflare’s defensive firewalls instead of the actual target server.

3. Geographic Location
   - What it means:
    The physical country and city where the data center or server rack is located.
   - Recon value:
    Crucial for compliance checking (like verifying if data stays within EU boundaries for GDPR regulations).

4. Open Ports & Services
   - What it means:
    The literal doors that are left open to the internet (80, 443, 22), accompanied by their software banners (e.g., Apache httpd 2.4.41).
   - Recon value:
    This is the most critical technical footprint. It reveals exactly what software stack the target uses.

5. Tags
   - What it means:
    Quick labels automatically attached by the platform's analysis engine, such as flagging that a server uses a CDN (Content Delivery Network) or adding a vuln tag if that specific software version has an unpatched, public CVE (vulnerability).

   - Recon value:
    It acts as a massive shortcut, highlighting low-hanging fruit and immediate entry points without requiring you to manually check version histories against exploit databases.


-----------------------------------------------------------------------+
|  [1. IP & ASN]          --->  Where is it routed on the backbone?     |
|  [2. Hosting/Org]       --->  Who owns the physical infrastructure?   |
|  [3. Geo-Location]      --->  Where sits the hardware physically?     |
|  [4. Ports & Services]  --->  What software/doors are left wide open? |
|  [5. Tags & Vulns]      --->  Is there an immediate way inside?       |
+-----------------------------------------------------------------------+






# Tools
1. whois & RDAP
- https://whois.icann.org/ (legacy WHOIS)
- https://lookup.icann.org/ (modern RDAP-focused lookup)
- https://www.whoxy.com/ (historical WHOIS snapshots, free limited use)
2. nslookup
3. dig
4. Censys.io
5. subfinder 
6. amass (passive)
7. shodan
8. DNSDumpster


# A logical passive reconnaissance workflow
| Order | Tool                     | Purpose                                                                                                                           |
| ----- | ------------------------ | --------------------------------------------------------------------------------------------------------------------------------- |
| **1** | **WHOIS / RDAP**         | Identify the domain registrar, registration details, name servers, and ownership information (where available).                   |
| **2** | **nslookup**             | Perform basic DNS lookups (A, MX, NS, TXT, etc.) to verify DNS records.                                                           |
| **3** | **dig**                  | Perform more detailed DNS queries, check TTLs, authoritative responses, zone information (where permitted), and troubleshoot DNS. |
| **4** | **DNSDumpster**          | Visualize DNS records, discover related hosts, and identify additional subdomains.                                                |
| **5** | **subfinder**            | Enumerate subdomains from passive sources quickly.                                                                                |
| **6** | **Amass (Passive Mode)** | Perform comprehensive passive subdomain enumeration and correlate data from many sources.                                         |
| **7** | **Censys**               | Search for certificates, hosts, services, and infrastructure associated with the domain.                                          |
| **8** | **Shodan**               | Identify internet-exposed hosts, open ports, services, banners, and technologies.                                                 |




# Key tools and techniques:

- WHOIS:
    Domain registration details including registrar, dates, and name servers. Most personal details are now redacted for privacy.
  
- lookups:
    A/AAAA (IP addresses), MX (mail servers), TXT (SPF/DMARC/verification), and other record types, queried via public resolvers like 1.1.1.1.
    
- Subdomain enumeration:
    DNSDumpster for DNS aggregation and graphing, and crt.sh for Certificate Transparency log searches, which is the most effective passive method for discovering subdomains via public SSL/TLS certificates.
    
- Exposed services:
    Shodan.io for device banners, ports, and hosting information.
