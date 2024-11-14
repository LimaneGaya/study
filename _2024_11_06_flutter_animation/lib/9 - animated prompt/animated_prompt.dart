import 'package:flutter/material.dart';

class AnimatedPrompt extends StatefulWidget {
  const AnimatedPrompt({super.key});
  @override
  State<AnimatedPrompt> createState() => _AnimatedPromptState();
}

const h = 250.0;
const w = 350.0;
typedef STPSM = SingleTickerProviderStateMixin<AnimatedPrompt>;

class _AnimatedPromptState extends State<AnimatedPrompt> with STPSM {
  late final _cont = AnimationController(
    vsync: this,
    duration: Duration(seconds: 1),
    animationBehavior: AnimationBehavior.preserve,
  );

  late final Animation<double> _icoScale = Tween(
    begin: 5.0,
    end: 1.0,
  ).animate(CurvedAnimation(parent: _cont, curve: Curves.bounceOut));

  late final Animation<double> _conScale = Tween(
    begin: 5.0,
    end: 2.0,
  ).animate(CurvedAnimation(parent: _cont, curve: Curves.bounceOut));

  late final Animation<double> _yDisplac = Tween(
    begin: 60.0,
    end: 0.0,
  ).animate(CurvedAnimation(parent: _cont, curve: Curves.easeInOut));

  @override
  void dispose() {
    _cont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _cont
      ..reset()
      ..forward();
    return Scaffold(
      body: Center(
        child: Container(
          width: w,
          height: h,
          padding: EdgeInsets.all(10),
          clipBehavior: Clip.antiAlias,

          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(25),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.up,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "This means you found this interesting enough to check it, which makes me happy.",
                textAlign: TextAlign.center,
              ),
              Text(
                "Thank you for checking this out!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),

              AnimatedBuilder(
                animation: _cont,
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform:
                        Matrix4.identity()
                          ..scale(_icoScale.value, _icoScale.value, 1)
                          ..setTranslationRaw(0, _yDisplac.value, 0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ScaleTransition(
                          scale: _conScale,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  Theme.of(context).colorScheme.onPrimaryFixed,
                            ),
                          ),
                        ),
                        Icon(Icons.check, size: 80),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: BackButton(),
    );
  }
}
