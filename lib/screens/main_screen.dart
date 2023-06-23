import 'package:flutter/material.dart';
import 'package:flutter_assignment/screens/add_card_screen.dart';
import 'package:flutter_assignment/screens/home_screen.dart';
import 'package:flutter_assignment/screens/news_screen.dart';
import 'package:flutter_assignment/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainScreen> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selected,
        children: const[
          HomeScreen(),
          AddCard(),
          News(),
          Profile()
        ],
      ),
      bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          child: Container(
            decoration: BoxDecoration(color: Colors.indigo.shade50),
            height: kBottomNavigationBarHeight + 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: getNavigationItems(context),
            ),
          )),
    );
  }

  List<Widget> getNavigationItems(BuildContext context) {
    List<String> items = ['Home', 'Card', 'News', 'Profile'];
    List<IconData> itemIcons = [
      Icons.home,
      Icons.add_card,
      Icons.feed,
      Icons.person
    ];
    return List.generate(
      items.length,
      (index) => InkWell(
        onTap: () {
          selected = index;
          setState(() {});
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              itemIcons[index],
              color: selected == index ? Colors.indigo : Colors.black,
            ),
            const SizedBox(height: 4),
            Text(
              items[index],
              style: TextStyle(
                color: selected == index ? Colors.indigo : Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
