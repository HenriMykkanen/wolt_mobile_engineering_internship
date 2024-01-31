import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// https://riverpod.dev/docs/concepts/about_hooks
// Used to give a fade in animation for contents that are loaded
class FadeIn extends HookWidget {
  const FadeIn({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Create an AnimationController. The controller will automatically be
    // disposed when the widget is unmounted.
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );

    useEffect(() {
      animationController.forward();
      return null;
    }, const []);

    useAnimation(animationController);

    return Opacity(
      opacity: animationController.value,
      child: child,
    );
  }
}
