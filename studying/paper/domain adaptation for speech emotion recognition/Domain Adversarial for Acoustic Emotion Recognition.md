# Domain Adversarial for Acoustic Emotion Recognition 

## Published:

---

- IEEE/ACM TRANSACTIONS ON AUDIO, SPEECH, AND LANGUAGE PROCESSING, VOL. 26, NO. 12, DECEMBER 2018

## Author:

---

- Mohammed Abdelwahab , Student Member, IEEE, and Carlos Busso , Senior Member, IEEE

## Keyword:

---

- Speech emotion recognition
- Adversarial training,
- Unlabeled adaptation of acoustic emotional models

## My Comment:

---

- 看來有多算一個以 domain's label  為主的分類器、loss 用以實踐 domain adaptation，跟我打算採用的方法不同。

## My Note:

---

- 研究 adversarial training 對 domain 的覆蓋率
- 分析 shallow, deep architecture 差異
- 本文提出一種提取 target data, source data 之 common features 的方法
- 本文表明使用未標記的訓練數據進行對抗訓練對情緒識別是有益的
- 因此，可以使用大量未標記的資料推廣模型、使其更具泛化性能
- By using the abundant unlabeled target data, we gain on average 27.3% relative improvement in concordance correlation coefficient (CCC) compared to just training with the source data.
  - What is concordance correlation coefficient (CCC) ?
    - In statistics, the concordance correlation coefficient measures the agreement between two variables, e.g., to evaluate reproducibility or for inter-rater reliability. 
- The visualization shows that adversarial training aligns the data distributions as expected, reducing the gap between the source and target domains.
  - 藉由可視化圖展示出對抗學習確實把資料的分佈對齊成我們所希望的「減少 source 和 target 間的 gap」。
  - 這邊我可以借用他的成果，說明這種方法確實會有效、或者說它就是在佐證我現在的方向沒有全錯。
- The study also shows the effect of the number of shared layers between the domain classifier and the emotion predictor on the performance of the system.
  - 它還有展示 domain classifier 和 emotion predictor 的層數對效果的影響，如果我需要湊字數、想研究也可以考慮。
- The size of the source domain is an important factor that determines the optimal number of shared layers in the network.
  - source domain 的大小是決定分享層數的因子，尚不能理解。
- We learn the representation by using a gradient reversal layer (GRL) where the gradient produced by the domain classifier is multiplied by a negative value when it is propagated back to the shared layers.
  - why multiplied by a negative value?
    - Changing the sign of the gradient causes the feature representation of the samples from both domains to converge, reducing the gap between domains.
- DANN architecture
  - ![DANN Architecture]("https://github.com/RobinYang064023/myStudying/blob/master/studying/paper/domain adaptation for speech emotion recognition/dann_architecture.jpg")
    - We train the primary recognition task with the source data, for which we have emotional labels.
    - For the domain classifier, we train the classifier with data from the source and target domains.
    - 但這樣是不是需要對新的 unlabeled data 做一個 domain 的 label? 是不是可以把這個也省略掉?