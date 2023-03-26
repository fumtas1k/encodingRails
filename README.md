# encodingRails

Windows-31Jでのリクエスト、Windows-31Jでのレスポンス

### デフォルトからの設定変更必要箇所

* config/puma.rb

portをコメントアウトし、bind追加。EC2ではpuma.sockを使用

```ruby
# port ENV.fetch("PORT") { 3000 }
bind "unix://#{Rails.root}/tmp/sockets/puma.sock"
```

* config/database.yml

mysql.sockの配置場所がEC2とMACで異なるので以下の設定をし、.envファイルに記載する

```yaml
socket: <%= ENV["DB_SOCKET"] %> #/var/lib/mysql/mysql.sock or /tmp/mysql.sock
```
