# アプリ詳細

## アプリurl
https://visual-discussion.herokuapp.com

## アプリ名
Visual Discussion (略称: Visu Disu)

## 誰に向けた､何のための､どういったアプリなのか
**文章のやりとりを通じてディスカッションを行いたい人**に向けた､  
**視覚的に分かりやすいディスカッションを行う**ための､  
**ディスカッション情報を視覚化することに特化したコミュニュケーションアプリ**

## 開発の理由と背景
### 理由

以下の3点を満たすディスカッションの場がインターネット上にほしかったから｡
1. ユーザー非依存に意見の質を確保する仕組みがあること
2. 文章を読まずとも｢意見の種類｣､｢どの反論が､どの意見の､どの要素に対して批判を提示しているのか｣､｢意見の構成｣の3点を把握できること
3. 1つの意見に複数の反論が作成されても､意見ー反論間の関係が分かりやすいこと

### 背景
&nbsp;&nbsp;日常生活を送る中でふと疑問に思った｡｢なぜ空は青いのか?｣
そして､この疑問について誰かとディスカッションをしてみたくなった｡
まず､友人に話題を振ってみたのだが､乗り気が全く感じられなかったので断念｡
かと言って､SNSで募集をかけて専用グループを作るのは億劫だった｡
そして､インターネット上で話し合いの場として提供されている匿名掲示板､Q&Aサイト､SNSアプリ等への投稿を検討し始めたわけだが､気が進まない｡
前述した場所では､フォーマットの指定がなく自由に記述された文章の羅列が上下に表示されているだけのことが多く､そのことはディスカッションの場としていくつかの問題点を孕んでいるからだ｡

&nbsp;&nbsp;第一に､｢意見の質｣が100%ユーザーに依存してしまう点が挙げられる｡フォーマットが無いということは､いわば｢なんでもありな無法地帯｣ということであり､
証拠どころか理由すらない結論だけの発言でさえ歓迎されてしまう｡ 結論だけでは､とっかかりが少なすぎるため､反論が育ちにくい｡結果､｢結論だけの主張｣が乱立し､
｢異なる結論の押しつけ合い｣になってしまうことが多い｡最終的な勝敗は｢いいね数｣などで決まるのかもしれないが､その一連の流れで得られるものは､優越感や劣等感だけである｡  
&nbsp;&nbsp;しかし､ディスカッションはそんなものを得るために行うものではない｡ディスカッションの目的は､｢より正しい結論｣や｢よりよい解決策｣を導き出すことである｡  
&nbsp;&nbsp;そのような実りある建設的なディスカッションを行うためには､「主張→反論→再反論」という流れを作る必要がある｡  
そのためには､反論のとっかかりが多い意見､つまり､結論､理由､証拠の3要素を備えた意見を増やすことが重要になってくるのだが､
その3要素を満たすことを､フォーマット無しの自由記述方式で実現することは難しい｡

&nbsp;&nbsp;第二に､文章を読まないと｢意見の種類｣､｢どの反論が､どの意見の､どの要素に対して批判を提示しているのか｣､｢意見の構成｣の3点を､把握できないという点が挙げられる｡  
&nbsp;&nbsp;最初の2点は､意見を読む前に把握できなければ､読む必要の無い意見まで読まなければならなくなるので､タイムパフォーマンスが悪くなってしまう｡また､労力をかけて読んだ意見が､途中で不要なものだと分かれば､誰だってやる気が削がれてしまうだろう｡  
&nbsp;&nbsp;最後の1点は､意見を読む込む際に重要になってくる｡構成が分からない意見を素早く理解することは困難だ｡
少数のプロの書き手による意見(本や論文など)ならまだしも､不特定多数の素人の意見となると､千差万別の構成が出てくるので､それらをいちいち文章から読み解くことは大変な手間である｡

