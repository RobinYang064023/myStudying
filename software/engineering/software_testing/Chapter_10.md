# Chapter 10 Foreign-Language Testing

---

- Making the Words and Pictures Make Sense
  - 主要說明翻譯容易，但會翻出很奇怪不符合 native 使用者的翻譯。
- Translation Issues
  - 測試團隊不一定擅長該語言。
  - 只需要一個人擅長該語言即可，測試正確的翻譯而不能流利地使用該語言仍是可行的。
- Text Expansion
  - 每個語言的字型、詞語長度不同，需要再額外測試(如視窗長度、按鈕長度等等)。
- ASCII, DBCS, and Unicode
  - 不同語言使用不同編碼，所以需要額外測試。
  - 如果統一採用 Unicode 則可省下時間、負擔和 bugs 。
- Hot Keys and Shortcuts
  - 不同國家需要不同快捷鍵，比如英文的搜尋是 Search 故採用 Ctrl+S ，但法文的搜尋就不是 S 開頭的詞彙，就不適合用 Ctrl+S 。
- Extended Characters
  - 就是特殊字元，比如古字、表情符號、愛心等等。
  - 需要測試其是否可被解碼、檔案名稱可否有特殊字元、檔案內部可否有特殊字元、使用複製、貼上會不會發生錯誤。
- Computations on Characters
  - 簡單例子是你需要依名稱排序，那英文、法文、中文的檔案名稱同時存在該如何排序。
  - 或者說英文排序就是 a~z ，那中文呢？
- Reading Left to Right and Right to Left
  - 各種國家各種閱讀、寫作次序，像中文也有由上往下、由右而左與英文的由左而右、由上而下不同。
- Text in Graphics
  - 被圖形化的文字也較麻煩。
- Keep the Text out of the Code
  - 這是一個白箱測試問題。
  - 我們應該讓所有包含文字的字串、錯誤訊息、任何東西儲存在獨立於 source code 之外的一個檔案，也就是說 source code 不應包含任何文字敘述。
  - 這樣的好處之一是有人翻譯的時候，不會動到 source code ，換言之，甚至可以是非 programmer 來自行對軟體作翻譯。
  - 另外的問題是在於拼接問題，如果字串有經過拼接，那不同語言就徹底完蛋，比如日文和中文文法就不同了。
- Localization Issues
  - Content
    - 不同地區的相同語言可能會有一種現象：相同物體有不同的名稱或者相同名稱有不同的物體又或者單純有相異的規則。
    - Football 在美國、英國是不同的東西、英國有"我們的女王"、但美國沒有"我們的女王"。
    - 影片 vs 視頻
  - Data Formats
    - 單位不同 (mile vs kilometer)
    - 格式不同 (csv 的 delimitor 是 ` ` 或 `,` ，還有日期的格式等等)
- Configuration and Compatibility Issues
  - Foreign Platform Configurations
    - 鍵盤有國情之分。
  - Data Compatibility
    - 不同語言之間的轉換，需要有其支援，本身就很繁瑣，更何況有一方轉不回去？
    - 該如何轉？
    - 他該自動轉換？還是手動決定？
    - 資料遺失該作何處理？
- How Much Should You Test?
  - 取決於產品是不是從一開始就需要作 localized 。
  - code 是否可以產生 localized version 。