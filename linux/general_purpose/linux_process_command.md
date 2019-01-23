# Linux Process Related Command
---

1. `at`
    - Do one time jobs.
    - Need to be launch `atd` first(Some distribution stop it defaultly.)
    - `/etc/at.allow`
        + 定義誰(User)可以設定 `at` 工作排程。
    - `/etc/at.deny`
        + 定義誰(User)不可以設定 `at` 工作排程。
    - 如果都沒有，則只有root可以設定 `at` 工作排程。
    - example:
    ```
    在五分鐘後說 Hello!
    [root@study ~]# at now + 5 minutes
    at> echo "Hello!" > /dev/tty1
    at> <EOT>
    ```
    - `atq`
        + 查詢 `at` 排程。
    - `atrm`
        + 刪除 `at` 排程。
    - `batch`
        + 會在 CPU 附載低的時候執行的 `at` 排程。
2. `crontab`
    - Do jobs preiodicly.
    - `crontd` --service name
    - `/etc/at.allow`
        + 定義誰(User)可以設定 `at` 工作排程。
    - `/etc/at.deny`
        + 定義誰(User)不可以設定 `at` 工作排程。
    - Format
        + `min hr day mon week instruction`
    - Special Identifier
        + `*`: any(eg. `00 10 * * * echo "It's 10 o'clock a.m."`)
        + `,`: and(eg. `00 10,22 * * * echo "It's 10 o'clock."`)
        + `-`: interval(eg. `00 12-13 * * * echo "It's noon."`)
        + `/n`: every interval(eg. `20/5 * * * * echo "Hello when time is early 20 per 5 minutes."`)
    - Related Config's Location
        + `/etc/crontab`
        + `/etc/cron.d/*`
        + `/var/spool/cron/*`
3. `bg`
    - 把背景的 job 從`Stopped`轉為`Running`。
4. `fg`
    - 把 job 拿到前景執行。
5. `jobs`
    - 查看有哪些 jobs 在背景中。
6. `kill`
    - `kill -l` --查詢可使用那些訊號作 `kill`。
    - `kill -9 $PID` --強殺不正常程序。
    - `kill -15 $PID` -- 正常步驟關閉程序。
7. `nohup`
    - 可以在離線後，讓程序依然執行。
    - 需先 `chmod a+x $file_name` ，給予執行權限。
8. `ps`
    - 查詢 Process 並以靜態形式呈現。
    - `ps aux`  --觀察系統所有的程序資料。
    - `ps -l` --觀察與自己 bash 有關的資料。
9. `top`
    - 查詢 Process 並動態呈現。
    - parameter
        + `-d`: 時間間隔。
        + `-b`: 批量呈現(類似改為append形式)。
        + `-n`: 與 -b 搭配，指定次數。
        + `-p`: 指定 Process by PID。
10. `pstree`
    - 列出程序樹狀圖
    - `pstree -A`: 列出所有程序。
    - `pstree -Aup`: 列出所有程序、User及PID。
11. `pgrep`
    - 找出該程序。
    - `pgrep chrome` --找出 chrome 的程序。
    - `pgrep -u robin chrome` --找出 User 為 robin 之 chrome 的程序。
12. `nice`
    - 調整優先權(以新執行之指令為目標)。
13. `renice`
    - 調整優先權(以已存在的程序為目標)。
14. `sleep`
    - 暫停程序。