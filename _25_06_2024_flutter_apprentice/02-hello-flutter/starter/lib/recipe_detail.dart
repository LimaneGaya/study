import 'package:flutter/material.dart';
import 'recipe.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetail({super.key, required this.recipe});
  @override
  State<RecipeDetail> createState() {
    return _RecipeDetailState();
  }
}

class _RecipeDetailState extends State<RecipeDetail> {
  int _sliderVal = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.label),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              clipBehavior: Clip.antiAlias,
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Image(
                image: AssetImage(widget.recipe.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.recipe.label,
              style: const TextStyle(fontSize: 18),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(7.0),
                itemCount: widget.recipe.ingredients.length,
                itemBuilder: (BuildContext context, int index) {
                  final ingredient = widget.recipe.ingredients[index];
                  return Text(
                    '${ingredient.quantity * _sliderVal} '
                    '${ingredient.measure} '
                    '${ingredient.name}',
                  );
                },
              ),
            ),
            Slider(
              min: 1,
              max: 10,
              divisions: 9,
              label: '${_sliderVal * widget.recipe.servings} servings',
              value: _sliderVal.toDouble(),
              onChanged: (newValue) {
                setState(() => _sliderVal = newValue.round());
              },
              activeColor: Colors.green,
              inactiveColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
