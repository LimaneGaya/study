import 'package:flutter/material.dart';
import 'package:_21_05_2024_rich_scrolling_experiences/weather_data.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sliver Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.teal,
              pinned: true,
              floating: true,
              snap: true,
              stretch: true,
              //Function to call when strech stretchTriggerOffset is reached
              onStretchTrigger: () async => print('hello'),
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                //The behavior the FlexibleSpaceBar takes when it's stretched
                stretchModes: const [
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle,
                  StretchMode.blurBackground,
                ],
                //The behavious the FlexibleSpaceBar takes when it's collapsed
                //collapseMode: CollapseMode.parallax,
                title: const Text('Flexible Space Bar'),
                background: DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.teal,
                        ]),
                  ),
                  child: Image.network(
                    'https://picsum.photos/250?image=9',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  WeatherData data = WeatherData.getData(index);
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Row(
                      children: [
                        SizedBox(
                            width: 200,
                            height: 200,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                DecoratedBox(
                                    position: DecorationPosition.foreground,
                                    decoration: const BoxDecoration(
                                      gradient: RadialGradient(
                                        colors: [
                                          Colors.black87,
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                    child: Image.network(
                                      'https://picsum.photos/250?image=9',
                                      fit: BoxFit.cover,
                                    )),
                                Center(
                                  child: Text(
                                    data.date,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                ),
                              ],
                            )),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.temperature,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(data.weather),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data.highTemps,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
