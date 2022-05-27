// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:app_architecture/app_architecture.dart' hide logger;
import 'package:intl/intl.dart';
import 'package:utils/utils.dart';

import '../../app_image/app_provider_image.dart';

// 🌎 Project imports:

/// Display member info.
///
class MemberHeader extends StatefulWidget implements HasMember {
  static const avatarSize = 70.0;
  static const padding = 10.0;
  static const height = 110.0;

  @override
  final Member member;
  final String? localUserId;

  final Color? genderColor;

  final UserInfo? userInfo;

  final void Function()? onChangeHeight;

  const MemberHeader({
    Key? key,
    required this.member,
    this.genderColor,
    this.localUserId,
    this.userInfo,
    this.onChangeHeight,
  }) : super(key: key);

  @override
  _MemberHeaderState createState() => _MemberHeaderState();
}

class _MemberHeaderState extends State<MemberHeader>
    with SingleTickerProviderStateMixin {
  late ValueNotifier<String> phoneNumberNotifier;

  final dateFormat = DateFormat('MM/dd/yyyy');

  Member get member => widget.member;

  UserInfo? get userInfo => widget.userInfo;

  double animatedHeight = 0.0;

  @override
  void initState() {
    super.initState();
    phoneNumberNotifier = ValueNotifier('');
    () async {
      final phoneNumber = await formatPhoneNumber(member.telecomPhone!);
      if (phoneNumber != null) {
        phoneNumberNotifier.value = phoneNumber.replaceFirst('+1-', '');
      }
    }();
  }

  @override
  void dispose() {
    phoneNumberNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final imageBorderRadius = BorderRadius.circular(2);

    final birthdate = DateTime.parse(member.birthdate ?? '');

    final noAvatarName =
        '${member.nameGiven.firstOrNull ?? ''}${(member.nameMiddle ?? '').firstOrNull ?? ''}${member.nameFamily.firstOrNull ?? ''}';

    final image = AppImage(
      width: MemberHeader.avatarSize,
      height: MemberHeader.avatarSize,
      resource: 'user',
      resourceId: userInfo?.id,
      id: widget.userInfo?.pictureId,
      noImageName: noAvatarName,
      imageType: ImageType.RectangleAvatar,
      genderColor: ColorUtils.getColorFromGender(member.gender?.firstLetter),
    );

    const sizedBox10 = SizedBox(height: 5);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(MemberHeader.padding)
              .copyWith(top: 5, bottom: 5),
          height: MemberHeader.height,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black12,
            //     blurRadius: 8,
            //     offset: Offset(0, 8),
            //     spreadRadius: 2,
            //   ),
            // ],
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: imageBorderRadius,
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: imageBorderRadius,
                  child: image,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.fullName,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    sizedBox10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              member.hicn?.replaceRange(
                                      0, member.hicn!.length - 3, '********') ??
                                  '-',
                              style: const TextStyle(
                                fontFamily: 'RobotoMono',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.1,
                              ),
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(width: 10),
                            Text.rich(
                              TextSpan(
                                text: member.gender?.firstLetter ?? 'N/A',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: getColorFromGender(
                                      member.gender?.firstLetter),
                                ),
                                children: [
                                  TextSpan(
                                    text: '  ' +
                                        (birthdate == null
                                            ? 'N/A'
                                            : '(${dateFormat.format(birthdate)})'),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    sizedBox10,
                    Text(
                      itemAddress(member),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    sizedBox10,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ValueListenableBuilder<String>(
                          valueListenable: phoneNumberNotifier,
                          builder: (_, value, __) => Text(
                            member.telecomPhone == null ? '—' : value,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        const Text(
                          ',',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Text(
                            member.telecomEmail ?? '—',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String itemAddress(Member? item) {
    final address = ([
      item?.addressLine1,
      item?.addressState,
      item?.addressPostal,
    ].where(notNullAndNotEmpty).join(', '));
    final trimmed = address.trim();
    return trimmed.isEmpty ? '—' : trimmed;
  }

  Color getColorFromGender(String? gender) {
    if (gender == null) {
      return Colors.redAccent;
    }
    switch (gender) {
      case 'M':
        return const Color(0xff9bd7ff);
      case 'F':
        return const Color(0xfff581ff);
      case 'O':
        return const Color(0xffffAA44);
      case 'U':
        return Colors.white54;
    }
    return Colors.redAccent;
  }
}
