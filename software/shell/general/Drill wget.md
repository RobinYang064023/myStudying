# Drill `wget`
---

1. `wget http://ftp***********.tar.gz`
  - 直接下載檔案(網址為檔案位址)
2. `wget ftp://ftp************.tar.gz`
  - 使用ftp下載
3. `wget ftp://ftp************.tar.gz http://ftp*******.tar.gz`
  - 下載多個檔案
4. `wget -O file_name ftp://ftp******.tar.gz`
  - 指定下載後的檔名
5. `wget -i the_list_of_what_we_want_to_download.txt`
  - 用txt紀錄要下載的網址，並以此批量下載
6. `wget -c ftp://ftp************.tar.gz`
  - 接續上次未完的下載已進行下載
7. `wget -b ftp://ftp************.tar.gz`
  - 於背景執行下載
8. `wget --limit-rate=100k ftp://ftp************.tar.gz`
  - 限速下載
9. `wget --http-user=my_user --http-password=my_password ftp://ftp************.tar.gz`
  - 輸入帳號密碼並下載(http)
10. `wget --ftp-user=my_user --ftp-password=my_password ftp://ftp************.tar.gz`
  - 輸入帳號密碼並下載(ftp)
11. `wget --tries=50 ftp://ftp************.tar.gz`
  - 設定嘗試次數，可以在不穩定的情況下多次嘗試而非一次死掉
12. `wget --user-agent="Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko" ftp://ftp************.tar.gz`
  - 偽裝為瀏覽器下載
13. `wget --spider ftp://ftp************.tar.gz`
  - 單純查看存在而不真的下載
14. `wget --mirror -p --convert-links -P ./my_folder http://edition.cnn.com/`
  - 下載整個網站
  - `--mirror`: 下載整個網站
  - `-p`: 自動下載顯示網頁所需的所有相關檔案
  - `--convert-links`: 將下載網頁的超連結改為本地連結
  - `-P`: 指定存放的資料夾
15. `wget -Q5m -i url.txt`
  - 若下載量超過(eg. 5mb)則停止下載
16. `wget -r -A.pdf http://www.example.com/`
  - 遞廻下載指定格式的檔案
17. Proxy download
  - edit `~/.wgetrc`, 加入`use_proxy=yes;http_proxy=http://proxy.yoyodyne.com:18023/`
  - `wget -e use_proxy=yes -e http_proxy=http://proxy.yoyodyne.com:18023/ http://www.example.com/`
  - `wget -e use_proxy=yes -e https_proxy=http://username:password@proxy.server.address:port/ http://www.example.com/`
  - `wget -e use_proxy=yes -e http://username:password@proxy.server.address:port/ http://www.example.com/`
18. `wget -t0 -c -nH -np -m -P /localdir http://example.com/mirrors/ftp.redhat.com`
  - 此為砍站示範指令
  - `-t0`: 設定重傳次數(即--tries)，0為無窮次
  - `-c`: 續傳
  - `-nH`: 不建立該網站名稱的子目錄 /example.com/，而直接在當前目錄下建立鏡像的目錄結構。
  - `-np`: 不遍歷父目錄，如果有連結連到目標資料夾的parent或其他目錄，不下載。
  - `-m`: 即`-r` + `-N`
  - `-r`: 遞迴下載
  - `-N`: 下載時檢查timestamp，只下載有更新的文件，如果檔案大小和最修改日期都一樣就不下載。
  - `-P`: 指定存放資料夾