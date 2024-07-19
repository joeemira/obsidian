# NMAP 
```
nmap -T -p- -A  //simple use
//-T for technologies 
//-p- for all ports 
//-A operating sys

```

	![[Network_Enumeration_With_Nmap_Module_Cheat_Sheet.pdf]]
```
```shell-session
joeemira@htb[/htb]$ sudo nmap 10.129.2.0/24 -sn -oN joe | grep for | cut -d" " -f5
joeemira@htb[/htb]$ sudo nmap -sn -oN joe -iL hosts.lst | grep for | cut -d" " -f5

sudo nmap -sn -oA tnet 10.129.2.18 10.129.2.19 10.129.2.20| grep for | cut -d" " -f5
multiple ip or if we have a range **10.0.2.1-5**
//read from file 
```


we can know the operating system from the TTL (time to live)
![[3d6f8bc2-f387-46ce-af32-72d7ce230085.png]]


# NIKTO vulnerability scanner 
```
 nikto -h https:// 10.0.2.15
```
check of externally buffer overflow 
# **directory fuzzing**
dirbuster GUI
directory fuzzing and  dumbing 

`dirb https://10.0.2.15`

### using ffuf 
`ffuf -w <wordlist> :FUZZ -u http://10.0.2.15/FUZZ `

# SMB protocol enumeration 
using Metasploit 

 1. search for smb 
 2. choose auxiliary or enumeration 
 3. set RHOST 
 4. run   
### connect to SMB 
```
smbclient -L  ////10.0.2.15//
```

# we can search for exploit in **searchsploit** 
