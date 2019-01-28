# 20 Linux Commands Every Sysadmin Should Know
---

1. `curl`
	- transfer a URL
	- support HTTP, HTTPS, FTP, FTPS, SCP, SFTP, TFTP, DICT, TELNET, LDAP or FILE
	- `curl https://domain.com/`
		- display the content of the URL on your terminal.
	- `curl -o website https://domain.com/`
		- save the output of a cURL as $website.
	- `curl -O https://domain.com/file.zip`
		- download files with cURL
		- `curl -o archive.zip https://domain.com/file.zip` can do the same thing but change the file name.
		- You can also download multiple files by `curl -O https://domain.com/file.zip -O https://domain.com/file2.zip`
		- `curl -u user sftp://server.domain.com/path/to/file`
			- download files securely via SSH
	- `curl -I http://domain.com`
		- get HTTP header information
		- here is am example:
        ```
            HTTP/1.1 200 OK
		    Date: Sun, 16 Oct 2016 23:37:15 GMT
		    Server: Apache/2.4.23 (Unix)
		    X-Powered-By: PHP/5.6.24
		    Connection: close
		    Content-Type: text/html; charset=UTF-8
        ```
	- `curl ftp://ftp.domain.com --user username:password`
		- access your FTP server with password
	- `curl ftp://ftp.domain.com/filename.extension --user username:password`
		- connect to FTP server and list all files and directories.
	- `curl -T filename.extension ftp://ftp.domain.com/ --user username:password`
		- upload a file onto the FTP server.
	- `curl -I -s myapplication:5000`
		- The -I option shows the header information and the -s option silences the response body.
		- here is an output sample:
			- `HTTP/1.0 500 INTERNAL SERVER ERROR` 
2. `python -m json.tool / jq`	
	- compare the difference:
		- `cat test.json`
			- `{"title":"Person","type":"object","properties":{"firstName":{"type":"string"},"lastName":{"type":"string"},"age":{"description":"Age in years","type":"integer","minimum":0}},"required":["firstName","lastName"]}`
		- `cat test.json | python -m json.tool`
			```
            {
                "properties": {
                    "age": {
                        "description": "Age in years",
                        "minimum": 0,
                        "type": "integer"
                    },
                    "firstName": {
                        "type": "string"
                    },
                    "lastName": {
                        "type": "string"
                    }
                },
                "required": [
                    "firstName",
                    "lastName"
                ],
                "title": "Person",
                "type": "object"
            }
			```
		- `cat test.json | jq` (you must install jq first.)
			```
            {
                "title": "Person",
                "type": "object",
                "properties": {
                    "firstName": {
                      "type": "string"
                    },
                    "lastName": {
                    "type": "string"
                    },
                    "age": {
                        "description": "Age in years",
                        "type": "integer",
                        "minimum": 0
                    }
                },
                "required": [
                    "firstName",
                    "lastName"
                ]
            }
			```
3. `ls`
    - list directory 
4. `tail`
    - tail displays the last part of a file.
    - `tail -f /var/log/httpd/access_log`
        + `-f` indicat "follow", which outputs the log lines as they are written to the file.
    - `tail -n 100 /var/log/httpd/access_log`
        + `-n 100` for only showing the last 100 lines.
5. `cat`
6. `grep`
7. `ps`
    - `ps` show the process status.
    - `ps -l` <==查閱自己bash程序資料
    - `ps aux`  <==觀察系統所有的程序資料
    - `ps -lA`  <==也是能夠觀察所有系統的資料
    - `ps axjf` <==連同部分程序樹狀態
    - `ps -ef` <==all and full format
8. `env`
9. `top`
    - `-d`: update information per ? seconds.
    - `-b`: change mode which print each batch one by one.
    - `-n`: to specify the number of lines.
    - `-p`: to specify PID.
10. `netstat`
    - `netstat -tulpn`: shows that Apache already uses port 80 on this machine.
    - `-r`: 列出路由表(route table)，功能如同 route 這個指令；
    - `-n`: 不使用主機名稱與服務名稱，使用 IP 與 port number ，如同 route -n
與網路介面有關的參數：
    - `-a`: 列出所有的連線狀態，包括 tcp/udp/unix socket 等；
    - `-t`: 僅列出 TCP 封包的連線；
    - `-u`: 僅列出 UDP 封包的連線；
    - `-l`: 僅列出有在 Listen (監聽) 的服務之網路狀態；
    - `-p`: 列出 PID 與 Program 的檔名；
    - `-c`: 可以設定幾秒鐘後自動更新一次，例如 -c 5 每五秒更新一次網路狀態的顯示；
