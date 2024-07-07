import 'package:flutter/material.dart';
import '../models/restaurant.dart';

class RestaurantLandscapeCard extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantLandscapeCard({super.key, required this.restaurant});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Image.asset(
              restaurant.imageUrl, 
              fit: BoxFit.cover,
              width: double.infinity,
              cacheHeight: 400,
              cacheWidth: 400,
            ),
          ),
          SizedBox(
            height: 70,
            child: ListTile(
              title: Text(restaurant.name, style: textTheme.titleSmall),
              subtitle: Text(
                restaurant.attributes,
                maxLines: 1,
                style: textTheme.bodySmall,
              ),
              onTap: () => print('Tap on ${restaurant.name}'),
            ),
          ),
        ],
      ),
    );
  }
}
