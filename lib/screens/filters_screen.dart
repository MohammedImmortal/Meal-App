import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<Filter, bool> activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          customSwitch(
            context,
            'Gluten-Free',
            'only include gluten-free meals',
            activeFilters[Filter.glutenfree]!,
            (bool value) => ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.glutenfree, value),
          ),
          const SizedBox(height: 15),
          customSwitch(
            context,
            'Lactose-Free',
            'only include lactose-free meals',
            activeFilters[Filter.lactosefree]!,
            (bool value) => ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.lactosefree, value),
          ),
          const SizedBox(height: 15),
          customSwitch(
            context,
            'Vegan',
            'only include vegan meals',
            activeFilters[Filter.vegan]!,
            (bool value) => ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.vegan, value),
          ),
          const SizedBox(height: 15),
          customSwitch(
            context,
            'Vegetarian',
            'only include vegetarian meals',
            activeFilters[Filter.vegetarian]!,
            (bool value) => ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.vegetarian, value),
          ),
        ],
      ),
    );
  }

  SwitchListTile customSwitch(
    BuildContext context,
    String title,
    String subtitle,
    bool filter,
    Function(bool newValue) onChanged,
  ) {
    return SwitchListTile(
      activeColor: Theme.of(context).colorScheme.primary,
      contentPadding: const EdgeInsets.only(left: 20, right: 20),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      value: filter,
      onChanged: onChanged,
    );
  }
}
