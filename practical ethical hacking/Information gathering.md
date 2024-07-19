# collect emails about a target 
[hunter.io]()
[phonebook.cz]()
[voilanorbert.com]()
[clearbitconnect]().com
[tools.verifyemailaddress.io]()
email-checker.net/validate

# collecting subdomains 
 ###`sublist3r -d test.com`###
####srt.sh 
collecting subdomains by checking SSL fingerprint [[web techniques]]
###############################################
## **amass**
`amass enum -passive -d {{domain_name}}`
### analyzing the output of amass
The output you provided appears to be the result of a domain name system (DNS) and network enumeration, which includes various DNS records and their relationships for the `google.com` domain and its subdomains. This information is often used in penetration testing, security analysis, and network mapping to understand the infrastructure and how different components are connected. Here's a breakdown of the different types of records and relationships in your output:

 DNS Records and Their Meanings

1. A Record:
    
    - Maps a domain name to an IPv4 address.
    - Example: `google.com (FQDN) --> a_record --> 172.253.115.139 (IPAddress)`
2. **AAAA Record**:
    
    - Maps a domain name to an IPv6 address.
    - Example: `health.google.com (FQDN) --> aaaa_record --> 2607:f8b0:4004:c06::64 (IPAddress)`
3. **MX Record**:
    
    - Specifies the mail servers responsible for receiving email for a domain.
    - Example: `google.com (FQDN) --> mx_record --> smtp.google.com (FQDN)`
4. **NS Record**:
    
    - Indicates the name servers for a domain.
    - Example: `google.com (FQDN) --> ns_record --> ns1.google.com (FQDN)`
5. **CNAME Record**:
    
    - Creates an alias for a domain name, mapping one domain to another.
    - Example: `productforums.google.com (FQDN) --> cname_record --> groups.l.google.com (FQDN)`

Network and Autonomous System Information

1. **Netblock**:
    
    - A range of IP addresses managed by an organization.
    - Example: `74.125.208.0/20 (Netblock) --> contains --> 74.125.217.10 (IPAddress)`
2. **ASN (Autonomous System Number)**:
    
    - An ASN is assigned to an organization and is used to identify a network on the internet.
    - Example: `15169 (ASN) --> managed_by --> GOOGLE - Google LLC (RIROrganization)`
    - Example: `15169 (ASN) --> announces --> 74.125.200.0/24 (Netblock)`

Interpretation of the Data

- **Domain to IP Mapping**:
    
    - You can see which domains and subdomains resolve to which IP addresses.
    - Example: `google.com` resolves to multiple IPv4 addresses like `172.253.115.139`, `172.253.115.101`, etc.
- **Alias Mappings**:
    
    - Several subdomains use CNAME records to point to other Google-related domains.
    - Example: `productforums.google.com` is an alias for `groups.l.google.com`.
- **Mail Servers**:
    
    - The MX record for `google.com` indicates that `smtp.google.com` is responsible for handling email.
- **Name Servers**:
    
    - NS records show which servers are authoritative for the domain.
    - Example: `google.com` uses `ns1.google.com`, `ns2.google.com`, `ns3.google.com`, and `ns4.google.com` as its name servers.
- **Network Blocks**:
    
    - IP addresses are organized into netblocks, which are announced by Google's ASN (`15169`).
    - Example: The IP `74.125.217.10` belongs to the netblock `74.125.208.0/20`.
- **Autonomous System Announcements**:
    
    - Google's ASN (`15169`) announces several netblocks, meaning it is responsible for routing traffic for those IP ranges.

How to Use This Information as a Bug Bounty Hunter

1. **Identify Attack Surface**:
    
    - Use the information to understand the scope of the target. Identify all subdomains and associated IP addresses.
2. **Reconnaissance**:
    
    - Perform further reconnaissance on the identified subdomains and IP addresses to find potential vulnerabilities.
3. **Email Security**:
    
    - Analyze MX records to assess the security of email servers and look for potential misconfigurations or vulnerabilities.
4. **DNS Security**:
    
    - Investigate NS records and other DNS configurations for weaknesses like DNS hijacking or misconfigured records.
5. **Network Mapping**:
    
    - Understand the network layout and how different services are hosted and managed by the organization.
6. **Service Enumeration**:
    
    - Use the IP addresses to identify running services and their versions, which can help in finding exploitable vulnerabilities.





## **tomnomnomnom prob**   
check the domain is alive or not 






##  **web sites technology** 
[builtwith.com]()  analyze the website 
wappalyzer extension 
```
whatweb domain.com

```


## subfinder
## assetfinder

# take screen shots for all subdomains 
gowitness 