import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class ReusableFunctions {
  static String formatTotalTime(String totalTime) {
    int timeInMinutes = int.parse(totalTime);
    if (timeInMinutes >= 100) {
      int hours = timeInMinutes ~/ 60;
      int minutes = timeInMinutes % 60;
      return '${hours}h ${minutes}m';
    } else {
      return '${timeInMinutes} Min';
    }
  }
}

Future pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No image selected');
}
