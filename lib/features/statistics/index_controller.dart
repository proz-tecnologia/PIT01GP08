import 'package:flutter/foundation.dart';

class IndexController extends ValueNotifier<int> {
  static final _instance = IndexController._(-1);

  IndexController._(super.value);

  factory IndexController() => _instance;
}
