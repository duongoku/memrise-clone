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
  var userId =
      supabase.auth.currentUser?.id ?? "fc6a2f71-9895-4d42-8f3f-682fe79680c9";

  List<Widget> getLeaderBoard(data) {
    List<Widget> users = [];
    int index = 0;
    for (Map user in data) {
      index++;

      Color bgColor = (userId == user["id"])
          ? Colors.blueGrey.shade400
          : Colors.blueGrey.shade700;
      users.add(Container(
        color: bgColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 15, 15, 15),
          child: SizedBox(
            height: 40,
            child: Row(
              children: [
                Text(
                  "$index.",
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
                Prefab.hPadding15,
                ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(22), // Image radius
                    child: Image.asset(
                      "assets/images/${user["avatar_url"]}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Prefab.hPadding15,
                Text(
                  "${user["username"]}",
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
                const Spacer(),
                Text(
                  "${user["experience_point"]}",
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ));
    }

    return users;
  }

  getCurrentUser(users) {
    for (Map user in users) {
      if (user["id"] == userId) return user;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              supabase.auth.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/GettingStarted/', ModalRoute.withName('/'));
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
          future: supabase
              .from("profiles")
              .select()
              .order("experience_point", ascending: false),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            } else {
              var users = snapshot.data;
              var currentUser = getCurrentUser(users);
              num level = currentUser["experience_point"] ~/ 500;
              double levelProgress =
                  currentUser["experience_point"] % 500 / 500;
              num expNeeded = 500 - currentUser["experience_point"] % 500;

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
                                  "assets/images/${currentUser["avatar_url"]}",
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
                                        color: Colors.grey.shade500,
                                        fontSize: 14)),
                                Prefab.vPadding5,
                                Text("${currentUser["username"]}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14)),
                                Prefab.vPadding5,
                                Text("Words learned",
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 14)),
                                Prefab.vPadding5,
                                Text("${currentUser["word_learned"]}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14)),
                              ],
                            ),
                            Prefab.hPadding30,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Experience Points",
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 14)),
                                Prefab.vPadding5,
                                Text("${currentUser["experience_point"]}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14)),
                                Prefab.vPadding5,
                                Text("Longest streak",
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 14)),
                                Prefab.vPadding5,
                                Text("${currentUser["longest_streak"]}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14)),
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
                                  Text("$level",
                                      style: const TextStyle(
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
                                      value: levelProgress,
                                      color: Colors.orange.shade600,
                                    ),
                                  ),
                                  Prefab.vPadding10,
                                  Text("+$expNeeded point to rank 4",
                                      style: const TextStyle(
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
                          "Leaderboard",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Spacer(),
                        // to do maybe? types of leaderboard
                        //Icon(Icons.more_vert, color: Colors.white)
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [...getLeaderBoard(users)],
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}
