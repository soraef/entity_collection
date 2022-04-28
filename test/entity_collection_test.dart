import 'package:entity_collection/entity_collection.dart';
import 'package:flutter_test/flutter_test.dart';

class Person implements Entity<String> {
  @override
  final String id;
  final String name;
  final int age;

  Person({
    required this.id,
    required this.name,
    required this.age,
  });
}

typedef PersonMap = EntityMap<String, Person>;

void main() {
  final person1 = Person(id: "1", name: "Hoge", age: 1);
  final person2 = Person(id: "2", name: "Fuga", age: 2);
  final person3 = Person(id: "3", name: "Sora", age: 3);

  test('exist', () {
    final personMap = PersonMap.fromIterable([person1, person2]);
    expect(personMap.exist(person1.id), true);
    expect(personMap.exist(person3.id), false);
  });

  test('byId', () {
    final personMap = PersonMap.fromIterable([person1, person2]);
    final person = personMap.byId(person1.id);
    final notExist = personMap.byId(person3.id);
    expect(person, person1);
    expect(notExist, null);
  });

  test('put', () {
    final personMap = PersonMap.empty();
    final putPersonMap = personMap.put(person1);
    expect(personMap != putPersonMap, true);
    expect(personMap.length, 0);
    expect(putPersonMap.length, 1);
  });

  test('putAll', () {
    final personMap = PersonMap.empty();
    final putPersonMap = personMap.putAll([person1, person2]);
    expect(personMap != putPersonMap, true);
    expect(personMap.length, 0);
    expect(putPersonMap.length, 2);
  });

  test('remove', () {
    final personMap = PersonMap.fromIterable([person1, person2]);
    final removePersonMap = personMap.remove(person1);
    expect(personMap != removePersonMap, true);
    expect(personMap.length, 2);
    expect(removePersonMap.length, 1);
  });

  test('removeAll', () {
    final personMap = PersonMap.fromIterable([person1, person2, person3]);
    final removePersonMap = personMap.removeAll([person1, person2]);
    expect(personMap != removePersonMap, true);
    expect(personMap.length, 3);
    expect(removePersonMap.length, 1);
  });

  test('removeById', () {
    final personMap = PersonMap.fromIterable([person1, person2, person3]);
    final removePersonMap = personMap.removeById(person1.id);
    expect(personMap != removePersonMap, true);
    expect(personMap.length, 3);
    expect(removePersonMap.length, 2);
  });
  test('merge', () {
    final personMap1 = PersonMap.fromIterable([person1, person2]);
    final personMap2 = PersonMap.fromIterable([person2, person3]);
    final mergedMap = personMap1.marge(personMap2);
    expect(mergedMap != personMap1, true);
    expect(mergedMap != personMap2, true);
    expect(mergedMap.length, 3);
  });

  test('where', () {
    final personMap = PersonMap.fromIterable([person1, person2, person3]);
    // expect(personMap.where((p0) => p0.age))
  });

  test('map', () {
    final personMap = PersonMap.fromIterable([person1, person2, person3]);
  });

  test('sort', () {
    final personMap = PersonMap.fromIterable([person1, person2, person3]);
  });
}
