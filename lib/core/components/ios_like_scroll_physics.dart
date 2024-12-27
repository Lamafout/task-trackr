import 'package:flutter/widgets.dart';

class AlwaysBouncingScrollPhysics extends BouncingScrollPhysics {
  const AlwaysBouncingScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  AlwaysBouncingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return AlwaysBouncingScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) {
    return true;
  }
}
