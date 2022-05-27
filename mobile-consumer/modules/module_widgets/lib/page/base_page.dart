import '../../common_widgets.dart';
import 'header/provider_header.dart';
import 'package:flutter/material.dart';
import 'package:app_architecture/app_architecture.dart';

class BasePage extends StatefulWidget {
  final Widget child;
  final String title;
  final Member member;
  final AppName appName;
  final void Function(BuildContext) onTapBackIcon;

  BasePage({
    Key? key,
    required this.title,
    required this.member,
    required this.child,
    required this.appName,
    required this.onTapBackIcon,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeaderMember(
        title: widget.title,
        elevation: 0.0,
        onTapBackIcon: (context) => widget.onTapBackIcon.call(context),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 0,
            child: widget.appName == AppName.MEMBER
                ? MemberHeader(member: widget.member)
                : ProviderHeader(member: widget.member),
          ),
          Expanded(
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
