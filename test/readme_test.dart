import 'package:entity_collection/entity_collection.dart';
import 'package:flutter_test/flutter_test.dart';

class User implements Entity<String> {
  User(this.id, this.name);

  @override
  final String id;
  final String name;
}

typedef Users = EntityMap<String, User>;

extension UsersX on Users {
  Iterable<String> get names => entities.map((e) => e.name);
}

void main() {
  test("README TEST", () {
    final user1 = User("1", "Anya");
    final user2 = User("2", "Loid");
    final user3 = User("3", "Yor");

    // create Empty Users
    final users = Users.empty();
    expect(users.length, 0);

    // putUsers.entities: [user1]
    final putUsers = users.put(user1);
    expect(putUsers.length, 1);

    // removeUsers.entities: []
    final removeUsers = putUsers.remove(user1);
    expect(removeUsers.length, 0);

    // putAllUsers.entities: [user1, user2]
    final putAllUsers = removeUsers.putAll([user1, user2]);
    expect(putAllUsers.length, 2);

    // findUser: user1
    final findUser = putAllUsers.byId(user1.id);
    expect(findUser, user1);

    // removeAllUsers: []
    final removeAllUsers = putAllUsers.removeAll([user1, user2]);
    expect(removeAllUsers.length, 0);

    // whereUsers: [user1]
    final whereUsers = putAllUsers.where((e) => e.name == user1.name);
    expect(whereUsers.length, 1);

    // sorted: [user3, user2, user1]
    final spyFamily = Users.fromIterable([user1, user2, user3]);
    final sorted = spyFamily.sorted((a, b) => b.id.compareTo(a.id));
    expect(sorted.first, user3);

    print(spyFamily.names);
  });
}
