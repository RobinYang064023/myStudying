# Drill curl

---

1. GET/POST/PUT/DELETE
  - `curl -X GET "http://www.rest.com/api/users"`
  - `curl -X POST "http://www.rest.com/api/users"`
  - `curl -X PUT "http://www.rest.com/api/users"`
  - `curl -X DELETE "http://www.rest.com/api/users"`
2. `curl -u name:passwd "http://www.rest.com/api/users"`
  - 輸入帳號密碼
3. `curl -o file_name "http://www.rest.com/api/users:port/path/to/endpoint"`
  - 將回傳值存成file_name
4. `curl -O "http://www.rest.com/api/users:port/path/to/filename"`
  - 以server端檔案名稱儲存
5. `curl -H "Accept-Language: zh-tw"`
  - 告知存取 zh-tw 網頁
6. `curl "http://www.rest.com/api/users" -D save_cookie.txt` 
  - 儲存 cookie
7. `curl -b use_cookie.txt "http://www.rest.com/api/users"`
  - 使用該 cookie 存取網頁
8. `curl -d "useer-xxx&password=1234" "http://www.rest.com/api/users"`
  - 使用 POST 存取網頁
9. `curl -A "Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)" "http://www.rest.com/api/users"`
  - 使用代理瀏覽器存取網頁
10. `curl -L -o file_name.zip "http://www.rest.com/api/users"` 
  - 跟隨並下載
11. `curl -X POST -d param1=value1&param2=value2`
  - HTTP Parameter
12. `curl "http://www.rest.com/api/users" -X PUT -i -H "Content-Type:application/json" -H "Accept:application/json" -d '{"boolean" : false, "foo" : "bar"}'`
  - post json file
13. 區分有無認證登入的 service
  - session
    - `curl --request GET 'http://www.rest.com/api/users' --header 'sessionid:1234567890987654321'`
  - cookie
    - # 將cookie存檔
      `curl -i -X POST -d username=kent -d password=kent123 -c  ~/cookie.txt  http://www.rest.com/auth`
    - # 載入cookie到request中 
      `curl -i --header "Accept:application/json" -X GET -b ~/cookie.txt http://www.rest.com/users/1`
14. `curl -i -X POST -F 'file=@/Users/kent/my_file.txt' -F 'name=a_file_name'`
  - Upload file
  - 這個是透過 HTTP multipart POST 上傳資料， -F 是使用http query parameter的方式，指定檔案位置的參數要加上@
15. HTTP Basic Authentication
  - `curl -i --user kent:secret http://www.rest.com/api/foo'`
  - 回傳401是認證失敗，回傳200是認證成功。
  - `curl -i --user kent:secret http://www.rest.com/api/foo' -c ~/cookies.txt`
    - 儲存登入成功的cookie
  - `curl -i  http://www.rest.com/api/foo' -b ~/cookies.txt`
    - 使用上則登入成功的cookie進行登入


# Reference:
---

\[1\] [Kent's Blog - 使用curl指令測試REST服務](http://blog.kent-chiu.com/2013/08/14/testing-rest-with-curl-command.html)
