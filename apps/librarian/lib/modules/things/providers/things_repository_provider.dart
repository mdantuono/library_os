import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:librarian_app/modules/things/data/inventory_repository.dart';
import 'package:librarian_app/api/models/thing_model.dart';

final thingsRepositoryProvider =
    NotifierProvider<InventoryRepository, Future<List<ThingModel>>>(
        InventoryRepository.new);
