// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import 'delete_trashcan_widget.dart';

// class SavedCard extends StatefulWidget {
//   final void Function()? goToAction;
//   final Widget? leading;
//   final String title;
//   final String subTitle;

//   const SavedCard(
//       {super.key,
//       this.goToAction,
//       this.leading,
//       required this.title,
//       required this.subTitle});

//   @override
//   State<SavedCard> createState() =>
//       _SavedCardState(goToAction, leading, title, subTitle);
// }

// class _SavedCardState extends State<SavedCard> {
//   final void Function()? goToAction;
//   final Widget? leading;
//   final String title;
//   final String subTitle;

//   _SavedCardState(this.goToAction, this.leading, this.title, this.subTitle);

//   bool deleteNews = false;


//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(6),
//       decoration: BoxDecoration(
//           shape: BoxShape.rectangle,
//           borderRadius: BorderRadius.circular(10),
//           color: Colors.white,
//           boxShadow: const [
//             BoxShadow(
//                 color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 6.0)
//           ]),
//       child: ListTile(
//           leading: leading,
//           title: GestureDetector(
//             onTap: goToAction,
//             child: Center(
//               child: Text(title),
//             ),
//           ),
//           subtitle: Center(child: Text(subTitle)),
//           trailing: (!deleteNews)
//               ? GestureDetector(
//                   onTap: () {
//                     deleteNews = true;
//                     setState(() {});
//                   },
//                   child: FadeIn(
//                     delay: const Duration(milliseconds: 100),
//                     child: const FaIcon(
//                       FontAwesomeIcons.trashCan,
//                       size: 20,
//                     ), 
//                   ))
//               : DeleteTrashCanWidgetDrawer(
//                   ontTapCheck: () {
//                     citiesListProvider!
//                         .deleteSavedCitiesById(widget.selectedDelete!);
//                     citiesListProvider!.loadSavedCities();
//                     deleteNews = false;
//                     setState(() {});
//                   },
//                   ontTapX: () {
//                     deleteNews = false;
//                     setState(() {});
//                   },
//                 )),
//     );
//   }
// }
