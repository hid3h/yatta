# Riverpod Integration Guide

## 概要

このプロジェクトにRiverpodを導入し、状態管理を改善しました。従来のStatefulWidget + setStateパターンから、より保守性とテスタビリティの高いアーキテクチャに移行しています。

## 導入されたパッケージ

```yaml
dependencies:
  flutter_riverpod: ^2.4.10
  riverpod_annotation: ^2.3.4

dev_dependencies:
  riverpod_generator: ^2.3.11
  build_runner: ^2.4.7
```

## アーキテクチャ構造

```
lib/
├── main.dart                    # ProviderScopeでアプリをラップ
├── data/
│   └── models/
│       └── habit.dart          # Habitモデル（イミュータブル）
└── ui/
    └── home/
        ├── home_page.dart      # ConsumerWidget使用
        ├── view_model/
        │   └── home_view_model.dart  # ViewModelとRiverpodプロバイダー
        └── widgets/
            └── habit_list_item.dart  # 再利用可能なウィジェット
```

## 主要な変更点

### 1. main.dart
- `ProviderScope`でアプリ全体をラップ
- Riverpodの状態管理を有効化

### 2. Habitモデル
- イミュータブルなデータクラス
- `copyWith`メソッドで状態更新
- 適切な`equals`と`hashCode`実装

### 3. HomeViewModel
- `StateNotifier`を使用した状態管理
- 習慣の追加、削除、更新、カウント増加機能
- テスタブルなビジネスロジック
- ViewModelファイル内にプロバイダーも定義

### 4. HomePage
- `ConsumerWidget`に変更
- `ref.watch`で状態監視
- `ref.read`でアクション実行

### 5. HabitListItem
- 再利用可能なウィジェット
- 削除機能付きの改良されたUI

## 使用方法

### 状態の監視
```dart
final habits = ref.watch(homeViewModelProvider);
```

### アクションの実行
```dart
final homeViewModel = ref.read(homeViewModelProvider.notifier);
homeViewModel.addHabit();
homeViewModel.incrementHabit(habitId);
```

## テスト

ViewModelのテストが`test/view_models/home_view_model_test.dart`に実装されています。

```bash
flutter test test/view_models/home_view_model_test.dart
```

## Riverpodの利点

1. **状態の分離**: UIロジックとビジネスロジックの明確な分離
2. **テスタビリティ**: ViewModelの単体テストが容易
3. **パフォーマンス**: 必要な部分のみ再描画
4. **スケーラビリティ**: 複雑な状態管理にも対応可能
5. **型安全性**: コンパイル時の型チェック
6. **デバッグ**: Riverpod Inspector使用可能

## 今後の拡張

- 永続化（SharedPreferences、Hive等）
- 非同期処理（API連携）
- より複雑な状態管理
- カスタムプロバイダーの追加

## 参考資料

- [Riverpod公式ドキュメント](https://riverpod.dev/)
- [Flutter状態管理ガイド](https://docs.flutter.dev/development/data-and-backend/state-mgmt)