&nbsp;&nbsp;第三に､意見の配置が一次元的(上下のみ)なので､1つの意見に複数の反論がつけられたとき､意見間の関係が分かりにくくなってしまうという問題がある｡
例えば､主張Aがあり､それに対する1つめの反論(反論A)に続いて､2つめの反論(反論B)が作成されたとする｡この場合､上から下に向かって､主張A→反論A→反論Bという配置になる｡
そのような配置になってしまうと､反論Bが､反論Aに対する再反論なのか､主張Aに対する反論なのか､見分けがつきづらいというわけだ｡
今回の場合は反論が2つだけだったからまだ良いが､反論の数に比例してこの問題は大きくなる｡

そこで､情報を視覚的に整理して表示するディスカッションアプリを開発することで､
前述した問題点を解消し､ストレスフリーなディスカッションの場をインターネット上に提供することを試みた｡

## 理由に挙げた3点を満たすために実行した対応策
>1. ユーザー非依存に意見の質を確保する仕組みがあること

→ 意見の構成要素を｢結論｣｢理由｣｢証拠｣の3要素とし､それに応じたフォーマットを意見入力欄に適用することで対応

<br/>
<br/>

>2. 文章を読まずとも｢意見の種類｣､｢どの反論が､どの意見の､どの要素に対して批判を提示しているのか｣､｢意見の構成｣の3点を把握できること

→
* ｢意見の種類｣に関しては､意見を｢主張｣と｢反論｣の2種類に大別し､両者を色で判別できるよう｢主張｣を｢青｣､｢反論｣を｢ピンク｣で色分けすることで対応
  
<br/>

* ｢どの反論が､どの意見の､どの要素に対して批判を提示しているのか｣については､反論左上の｢●｣から､意見中の｢結論｣｢理由｣｢証拠｣要素の左右の｢●｣や各要素間の｢●｣に赤い接続線を引けるようにすることで対応
  
<br/>

* ｢意見の構成｣に関しては､意見の構成要素である｢結論｣｢理由｣｢証拠｣をツリー型に配置することで対応

<br/>
<br/>

>3. 1つの意見に複数の反論が作成されても､意見ー反論間の関係が分かりやすいこと

→ 意見の位置をドラッグ&ドロップで移動できるようして､二次元的(上下+左右)な配置を可能にすることで対応




## 既存のQ&Aサイト(Quora)と本アプリで同様の議論展開がされたときの比較

<img width="1452" alt="比較画像 スクショ" src="https://github.com/tikuwabux/VisualDiscussion/assets/111355072/1354c4b0-198f-47f8-bb23-0bdc8373887c">




## デモ画像

### ログイン前のトップページ

