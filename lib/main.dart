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

class _MainAppState extends State<MainApp> {
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

  @override
  Widget build(BuildContext context) {
    final PostApi postApi = PostApi();
    return MaterialApp(
      home: Scaffold(
        body: Column(
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
                })
            // ElevatedButton(
            //     onPressed: () async => await AndroidDialog().show(context),
            //     child: const Center(
            //       child: Text('Submit'),
            //     ))
          ],
        ),
      ),
    );
  }
}
