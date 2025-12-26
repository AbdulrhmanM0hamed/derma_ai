import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart' as animate;

/// A collection of reusable animation effects.

/// A general-purpose fade-in and slide animation.
List<animate.Effect<dynamic>> fadeInSlide({
  Duration duration = const Duration(milliseconds: 400),
  Duration? delay,
  double beginX = 0,
  double beginY = 0.1,
  Curve curve = Curves.easeInOut,
}) =>
    [
      animate.FadeEffect(duration: duration, delay: delay, curve: curve),
      animate.SlideEffect(
        begin: Offset(beginX, beginY),
        end: Offset.zero,
        duration: duration,
        delay: delay,
        curve: curve,
      ),
    ];

/// A general-purpose fade-in and scale-up animation.
List<animate.Effect<dynamic>> fadeInScaleUp({
  Duration duration = const Duration(milliseconds: 400),
  Duration? delay,
  double begin = 0.95,
  Curve curve = Curves.easeInOut,
}) =>
    [
      animate.FadeEffect(duration: duration, delay: delay, curve: curve),
      animate.ScaleEffect(
        begin: Offset(begin, begin),
        end: const Offset(1, 1),
        duration: duration,
        delay: delay,
        curve: curve,
      ),
    ];

/// A simple fade-in animation.
List<animate.Effect<dynamic>> fadeIn({
  Duration duration = const Duration(milliseconds: 400),
  Duration? delay,
  Curve curve = Curves.easeInOut,
}) =>
    [
      animate.FadeEffect(duration: duration, delay: delay, curve: curve),
    ];

/// An animation for card selection, involving scale and elevation.
List<animate.Effect<dynamic>> cardSelection({
  Duration duration = const Duration(milliseconds: 200),
  Offset scaleBegin = const Offset(1, 1),
  Offset scaleEnd = const Offset(0.95, 0.95),
  Color? color,
}) =>
    [
      animate.ScaleEffect(
        begin: scaleBegin,
        end: scaleEnd,
        duration: duration,
        curve: Curves.easeInOut,
      ),
      if (color != null)
        animate.CustomEffect(
          builder: (context, value, child) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.2 * value),
                  blurRadius: 20 * value,
                  spreadRadius: 2 * value,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: child,
          ),
          duration: duration,
        ),
    ];

/// A continuous pulsing animation using scale.
List<animate.Effect<dynamic>> pulse({
  Duration duration = const Duration(milliseconds: 1500),
  double begin = 1,
  double end = 1.05,
  Curve curve = Curves.easeInOut,
}) =>
    [
      animate.ScaleEffect(
        begin: Offset(begin, begin),
        end: Offset(end, end),
        duration: duration,
        curve: curve,
      ),
    ];
