<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

## Features

ring_layout is a ui component that helps you build ring layouts.

Support Android and iOS platforms

<div align="left">
<img src=https://imgoldjii.oss-cn-beijing.aliyuncs.com/屏幕录制2022-06-15-上午10.41.11.gif height=400 />
</div>

## Getting started

Run this command:

With Flutter:

```
 $ flutter pub add ring_layout
```

This will add a line like this to your package's pubspec.yaml (and run an implicit flutter pub get):

```
dependencies:
  ring_layout: ^1.0.1
```

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.

## Usage

```
RingLayout(
  initAngle: _controller.value * 360,
  children: List.generate(
    9,
    (index) =>
        buildPoint(width: 80, height: 80, color: Colors.blue),
  ),
);
```

## Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

For help on editing plugin code, view the [documentation](https://flutter.io/developing-packages/#edit-plugin-package).