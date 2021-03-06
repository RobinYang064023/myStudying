# Single Responsibility Principle (單一職責原則)

---

## 單一職責原則的介紹、解釋及優點

---

`一個模組只有一個，也只能有一個理由使其改變`

`一個模組只為唯一的一個角色負責`

上為 "Clean Architecture" 一書中提到對單一職責原則的描述，為解釋先設定一個場景：現在有A, B, C 三個角色、甲, 乙, 丙則分別為他們需要的功能，以下解釋單一職責原則的功能及優劣：

- 若今天架構符合單一職責原則，也就是 `甲只為 A 負責`、`乙只為 B 負責`、`丙只為 C 負責`，而今天 `A` 希望能夠修改`甲`功能，那...
  - 那就改啊！改完對 `B`, `C` 沒有影響且 `A` 也能得到他想要的功能。
- 若今天架構並不符合單一職責原則，也就是我們假設 `我們有 "甲" 功能而且他必須為了 A, B(或連 C 也包含)負責`，而今天 `B` 希望能修改`甲`功能，那...
  - 那就麻煩了，也許我們改完後順利符合 `B` 的需求，但卻讓 `A` 的需求是錯誤的，甚至 `A` 根本也不知道就沿用這個錯誤的結果。
- 若今天架構符合單一職責原則，也就是 `甲只為 A 負責`、`乙只為 B 負責`、`丙只為 C 負責`，而今天 `A` 要修改`甲`功能、 `B` 要修改`乙`功能，那...
  - 那就改啊！改完對 `C` 沒有影響且 `A`, `B` 都能得到他們預期的功能。
- 若今天架構並不符合單一職責原則，也就是我們假設 `我們有 "甲" 功能而且他必須為了 A, B(或連 C 也包含)負責`，而今天 `A` 希望能修改`甲`功能、`B` 也希望能修改`甲`功能，那...
  - 那就慘了， `A` 的修改和 `B` 的修改合併後，也許對雙方分別有別的影響，更遑論還可能影響到 `C` ，如果他有要使用`甲`功能的話。

那什麼是 "`我們有 "甲" 功能而且他必須為了 A, B(或連 C 也包含)負責`" ？(可以直接從第二個例子開始看)

- 比如一對夫妻對於何為 "寬裕的資金" 有一套他們自己的算法，他們會根據 "寬裕的資金" 決定寬裕的資金實際有多少，而他們也會根據 "寬裕的資金" 決定這個月可以花費多少比例在玩樂上，但也許夫妻倆想要限制 "玩樂花費" 去做投資而更動了所謂 "寬裕的資金" 的演算法，對應 "`我們有 "甲" 功能而且他必須為了 A, B(或連 C 也包含)負責`" 的話，甲就是 "寬裕的資金" 的演算法、 A 是決定寬裕資金的實際量、 B 為決定花多少比例在玩樂，我們就能用這個例子套用在上述相對應的情境，但這個例子只是嘗試理解並舉出的怪例子，現實並不會發生，我們可能會直接把玩樂花費的比例直接砍一些給投資金而不是改變那個根本就聽不懂是什麼鬼的演算法。
- 原書中舉的例子比較好了解、也比較像是現實生活會發生的，會計部會根據"常規上班時間"計算"薪水"、人力資源部也會根據"常規上班時間"計算"員工工時"，那這時會計部想要更改"常規上班時間"的算法而人力資源部並沒有這樣的打算，那改動後就會造成人力資源部對"員工工時"地計算出現錯誤，造成公司大量的損失，這就是第二條情境：意外重複。
- 原書中舉的例子是接續上一個例子的，那些計算會使用到的資料，我們稱為 "Employee 表格"，而今天資料庫小組需要更改該表格的 schema ，同時人力資源部就需要改變"員工工時"的表格格式，而這兩項各自修改後需要做合併，然而任何的合併都有風險，甚至影響到會計部的工作，也就是上面第四條情境：合併。

所以我們若使架構符合單一職責原則，也就是`一個模組只為唯一的一個角色負責`，那會解決意外重複、合併的問題。

## 缺點

---

- 我們很難找出、量化 "為什麼要變化"。
- 我們很難劃分、量化 "職責"。
- 劃分完之後，要考慮每一項都能透過命名清楚表達 "職責"。
- 真的劃分清楚則會太細導致超級大量的介面出現。
- 我們可能分過頭、導致出現不必要的複雜，其實這也是很難劃分、量化 "職責"。

[SOLID 之 單一職責原則（Single responsibility principle）](https://ithelp.ithome.com.tw/articles/10191955)

[單一職責原則 Single Responsibility Principle (SRP)](https://medium.com/@f40507777/%E5%96%AE%E4%B8%80%E8%81%B7%E8%B2%AC%E5%8E%9F%E5%89%87-single-responsibility-principle-7b4eb03f1fff)

## 總結

---

因為還沒看前面章節，我還看不懂總結，待以後補完。