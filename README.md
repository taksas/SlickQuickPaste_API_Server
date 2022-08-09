# API Server Application for SlickQuickPaste

SlickQuickPasteにおいて、クリップボードの内容をサーバー上に一時保存するためのAPIを提供します。

API仕様は公開しているため、誰でも自由にクライアントを作成することが可能です。

## 新規登録
アカウントの新規登録時は、HTTPで /v1/auth にPOSTメソッドで接続します。

その際、メールアドレスやパスワードをjsonでBodyに挿入します。メールアドレスとパスワードが必要です。

・例

```
{
  "email": "test1@example.com",
  "password": "password"
}
```

正常に登録が完了すれば200 OK、既にメールアドレスが登録済みの場合は422 Unprocessable Entityが返ってきます。

## ログイン


## ログイン
## ログイン