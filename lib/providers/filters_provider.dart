import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'meals_provider.dart';
import '../models/meal.dart';

enum Filter {
  glutenfree,
  lactosefree,
  vegan,
  vegetarian,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenfree: false,
          Filter.lactosefree: false,
          Filter.vegan: false,
          Filter.vegetarian: false,
        });

  void setFilters(Map<Filter, bool> choosenFilters) {
    state = choosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider(
  (ref) {
    final List<Meal> meals = ref.watch(mealsProvider);
    final Map<Filter, bool> activeFilters = ref.watch(filtersProvider);

    return meals.where(
      (meal) {
        if (activeFilters[Filter.glutenfree]! && !meal.isGlutenFree) {
          return false;
        }
        if (activeFilters[Filter.lactosefree]! && !meal.isLactoseFree) {
          return false;
        }
        if (activeFilters[Filter.vegan]! && !meal.isVegan) {
          return false;
        }
        if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
          return false;
        }
        return true;
      },
    ).toList();
  },
);
