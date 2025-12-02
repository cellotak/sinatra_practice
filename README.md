# Sinatra Practice

## 概要

メモの作成、閲覧、編集、削除（CRUD）ができるメモアプリケーションです。
DB には PostgreSQL を使用しています。

## 必要な環境

- Ruby (バージョン `3.4.5`)
- Bundler
- PostgreSQL (バージョン`13.14` で動作確認済み)

## 実行手順（ローカル環境）

### リポジトリのクローン

```bash
git clone git@github.com:cellotak/sinatra_practice.git
cd sinatra_practice
```

### Gem のインストール

```bash
bundle install
```

### データベースのセットアップ

以下のように PostgreSQL に接続します。

```bash
psql -U [データベースユーザー名] -d [初期接続データベース名]
```

psql プロンプト (`postgres=#`) に入ったら、以下の SQL/コマンドを実行してください。

```sql
-- データベースを作成
CREATE DATABASE sinatra_memo;

-- 新しいデータベースに接続を切り替え
\c sinatra_memo

-- memos テーブルを作成
CREATE TABLE memos (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT
);
-- psql クライアントを終了
\q
```

## 環境変数の設定

`.env.example` を参考にして、ルートディレクトリに `.env` ファイルを作成し、`DATABASE_URL` を設定してください。

### アプリケーションの起動

```bash
bundle exec ruby app.rb
```

### ブラウザでアクセス

ブラウザで `http://localhost:4567` にアクセスしてください。

### その他

#### linter

```bash
# rubocop
bundle exec rubocop
# erb_lint
bundle exec erb_lint --lint-all
```
