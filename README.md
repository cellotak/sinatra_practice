# Sinatra Practice

## 概要

メモの作成、閲覧、編集、削除（CRUD）ができるメモアプリケーションです。
データは `data/memo.json` ファイルに保存されます。

## 必要な環境

- Ruby (バージョン `3.4.5`)
- Bundler

## 実行手順（ローカル環境）

### 1. リポジトリのクローン

```bash
git clone git@github.com:cellotak/sinatra_practice.git
cd sinatra_practice
```

### 2. Gem のインストール

```bash
bundle install
```

### 3. アプリケーションの起動

```bash
bundle exec ruby app.rb
```

### 4. ブラウザでアクセス

ブラウザで `http://localhost:4567` にアクセスしてください。

### その他

#### linter

```bash
# rubocop
bundle exec rubocop
# erb_lint
bundle exec erb_lint --lint-all
```
