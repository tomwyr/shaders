import 'dart:ui';

import 'package:flutter/material.dart';

class SmoothClip extends StatefulWidget {
  const SmoothClip({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<SmoothClip> createState() => _SmoothClipState();
}

class _SmoothClipState extends State<SmoothClip> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  FragmentProgram? program;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
    _loadShaderAsset();
  }

  void _setupAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  void _loadShaderAsset() async {
    final program = await FragmentProgram.fromAsset('shaders/smooth_clip.frag');

    setState(() {
      this.program = program;
    });
  }

  FragmentShader _createShader(Rect rect) {
    final shader = program!.fragmentShader();

    shader
      ..setFloat(0, controller.value)
      ..setFloat(1, rect.width)
      ..setFloat(2, rect.height);

    return shader;
  }

  @override
  Widget build(BuildContext context) {
    if (program == null) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => ShaderMask(
        blendMode: BlendMode.dstOut,
        shaderCallback: (rect) => _createShader(rect),
        child: widget.child,
      ),
    );
  }
}
