import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:librarian_app/api/models/thing_model.dart';

final selectedThingProvider = StateProvider<ThingModel?>((ref) => null);
