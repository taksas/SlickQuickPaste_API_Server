# API Server Application for SlickQuickPaste

SlickQuickPasteにおいて、クリップボードの内容をサーバー上に一時保存するためのAPIを提供します。

API仕様は公開しているため、誰でも自由にクライアントを作成することが可能です。

Chrome拡張機能版のクライアントはこちら→　https://github.com/taksas/SlickQuickPaste_Cli_Chrome

Android版、Win版の公開は未定です。

## これは何？

クラウド上で管理するクリップボード機能を提供するシステムの、バックエンドを担当します。Ruby on RailsのAPIモードで構築しています。

## 使い方

### 新規登録
アカウントの新規登録時は、/v1/auth にPOSTメソッドでアクセスします。

その際、新規登録に必要な情報をjsonでBodyに挿入します。メールアドレスとパスワード（という名の入力欄2つ）が必要です。**これらは適当な文字列、数列で大丈夫です。実際に使用しているメールアドレス、パスワード含む個人情報は入力しないでください。**

・例

```
{
  "email": "test1@example.com",
  "password": "password"
}
```

正常に登録が完了すれば200 OK、既にメールアドレスが登録済みの場合は422 Unprocessable Entityが返ってきます。


### ログイン
アカウントへのログイン時は、/v1/auth/sign_in にPOSTメソッドでアクセスします。

その際、ログインに必要な情報をjsonでBodyに挿入します。メールアドレスとパスワードが必要です。

・例

```
{
  "email": "test1@example.com",
  "password": "password"
}
```

正常にログインが完了すれば200 OK、ログイン出来なかった場合は401 Unauthorizedが返ってきます。

ログインが成功した場合は、その後の作業に必要なアクセストークンが発行されます。これはレスポンスヘッダに含まれます。

・例

```
x-frame-options:
SAMEORIGIN
x-xss-protection:
0
x-content-type-options:
nosniff
x-download-options:
noopen
x-permitted-cross-domain-policies:
none
referrer-policy:
strict-origin-when-cross-origin
content-type:
application/json; charset=utf-8
access-token:
upUZQMyGXjytY7v_PSZdWg
token-type:
Bearer
client:
bNResPMAJbZSF1QXTqm9IA
expiry:
1780970166
uid:
test@example.com
authorization:
Bearer eyJhY2Nlc3MtdG9rZW4iOiJ1cFVaUU15R1hqeXRZN3ZfUFNaZFdnIiwidG9rZW4tdHlwZSI6IkJlYXJlciIsImNsaWVudCI6ImJOUmVzUE1BSmJaU0YxUVhUcW05SUEiLCJleHBpcnkiOiIxNzgwOTcwMTY2IiwidWlkIjoidGVzdEBleGFtcGxlLmNvbSJ9
etag:
W/"573c5f2ffab0f04c0019352386f6e6c3"
cache-control:
max-age=0, private, must-revalidate
x-request-id:
e7add988-9b04-4707-b9fc-66af942c214e
x-runtime:
0.316396
server-timing:
start_processing.action_controller;dur=0.306396484375, unpermitted_parameters.action_controller;dur=0.886474609375, sql.active_record;dur=9.207763671875, instantiation.active_record;dur=0.206787109375, process_action.action_controller;dur=313.240478515625
vary:
Origin
transfer-encoding:
chunked
```

この内、

* access-token

* uid

* client

* expiry

* token-type

がアクセストークンになります。


### クリップボードの内容呼び出し

内容呼び出しには、 /v1/users/get にGETメソッドでアクセスします。

その際、先ほど取得したアクセストークンをヘッダーに付けてください。

・例

```
content-type: application/json
access-token: upUZQMyGXjytY7v_PSZdWg
uid: test@example.com
client: bNResPMAJbZSF1QXTqm9IA
expiry: 1780970166
token-type: Bearer
```

正常に取得が完了すれば200 OK、ログイン出来なかった場合は401 Unauthorizedが返ってきます。

クリップボードの内容が取得できた場合はレスポンスヘッダーで内容が得られます。


・例

```
{
"clipboard": {
"id": 2,
"user_id": 1,
"text": "S.Q.Pasteにクリップボードの内容を保存し、端末間で共有します。",
"created_at": "2022-08-09T01:43:48.718Z",
"updated_at": "2022-08-09T01:43:48.718Z"
}
}
```

textプロパティがクリップボードの内容です。


### クリップボードの内容書き換え

内容書き換えには、 /v1/users/edit にPOSTメソッドでアクセスします。

その際、先ほど取得したアクセストークンをヘッダーに付けてください。

・例

```
content-type: application/json
access-token: upUZQMyGXjytY7v_PSZdWg
uid: test@example.com
client: bNResPMAJbZSF1QXTqm9IA
expiry: 1780970166
token-type: Bearer
```

更に、書き換えたい内容をBodyにjsonで付けてください。insert_textプロパティを使用します。

・例

```
{
  "insert_text": "S.Q.Pasteでクリップボードの内容を書き換えまょう！"
}
```



正常に処理が完了すれば200 OK、ログイン出来なかった場合は401 Unauthorizedが返ってきます。

## よくあるかもしれない質問

### メアド認証とかしないならメアドパスワード要らなくない？

全く以てその通りです。面倒なので適当に作った関係上メアドパスワード（という名称のカラム2つ）が必要になりますが、適当なものを入力してください。

### メアドパスワードの変更は？

出来ません。そういう仕様です。**つまるところ、メアドパスワードを忘れた場合クリップボードの内容は永久に取得できなくなります。**

### セキュリティーは？

未経験エンジニアがRuby on Railsで作ったポートフォリオレベルです。何度も言いますが、**個人情報を入力しないでください。**
rack-corsについては導入済みですが、このリポジトリでは（ほぼ）無効化状態です。

### 一定期間でクリップボードの内容は消える？

そういった仕様にはしていません。
