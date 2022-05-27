// 📦 Package imports:
import 'package:app_architecture/app_architecture.dart' hide logger;
import 'package:utils/utils.dart';

// 🌎 Project imports:

class GetUserInfoSuccess extends BaseState {
  final UserInfo userInfo;

  GetUserInfoSuccess({
    required this.userInfo,
  });

  @override
  List<Object?> get props => [userInfo];
}

class GetUserInfoError extends BaseState {}
