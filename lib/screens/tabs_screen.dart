import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';
import '../providers/favorites_provider.dart';
import '../providers/filters_provider.dart';
import '../providers/nav_bar_provider.dart';
import '../widgets/main_drawer.dart';
import '../screens/categories_screen.dart';
import '../screens/filters_screen.dart';
import '../screens/meals_screen.dart';

class TabsScreen extends ConsumerWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Meal> availableMeals = ref.watch(filteredMealsProvider);
    final int selectedPageIndex = ref.watch(navBarProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Pick Your Categories';
    if (selectedPageIndex == 1) {
      final List<Meal> favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        centerTitle: true,
      ),
      body: activePage,
      drawer: MainDrawer(onSelectScreen: (String identifier) {
        Navigator.of(context).pop();
        if (identifier == 'filters') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const FiltersScreen(),
            ),
          );
        }
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPageIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedFontSize: 15,
        unselectedFontSize: 10,
        onTap: ref.read(navBarProvider.notifier).selectPage,
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
