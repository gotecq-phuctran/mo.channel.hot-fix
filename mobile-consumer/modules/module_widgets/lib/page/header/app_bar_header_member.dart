import 'package:app_architecture/app_architecture.dart' hide logger;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gotecq_widget/toolbar/toolbar.dart';
import 'package:module_widgets/app_image/app_provider_image.dart';
import 'package:module_widgets/user_info_cubit/index.dart';
import 'package:provider/provider.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:utils/utils.dart';

class AppBarHeaderMember extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  final Member? member;
  final bool primary;
  final double? elevation;
  final void Function(BuildContext) onTapBackIcon;

  const AppBarHeaderMember({
    Key? key,
    required this.title,
    this.member,
    this.primary = false,
    this.elevation,
    required this.onTapBackIcon,
  }) : super(key: key);

  @override
  _AppBarHeaderMember createState() => _AppBarHeaderMember();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarHeaderMember extends State<AppBarHeaderMember> {
  late UserInfoCubit bloc;

  double animatedHeight = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = Provider.of<UserInfoCubit>(context);
    final rxSharedPreferences = RxSharedPreferences.getInstance();
    final userLocalSource =
        DataLocalModule.provideUserLocalSource(rxSharedPreferences);
    userLocalSource.userLocal.then((user) => bloc.getCurrentUserInfo(user?.id));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          MyAppBar(
            titleTextStyle: TextStyle(
              fontSize: 20,
              color: widget.primary
                  ? Colors.white
                  : Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            ),
            title: widget.title,
            primary: widget.primary,
            onTapBackIcon: (context) => widget.onTapBackIcon.call(context),
            elevation: widget.elevation,
            trailing: Padding(
              padding: const EdgeInsets.all(13.0),
              child: BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is GetUserInfoSuccess) {
                    final userInfo = state.userInfo;

                    final noAvatarName =
                        '${userInfo.nameGiven?.firstOrNull ?? ''}${(userInfo.nameMiddle ?? '').firstOrNull ?? ''}${userInfo.nameFamily?.firstOrNull ?? ''}';

                    return AppImage(
                      width: 30,
                      height: 30,
                      resource: 'user',
                      imageType: ImageType.CircleAvatar,
                      resourceId: userInfo.id,
                      id: userInfo.pictureId,
                      noImageName: noAvatarName,
                      genderColor: ColorUtils.getColorFromGender(
                          userInfo.gender?.firstLetter),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
