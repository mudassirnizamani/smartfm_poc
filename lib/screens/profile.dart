import 'package:flutter/material.dart';
import 'package:smartfm_poc/config/routes.dart';
import 'package:smartfm_poc/models/user.dart';
import 'package:smartfm_poc/services/user_service.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: UserService.fetchUser(),
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          } else if (snapshot.hasError) {
            return const Text("Error Occurred");
          } else {
            return Scaffold(
              appBar: AppBar(
                elevation: 13.0,
                actions: <Widget>[
                  IconButton(
                    icon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                    tooltip: 'Search',
                    onPressed: () {},
                  ),
                ],
                title: const Text(
                  "Profile",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.93,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.83,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.1,
                                left: 20,
                                right: 20,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data?.name ?? "",
                                    style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "EDIT",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xffc44536),
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(
                                      top: 10,
                                    ),
                                    child: const Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "Followers",
                                              style: kTitleStyle,
                                            ),
                                            Text(
                                              "Following",
                                              style: kTitleStyle,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "127",
                                              style: kSubtitleStyle,
                                            ),
                                            Text(
                                              "83",
                                              style: kSubtitleStyle,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, Routes.studio);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      alignment: Alignment.center,
                                      elevation: 3,
                                      fixedSize: const Size(400, 50),
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white,
                                    ),
                                    child: const Text("Studio"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, top: 20),
                          child: Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height / 7,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                "assets/images/user.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}

const kTitleStyle = TextStyle(
  fontSize: 20,
  color: Colors.grey,
  fontWeight: FontWeight.w700,
);

const kSubtitleStyle = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.w700,
);
