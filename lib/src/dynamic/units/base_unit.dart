import 'package:flutter/material.dart';

import '../../../flui_nullsafety.dart';
import 'unit_constant.dart';

abstract class FLDyBaseUnit extends StatelessWidget {
  const FLDyBaseUnit({super.key});

  @override
  Widget build(BuildContext context) => Container();
}

abstract class FLDyRenderUnit extends FLDyBaseUnit {
  const FLDyRenderUnit({super.key, required this.unitModel});

  final FLDyUnitModel unitModel;

  String? get uniqueId => unitModel.uniqueId;

  // subclass override
  @override
  Widget build(BuildContext context) => const SizedBox();

  // mark up single unit
  Widget? markupUnit(FLDyUnitModel unitModel) =>
      FLDyRenderParser.parseUnitModel(unitModel);

  // mark up unit list
  List<Widget?> markupUnits(List<FLDyUnitModel> unitModels) {
    List<Widget?> children = [];
    for (var unitModel in unitModels) {
      children.add(markupUnit(unitModel));
    }
    return children;
  }

  Widget? resolveChild() {
    Widget? child;
    if (unitModel.align != null && unitModel.child != null) {
      child = resolveAlignChild(unitModel.align!, unitModel.child!);
    } else if (unitModel.align != null && unitModel.children != null) {
      child = resolveAlignChildren(unitModel.align!, unitModel.children!);
    } else if (unitModel.child != null) {
      child = markupUnit(unitModel.child!);
    }
    return child;
  }

  // resolve child with align
  Widget resolveAlignChild(FLDyUnitAlign align, FLDyUnitModel childModel) {
    final Widget? widget = markupUnit(childModel);
    return FLDyAlignUnit(
      align: align,
      child: widget,
    );
  }

  // resolve children with align
  Widget resolveAlignChildren(
      FLDyUnitAlign align, List<FLDyUnitModel> childModels) {
    final List<Widget?> widgets = markupUnits(childModels);
    return FLDyAlignUnit(
      align: align,
      children: widgets,
    );
  }

  Widget resolveSelf(Widget self) {
    // flex
    if (unitModel.flex != null) {
      if (unitModel.flex == 'Expanded') {
        self = Expanded(child: self);
      } else if (unitModel.flex == 'Flexible') {
        self = Flexible(child: self);
      }
    }
    // position layout
    if (unitModel.positioned != null) {
      FLDyUnitPositioned positionedConf = unitModel.positioned!;
      self = Positioned(
        left: positionedConf.left,
        right: positionedConf.right,
        top: positionedConf.top,
        bottom: positionedConf.bottom,
        width: positionedConf.width,
        height: positionedConf.height,
        child: self,
      );
    }

    return self;
  }
}

class FLDyAlignUnit extends FLDyBaseUnit {
  const FLDyAlignUnit({super.key, required this.align, this.child, this.children});

  final FLDyUnitAlign align;
  final Widget? child;
  final List<Widget?>? children;

  MainAxisSize? resolveMainAxisSize(String? size) {
    switch (size) {
      case "min":
        return MainAxisSize.min;
      case "max":
        return MainAxisSize.max;
      default:
        return null;
    }
  }

  MainAxisAlignment? resolveMainAlignment(String? alignment) {
    switch (alignment) {
      case "start":
        return MainAxisAlignment.start;
      case "end":
        return MainAxisAlignment.end;
      case "center":
        return MainAxisAlignment.center;
      case "spaceBetween":
        return MainAxisAlignment.spaceBetween;
      case "spaceAround":
        return MainAxisAlignment.spaceAround;
      case "spaceEvenly":
        return MainAxisAlignment.spaceEvenly;
      default:
        return null;
    }
  }

  CrossAxisAlignment? resolveCrossAlignment(String? alignment) {
    switch (alignment) {
      case "start":
        return CrossAxisAlignment.start;
      case "end":
        return CrossAxisAlignment.end;
      case "center":
        return CrossAxisAlignment.center;
      case "stretch":
        return CrossAxisAlignment.stretch;
      case "baseline":
        return CrossAxisAlignment.baseline;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (align.type == FLDyAlignType.center) {
      return Center(
          widthFactor: align.widthFactor,
          heightFactor: align.heightFactor,
          child: child);
    }

    final MainAxisSize? mainAxisSize = align.mainAxisSize != null
        ? resolveMainAxisSize(align.mainAxisSize)
        : MainAxisSize.max;
    final MainAxisAlignment? mainAxisAlignment = align.mainAxisAlignment != null
        ? resolveMainAlignment(align.mainAxisAlignment)
        : MainAxisAlignment.start;
    final CrossAxisAlignment? crossAxisAlignment =
        align.crossAxisAlignment != null
            ? resolveCrossAlignment(align.crossAxisAlignment)
            : CrossAxisAlignment.center;
    if (align.type == FLDyAlignType.row) {
      return Row(
        mainAxisSize: mainAxisSize!,
        mainAxisAlignment: mainAxisAlignment!,
        crossAxisAlignment: crossAxisAlignment!,
        children: children as List<Widget>,
      );
    } else if (align.type == FLDyAlignType.column) {
      return Column(
        mainAxisSize: mainAxisSize!,
        mainAxisAlignment: mainAxisAlignment!,
        crossAxisAlignment: crossAxisAlignment!,
        children: children as List<Widget>,
      );
    } else if (align.type == FLDyAlignType.align) {
      return Align(
        alignment: align.getAlignment() ?? Alignment.center,
        widthFactor: align.widthFactor,
        heightFactor: align.heightFactor,
        child: child,
      );
    }

    return Container();
  }
}
