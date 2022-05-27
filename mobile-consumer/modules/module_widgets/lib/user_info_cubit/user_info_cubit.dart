// 📦 Package imports:
import 'package:app_architecture/app_architecture.dart' hide logger;
import 'package:utils/utils.dart';

// 🌎 Project imports:
import 'user_info_state.dart';

class UserInfoCubit extends BaseCubit with SingleCubitMixin {
  final UserRepository repository;

  UserInfoCubit(this.repository);

  void getCurrentUserInfo(String? id) {
    single<UserInfo>(
      () => repository.getUserInfoById(id),
      onSuccess: (data) => GetUserInfoSuccess(userInfo: data),
    );
  }
}
