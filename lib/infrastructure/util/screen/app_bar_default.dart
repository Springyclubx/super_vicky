import 'package:flutter/material.dart';

/// Method for default app bar
PreferredSizeWidget appBarDefault({
  required BuildContext context,
  required String title,
}) {
  return AppBar(
    title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
    centerTitle: true,
  );
}
