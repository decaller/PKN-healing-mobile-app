import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app/theme/pkn_tokens.dart';

bool usesCupertino(BuildContext context) =>
    Theme.of(context).platform == TargetPlatform.iOS ||
    Theme.of(context).platform == TargetPlatform.macOS;

/// Shared route content; only native chrome changes, never route/state ownership.
class PknScaffold extends StatelessWidget {
  const PknScaffold({super.key, this.appBar, required this.body});
  final PknAppBar? appBar;
  final Widget body;
  @override
  Widget build(BuildContext context) {
    if (!usesCupertino(context)) return Scaffold(appBar: appBar, body: body);
    return CupertinoPageScaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      navigationBar: appBar?.cupertino(context),
      child: SafeArea(bottom: false, child: Material(
        color: Theme.of(context).scaffoldBackgroundColor, child: body)),
    );
  }
}

class PknAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PknAppBar({super.key, this.title, this.leading, this.actions});
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  CupertinoNavigationBar cupertino(BuildContext context) => CupertinoNavigationBar(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    automaticBackgroundVisibility: false,
    transitionBetweenRoutes: false,
    leading: leading,
    middle: title == null ? null : DefaultTextStyle(
      style: Theme.of(context).textTheme.titleMedium!, child: title is Text
        ? FittedBox(fit: BoxFit.scaleDown, child: title!) : title!),
    trailing: actions == null ? null : Row(mainAxisSize: MainAxisSize.min, children: actions!),
  );
  @override
  Widget build(BuildContext context) => AppBar(title: title, leading: leading, actions: actions);
}

class PknIconButton extends StatelessWidget {
  const PknIconButton({super.key, required this.icon, required this.onPressed, this.tooltip});
  final Widget icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  @override
  Widget build(BuildContext context) {
    if (!usesCupertino(context)) return IconButton(icon: icon, onPressed: onPressed, tooltip: tooltip);
    final button = Semantics(enabled: onPressed != null, label: tooltip, button: true,
      child: CupertinoButton(padding: EdgeInsets.zero, minSize: 44,
        onPressed: onPressed, child: icon));
    return tooltip == null ? button : Tooltip(message: tooltip!, child: button);
  }
}

class PknActionButton extends StatelessWidget {
  const PknActionButton({super.key, required this.onPressed, required this.child, this.style}) : variant = 0;
  const PknActionButton.outlined({super.key, required this.onPressed, required this.child, this.style}) : variant = 1;
  const PknActionButton.text({super.key, required this.onPressed, required this.child, this.style}) : variant = 2;
  PknActionButton.icon({super.key, required this.onPressed, required Widget icon,
    required Widget label, this.style}) : variant = 0,
    child = Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center,
      children: [icon, const SizedBox(width: 8), label]);
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;
  final int variant;
  @override
  Widget build(BuildContext context) {
    if (!usesCupertino(context)) {
      if (variant == 1) return OutlinedButton(style: style, onPressed: onPressed, child: child);
      if (variant == 2) return TextButton(style: style, onPressed: onPressed, child: child);
      return ElevatedButton(style: style, onPressed: onPressed, child: child);
    }
    final states = onPressed == null ? <WidgetState>{WidgetState.disabled} : <WidgetState>{};
    final foreground = style?.foregroundColor?.resolve(states) ??
        (variant == 0 ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.primary);
    final background = variant == 0 ? style?.backgroundColor?.resolve(states) ?? Theme.of(context).colorScheme.primary : null;
    final content = DefaultTextStyle.merge(style: Theme.of(context).textTheme.labelLarge!.copyWith(color: foreground),
      child: IconTheme.merge(data: IconThemeData(color: foreground), child: child));
    final borderSide = style?.side?.resolve(states) ??
        (variant == 1 ? BorderSide(color: Theme.of(context).dividerColor) : null);
    return DecoratedBox(decoration: BoxDecoration(
      borderRadius: PknRadius.roundedSm,
      border: borderSide == null ? null : Border.fromBorderSide(borderSide)),
      child: CupertinoButton(color: background, disabledColor: Theme.of(context).disabledColor,
        borderRadius: PknRadius.roundedSm, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        minSize: 48, onPressed: onPressed, child: content));
  }
}

