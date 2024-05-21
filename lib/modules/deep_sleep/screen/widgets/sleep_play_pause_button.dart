import 'package:flutter/material.dart';

class SleepPlayPauseButton extends StatefulWidget {
  final bool isPlaying;
  final VoidCallback onTap;
  const SleepPlayPauseButton(
      {super.key, required this.isPlaying, required this.onTap});
  @override
  SleepPlayPauseButtonState createState() => SleepPlayPauseButtonState();
}

class SleepPlayPauseButtonState extends State<SleepPlayPauseButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.18,
        height: MediaQuery.sizeOf(context).height * 0.08,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(
                widget.isPlaying ? Icons.pause_circle_outline_outlined : Icons.play_circle_outline_outlined,
                size: 40,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
