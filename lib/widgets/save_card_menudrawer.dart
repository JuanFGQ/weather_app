import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'delete_trashcan_widget.dart';

class SavedCardMenuDrawer extends StatefulWidget {
  final void Function()? goToAction;
  final Widget? leading;
  final String title;
  final String? subTitle;
  final VoidCallback? ontTapCheck;
  final VoidCallback? ontTapX;
  final VoidCallback? ontTapTitle;

  const SavedCardMenuDrawer(
      {super.key,
      this.goToAction,
      this.leading,
      required this.title,
      this.subTitle,
      this.ontTapCheck,
      this.ontTapX,
      this.ontTapTitle});

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
          subtitle: Center(child: Text(widget.subTitle!)),
          trailing: (!deleteNews)
              ? GestureDetector(
                  onTap: () {
                    deleteNews = true;
                    // setState(() {});
                  },
                  child: FadeIn(
                    delay: const Duration(milliseconds: 100),
                    child: const FaIcon(
                      FontAwesomeIcons.trashCan,
                      size: 20,
                    ),
                  ))
              : DeleteTrashCanWidgetDrawer(
                  ontTapCheck: widget.ontTapCheck,
                  ontTapX: widget.ontTapX,
                )),
    );
  }
}
