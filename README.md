# app_creditnote-2

クレジットカードの請求・明細をローカルで一元管理する Flutter 製の家計簿アプリです。
カード別・カテゴリ別・月次・年次の集計表示、サブスクリプション管理、CSV インポート/エクスポートに対応しています。

---

## 主な機能

### クレジット請求の管理
- **請求入力** — カード名・請求日・合計金額を登録
- **金額編集** — 登録済み請求金額の修正
- **空白データ再入力** — 未入力の明細をまとめて補完

### 明細の管理
- **明細入力** — 年月・請求日・明細日・項目・説明・金額を紐付けて登録
- **明細編集** — 登録済み明細の内容を修正
- **同一項目一覧** — 同じ項目名でまとめた明細履歴を表示
- **月次明細一覧** — 月ごとのクレジット項目を一覧表示

### カテゴリ・集計
- **カテゴリ項目管理** — 支出カテゴリの作成・カラー設定・ドラッグ＆ドロップ並び替え
- **カテゴリ別金額タブ** — カテゴリごとの金額集計をタブ切り替えで表示
- **カテゴリ別金額一覧ページ** — 全カテゴリの金額を一覧表示
- **年次カテゴリタブ** — 年ごとのカテゴリ別支出サマリー
- **年次カテゴリ一覧ページ** — 年次のカテゴリ別明細を詳細表示

### サブスクリプション管理
- **サブスク項目登録** — 定期課金サービス名の一覧管理

### データ管理
- **CSVインポート** — 外部CSVファイルからクレジット明細を取り込み
- **データダウンロード** — 記録データをCSV形式でエクスポート・共有
- **アプリ設定** — 表示設定などのカスタマイズ

---

## 技術スタック

| カテゴリ | 技術 |
|---|---|
| フレームワーク | [Flutter](https://flutter.dev/) (Dart SDK >=3.3.0 <4.0.0) |
| 状態管理 | [Riverpod](https://riverpod.dev/) (hooks_riverpod / flutter_hooks / riverpod_annotation) |
| ローカルDB | [Isar](https://isar.dev/) v3 |
| コード生成 | freezed / json_serializable / riverpod_generator / build_runner |
| グラフ | [fl_chart](https://pub.dev/packages/fl_chart) |
| UI操作 | [flutter_slidable](https://pub.dev/packages/flutter_slidable), [drag_and_drop_lists](https://pub.dev/packages/drag_and_drop_lists), [flutter_colorpicker](https://pub.dev/packages/flutter_colorpicker) |
| ファイル操作 | [file_picker](https://pub.dev/packages/file_picker), [share_plus](https://pub.dev/packages/share_plus), [external_path](https://pub.dev/packages/external_path), [charset_converter](https://pub.dev/packages/charset_converter) |
| フォント | KiwiMaru / Google Fonts |

---

## 対応プラットフォーム

- Android
- iOS
- macOS
- Windows
- Linux

---

## データモデル (Isar Collections)

| コレクション | 概要 |
|---|---|
| `Credit` | クレジット請求（日付・カード名・金額） |
| `CreditDetail` | 明細詳細（年月・請求日・明細日・項目・説明・金額） |
| `CreditItem` | カテゴリ項目（名前・表示順・カラー） |
| `SubscriptionItem` | サブスクリプション項目（名前） |
| `Config` | アプリ設定 |

---

## プロジェクト構成

```
lib/
├── main.dart                  # エントリーポイント・Isar初期化
├── collections/               # Isarコレクション定義
│   ├── credit.dart            # クレジット請求
│   ├── credit_detail.dart     # 明細詳細
│   ├── credit_item.dart       # カテゴリ項目
│   ├── subscription_item.dart # サブスクリプション項目
│   └── config.dart            # アプリ設定
├── model/                     # データモデル（Freezed）
├── repository/                # データアクセス層
├── state/                     # Riverpod状態
├── screens/
│   ├── home_screen.dart       # ホーム画面
│   └── components/            # ダイアログ・UIコンポーネント
│       ├── credit_input_alert.dart             # 請求入力
│       ├── credit_detail_input_alert.dart      # 明細入力
│       ├── credit_detail_edit_alert.dart       # 明細編集
│       ├── credit_price_edit_alert.dart        # 金額編集
│       ├── credit_item_input_alert.dart        # カテゴリ項目入力
│       ├── credit_blank_re_input_alert.dart    # 空白データ再入力
│       ├── categories_price_tab_alert.dart     # カテゴリ別金額タブ
│       ├── monthly_credit_item_list_alert.dart # 月次明細一覧
│       ├── yearly_credit_category_tab_alert.dart # 年次カテゴリタブ
│       ├── same_item_list_alert.dart           # 同一項目一覧
│       ├── download_data_list_alert.dart       # データダウンロード
│       ├── config_setting_alert.dart           # 設定
│       ├── csv_data/                           # CSVインポート関連
│       ├── pages/                              # フルページ画面
│       └── parts/                             # 共通UIパーツ
├── enums/                     # 列挙型
├── extensions/                # 拡張メソッド
└── utility/                   # ユーティリティ
assets/
├── images/                    # 画像リソース
└── fonts/                     # KiwiMaruフォント
```

---

## セットアップ

### 前提条件

- Flutter SDK (Dart >=3.3.0 <4.0.0)

### インストール手順

```bash
# リポジトリをクローン
git clone https://github.com/toyotarou/app_creditnote-2.git
cd app_creditnote-2

# 依存パッケージをインストール
flutter pub get

# コード生成（Isar / Riverpod / Freezed）
dart run build_runner build --delete-conflicting-outputs

# アプリを実行
flutter run
```

---

## ライセンス

このプロジェクトはプライベートリポジトリです (`publish_to: 'none'`)。
