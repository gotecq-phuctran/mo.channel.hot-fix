// 📦 Package imports:
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:meta/meta.dart';
import 'package:core/core.dart';

@module
@sealed
class WidgetsModule extends BaseModule {
  static final shared = WidgetsModule._();

  WidgetsModule._();

  Func1<String, Uri>? _buildImageUrl;

  @initModule
  void init({
    required Func1<String, Uri> buildImageUrl,
  }) {
    _buildImageUrl = buildImageUrl;
    maskAsInit();
  }

  @internal
  Uri buildImageUrl(String unencodedPath) {
    checkInit();
    return _buildImageUrl!(unencodedPath);
  }
}
