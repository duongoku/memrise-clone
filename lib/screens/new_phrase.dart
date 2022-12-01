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
  static const phraseStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );
  static const meaningStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );
  static const srcStyle = TextStyle(
    color: Colors.grey,
    fontSize: 12,
  );

  late List<VideoPlayerController> videoControllers = [];

  late PageController pageController;

  dynamic currentWord;

  void replayVideo() {
    setState(() {
      videoControllers[widget.words.indexOf(currentWord)]
          .seekTo(const Duration(seconds: 0));
      videoControllers[widget.words.indexOf(currentWord)].play();
    });
  }

  @override
  void initState() {
    super.initState();
    currentWord = widget.words[widget.currentWordIndex];
    pageController = PageController(
      initialPage: widget.currentWordIndex,
    );
    for (int i = 0; i < widget.words.length; i++) {
      VideoPlayerController v = VideoPlayerController.network(
        widget.words[i]["videoUrl"],
      );
      v.initialize().then((_) {
        setState(() {
          if (i == widget.currentWordIndex) {
            v.play();
          }
        });
      });
      videoControllers.add(v);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [];
    for (int i = 0; i < videoControllers.length; i++) {
      pages.add(
        ListView(
          children: [
            Prefab.vPadding10,
            videoControllers[i].value.isInitialized
                ? AspectRatio(
                    aspectRatio: videoControllers[i].value.aspectRatio,
                    child: VideoPlayer(videoControllers[i]),
                  )
                : const Center(child: CircularProgressIndicator()),
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
              widget.words[i]["srcLang"],
              style: srcStyle,
              textAlign: TextAlign.center,
            ),
            Prefab.vPadding15,
            Text(
              widget.words[i]["phrase"],
              style: phraseStyle,
              textAlign: TextAlign.center,
            ),
            Prefab.vPadding35,
            Text(
              widget.words[i]["dstLang"],
              style: srcStyle,
              textAlign: TextAlign.center,
            ),
            Prefab.vPadding15,
            Text(
              widget.words[i]["meaning"],
              style: meaningStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomPalette.lighterPrimaryColor,
        title: Text(
            "${widget.words.indexOf(currentWord) + 1}/${widget.words.length}"),
      ),
      backgroundColor: CustomPalette.primaryColor,
      body: PageView(
        controller: pageController,
        children: pages,
        onPageChanged: (index) {
          setState(() {
            currentWord = widget.words[index];
            replayVideo();
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (var element in videoControllers) {
      element.dispose();
    }
  }
}
