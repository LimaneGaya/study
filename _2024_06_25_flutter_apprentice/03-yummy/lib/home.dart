import 'package:flutter/material.dart';
import 'components/category_card.dart';
import 'components/post_card.dart';
import 'components/restaurant_landscape_card.dart';
import 'models/food_category.dart';
import 'models/post.dart';
import 'models/restaurant.dart';
import 'components/theme_button.dart';
import 'components/color_button.dart';
import 'constants.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.changeTheme,
    required this.changeColor,
    required this.colorSelected,
  });
  final void Function(bool useLightMode) changeTheme;
  final void Function(int value) changeColor;
  final ColorSelection colorSelected;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int tab = 0;
  List<NavigationDestination> appBarDestinations = const [
    NavigationDestination(
      icon: Icon(Icons.credit_card),
      label: 'Category',
      selectedIcon: Icon(Icons.credit_card),
    ),
    NavigationDestination(
      icon: Icon(Icons.credit_card),
      label: 'Post',
      selectedIcon: Icon(Icons.credit_card),
    ),
    NavigationDestination(
      icon: Icon(Icons.credit_card),
      label: 'Restaurant',
      selectedIcon: Icon(Icons.credit_card),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final pages = [
      GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.80,
          maxCrossAxisExtent: 400,
        ),
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return CategoryCard(category: categories[index]);
        },
      ),
      ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: PostCard(post: posts[index]),
          );
        },
      ),
      GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          childAspectRatio: 1.75,
          maxCrossAxisExtent: 400,
        ),
        itemCount: restaurants.length,
        itemBuilder: (BuildContext context, int index) {
          return RestaurantLandscapeCard(restaurant: restaurants[index]);
        },
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          ThemeButton(changeThemeMode: widget.changeTheme),
          ColorButton(
            changeColor: widget.changeColor,
            colorSelected: widget.colorSelected,
          ),
        ],
      ),
      body: IndexedStack(index: tab, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (index) => setState(() => tab = index),
        destinations: appBarDestinations,
      ),
    );
  }
}