class PknTextField extends StatelessWidget {
  const PknTextField({super.key, this.controller, this.autofocus = false, this.decoration, this.onChanged});
  final TextEditingController? controller;
  final bool autofocus;
  final InputDecoration? decoration;
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) => usesCupertino(context)
    ? CupertinoSearchTextField(controller: controller, autofocus: autofocus,
        style: Theme.of(context).textTheme.bodyMedium,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: PknRadius.roundedSm,
        placeholderStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        placeholder: decoration?.hintText, onChanged: onChanged)
    : TextField(controller: controller, autofocus: autofocus, decoration: decoration, onChanged: onChanged);
}

Future<T?> showPknSheet<T>({required BuildContext context, required WidgetBuilder builder,
  bool isScrollControlled = false, Color? backgroundColor, ShapeBorder? shape}) {
  if (!usesCupertino(context)) {
    return showModalBottomSheet<T>(context: context,
      isScrollControlled: isScrollControlled, useSafeArea: true,
      backgroundColor: backgroundColor, shape: shape, builder: builder);
  }
  final theme = Theme.of(context);
  return showCupertinoModalPopup<T>(context: context, builder: (ctx) => Theme(data: theme,
    child: SafeArea(top: true, child: Material(color: Colors.transparent,
      child: Container(constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(ctx).height * .92),
        decoration: BoxDecoration(color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24))),
        clipBehavior: Clip.antiAlias, child: Builder(builder: (sheetContext) => isScrollControlled
          ? builder(sheetContext) : SingleChildScrollView(child: builder(sheetContext))))))));
}

class PknSwitch extends StatelessWidget {
  const PknSwitch({super.key, required this.value, required this.onChanged, this.activeColor});
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  @override
  Widget build(BuildContext context) => usesCupertino(context)
    ? CupertinoSwitch(value: value, onChanged: onChanged, activeTrackColor: activeColor ?? Theme.of(context).colorScheme.secondary)
    : Switch(value: value, onChanged: onChanged, activeColor: activeColor);
}

class PknTap extends StatelessWidget {
  const PknTap({super.key, required this.child, this.onTap, this.borderRadius});
  final Widget child;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  @override
  Widget build(BuildContext context) => usesCupertino(context)
    ? CupertinoButton(padding: EdgeInsets.zero, onPressed: onTap,
        child: DefaultTextStyle(style: DefaultTextStyle.of(context).style, child: child))
    : InkWell(onTap: onTap, borderRadius: borderRadius, child: child);
}

class PknChoiceChip extends StatelessWidget {
  const PknChoiceChip({super.key, required this.label, required this.selected,
    required this.onSelected, this.selectedColor, this.backgroundColor, this.side,
    this.labelStyle, this.showCheckmark = true});
  final Widget label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final Color? selectedColor;
  final Color? backgroundColor;
  final BorderSide? side;
  final TextStyle? labelStyle;
  final bool showCheckmark;
  @override
  Widget build(BuildContext context) {
    if (!usesCupertino(context)) {
      return ChoiceChip(label: label, selected: selected,
        onSelected: onSelected, selectedColor: selectedColor, backgroundColor: backgroundColor,
        side: side, labelStyle: labelStyle, showCheckmark: showCheckmark);
    }
    return Semantics(selected: selected, enabled: onSelected != null, button: true, child: DecoratedBox(
      decoration: BoxDecoration(color: selected ? selectedColor ?? Theme.of(context).chipTheme.selectedColor : backgroundColor ?? Theme.of(context).chipTheme.backgroundColor,
        border: Border.fromBorderSide(side ?? BorderSide(color: Theme.of(context).dividerColor)),
        borderRadius: PknRadius.roundedPill),
      child: CupertinoButton(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        minSize: 44, onPressed: onSelected == null ? null : () => onSelected!(!selected),
        child: DefaultTextStyle.merge(style: labelStyle ?? Theme.of(context).textTheme.labelMedium, child: label))));
  }
}

class PknSlider extends StatelessWidget {
  const PknSlider({super.key, required this.value, required this.onChanged});
  final double value;
  final ValueChanged<double>? onChanged;
  @override
  Widget build(BuildContext context) => usesCupertino(context)
    ? CupertinoSlider(value: value, onChanged: onChanged)
    : Slider(value: value, onChanged: onChanged);
}

void showPknFeedback(BuildContext context, SnackBar message) {
  if (!usesCupertino(context)) {
    ScaffoldMessenger.of(context).showSnackBar(message);
    return;
  }
  final theme = Theme.of(context);
  showCupertinoDialog<void>(context: context, builder: (ctx) => Theme(data: theme,
    child: CupertinoAlertDialog(content: message.content,
      actions: [CupertinoDialogAction(onPressed: () => Navigator.of(ctx).pop(), child: const Text('OK'))])));
}
