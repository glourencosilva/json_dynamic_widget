import 'package:child_builder/child_builder.dart';
import 'package:flutter/material.dart';
import 'package:json_class/json_class.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

/// Builder that can build an [AnimatedOpacity] widget.
/// See the [fromDynamic] for the format.
class JsonAnimatedOpacityBuilder extends JsonWidgetBuilder {
  JsonAnimatedOpacityBuilder({
    this.alwaysIncludeSemantics,
    this.curve,
    @required this.duration,
    this.onEnd,
    @required this.opacity,
  })  : assert(duration != null),
        assert(opacity != null),
        super(numSupportedChildren: kNumSupportedChildren);

  static const kNumSupportedChildren = 1;
  static const type = 'animated_opacity';

  final bool alwaysIncludeSemantics;
  final Curve curve;
  final Duration duration;
  final VoidCallback onEnd;
  final double opacity;

  /// Builds the builder from a Map-like dynamic structure.  This expects the
  /// JSON format to be of the following structure:
  ///
  /// ```json
  /// {
  ///   "alwaysIncludeSemantics": <bool>,
  ///   "curve": <Curve>,
  ///   "duration": <int; millis>,
  ///   "onEnd": <VoidCallback>,
  ///   "opacity": <double>,
  /// }
  /// ```
  ///
  /// As a note, the [Curve] and [VoidCallback] cannot be decoded via JSON.
  /// Instead, the only way to bind those values to the builder is to use a
  /// function or a variable reference via the [JsonWidgetRegistry].
  static JsonAnimatedOpacityBuilder fromDynamic(
    dynamic map, {
    JsonWidgetRegistry registry,
  }) {
    JsonAnimatedOpacityBuilder result;

    if (map != null) {
      result = JsonAnimatedOpacityBuilder(
        alwaysIncludeSemantics: JsonClass.parseBool(
              map['alwaysIncludeSemantics'],
            ) ??
            false,
        curve: map['curve'] ?? Curves.linear,
        duration: JsonClass.parseDurationFromMillis(
          map['duration'],
        ),
        onEnd: map['onEnd'],
        opacity: JsonClass.parseDouble(map['opacity']),
      );
    }

    return result;
  }

  @override
  Widget buildCustom({
    ChildWidgetBuilder childBuilder,
    BuildContext context,
    JsonWidgetData data,
    Key key,
  }) {
    var child = getChild(data);

    return _JsonAnimatedOpacity(
      builder: this,
      childBuilder: childBuilder,
      data: data,
      key: key,
      child: child,
    );
  }
}

class _JsonAnimatedOpacity extends StatefulWidget {
  _JsonAnimatedOpacity({
    @required this.builder,
    @required this.child,
    @required this.childBuilder,
    @required this.data,
    Key key,
  })  : assert(builder != null),
        assert(data != null),
        super(key: key);

  final JsonAnimatedOpacityBuilder builder;
  final JsonWidgetData child;
  final ChildWidgetBuilder childBuilder;
  final JsonWidgetData data;

  @override
  _JsonAnimatedOpacityState createState() => _JsonAnimatedOpacityState();
}

class _JsonAnimatedOpacityState extends State<_JsonAnimatedOpacity> {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      alwaysIncludeSemantics: widget.builder.alwaysIncludeSemantics,
      curve: widget.builder.curve,
      duration: widget.builder.duration,
      onEnd: widget.builder.onEnd,
      opacity: widget.builder.opacity,
      child: widget.child.build(
        childBuilder: widget.childBuilder,
        context: context,
      ),
    );
  }
}
