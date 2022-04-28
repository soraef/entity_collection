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

It provides an Entity abstract class with an id property of type Id and an EntityMap class that manages a collection of Entities.

The motivation for this package is to provide a way to operate on Entity collections in an Immutable way.

To add Entity/Id pairs in Dart's Map class in an Immutable way, one must write

```dart
/// put entity
final putEntityMap = {...entityMap, id: entity}

/// remove entity
final removeEntityMap = {...entityMap}..removeWhere((id, _) => id == entity.id);
```

In this package, the EntityMap class, which wraps the Map class, can be used to perform Immutable operations on Entity in a readable.

```dart
/// put entity
final putEntityMap = entityMap.put(entity);

/// remove entity
final removeEntityMap = entityMap.remove(entity);
```

## Usage

### Define Entity
As an example, we define the User class.
The User class is an Entity with String type id and name as properties.

```dart
class User implements Entity<String> {
  User(this.id, this.name);

  @override
  final String id;
  final String name;
}
```

Declare `EntityMap<String, User>` to manage a collection of User classes.
Since `EntityMap<String, User>` is long, define Users as an alias.

```dart
typedef Users = EntityMap<String, User>;
```

This completes the preparation.
Now we can use the API of the EntityMap class to operate on the User collection Immutably.

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

If desired, a method can be added to the Users class using extension.
This can be a very effective way to add User-specific processing.

```dart
/// names: (Anya, Loid, Yor)
final spyFamily = Users.fromIterable([user1, user2, user3]);
final names = spyFamily.names;
```

