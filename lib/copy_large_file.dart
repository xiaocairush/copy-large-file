
import 'dart:async';

import 'package:flutter/services.dart';

class CopyLargeFile {
  static const MethodChannel _channel =
      const MethodChannel('com.guoka/copy_large_file');

  final String fileName;

  CopyLargeFile(this.fileName);

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<String> get copyLargeFile async {
    final String fullPathName = await _channel.invokeMethod('copyLargeFile',<String, dynamic> {
      'fileName': this.fileName,
    });
    return fullPathName;
  }

}
