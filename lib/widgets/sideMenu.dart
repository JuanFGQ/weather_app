import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SideMenu extends StatelessWidget {
  final TextEditingController? textController;

  const SideMenu({super.key, this.textController});

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
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                // onChanged: searchCity,
                controller: textController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Find a place',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black))),
              ),
            ),
            SizedBox(
              width: size.width * 0.7,
              height: size.height * 0.55,
              child: ListView.builder(
                  itemCount: 0, itemBuilder: (_, int index) => _CityItem()),
            ),
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

  void searchCity(String placeName) {
    // final mapBoxService = MapBoxService();
    // mapBoxService.getFeatures(placeName);
    // print(mapBoxService);
  }
}

class _CityItem extends StatelessWidget {
  const _CityItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: CircleAvatar(
        child: FaIcon(FontAwesomeIcons.mountainCity),
      ),
      title: Text('city specified'),
    );
  }
}