![ログイン前 トップページ](https://github.com/tikuwabux/VisualDiscussion/assets/111355072/e57c207f-ecbd-4d00-a94e-1c3f37b3c133)

### ログイン後のトップページ

![ログイン後 トップページ](https://github.com/tikuwabux/VisualDiscussion/assets/111355072/277ca439-8ead-4439-ae9b-0228d90d547d)


## 機能一覧
| User周りの機能 | 説明 |
| ---- | ---- |
| サインアップ機能 | 有効な｢ニックネーム｣, ｢メールアドレス｣, ｢パスワード｣, ｢確認用パスワード｣を入力することで､サインアップすることができる |
| ログイン機能 | 有効な｢メールアドレス｣, ｢パスワード｣を入力することで､ログインすることができる |
| ゲストログイン機能 | ｢ゲストログイン｣リンクを押すだけで､ゲストユーザーとしてログインすることができる |
| ログアウト機能 | ｢ログアウト｣リンクを押すと､ログアウトすることができる |
| ユーザー情報編集機能 |  ｢ニックネーム｣, ｢メールアドレス｣, ｢パスワード｣等を編集することができる |


| AgendaBoard周りの機能 | 説明 |
| ---- | ---- |
| 新規議題ボード作成機能 | 有効な｢議題｣を入力し､｢カテゴリ｣を選択することで､新たな議題ボードを作成することができる |
| ログインユーザーが作成した議題ボード一覧閲覧機能 | ログインユーザーは自身が作成した議題ボードの一覧を閲覧することができる |
| ログインユーザーが発言した議題ボード一覧閲覧機能 | ログインユーザーは自身が意見を投稿した議題ボードの一覧を閲覧することができる |
| カテゴリ名での議題ボード一覧検索機能 | ｢カテゴリ｣を選択することで､そのカテゴリを有する議題ボードの一覧を検索し､閲覧することができる |
| 議題名での議題ボード一覧検索機能 | ｢議題名｣を入力することで､入力した単語を議題名に有する議題ボードの一覧を検索し､閲覧することができる |
| 議題ボード詳細閲覧機能 | 議題ボードの議題と､作成された主張や反論の一覧を閲覧することができる |
| 議題ボード編集機能 | ログインユーザーは､自身が作成した､かつ､意見数が0である議題ボードに限り､｢議題｣や｢カテゴリ｣を編集することができる |
| 議題ボード削除機能 | ログインユーザーは､自身が作成した､かつ､意見数が0である議題ボードに限り､議題ボードを削除することができる |


| Argument周りの機能 | 説明 |
| ---- | ---- |
| 新規主張作成機能 | ｢結論｣,｢理由｣,｢証拠｣を入力することで､主張を作成することができる|
| 主張編集機能 | ログインユーザーは､自身が作成した､かつ､反論が1つもついてない主張に限り､主張を編集することができる |
| 主張削除機能 | ログインユーザーは､自身が作成した､かつ､反論が1つもついてない主張に限り､主張を削除することができる |


| Refutation周りの機能 | 説明 |
| ---- | ---- |
| 新規反論作成機能 | ｢結論｣,｢理由｣,｢証拠｣を入力することで､反論を作成することができる|
| 反論編集機能 | ログインユーザーは､自身が作成した､かつ､反論が1つもついてない反論に限り､反論を編集することができる |
| 反論削除機能 | ログインユーザーは､自身が作成した､かつ､反論が1つもついてない反論に限り､反論を削除することができる |


| OpinionPosition周りの機能 | 説明 |
| ---- | ---- |
| 意見の位置情報保存機能 | 議題ボード詳細ページ上で､意見をドラッグ&ドロップして移動させた際､ドロップ時の位置情報をDBに保存する |
| 意見の位置復元機能 | 議題ボード詳細ページリロード時､DBに保存されている位置情報をもとに､意見の位置を復元する |


| OpinionConnection周りの機能 | 説明 |
| ---- | ---- |
| 意見間の接続線情報保存機能 | 議題ボード詳細ページ上で､意見間に接続線を引いたとき､その接続線情報をDBに保存する |
| 意見間の接続線情報削除機能 | 議題ボード詳細ページ上で､意見間の接続線を削除したとき､その接続線情報をDBから削除する |
| 意見間の接続線復元機能 | 議題ボード詳細ページリロード時､DBに保存されている接続線情報をもとに､意見間の接続線を復元する |

## こだわりのポイント
### 1. 新規主張･反論を作成する際の自由度の高さ
1. 理由･証拠フォームは無制限に追加することが可能
2. 理由フォームを削除すると､それに紐づく証拠フォームも自動で削除
3. 結論･理由･証拠入力欄(改行不可)の幅は､入力された文字列の幅に合わせて伸縮
4. 結論詳細･理由詳細･証拠詳細入力欄(改行可)の幅は､最大幅の文字列を含む行の幅に､高さは全行の高さに合わせて伸縮


https://github.com/tikuwabux/VisualDiscussion/assets/111355072/711d8c99-31a7-4262-b3e4-cc3ecc77d29c



https://github.com/tikuwabux/VisualDiscussion/assets/111355072/fe821be7-f99f-4e3f-b27a-f73b7e8a97cc


### 2. 反論作成のしやすさ
反論対象の意見を横目に見ながら反論を作成することができる
![反論作成のこだわり](https://github.com/tikuwabux/VisualDiscussion/assets/111355072/24c9aa1e-4852-4786-a7c1-5726c5e910bd)

![反論作成のこだわり2](https://github.com/tikuwabux/VisualDiscussion/assets/111355072/85e47cd2-0490-4d67-be00-eea6ec4f24c5)



### 3. 意見のレイアウト
意見の構造を視覚的に捉えやすいツリー型のレイアウト
![意見のレイアウトこだわり1](https://github.com/tikuwabux/VisualDiscussion/assets/111355072/3a264a21-ed85-4bd6-bd0d-4b0c4d2ab525)
![意見のこだわり理レイアウト2](https://github.com/tikuwabux/VisualDiscussion/assets/111355072/f59fc120-54f1-4fdd-a21b-f199427128e7)


### 4. 目に優しい配色
長時間見続けても､疲れにくいよう青を基調とした淡い色で配色を統一


https://github.com/tikuwabux/VisualDiscussion/assets/111355072/6ba4cd13-d352-43ee-85d1-6a3c4d4d15fc


### 5. 最短距離で繋がる接続線
接続線が繋がった状態で､片方の意見の位置を移動させると､接続線が最短距離になるように接続線の終点が左右に移動する｡


https://github.com/tikuwabux/VisualDiscussion/assets/111355072/e5c22dc1-df7b-4f4d-aeef-adae34f19fd1




### 6. 議題名での議題ボード検索の自由度の高さ
複数単語での自由度の高い検索が可能



https://github.com/tikuwabux/VisualDiscussion/assets/111355072/3b8c96bd-d162-48a3-adc8-0b3549b94a49




## 使用した技術
### バックエンド
| 使用技術 | 用途 |
| ---- | ---- |
| Rails 6.0.6.1 | rubyを使用したwebアプリ開発の簡素化 |
| Ruby 2.7.6 | メイン言語 |
| Rspec | コードのテスト |
| Rubocop | コードのリファクタリング |
| PostgreSQL 14.6 | DBの操作 |

### フロントエンド
| 使用技術 | 用途 |
| ---- | ---- |
| HTML | 全体的なレイアウト |
| SCSS | 全体的なレイアウト整理 |
| Javascript | 動的操作の実装 |
| jQuery | js記述の簡素化 |
| jsplumb | 意見のレイアウトをツリー状に整えることを簡素化 |
| 同上 | 議題ボード詳細ページ上の､意見の挙動や意見間の接続線機能実装の簡素化 |

### インフラ
| 使用技術 | 用途 |
| ---- | ---- |
| Heroku | アプリケーション公開に必要な環境構築の簡素化 |


## ER図
![スクリーンショット 2023-08-27 7 07 05](https://github.com/tikuwabux/VisualDiscussion/assets/111355072/cc4c5930-2f45-4bff-8fa7-8feb455a280c)


## 今後追加したい機能
-[ ] **反論通知機能** ・・・ 意見に反論が追加された時､その意見を作成したユーザーのメールアドレスに通知メッセージを送る
-[ ] **意見最小化/展開機能** ・・・ 議題ボード詳細ページ中の意見の表示について､｢結論詳細｣､｢理由詳細｣､｢証拠詳細｣らは､通常時､折り畳められており､｢結論｣､｢理由｣､｢証拠｣の3行のみがデフォルトで表示される｡左クリックによる展開と最小化の操作が可能｡
-[ ] **意見評価機能** ・・・ ｢論理的｣ボタンと｢感情的｣ボタンを各意見に設置し､意見の作成者以外が1度だけ押せるようにする｡ボタンの横にはカウント数が表示される｡
-[ ] **評価に応じた意見サイズの相対化機能** ・・・ 表示される意見のサイズは､｢論理的｣のカウント数が多いほど大きくなり､｢感情的｣のカウント数が多いほど小さくなる｡
  
## 今後修正したい点
-[x] **意見のドラッグハンドル領域** ・・・ 現在の議題ボード詳細ページの意見は､意見全体がドラッグハンドルになっているため､意見中の分からない単語等のコピーができず不便｡なので､｢〇〇さんの主張(or反論)｣の部分のみがドラッグハンドルになるよう変更したい｡

-[ ] **意見中に貼付けられたurlの表示**  ・・・ 現在の議題ボード詳細ページでは､意見中にurlが貼り付けられていても､リンク化されず文字列のまま表示されるため､リンク先の参照が億劫｡なので､貼り付けられてurlはリンク化して表示したい｡

## 本アプリの仕様決定において参考にしたサイト
https://www.ritsumei.ac.jp/ir/ir-navi/technic/technic06.html/

