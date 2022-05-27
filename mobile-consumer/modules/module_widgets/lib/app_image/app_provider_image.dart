// 🎯 Dart imports:
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:app_architecture/app_architecture.dart' hide logger;
import 'package:provider/provider.dart';
import 'package:quiver/collection.dart';
import 'package:tuple/tuple.dart';

import '../module/module.dart';

mixin ImageUrlMixin {
  final _cachedUrls =
      LruMap<Tuple3<String, String?, String>, String>(maximumSize: 1024);

  String? getFileUrl({
    required String resource,
    required String? resourceId,
    required String? id,
  }) {
    if (id == null) {
      return null;
    }
    return _cachedUrls.putIfAbsent(
      Tuple3(resource, resourceId, id),
      () => WidgetsModule.shared
          .buildImageUrl('/file/$resource/$resourceId/$id')
          .toString(),
    );
  }

  String? getImageByToken({
    required String? pictureRealm,
    required String? token,
  }) {
    if (token == null) {
      return null;
    }
    return WidgetsModule.shared
        .buildImageUrl('/blob/$pictureRealm/$token')
        .toString();
  }
}

class ItemImage extends StatelessWidget with ImageUrlMixin {
  /// Require the images to have this width.
  final double width;

  /// require the images to have this height.
  final double height;

  final String? pictureRealm;

  final String? token;

  final BoxFit boxFit;

  /// Size of [CircularProgressIndicator]
  final double size;

  /// Widget displayed when [id] is null.
  /// If `null`, display a [Container] with gray background.
  final Widget? noImage;

  ItemImage({
    Key? key,
    required this.pictureRealm,
    required this.token,
    required this.width,
    required this.height,
    this.noImage,
    this.size = 16,
    this.boxFit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final url = getImageByToken(pictureRealm: pictureRealm, token: token);

    if (url == null) {
      return noImage ??
          Container(
            width: width,
            height: height,
            color: const Color(0xffE1E1E3),
          );
    }

    final sessionId = Provider.of<AuthRepository>(context)
        .user$
        .value
        ?.fold(() => null, (v) => v.sessionId);

    // final themeData = Theme.of(context);

    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: url,
      fit: boxFit,
      httpHeaders: {
        'Cookie': 'session=$sessionId',
      },
      placeholder: (_, __) => Center(
        child: SizedBox(
          width: size,
          height: size,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),
      errorWidget: (_, __, ___) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Icon(
                Icons.image,
                size: size,
              ),
            ),
            const SizedBox(height: 4),
            // Text(
            //   'Error',
            //   style: themeData.textTheme.subtitle2!.copyWith(fontSize: 11),
            //   textAlign: TextAlign.center,
            // ),
          ],
        );
      },
    );
  }
}

enum ImageType {
  CircleAvatar,
  RectangleAvatar,
}

/// Image widget to show NetworkImage with caching functionality.
class AppImage extends StatelessWidget with ImageUrlMixin {
  final double width;

  final double height;

  final String resource;

  final String? resourceId;

  final String? id;

  final BoxFit boxFit;

  final double size;

  final ImageType imageType;

  final String noImageName;

  final Color genderColor;

  final bool isHasNoImage;

  final TextStyle? nameStyle;

  AppImage({
    Key? key,
    required this.width,
    required this.height,
    required this.resource,
    required this.resourceId,
    required this.id,
    this.isHasNoImage = true,
    this.size = 16,
    this.boxFit = BoxFit.cover,
    this.imageType = ImageType.CircleAvatar,
    this.noImageName = '',
    this.genderColor = Colors.redAccent,
    this.nameStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final url = getFileUrl(
      resource: resource,
      resourceId: resourceId,
      id: id,
    );

    if (url == null || resourceId == null) {
      return isHasNoImage ? noImage() : const SizedBox.shrink();
    }

    final sessionId = Provider.of<AuthRepository>(context)
        .user$
        .value
        ?.fold(() => null, (v) => v.sessionId);

    // final themeData = Theme.of(context);

    return ShapeImage(
      imageType: imageType,
      child: CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: url,
        fit: boxFit,
        httpHeaders: {
          'Cookie': 'session=$sessionId',
        },
        placeholder: (_, __) => Center(
          child: SizedBox(
            width: size,
            height: size,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        ),
        errorWidget: (_, __, ___) {
          return Center(
            child: Icon(
              Icons.image,
              size: size + 5,
              color: Theme.of(context).primaryColorLight,
            ),
          );
        },
      ),
    );
  }

  Widget loadingImage() {
    return ShapeImage(
      imageType: imageType,
      child: Container(
        width: width,
        height: height,
        color: const Color(0xffE1E1E3),
        child: Center(
          child: Icon(Icons.image),
        ),
      ),
    );
  }

  Widget noImage() {
    return ShapeImage(
      imageType: imageType,
      child: noImageName == ''
          ? loadingImage()
          : Container(
              width: width,
              height: height,
              color: const Color(0xffE1E1E3),
              child: Center(
                child: Text(
                  noImageName,
                  style: nameStyle ??
                      TextStyle(
                        color: genderColor,
                      ),
                ),
              ),
            ),
    );
  }
}

class ShapeImage extends StatelessWidget {
  final ImageType imageType;
  final Widget child;

  const ShapeImage({
    Key? key,
    required this.imageType,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageType == ImageType.CircleAvatar) {
      return ClipOval(
        child: child,
      );
    } else if (imageType == ImageType.RectangleAvatar) {
      return child;
    }
    return const SizedBox.shrink();
  }
}
