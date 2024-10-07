import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

void main() {
  runApp(XylophoneApp());
}

// ignore: must_be_immutable
class XylophoneApp extends StatelessWidget {
  final AudioCache player = AudioCache();
  AudioPlayer? audioPlayer;
  int? lastPlayedNote;

  void playSound(int noteNumber) async {
    if (audioPlayer != null) {
      await audioPlayer?.stop(); // Stop the last played sound if any
    }

    audioPlayer = await player.play('note$noteNumber.mp3'); // Play the new sound

    lastPlayedNote = noteNumber; // Track the last played note

    // Stop the sound after 1 second
    Timer(Duration(seconds: 1), () {
      audioPlayer?.stop();
    });
  }

  Expanded buildKey({required Color color, required int soundNumber}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          playSound(soundNumber); // Call playSound when tapped
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.8), color], // Gradient effect
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20), // Rounded corners
            border: Border.all(color: Colors.black, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 4), // Shadow effect
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
          child: Center(
            child: Text(
              '🎵 Note $soundNumber 🎵', // Child-friendly text
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22, // Larger font size for better visibility
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xylophone App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Xylophone App 🎶'),
          centerTitle: true,
          elevation: 5,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildKey(color: Colors.red, soundNumber: 1),
            buildKey(color: Colors.orange, soundNumber: 2),
            buildKey(color: Colors.yellow, soundNumber: 3),
            buildKey(color: Colors.green, soundNumber: 4),
            buildKey(color: Colors.teal, soundNumber: 5),
            buildKey(color: Colors.blue, soundNumber: 6),
          ],
        ),
      ),
    );
  }
}
