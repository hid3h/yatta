# Flutter アプリケーションの推奨アーキテクチャ

公式ドキュメント "App Architecture" セクションから得られる内容を日本語で簡潔にまとめます。

---

## 1. 目的とメリット
- 意図的なアーキテクチャを採用することで、保守性・スケーラビリティ・テスタビリティが向上し、チームの認知負荷を下げ、最終的にユーザー体験の向上につながる。

## 2. 共通アーキテクチャ概念

| 概念 | 要点 |
| --- | --- |
| Separation of Concerns | UI とビジネスロジックを分離し、層内でも責務単位でクラスを分割する |
| Layered Architecture | UI ↔ Domain (任意) ↔ Data の 2〜3 層構造。隣接層のみ通信可 |
| Single Source of Truth | 各データ型の真実の置き所は 1 つの Repository に集約 |
| Unidirectional Data Flow | データは下→上へ、ユーザ操作は上→下へ一方向に流れる |
| UI = f(Immutable State) | 不変データを入力として UI を再描画 |
| Extensibility / Testability | 層とクラスの境界がモジュール化とテスト容易性を担保 |

## 3. 推奨プロジェクト構造と MVVM

```
┌─ UI layer ──────────────┐
│  View        (Widget)   │
│  ViewModel   (logic)    │ ← MVVM
└──────────▲─────────────┘
            │
┌─ Domain layer (任意) ───┐
│  UseCase / Interactor    │
└──────────▲─────────────┘
            │
┌─ Data layer ────────────┐
│  Repository  (SSOT)      │
│  Service     (外部I/O)   │
└─────────────────────────┘
```

- MVVM: 機能ごとに View と ViewModel を 1 対 1 で持ち、Repository / Service は複数機能から再利用する。
- View は描画と簡易 UI ロジックのみ担当。
- ViewModel は Repository から取得したデータを UI 状態に整形し、Command で View ↔ ViewModel 間イベントを橋渡しする。
- Repository はキャッシュ・リトライ・変換などビジネスロジックを含み Service を呼び出す。
- Domain / Use-case 層は ViewModel が複雑化したときのみ導入し、複数 Repository のデータ統合などを行う。

## 4. ディレクトリ構成の実例 (Compass Sample)

```
lib/
├─ ui/
│  ├─ core/             # 共有 UI・テーマ
│  └─ <feature>/        # 機能単位
│     ├─ view_model/
│     └─ widgets/
├─ domain/
│  └─ models/           # ドメインモデル
├─ data/
│  ├─ repositories/
│  ├─ services/
│  └─ model/            # API モデルなど
├─ config/ utils/ routing/
├─ main.dart            # prod
├─ main_development.dart
└─ main_staging.dart
```

- UI は機能別、Data は型別に配置することで再利用と衝突回避を両立。
- 3 つの `main_*.dart` で環境 (dev / staging / prod) を切り替える。

## 5. Flutter チームのベストプラクティス
- レイヤ分離、Repository パターン、MVVM は強く推奨。
- ChangeNotifier & Listenable を用いた状態通知が基本手段 (他のパッケージ利用も可)。
- Widget にビジネスロジックを入れない。
- Domain 層は複雑ロジックや重複が増えた場合のみ導入。
- 依存性注入には `provider` パッケージを推奨。
- `go_router` が多くのアプリで推奨されるナビゲーション解法。
- 抽象 Repository を用意し、環境ごとに実装を差し替える設計を強く勧める。

## 6. 追加リソース
- **Compass App** – 完全実装例。サンプルコードと上記構成が一致。
- **very_good_cli** – Very Good Ventures 提供の Flutter テンプレート。似たディレクトリ構成を自動生成。

---

以上が公式ガイド全体の要点をまとめたものです。既存プロジェクトへの導入や新規アプリ設計のスタートポイントとして活用してください。
