import 'package:flutter/material.dart';

import '../model/pack_element.dart';

class CategoriesView extends StatelessWidget {
  final List<PackElementCategory> categories;
  final Function(PackElementCategory type)? onCategorySelected;
  final PackElementCategory? selected;

  const CategoriesView({
    required this.categories,
    Key? key,
    this.onCategorySelected,
    this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const Center(
        child: SizedBox(
          width: 500,
          child: Center(
            child: Text('No elements'),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final e = categories[index];
        return _CategoryItemView(
          title: e.asString(),
          icon: e.asIcon(),
          onTap: () => onCategorySelected?.call(e),
          selected: e == selected,
        );
      },
    );
  }
}

class _CategoryItemView extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;
  final String title;
  final bool selected;

  const _CategoryItemView({
    required this.title,
    required this.icon,
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondary;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      onTap: onTap,
      selected: selected,
    );
  }
}
