# Universum Autoencoder-Based Domain Adaptation for Speech Emotion Recognition

## Published:

---

- Manuscript received September 8, 2016
- revised February 6, 2017
- accepted February 10, 2017
- Date of publication February 22, 2017
- date of current version March 14, 2017.

## Author:

---

- Univ Passau, Chair Complex & Intelligent Syst, D-94032 Passau, Germany
- Tech Univ Munich, Machine Intelligence & Signal Proc Grp, D-80333 Munich, Germany
- Univ Zurich, Inst Psychol, CH-8006 Zurich, Switzerland
- Univ Zurich, Neurosci Ctr Zurich, CH-8092 Zurich, Switzerland
- ETH, CH-8092 Zurich, Switzerland
- Univ Zurich, Ctr Integrat Human Physiol, CH-8006 Zurich, Switzerland
- Imperial Coll London, Dept Comp, London, England

## Keyword:

---

- Deep learning
- domain adaptation
- speech emotion recognition
- universum autoencoders (U-AE)

## My Comment:

---

- 在影像辨識上， autoencoder 生成的圖片會有模糊的問題、generative adversarial network 生成的圖片會有很清楚但非正確的問題，兩者會被拿來比較，也許我能試試 GAN 做做看結果怎樣。
- Universum 看起來是一種處理 unlabeled data 的手段，它先取得 encoder encode 出來的特徵、再依其是否 labeled 分別套用一個式子去運算出 loss ，並將這個 loss 加上原本 autoencoder 的 loss 並以此 loss 訓練 model 。

## My Note:

---

- 此篇提出這個做題目的原因: speech emotion recognition systems in real-life settings is the lack of generalization of the emotion classifiers.
  - 語音情緒辨識缺乏一個具有廣泛能力的情緒分類器（分類器就是辨識情緒的手段）。
- 此篇也提到何謂 domain adaptation for speech emotion recognition 問題（或者說要解決的事情）: Many recognition systems often present a dramatic drop in performance when tested on speech data obtained from different speakers, acoustic environments, linguistic content, and domain conditions.
  - 語音情緒辨識只要在不同說話者、說話環境、語意、各種可能的環境，辨識效能（或者說辨識能力）會大幅度地下降。
- 此篇提出 Universum Autoencoder 作為 model 解決領域適應的問題，其重點在於 U-AE 是 semi-supervised 的 method 。
- 本文認為過去提出用在 domain adaptation 的方法幾乎都是 hybrid framework: 混合 unsupervised learning(eg. autoencoder), supervised learning(SVM) ，這種作法的問題在於 unsupervised learning 雖然能夠以一個未知的特徵區分出不同的答案（我指的是它該是什麼或者說它的 label），但是它能 encode 出來的特徵會不適合給 supervised learning 學習，因為不能做出「未知特徵 - 結果」這種 label（以影像辨識舉例，「貓的圖片 - 貓」是我們能做的 label，「貓的圖片特徵 - 貓」就做不到了，畢竟一般人看著特徵向量應該是沒辦法知道它是隻貓）。
- 實驗結果(UAR[\%], 同類型不同方法直接放在同一列)
  - Supervised methods: 54.1%, 54.8%
  - Hybrid methods(Unsupervised and Supervised learning): 56.7%, 55.8%, 58.3%
  - U-AE(proposed): 63.3%(+ABC), 62.0(+EMODB), 62.8%(+SUSAS)