library ring_layout;

import 'dart:math';

import 'package:flutter/material.dart';

class RingLayout extends StatelessWidget {
  final List<Widget> children;
  final double initAngle;
  final bool reverse;
  final double radiusRatio;

  const RingLayout({
    Key? key,
    required this.children,
    this.reverse = false,
    this.radiusRatio = 1.0,
    this.initAngle = 0,
  })  : assert(0.0 <= radiusRatio && radiusRatio <= 1.0),
        assert(0 <= initAngle && initAngle <= 360),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: _RingDelegate(
          count: children.length,
          initAngle: initAngle,
          reverse: reverse,
          radiusRatio: radiusRatio),
      children: [
        for (int i = 0; i < children.length; i++)
          LayoutId(id: i, child: children[i])
      ],
    );
  }
}

class _RingDelegate extends MultiChildLayoutDelegate {
  final double initAngle;
  final bool reverse;
  final int count;
  final double radiusRatio;

  _RingDelegate({
    required this.initAngle,
    required this.reverse,
    required this.count,
    required this.radiusRatio,
  });

  @override
  void performLayout(Size size) {
    // 容器圆心坐标
    Offset circleCenter = Offset(size.width / 2, size.height / 2);
    // 容器半径
    double containerRadius = min(size.width, size.height) / 2;
    // 子元素半径
    double childRadius = _getChildRadius(containerRadius, 360 / count);
    // 子元素约束宽高
    Size constraintsSize = Size(childRadius * 2, childRadius * 2);

    // 获取最大子元素外切圆的半径
    List<Size> childSizes = [];
    double maxRadius = 0;
    for (int i = 0; i < count; i++) {
      if (!hasChild(i)) {
        break;
      }

      Size childSize = layoutChild(i, BoxConstraints.loose(constraintsSize));
      double _radius = max(childSize.width, childSize.height) / 2;
      maxRadius = _radius > maxRadius ? _radius : maxRadius;

      // 记录子元素size
      childSizes.add(Size.copy(childSize));
    }
    containerRadius -= maxRadius;

    // 子元素布局
    for (int i = 0; i < count; i++) {
      if (!hasChild(i)) {
        break;
      }

      Offset offset = _getChildCenterOffset(
        circleCenter: circleCenter,
        radius: containerRadius * radiusRatio,
        count: count,
        which: i,
        firstAngle: initAngle,
        direction: reverse ? -1 : 1,
      );

      double cr = max(childSizes[i].width, childSizes[i].height) / 2;
      offset -= Offset(cr, cr);

      positionChild(i, offset);
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => true;
}

/// 计算圆心a相对于圆心A的偏移量
///
/// @param centerPoint 圆心A的坐标
/// @param radius 圆A的半径
/// @param count 圆a的数量
/// @param which 圆a的序号
/// @param initAngle 起始位置
/// @param direction 排列方向
Offset _getChildCenterOffset({
  required Offset circleCenter,
  required double radius,
  required int count,
  required int which,
  required double firstAngle,
  required int direction,
}) {
  // 扇形弧度
  double radian = _radian(360 / count);
  // 处理起始位置偏移和排列方向
  double radianOffset = _radian(firstAngle * direction);
  double x = circleCenter.dx + radius * cos(radian * which + radianOffset);
  double y = circleCenter.dy + radius * sin(radian * which + radianOffset);
  return Offset(x, y);
}

/// 计算圆a的半径
///
/// @param radius 圆A的半径
/// @param angle 扇形的角度
double _getChildRadius(double radius, double angle) {
  // 扇形角度大于180度，只可以放置一个。
  if (angle > 180) {
    return radius;
  }

  /// 扇形最大内切圆公式，见公式推导。
  return radius * sin(_radian(angle / 2)) / (1 + sin(_radian(angle / 2)));
}

/// 计算弧度
///
/// @param angle 角度
double _radian(double angle) {
  return pi / 180 * angle;
}
