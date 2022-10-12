import 'package:demo/colors/custom_palette.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter/foundation.dart';

class NewPhrase extends StatefulWidget {
  final String videoUrl;
  final String phrase;
  final String meaning;

  const NewPhrase(
      {super.key,
      required this.videoUrl,
      required this.phrase,
      required this.meaning});

  @override
  State<NewPhrase> createState() => _NewPhraseState();
}

class _NewPhraseState extends State<NewPhrase> {
  static const phraseStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24);
  static const meaningStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24);
  static const buttonTopPadding = SizedBox(
    height: 200,
  );
  ElevatedButton okButton = ElevatedButton(
    onPressed: () {},
    style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(CustomPalette.dimmedSecondaryColor),
    ),
    child: const Text(
      "Ok, got it",
      style: TextStyle(
          color: CustomPalette.primaryColor,
          fontWeight: FontWeight.w900,
          fontSize: 26),
    ),
  );

  late VideoPlayerController videoController;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print(widget.videoUrl);
    }
    videoController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          videoController.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomPalette.lighterPrimaryColor,
        foregroundColor: CustomPalette.lightGreen,
        title: const Icon(Icons.close),
      ),
      backgroundColor: CustomPalette.primaryColor,
      body: ListView(
        children: [
          videoController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: videoController.value.aspectRatio,
                  child: VideoPlayer(videoController),
                )
              : Container(),
          Text(
            widget.phrase,
            style: phraseStyle,
            textAlign: TextAlign.center,
          ),
          Text(
            widget.meaning,
            style: meaningStyle,
            textAlign: TextAlign.center,
          ),
          buttonTopPadding,
          Center(
            child: SizedBox(
              height: 50,
              width: 350,
              child: okButton,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
  }
}
