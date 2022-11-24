import 'package:demo/colors/custom_palette.dart';
import 'package:demo/screens/prefab.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class NewPhrase extends StatefulWidget {
  final dynamic words;
  final int currentWordIndex;

  const NewPhrase({
    super.key,
    required this.words,
    required this.currentWordIndex,
  });

  @override
  State<NewPhrase> createState() => _NewPhraseState();
}

class _NewPhraseState extends State<NewPhrase> {
  static const phraseStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24);
  static const meaningStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24);
  static const srcStyle = TextStyle(color: Colors.grey, fontSize: 12);

  late VideoPlayerController videoController;

  dynamic currentWord;

  void replayVideo() {
    setState(() {
      videoController.seekTo(const Duration(seconds: 0));
      videoController.play();
    });
  }

  @override
  void initState() {
    super.initState();
    currentWord = widget.words[widget.currentWordIndex];
    videoController = VideoPlayerController.network(currentWord["videoUrl"])
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
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            alignment: Alignment.center,
            child: const Text(
              '0', // TODO: dynamic score
              style: TextStyle(fontSize: 20, color: CustomPalette.iconColor),
            ),
          ),
        ],
      ),
      backgroundColor: CustomPalette.primaryColor,
      body: ListView(
        children: [
          Prefab.vPadding10,
          videoController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: videoController.value.aspectRatio,
                  child: VideoPlayer(videoController),
                )
              : Container(),
          ElevatedButton(
            onPressed: replayVideo,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  CustomPalette.lighterPrimaryColor),
            ),
            child: const Icon(Icons.replay),
          ),
          Prefab.vPadding35,
          Text(
            currentWord["srcLang"],
            style: srcStyle,
            textAlign: TextAlign.center,
          ),
          Prefab.vPadding15,
          Text(
            currentWord["phrase"],
            style: phraseStyle,
            textAlign: TextAlign.center,
          ),
          Prefab.vPadding35,
          Text(
            currentWord["dstLang"],
            style: srcStyle,
            textAlign: TextAlign.center,
          ),
          Prefab.vPadding15,
          Text(
            currentWord["meaning"],
            style: meaningStyle,
            textAlign: TextAlign.center,
          ),
          Prefab.vPadding150,
          Center(
            child: SizedBox(
              height: 50,
              width: 350,
              child: CustomElevatedButton(
                onPressed: () {}, // TODO: implement
                text: Prefab.okButtonText,
                style: Prefab.okButtonStyle,
              ),
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
