# CCSWebsite

[千葉大学電子計算機研究会 Webサイト](http://sherbet.transjiggen.com/ccs/)の制作用リポジトリです。  
pull requestやissueなど、どんどん送ってください。

---

### 自動デプロイ

masterにpushすると自動的にCCSのWebサーバへ仮デプロイされます。  
[こちらから現在の状態を確認することができます。](http://sherbet.transjiggen.com/ccs/new/)

### 方針

- コンテンツはほぼ全て静的HTML
- MarkdownでHTMLを生成できるスクリプトを用意？

### Onlyの認証システム

1. クライアント：入力されたパスワードをサーバに送信
2. サーバ：送信されたパスワードをBlowfish+saltでハッシュ化したものを返す
3. クライアント：Cookieにハッシュを登録し、閲覧したいページへ遷移
4. サーバ：mod_rewrite を利用してCookieに登録されているハッシュが正しいかどうかを判定
5. サーバ：Cookieが存在しない、もしくはハッシュが正しくない場合はログインページにリダイレクト

#### 問題点

- ログインせずにOnly内のページを閲覧しようとした場合、ログインページにリダイレクトされた時点でアクセスしたかったページの情報が失われる