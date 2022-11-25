import 'package:demo/screens/prefab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../colors/custom_palette.dart';
import '../constants.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              //to do push setting screen
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const UserCoursesScreen(),
              //   ),
              // );
            },
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        //leadingWidth: 25,
        backgroundColor: CustomPalette.lighterPrimaryColor,
        title: const Text("Profile"),
      ),
      backgroundColor: CustomPalette.primaryColor,
      body: FutureBuilder(
          //future: supabase.from('profiles').select('*').execute(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const Center(
        //       child: Text(
        //     'Please wait its loading...',
        //     style: TextStyle(color: Colors.white),
        //   ));
        // } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: CustomPalette.lighterPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(children: [
                      ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(50), // Image radius
                          child: Image.asset(
                            "assets/images/background.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Prefab.hPadding20,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Your username",
                              style: TextStyle(
                                  color: Colors.grey.shade500, fontSize: 14)),
                          Prefab.vPadding5,
                          const Text("Username",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                          Prefab.vPadding5,
                          Text("Words learned",
                              style: TextStyle(
                                  color: Colors.grey.shade500, fontSize: 14)),
                          Prefab.vPadding5,
                          const Text("3",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                        ],
                      ),
                      Prefab.hPadding30,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Experience Points",
                              style: TextStyle(
                                  color: Colors.grey.shade500, fontSize: 14)),
                          Prefab.vPadding5,
                          const Text("1957",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                          Prefab.vPadding5,
                          Text("Longest streak",
                              style: TextStyle(
                                  color: Colors.grey.shade500, fontSize: 14)),
                          Prefab.vPadding5,
                          const Text("0",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                        ],
                      ),
                    ]),
                    Prefab.vPadding25,
                    Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              "assets/images/shield.jpg",
                              height: 90,
                              width: 100,
                            ),
                            const Text("3",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 40))
                          ],
                        ),
                        Prefab.hPadding35,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              height: 5,
                              child: LinearProgressIndicator(
                                value: 0.95,
                                color: Colors.orange.shade600,
                              ),
                            ),
                            Prefab.vPadding10,
                            const Text("+43 point to rank 4",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Row(
                children: const [
                  Text(
                    "Leaderboard this week               ",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Spacer(),
                  Icon(Icons.more_vert, color: Colors.white)
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    color: Colors.blueGrey.shade700,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 15, 15, 15),
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            const Text(
                              "1.",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            Prefab.hPadding15,
                            ClipOval(
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(22), // Image radius
                                child: Image.asset(
                                  "assets/images/background.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Prefab.hPadding15,
                            const Text(
                              "Username",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            const Spacer(),
                            const Text(
                              "1957",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      }
          //}
          ),
    );
  }
}
