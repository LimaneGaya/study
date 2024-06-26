class FoodCategory {
  String name;
  int numberOfRestaurants;
  String imageUrl;

  FoodCategory(
    this.name,
    this.numberOfRestaurants,
    this.imageUrl,
  );
}

List<FoodCategory> categories = [
  FoodCategory('Dessert', 16, 'assets/categories/dessert.webp'),
  FoodCategory('Vegetarian', 20, 'assets/categories/vegetarian.webp'),
  FoodCategory('Burger', 21, 'assets/categories/burger.webp'),
  FoodCategory('Asian', 16, 'assets/categories/asian.webp'),
  FoodCategory('Italian', 18, 'assets/categories/italian.webp'),
  FoodCategory('Mexican', 15, 'assets/categories/mexican.webp'),
  FoodCategory('Seafood', 14, 'assets/categories/seafood.webp'),
  FoodCategory('Pizza', 19, 'assets/categories/pizza.webp'),
  FoodCategory('Sushi', 15, 'assets/categories/sushi.webp'),
  FoodCategory('Coffee', 22, 'assets/categories/coffee.webp'),
  FoodCategory('Fast Food', 23, 'assets/categories/fast_food.webp'),
  FoodCategory('Salad', 18, 'assets/categories/salad.webp'),
];
