import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:epandu/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../utils/constants.dart';

@RoutePage()
class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final localStorage = LocalStorage();

  String? name = '';
  final _constItem = [
    {
      'count': 0,
      'title': 'eDriving',
      'icon': 'eDriving-icon.png',
      'path': 'EpanduCategory'
    },
    {
      'count': 0,
      'title': 'Check Expenses',
      'icon': 'Espenses-icon.png',
      'path': 'CreateFuelRoute'
    },
    {
      'count': 0,
      'title': 'Check Driving Routes',
      'icon': 'Driving-routes-icon.png',
      'path': ''
    },
    {
      'count': 0,
      'title': 'eLearning',
      'icon': 'eLearning-icon.png',
      'path': 'KppCategory'
    },
    {
      'count': 0,
      'title': 'Direcotry & Rating',
      'icon': 'Directory-and-rating-icon.png',
      'path': ''
    },
    {
      'count': 0,
      'title': 'Favourites',
      'icon': 'Fovourite-icon.png',
      'path': 'EmergencyDirectory'
    },
    {
      'count': 0,
      'title': 'Find Jobs',
      'icon': 'Jobs-icon.png',
      'path': '',
    },
  ];

  List<dynamic> items = [];

  void startInit() async {
    var box = Hive.box('menu');

    var itemHive = box.get('menu_item_1');
    if (itemHive == null) {
      items = _constItem;
      box.put('menu_item', jsonEncode(items));
    } else {
      items = jsonDecode(itemHive);
      if (items.length != _constItem.length) {
        items = _constItem;
        box.put('menu_item', jsonEncode(items));
      }
    }

    name = await localStorage.getNickName();
    setState(() {
      name = name;
    });
  }

  @override
  void initState() {
    super.initState();
    startInit();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              ColorConstant.primaryColor,
            ],
            stops: [0.45, 0.65],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: SizedBox(
            width: 75,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  ImagesConstant().sos,
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            color: Colors.white,
            child: IconTheme(
              data:
                  IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () {
                        context.router.replaceAll([const Home()]);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              color: Colors.grey,
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.menu,
                              color: Colors.grey,
                            ),
                            Text(
                              'Menu',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello $name',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.merge(
                                      const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                              ),
                              Text(
                                'How may i help you today?',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.merge(
                                      const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {},
                          child: Image.asset(
                            ImagesConstant().profileRed,
                            // width: 150.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: items.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 16.0,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return MenuButton(
                        leftPadding: index % 2 != 0,
                        title: items[index]['title'],
                        icon: items[index]['icon'],
                        path: items[index]['path'],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const MenuButton(
                  leftPadding: true,
                  title: 'More',
                  icon: 'More-icon.png',
                  path: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final bool leftPadding;
  final String title;
  final String icon;
  final path;
  const MenuButton({
    Key? key,
    required this.leftPadding,
    required this.title,
    required this.icon,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (title != 'More') {
          var box = Hive.box('menu');
          List<dynamic> items = [];
          var itemHive = box.get('menu_item');
          items = jsonDecode(itemHive);
          items[items.indexWhere((element) => element['title'] == title)]
              ['count']++;
          items.sort((a, b) => b['count'].compareTo(a['count']));
          await box.put('menu_item', jsonEncode(items));
        }
        PageRouteInfo? route;
        switch (path) {
          case 'EpanduCategory':
            route = EpanduCategory();
            break;
          case 'CreateFuelRoute':
            route = CreateFuelRoute();
            break;
          case 'KppCategory':
            route = const KppCategory();
            break;
          case 'EmergencyDirectory':
            route = const EmergencyDirectory();
            break;
          default:
            route = null;
        }
        if (!context.mounted) return;
        if (route == null) {
          await context.router.replaceAll([const Home()]);
        } else {
          await context.router.replaceAll([const Home(), route]);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: leftPadding ? 64.0 : 0,
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  right: 32.0,
                  bottom: 8.0,
                  left: 64,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                top: -8,
                left: -12,
                child: Container(
                  child: Image.asset(
                    'assets/menu/$icon',
                    width: 50,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
