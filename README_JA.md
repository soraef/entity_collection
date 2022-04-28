<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

Provides an EntityMap that holds a collection of Entity classes with id and Immutable operations Provider 

## Features

Id型のidプロパティをもつEntity抽象クラスとEntityのコレクションを管理するEntityMapクラスを提供します。

このパッケージのモチベーションはEntityのコレクションをImmutableに操作する方法を提供することです。

Immutableな方法でDartのMapクラスでEntityとIdのペアを追加する場合、以下のように書かなければなりません。

```dart
/// put entity
final putEntityMap = {...entityMap, id: entity}

/// remove entity
final removeEntityMap = {...entityMap}..removeWhere((id, _) => id == entity.id);
```

本パッケージではMapクラスをラップした、EntityMapクラスを用いることで、EntityのImmutableな操作をリーダブルに行うことができます。

```dart
/// put entity
final putEntityMap = entityMap.put(entity);

/// remove entity
final removeEntityMap = entityMap.remove(entity);
```

## Usage

### Entityを定義する
例としてUserクラスを定義します。
UserクラスはString型のidとnameをプロパティとして持つEntityです。

```dart
class User implements Entity<String> {
  User(this.id, this.name);

  @override
  final String id;
  final String name;
}
```

Userクラスのコレクションを管理する場合`EntityMap<String, User>`を宣言します。
`EntityMap<String, User>`は長いのでエイリアスとして, Usersを定義します。

```dart
typedef Users = EntityMap<String, User>;
```

これで準備は完了です。
あとはEntityMapクラスのAPIを用いて、UserのコレクションをImmutableに操作することができます。

```dart
final user1 = User("1", "Anya");
final user2 = User("2", "Loid");
final user3 = User("3", "Yor");

// create Empty Users
final users = Users.empty();

// putUsers.entities: [user1]
final putUsers = users.put(user1);

// removeUsers.entities: []
final removeUsers = putUsers.remove(user1);

// putAllUsers.entities: [user1, user2]
final putAllUsers = removeUsers.putAll([user1, user2]);

// findUser: user1
final findUser = putAllUsers.byId(user1.id);

// removeAllUsers: []
final removeAllUsers = putAllUsers.removeAll([user1, user2]);

// whereUsers: [user1]
final whereUsers = putAllUsers.where((e) => e.name == user1.name);

// sorted: [user3, user2, user1]
final spyFamily = Users.fromIterable([user1, user2, user3]);
final sorted = spyFamily.sorted((a, b) => b.id.compareTo(a.id));
```

## Extension

もし必要であれば、extensionを使ってUsersクラスにメソッドを追加することができます。
User固有の処理を追加する場合にとても有効な手段となります。

```dart
/// names: (Anya, Loid, Yor)
final spyFamily = Users.fromIterable([user1, user2, user3]);
final names = spyFamily.names;
```

