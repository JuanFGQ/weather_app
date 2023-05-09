import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/mapBox_response.dart';
import 'package:weather/services/mapBox_Info_service.dart';
import 'package:weather/widgets/input_widget.dart';

import '../models/mapbox/Feature.dart';

class SideMenu extends StatefulWidget {
  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  bool _thereCity = false;

  MapBoxInfoProvider? mapBoxInfo;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Hero(
      tag: Object,
      child: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
                child: Image(image: AssetImage('assets/horus-eye.png'))),
            InputWidget(
              textController: _textController,
              autoFocus: true,
              onsubmitted: _searchCity,
              onchanged: (search) {
                setState(() {
                  if (search.isNotEmpty) {
                    _thereCity = true;
                  } else {
                    _thereCity = false;
                  }
                });
              },
              onpressANDROID: _thereCity
                  ? () => _searchCity(_textController.text.trim())
                  : null,
            ),
            // SizedBox(
            //   width: size.width * 0.7,
            //   height: size.height * 0.55,
            //   child: ListView.builder(
            //       itemCount: 0, itemBuilder: (_, int index) => _CityItem()),
            // ),
            const Spacer(),
            const ListTile(
                title: Text('Settings'),
                leading: FaIcon(FontAwesomeIcons.gear)),
            const ListTile(
                title: Text('Theme'), leading: FaIcon(FontAwesomeIcons.brush)),
          ],
        ),
      ),
    );
  }

  _searchCity(String placeName) async {
    if (placeName.isEmpty) {
      return _emptyContainer();
    }

    _textController.clear();

    // final mapBoxSearch =
    //     Provider.of<MapBoxInfoProvider>(context, listen: false);

    await mapBoxInfo!.getPlaces(placeName);

    return StreamBuilder(
      stream: mapBoxInfo!.suggestedCity,
      builder: (_, AsyncSnapshot<List<Feature>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final featureMethod = snapshot.data!;

        return ListView.builder(
          itemBuilder: (_, int index) => _CityItem(featureMethod[index]),
          itemCount: featureMethod.length,
        );
      },
    );
  }
}

class _CityItem extends StatelessWidget {
  final Feature city;

  const _CityItem(this.city);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: FaIcon(FontAwesomeIcons.mountainCity),
      ),
      title: Text(city.placeName),
      onTap: () {},
    );
  }
}

Widget _emptyContainer() {
  return const Center(
      child: FaIcon(
    FontAwesomeIcons.locationDot,
    color: Colors.blue,
    size: 50,
  ));
}
