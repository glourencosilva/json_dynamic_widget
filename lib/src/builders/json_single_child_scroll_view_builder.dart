import 'package:child_builder/child_builder.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:json_class/json_class.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:json_theme/json_theme.dart';

/// Builder that can build an [SingleChildScrollView] widget.  See the
/// [fromDynamic] for the format.
class JsonSingleChildScrollViewBuilder extends JsonWidgetBuilder {
  JsonSingleChildScrollViewBuilder({
    this.clipBehavior,
    this.controller,
    this.dragStartBehavior,
    this.padding,
    this.physics,
    this.primary,
    this.restorationId,
    this.reverse,
    this.scrollDirection,
  }) : super(numSupportedChildren: kNumSupportedChildren);

  static const kNumSupportedChildren = 1;
  static const type = 'single_child_scroll_view';

  final Clip clipBehavior;
  final ScrollController controller;
  final DragStartBehavior dragStartBehavior;
  final EdgeInsets padding;
  final ScrollPhysics physics;
  final bool primary;
  final String restorationId;
  final bool reverse;
  final Axis scrollDirection;

  /// Builds the builder from a Map-like dynamic structure.  This expects the
  /// JSON format to be of the following structure:
  ///
  /// ```json
  /// {
  ///   "clipBehavior": <Clip>,
  ///   "controller": <ScrollController>,
  ///   "dragStartBehavior": <DragStartBehavior>,
  ///   "padding": <EdgeInsetsGeometry>,
  ///   "physics": <ScrollPhysics>,
  ///   "primary": <bool>,
  ///   "restorationId": <String>,
  ///   "reverse": <bool>,,
  ///   "scrollDirection": <Axis>
  /// }
  /// ```
  ///
  /// As a note, the [ScrollController] cannot be decoded via JSON.  Instead,
  /// the only way to bind those values to the builder is to use a function or a
  /// variable reference via the [JsonWidgetRegistry].
  ///
  /// See also:
  ///  * [ThemeDecoder.decodeAxis]
  ///  * [ThemeDecoder.decodeDragStartBehavior]
  ///  * [ThemeDecoder.decodeEdgeInsetsGeometry]
  ///  * [ThemeDecoder.decodeScrollPhysics]
  static JsonSingleChildScrollViewBuilder fromDynamic(
    dynamic map, {
    JsonWidgetRegistry registry,
  }) {
    JsonSingleChildScrollViewBuilder result;

    if (map != null) {
      result = JsonSingleChildScrollViewBuilder(
        clipBehavior:
            ThemeDecoder.decodeClip(map['clipBehavior']) ?? Clip.hardEdge,
        controller: map['controller'],
        dragStartBehavior: ThemeDecoder.decodeDragStartBehavior(
              map['dragStartBehavior'],
              validate: false,
            ) ??
            DragStartBehavior.start,
        padding: ThemeDecoder.decodeEdgeInsetsGeometry(
          map['padding'],
          validate: false,
        ),
        physics: ThemeDecoder.decodeScrollPhysics(
          map['physics'],
          validate: false,
        ),
        primary:
            map['primary'] == null ? null : JsonClass.parseBool(map['primary']),
        restorationId: map['restorationId'],
        reverse: JsonClass.parseBool(map['reverse']),
        scrollDirection: ThemeDecoder.decodeAxis(
              map['scrollDirection'],
              validate: false,
            ) ??
            Axis.vertical,
      );
    }

    return result;
  }

  @override
  Widget buildCustom({
    ChildWidgetBuilder childBuilder,
    @required BuildContext context,
    @required JsonWidgetData data,
    Key key,
  }) {
    var child = getChild(data);

    return SingleChildScrollView(
      clipBehavior: clipBehavior,
      controller: controller,
      dragStartBehavior: dragStartBehavior,
      key: key,
      padding: padding,
      physics: physics,
      primary: primary,
      restorationId: restorationId,
      reverse: reverse,
      scrollDirection: scrollDirection,
      child: child.build(
        childBuilder: childBuilder,
        context: context,
      ),
    );
  }
}