11. `ip address`
    - `ip address show`: show information about ip address
12. `lsof`
    - lists the open files associated with your application.
    - `lsof -i tcp:80`: list the files whose Internet address matches the address specified in 80.
    - `lsof -p 18311`: list the files used by process 18311.
    - `netstat -tulnp`
    - `lsof`: list all the file being used.
    - `-a`: 多項資料需要『同時成立』才顯示出結果時！
    - `-U`: 僅列出 Unix like 系統的 socket 檔案類型；
    - `-u`: 後面接 username，列出該使用者相關程序所開啟的檔案；
    - `+d`: 後面接目錄，亦即找出某個目錄底下已經被開啟的檔案！
13. `df`
    - `df -h`: display free disk space, and `-h` stand for human-readable format.
    - `-a`: 列出所有的檔案系統，包括系統特有的 /proc 等檔案系統；
    - `-k`: 以 KBytes 的容量顯示各檔案系統；
    - `-m`: 以 MBytes 的容量顯示各檔案系統；
    - `-h`: 以人們較易閱讀的 GBytes, MBytes, KBytes 等格式自行顯示；
    - `-H`: 以 M=1000K 取代 M=1024K 的進位方式；
    - `-T`: 連同該 partition 的 filesystem 名稱 (例如 xfs) 也列出；
    - `-i`: 不用磁碟容量，而以 inode 的數量來顯示
14. `du`
    - `-a`: 列出所有的檔案與目錄容量，因為預設僅統計目錄底下的檔案量而已。
    - `-h`: 以人們較易讀的容量格式 (G/M) 顯示；
    - `-s`: 列出總量而已，而不列出每個各別的目錄佔用容量；
    - `-S`: 不包括子目錄下的總計，與 -s 有點差別。
    - `-k`: 以 KBytes 列出容量顯示；
    - `-m`: 以 MBytes 列出容量顯示；
    - `--max-depth=?`: 最深展示到幾層。
15. `id`
    - to check user identity.
16. `chmod`
    - change file mode
    - `chmod +x $filename`: change file mode to executable.
    - `chmod -R 777 $foldername`: change all files under this folder to mode 777. 
17. `dig / nslookup`
    - You may find that a URL does not resolve, which causes a connectivity issue for your application. dig (DNS lookup utility) or nslookup (query Internet name servers) to figure out why the application can't seem to resolve the database.
    ```
    $ nslookup mydatabase
    Server:   10.0.2.3
    Address:  10.0.2.3#53

    ** server can't find mydatabase: NXDOMAIN
    ```
    ```
    $ dig mydatabase

    ; <<>> DiG 9.9.4-RedHat-9.9.4-50.el7_3.1 <<>> mydatabase
    ;; global options: +cmd
    ;; connection timed out; no servers could be reached
    ```
18. `iptables`
    - Warning: Don't practice this syntax on remote server.
    - iptables blocks or allows traffic on a Linux host, similar to a network firewall.
    - `iptables -S`: show iptables rule.
    ```
    $ iptables -S
    -P INPUT DROP
    -P FORWARD DROP
    -P OUTPUT DROP
    -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
    -A INPUT -i eth0 -p udp -m udp --sport 53 -j ACCEPT
    -A OUTPUT -p tcp -m tcp --sport 22 -j ACCEPT
    -A OUTPUT -o eth0 -p udp -m udp --dport 53 -j ACCEPT
    ```
    - `-t`: 後面接 table ，例如 nat 或 filter ，若省略此項目，則使用預設的 filter
    - `-L`: 列出目前的 table 的規則
    - `-n`: 不進行 IP 與 HOSTNAME 的反查，顯示訊息的速度會快很多！
    - `-v`: 列出更多的資訊，包括通過該規則的封包總位元數、相關的網路介面等
19. `sestatus`
    - SELinux provides least-privilege access to processes running on the host, preventing potentially malicious processes from accessing important files on the system.
    ```
    $ sestatus
    SELinux status:                 enabled
    SELinuxfs mount:                /sys/fs/selinux
    SELinux root directory:         /etc/selinux
    Loaded policy name:             targeted
    Current mode:                   enforcing
    Mode from config file:          enforcing
    Policy MLS status:              enabled
    Policy deny_unknown status:     allowed
    Max kernel policy version:      28
    ```
20. `history`
    - print the command log.
    - Use `!??` to re-execute the ??th command.
