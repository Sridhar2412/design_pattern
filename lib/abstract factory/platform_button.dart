import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class PlatformLoader {
  Widget render();
  Color color();
  factory PlatformLoader(int index) {
    switch (index) {
      case TargetPlatform.android:
        return AndroidLoader();
      case TargetPlatform.iOS:
        return IOSLoader();
      default:
        return CustomLoader();
    }
  }
}

class AndroidLoader implements PlatformLoader {
  @override
  Widget render() {
    return CircularProgressIndicator(
      color: color(),
    );
  }

  @override
  Color color() {
    // TODO: implement color
    return Colors.red;
  }
}

class IOSLoader implements PlatformLoader {
  @override
  Widget render() {
    return CupertinoActivityIndicator(
      color: color(),
    );
  }

  @override
  Color color() {
    // TODO: implement color
    return Colors.blue;
  }
}

class CustomLoader implements PlatformLoader {
  @override
  Widget render() {
    return CupertinoActivityIndicator(
      color: color(),
    );
  }

  @override
  Color color() {
    // TODO: implement color
    return Colors.blue;
  }
}
