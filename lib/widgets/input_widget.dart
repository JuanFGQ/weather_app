import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController textController;
  final void Function(String)? onsubmitted;
  final void Function(String)? onchanged;
  final void Function()? onpressIOS;
  final void Function()? onpressANDROID;
  final bool autoFocus;
  final Widget? widget;

  final Color? colors;

  const InputWidget(
      {Key? key,
      required this.textController,
      this.onsubmitted,
      this.onchanged,
      this.onpressIOS,
      this.onpressANDROID,
      required this.autoFocus,
      this.colors,
      this.widget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        // color: Colors.white,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black,
                  spreadRadius: -5,
                  blurRadius: 5,
                  offset: Offset(5, 5))
            ]),
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                autofocus: autoFocus,
                controller: textController,
                onSubmitted: onsubmitted,
                onChanged: onchanged,
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: Platform.isIOS
                    ? CupertinoButton(
                        child: const Text('comment'), onPressed: onpressIOS)
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: IconTheme(
                          data: const IconThemeData(color: Colors.blue),
                          child: IconButton(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              icon: const Icon(Icons.send),
                              onPressed: onpressANDROID),
                        ),
                      ))
          ],
        ),
      ),
    );
  }
}
