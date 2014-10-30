日常に潜むBKBを発見する
====

## 概要

[バイク川崎バイク](http://www.google.co.jp/url?sa=t&rct=j&q=&esrc=s&source=web&cd=5&cad=rja&uact=8&ved=0CD8QFjAE&url=http%3A%2F%2Fmatome.naver.jp%2Fodai%2F2137761151482905501&ei=nyxQVLTXJYLPmwXhwIAw&usg=AFQjCNHYtnid7__OztJNegBrbPjaYGLx-A&sig2=EIDB4d-4EHlLfPwFV8xAEA&bvm=bv.78597519,d.dGY)を自動生成します. 

適当な文書を入力して, Mecabで形態素解析. 
文節で区切って, 頭文字が"BKB"になっている文節の並びを抽出します. 

###  実行例 

[NAVERまとめ](http://matome.naver.jp/odai/2137761151482905501) に載せられているネタの例:

  - いやバッファロー吾郎さんとは関係ないんですよ僕は. 

  - 「バッファロー吾郎さんとは！！関係ないです！！僕は！！」

  - BKB！！！ひぃ～ぁ！！！！

これを自動生成したいのです. 

=====

## 手法

### mecabに文章を入力. 文節で区切る.

```{sh}
> mecab
バッファロー吾郎さんとは関係ないんですよ僕は
バッファ  名詞,一般,*,*,*,*,バッファ,バッファ,バッファ
ロー  名詞,固有名詞,人名,姓,*,*,ロー,ロー,ロー
吾郎  名詞,固有名詞,人名,名,*,*,吾郎,ゴロウ,ゴロー
さん  名詞,接尾,人名,*,*,*,さん,サン,サン
と  助詞,格助詞,一般,*,*,*,と,ト,ト
は  助詞,係助詞,*,*,*,*,は,ハ,ワ
関係  名詞,サ変接続,*,*,*,*,関係,カンケイ,カンケイ
ない  形容詞,自立,*,*,形容詞・アウオ段,基本形,ない,ナイ,ナイ
ん  名詞,非自立,一般,*,*,*,ん,ン,ン
です  助動詞,*,*,*,特殊・デス,基本形,です,デス,デス
よ  助詞,終助詞,*,*,*,*,よ,ヨ,ヨ
僕  名詞,代名詞,一般,*,*,*,僕,ボク,ボク
は  助詞,係助詞,*,*,*,*,は,ハ,ワ
```

他動詞->自動詞のところが文節になる(...と思いきや, なかなか闇が深いらしい)

今回はうまくいっている. 

バッファロー吾郎さんとは/関係ないんですよ/僕は

バッファローゴロウサントハ/ カンケイナインデスヨ/ ボクハ


### 先頭文字で, カタカナ->ローマ字に変換. 

[kakasi](http://kakasi.namazu.org)を使います. 

```{sh}
> echo "バ カ ボ" | nkf -e | kakasi -Ka 
ba ka bo
```

### BKB判定

BKB! 

### ひぃ～ぁ!!

ひぃ～ぁ!!

=== 

## 用意するもの

- 文書データ
  
  - Wikipedia? Twitter? ニコニコ大辞典?

- 文節区切り: cabocha 

  - [Cabocha](https://code.google.com/p/cabocha/)で出来る.

- 読み方取得: mecab
  
- カタカナ変換の手法: kakasi

  - [kakasi](http://www.mk-mode.com/octopress/2014/04/27/linux-replacement-by-kakasi/)を利用

- Twitterアカウント


## 進捗

- 単語BKB 

  - ./bkb_judge_word.bash に標準入力で1文を流すと, 単語BKBを探してくれます. 

- 文節BKB

  - ./bkb_judge_clause.bashに標準入力で1文を流すと, 文節BKBしてくれます. 


```{sh}
> cat example.txt | ./bkb_judge_clause.bash 
いずれにしても現代の陪審制の形成についてはバイクと12世紀のイングランド王ヘンリー2世の設けた制度と1215年のマグナ・カルタがバイク川崎バイク大きく寄与したという点で多くの歴史家が一致している
陪審制の 形成については バイクと
B! K! B!
ひぃーあ!!
```

## 次にやること

- 文章の用意 : aozora文庫 坂口安吾の文書440本でやってます. 

- BKBの保存: 結果の確認がまだ. illegal byte なんちゃらで結構怒られてます. processがいまいちだろうと. 

- 結果ツイート
