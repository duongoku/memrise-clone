import 'dart:math';

import 'package:demo/colors/custom_palette.dart';
import 'package:demo/constants.dart';
import 'package:demo/screens/prefab.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

final Random random = Random((DateTime.now()).millisecondsSinceEpoch);

class LearnScreen extends StatefulWidget {
  final dynamic words;

  const LearnScreen({
    super.key,
    required this.words,
  });

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
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
  static const resultStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );
  static const limit = 4;
  static const baseCorrectScore = 60;
  static const streakBonusScore = 15;
  static const congratsImageWidth = 200.0;

  late VideoPlayerController videoController;
  var score = 0;
  var current = 0;
  var streak = 0;
  var isQuestion = false;
  var selected = 0;
  var done = false;

  void replayVideo() {
    setState(() {
      videoController.seekTo(const Duration(seconds: 0));
      videoController.play();
    });
  }

  void reloadVideo() {
    videoController = VideoPlayerController.network(
      widget.words[current]["videoUrl"],
    )..initialize().then((_) {
        setState(() {
          videoController.play();
        });
      });
  }

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.network(
      widget.words[current]["videoUrl"],
    )..initialize().then((_) {
        setState(() {
          videoController.play();
        });
      });
  }

  void showExitConfirmDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("CANCEL"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("YES"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Exit learning session"),
      content: const Text(
        "Are you sure you want to exit this session? Your progress will be saved",
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void toNextWord(int choice) {
    videoController.dispose();
    setState(
      () {
        // If the current screen is question screen
        if (isQuestion) {
          if (choice == selected) {
            score += baseCorrectScore + streakBonusScore * streak;
            streak += 1;
          } else {
            streak = 0;
          }
          // If this is the last word
          if (current == widget.words.length - 1) {
            done = true;
          } else {
            current += 1;
            reloadVideo();
            isQuestion = false;
          }
        } else {
          if ((current + 1) % limit == 0 ||
              current == widget.words.length - 1) {
            isQuestion = true;
          } else {
            current += 1;
            reloadVideo();
          }
        }
      },
    );
  }

  Widget widgetForNewWord() {
    return ListView(
      children: [
        Prefab.vPadding10,
        videoController.value.isInitialized
            ? AspectRatio(
                aspectRatio: videoController.value.aspectRatio,
                child: VideoPlayer(videoController),
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
          widget.words[current]["srcLang"],
          style: srcStyle,
          textAlign: TextAlign.center,
        ),
        Prefab.vPadding15,
        Text(
          widget.words[current]["phrase"],
          style: phraseStyle,
          textAlign: TextAlign.center,
        ),
        Prefab.vPadding35,
        Text(
          widget.words[current]["dstLang"],
          style: srcStyle,
          textAlign: TextAlign.center,
        ),
        Prefab.vPadding15,
        Text(
          widget.words[current]["meaning"],
          style: meaningStyle,
          textAlign: TextAlign.center,
        ),
        Prefab.vPadding150,
        Center(
          child: SizedBox(
            height: 50,
            width: 350,
            child: CustomElevatedButton(
              onPressed: () {
                toNextWord(-1);
              },
              text: Prefab.okButtonText,
              style: Prefab.okButtonStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget widgetForQuestion() {
    // A random number from 0 to current
    selected = random.nextInt(current + 1);
    // A random number from 0 to 3
    var position = random.nextInt(4);
    // 3 different numbers from 0 to widget.words.length - 1, excluding selected
    var tempList = List<int>.generate(widget.words.length, (i) => i);
    tempList.remove(selected);
    tempList.shuffle();
    var options = tempList;
    tempList.sublist(0, 3);
    options.insert(position, selected);

    return ListView(
      children: [
        Prefab.vPadding10,
        Center(
          child: SizedBox(
            height: 50,
            width: 350,
            child: Text(
              widget.words[selected]["phrase"],
              style: meaningStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 1,
            children: List.generate(4, (index) {
              var id = options[index];
              return Container(
                margin: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () {
                    toNextWord(id);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        CustomPalette.lighterPrimaryColor),
                  ),
                  child: Text(
                    widget.words[id]["meaning"],
                    style: meaningStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Future<void> updateScoreToDB() async {
    try {
      final userId = supabase.auth.currentUser!.id;
      final userData = await supabase
          .from("profiles")
          .select()
          .eq("id", userId)
          .single() as Map;
      userData["experience_point"] += score;
      await supabase.from("profiles").upsert(userData);
    } catch (e) {
      if (kDebugMode) {
        print("Unexpected exception occurred when updating score");
      }
    }
  }

  Widget widgetForFinalResult() {
    updateScoreToDB();
    return ListView(
      children: [
        Prefab.vPadding15,
        const Text(
          "Congratulations",
          style: resultStyle,
          textAlign: TextAlign.center,
        ),
        Prefab.vPadding5,
        const Text(
          "You've completed this session!",
          style: resultStyle,
          textAlign: TextAlign.center,
        ),
        Prefab.vPadding50,
        Image.asset(
          "assets/images/congrats.png",
          width: congratsImageWidth,
        ),
        Prefab.vPadding50,
        Text(
          "Your score: $score",
          style: resultStyle,
          textAlign: TextAlign.center,
        ),
        Prefab.vPadding50,
        Center(
          child: SizedBox(
            height: 50,
            width: 350,
            child: CustomElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              text: const Text(
                "GO BACK",
                style: TextStyle(
                  color: CustomPalette.primaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 26,
                ),
              ),
              style: Prefab.okButtonStyle,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomPalette.lighterPrimaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            size: 30,
          ),
          splashRadius: 22,
          onPressed: () {
            showExitConfirmDialog(context);
          },
        ),
        actions: [
          Container(
            constraints: const BoxConstraints(
              minWidth: 100,
            ),
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(
              right: 10,
              top: 10,
              bottom: 10,
            ),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: CustomPalette.evenLighterPrimaryColor,
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            child: Text(
              "$score",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: CustomPalette.primaryColor,
      body: done
          ? widgetForFinalResult()
          : (isQuestion ? widgetForQuestion() : widgetForNewWord()),
    );
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
  }
}
