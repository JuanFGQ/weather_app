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
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 6.0)
          ]),
      child: ListTile(
          leading: widget.leading,
          title: GestureDetector(
            onTap: widget.goToAction,
            child: Center(
              child: Text(widget.title),
            ),
          ),
          subtitle: widget.subtitle,
          trailing: widget.trailing

          // (!deleteBox!.deleteBox)
          //     ? GestureDetector(
          //         onTap: () {
          //           deleteBox!.deleteBox = true;
          //         },
          //         child: FadeIn(
          //           delay: const Duration(milliseconds: 100),
          //           child: const FaIcon(
          //             FontAwesomeIcons.trashCan,
          //             size: 20,
          //           ),
          //         ))
          //     : DeleteTrashCanWidgetDrawer(
          //         ontTapCheck: widget.ontTapCheck,
          //         ontTapX: widget.ontTapX,
          //       )
          ),
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
