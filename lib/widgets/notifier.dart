import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

ValueNotifier<bool> editSave = ValueNotifier<bool>(false);
ValueNotifier<String> taskText=ValueNotifier<String>('');
ValueNotifier<int> editIndex=ValueNotifier<int>(0);
ValueNotifier<String> status=ValueNotifier<String>('');