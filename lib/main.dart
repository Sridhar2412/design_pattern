import 'package:design_pattern/abstract%20factory/custom_widget.dart';
import 'package:design_pattern/abstract%20factory/factory_section.dart';
import 'package:design_pattern/adapter/adapter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with SingleTickerProviderStateMixin {
  final List<IWidgetsFactory> widgetsFactoryList = const [
    MaterialWidgetsFactory(),
    CupertinoWidgetsFactory(),
    CustomWidgetsFactory(),
  ];
  var _selectedFactoryIndex = 0;

  late IActivityIndicator _activityIndicator;

  late ISlider _slider;
  var _sliderValue = 50.0;
  String get _sliderValueString => _sliderValue.toStringAsFixed(0);

  @override
  void initState() {
    super.initState();
    _createWidgets();
  }

  void _createWidgets() {
    _activityIndicator =
        widgetsFactoryList[_selectedFactoryIndex].createActivityIndicator();
    _slider = widgetsFactoryList[_selectedFactoryIndex].createSlider();
  }

  void _setSelectedFactoryIndex(int? index) {
    if (index == null) return;

    setState(() {
      _selectedFactoryIndex = index;
      _createWidgets();
    });
  }

  void _setSliderValue(double value) => setState(() => _sliderValue = value);
  late AnimationController animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 5))
        ..repeat(reverse: true);
  late Animation<double> animation =
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);
  late Animation<Offset> animations =
      Tween<Offset>(end: Offset.zero, begin: const Offset(0.0, 2.0))
          .animate(animationController);
  @override
  Widget build(BuildContext context) {
    final PostApi postApi = PostApi();
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FactorySelection(
                widgetsFactoryList: widgetsFactoryList,
                selectedIndex: _selectedFactoryIndex,
                onChanged: _setSelectedFactoryIndex,
              ),
              const SizedBox(height: 20),
              Text(
                'Widgets showcase',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Text(
                'Process indicator',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              _activityIndicator.render(),
              const SizedBox(height: 20),
              Text(
                'Slider ($_sliderValueString%)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              _slider.render(_sliderValue, _setSliderValue),
              const SizedBox(height: 20),
              Text(
                'Adapter',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              ListView.builder(
                  itemCount: postApi.getPosts().length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final Post post = postApi.getPosts()[index];
                    return ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.bio),
                    );
                  }),
              // ElevatedButton(
              //     onPressed: () async => await AndroidDialog().show(context),
              //     child: const Center(
              //       child: Text('Submit'),
              //     ))
              Text(
                'Scale transition',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              ScaleTransition(
                  alignment: Alignment.bottomCenter,
                  scale: animation,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                  )),
              const SizedBox(height: 20),

              Text(
                'Rotation transition',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              RotationTransition(
                  alignment: Alignment.bottomCenter,
                  turns: animation,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blue),
                  )),
              const SizedBox(height: 20),
              Text(
                'Size transition',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              SizeTransition(
                  axis: Axis.horizontal,
                  sizeFactor: animation,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.yellow),
                  )),
              const SizedBox(height: 20),
              Text(
                'Slide transition',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              SlideTransition(
                  position: animations,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.green),
                  )),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
