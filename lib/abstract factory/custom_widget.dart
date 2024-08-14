import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract interface class IWidgetsFactory {
  String getTitle();
  IActivityIndicator createActivityIndicator();
  ISlider createSlider();
}

class MaterialWidgetsFactory implements IWidgetsFactory {
  const MaterialWidgetsFactory();

  @override
  String getTitle() => 'Android widgets';

  @override
  IActivityIndicator createActivityIndicator() =>
      const AndroidActivityIndicator();

  @override
  ISlider createSlider() => const AndroidSlider();
}

class CupertinoWidgetsFactory implements IWidgetsFactory {
  const CupertinoWidgetsFactory();

  @override
  String getTitle() => 'iOS widgets';

  @override
  IActivityIndicator createActivityIndicator() => const IosActivityIndicator();

  @override
  ISlider createSlider() => const IosSlider();
}

class CustomWidgetsFactory implements IWidgetsFactory {
  const CustomWidgetsFactory();

  @override
  String getTitle() => 'Custom widgets';

  @override
  IActivityIndicator createActivityIndicator() => const CustomLoader();

  @override
  ISlider createSlider() => const CustomSlider();
}

abstract interface class IActivityIndicator {
  Widget render();
}

class AndroidActivityIndicator implements IActivityIndicator {
  const AndroidActivityIndicator();

  @override
  Widget render() {
    return CircularProgressIndicator(
      backgroundColor: const Color(0xFFECECEC),
      valueColor: AlwaysStoppedAnimation<Color>(
        Colors.black.withOpacity(0.65),
      ),
    );
  }
}

class IosActivityIndicator implements IActivityIndicator {
  const IosActivityIndicator();

  @override
  Widget render() {
    return const CupertinoActivityIndicator();
  }
}

class CustomLoader implements IActivityIndicator {
  const CustomLoader();

  @override
  Widget render() {
    return const CupertinoActivityIndicator(
      color: Colors.amber,
    );
  }
}

abstract interface class ISlider {
  Widget render(double value, ValueSetter<double> onChanged);
}

class AndroidSlider implements ISlider {
  const AndroidSlider();

  @override
  Widget render(double value, ValueSetter<double> onChanged) {
    return Slider(
      activeColor: Colors.black,
      inactiveColor: Colors.grey,
      max: 100.0,
      value: value,
      onChanged: onChanged,
    );
  }
}

class IosSlider implements ISlider {
  const IosSlider();

  @override
  Widget render(double value, ValueSetter<double> onChanged) {
    return CupertinoSlider(
      max: 100.0,
      value: value,
      onChanged: onChanged,
    );
  }
}

class CustomSlider implements ISlider {
  const CustomSlider();

  @override
  Widget render(double value, ValueSetter<double> onChanged) {
    return CupertinoSlider(
      max: 100.0,
      activeColor: Colors.amber,
      value: value,
      onChanged: onChanged,
    );
  }
}
