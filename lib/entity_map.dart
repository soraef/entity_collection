// Copyright 2022 Sora Fukui. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'entity.dart';
import 'package:collection/collection.dart';

class EntityMap<Id, E extends Entity<Id>> {
  final Map<Id, E> _entities;

  const EntityMap(this._entities);

  factory EntityMap.empty() => EntityMap<Id, E>(const {});

  factory EntityMap.fromIterable(Iterable<E> entities) {
    return EntityMap<Id, E>({for (final entity in entities) entity.id: entity});
  }

  Iterable<E> get entities => _entities.values;

  Iterable<Id> get ids => _entities.keys;

  int get length => entities.length;

  bool exist(Id id) => _entities[id] != null;

  E? byId(Id id) => _entities[id];

  EntityMap<Id, E> byIds(List<Id> ids) {
    return EntityMap.fromIterable(
      ids.where((id) => exist(id)).map((id) => byId(id)!),
    );
  }

  EntityMap<Id, E> put(E entity) {
    return EntityMap<Id, E>({..._entities, entity.id: entity});
  }

  EntityMap<Id, E> putAll(Iterable<E> entities) {
    return EntityMap<Id, E>({
      ..._entities,
      for (final entity in entities) entity.id: entity,
    });
  }

  EntityMap<Id, E> remove(E entity) {
    return EntityMap<Id, E>(
      {..._entities}..removeWhere((id, _) => id == entity.id),
    );
  }

  EntityMap<Id, E> removeAll(Iterable<E> entities) {
    return EntityMap<Id, E>(
      {..._entities}..removeWhere(
          (id, entity) => entities.map((e) => e.id).contains(id),
        ),
    );
  }

  EntityMap<Id, E> removeWhere(bool Function(E entity) test) {
    return EntityMap<Id, E>(
      {..._entities}..removeWhere((id, e) => test(e)),
    );
  }

  EntityMap<Id, E> removeById(Id id) {
    return EntityMap<Id, E>(
      {..._entities}..removeWhere((_id, entity) => id == _id),
    );
  }

  EntityMap<Id, E> marge(EntityMap<Id, E> other) {
    return EntityMap<Id, E>({..._entities, ...other._entities});
  }

  EntityMap<Id, E> where(bool Function(E) test) {
    return EntityMap.fromIterable(_entities.values.where(test));
  }

  Iterable<T> map<T>(T Function(E entity) convert) {
    return entities.map(convert);
  }

  List<E> sorted(int Function(E a, E b) compare) {
    return entities.sorted(compare);
  }
}
