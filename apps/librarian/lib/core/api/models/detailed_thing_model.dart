import 'package:librarian_app/core/api/models/image_model.dart';

import 'item_model.dart';

class DetailedThingModel {
  DetailedThingModel({
    required this.id,
    required this.name,
    required this.categories,
    required this.linkedThings,
    required this.images,
    required this.items,
    required this.hidden,
    required this.eyeProtection,
    required this.stock,
    required this.available,
    this.spanishName,
  });

  final String id;
  final String name;
  final String? spanishName;
  final bool hidden;
  final bool eyeProtection;
  final int stock;
  final int available;
  final List<String> categories;
  final List<LinkedThing> linkedThings;
  final List<ImageModel> images;
  final List<ItemModel> items;

  factory DetailedThingModel.fromJson(Map<String, dynamic> json) {
    return DetailedThingModel(
      id: json['id'] as String,
      name: json['name'] as String,
      spanishName: json['name_es'] as String?,
      hidden: json['hidden'] as bool,
      eyeProtection: json['eyeProtection'] as bool,
      stock: json['stock'] as int,
      available: json['available'] as int,
      categories: (json['categories'] as List).cast<String>(),
      linkedThings: (json['linkedThings'] as List)
          .map((e) => LinkedThing.fromJson(e))
          .toList(),
      images:
          (json['images'] as List).map((e) => ImageModel.fromJson(e)).toList(),
      items: (json['items'] as List).map((e) => ItemModel.fromJson(e)).toList(),
    );
  }

  factory DetailedThingModel.fromQuery(Map<String, dynamic> data) {
    final items = data['items'] as List;
    return DetailedThingModel(
      id: data['id'].toString(),
      name: data['name'] as String,
      spanishName: data['spanish_name'] as String?,
      hidden: data['hidden'] as bool,
      eyeProtection: data['eye_protection'] as bool,
      stock: items.length,
      available: items.length - data['unavailable_items'][0]['count'] as int,
      categories: (data['categories'] as List)
          .map((e) => e['name'].toString())
          .toList(),
      linkedThings: (data['associations'] as List)
          .map((e) => LinkedThing(
                id: e['id'].toString(),
                name: e['things']['name'] as String,
              ))
          .toList(),
      images:
          (data['images'] as List).map((e) => ImageModel.fromQuery(e)).toList(),
      items: items.map((e) => ItemModel.fromQuery(e)).toList(),
    );
  }
}

class LinkedThing {
  const LinkedThing({required this.id, required this.name});

  final String id;
  final String name;

  factory LinkedThing.fromJson(Map<String, dynamic> json) {
    return LinkedThing(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}
