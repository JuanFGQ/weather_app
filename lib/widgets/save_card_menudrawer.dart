import 'package:flutter/material.dart';

class SavedCardMenuDrawer extends StatefulWidget {
  final void Function()? goToAction;
  final Widget? leading;
  final Widget? subtitle;
  final Widget? trailing;

  final String title;
  final void Function()? ontTapCheck;
  final void Function()? ontTapX;

  const SavedCardMenuDrawer({
    super.key,
    this.goToAction,
    this.leading,
    required this.title,
    this.ontTapCheck,
    this.ontTapX,
    this.subtitle,
    this.trailing,
  });

  @override
  State<SavedCardMenuDrawer> createState() => _SavedCardMenuDrawerState();
}

class _SavedCardMenuDrawerState extends State<SavedCardMenuDrawer> {
  bool deleteNews = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: ListTile(
          leading: widget.leading,
          title: GestureDetector(
            onTap: widget.goToAction,
            child: Center(
              child: Text(widget.title),
            ),
          ),
          subtitle: widget.subtitle,
          trailing: widget.trailing),
    );
  }
}

class DeleteBox extends ChangeNotifier {
  bool _deleteBox = false;

  bool get deleteBox => _deleteBox;

  set deleteBox(bool value) {
    _deleteBox = value;
    notifyListeners();
  }
}
