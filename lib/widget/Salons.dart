import 'dart:async';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

const appId = '<>';
const token = '<>';
const channel = 'voice';

class Salon extends StatefulWidget {
  @override
  SalonState createState() => SalonState();
}

class SalonState extends State<Salon> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  late double _modalHeight;
  bool hasEntered = false;

  Future<void> initAgora() async {
    await [Permission.microphone].request();
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    await _engine.disableVideo();

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableAudio();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: token,
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: GestureDetector(
        onTap: () {
          _modalHeight =
              MediaQuery.of(context).size.height * 0.5; // Initial height
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setModalState) {
                    return Container(
                      height:
                          !hasEntered ? _modalHeight : screenSize.height * 0.85,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: !hasEntered
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 15),
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Icon(Icons.close)),
                                    ),
                                    const Spacer(),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 20, right: 15),
                                      child: Icon(Icons.file_upload_outlined),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'LIVE .',
                                        style: TextStyle(
                                          color: Colors.green[700],
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text('50 participants')
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.01,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    'Football & Tchintchins',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.01,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            height: 80,
                                            width: 80,
                                            decoration: const BoxDecoration(
                                              color: Colors.grey,
                                              shape: BoxShape.circle,
                                              // Border width
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: screenSize.height * 0.01),
                                            child: const Text(
                                              'Participant 0',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: screenSize.width * 0.04,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            height: 80,
                                            width: 80,
                                            decoration: const BoxDecoration(
                                              color: Colors.grey,
                                              shape: BoxShape.circle,
                                              // Border width
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: screenSize.height * 0.01),
                                            child: const Text(
                                              'Participant 1',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.04,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Container(
                                    height: screenSize.height * 0.05,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 0.5),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '48 autres participants',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.02,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: GestureDetector(
                                    onTap: () {
                                      setModalState(() {
                                        _modalHeight =
                                            MediaQuery.of(context).size.height *
                                                0.85; // New height
                                      });
                                      setState(() {
                                        hasEntered = !hasEntered;
                                      });
                                      initAgora();
                                      if (hasEntered) {
                                        AgoraVideoView(
                                          controller:
                                              VideoViewController.remote(
                                            rtcEngine: _engine,
                                            canvas:
                                                VideoCanvas(uid: _remoteUid),
                                            connection: const RtcConnection(
                                                channelId: channel),
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      height: screenSize.height * 0.07,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 0.5),
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color(0xffC8C7B3),
                                      ),
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Entrer Dans le Salon',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, top: 15, right: 12),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Football & Tchintchins',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            hasEntered = !hasEntered;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 8, left: 12, right: 12),
                                  child: Text(
                                      'En vrai Messi est fort que Cristiano'),
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.015,
                                ),
                                GridParticipant(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30, bottom: 20),
                                  child: Container(
                                    width: double.infinity,
                                    height: screenSize.height * 0.07,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(),
                                      color: const Color(0xffC8C7B3),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Demander le micro',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    hasEntered = !hasEntered;
                                    _engine.leaveChannel();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 30, bottom: 50),
                                    child: Container(
                                      width: double.infinity,
                                      height: screenSize.height * 0.07,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Quitter le salon',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                    );
                  },
                );
              });
        },
        child: Container(
          height: screenSize.height * 0.25,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xfffcfcfa),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Football & Tchintchins',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '30 Mins',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                child: Divider(),
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenSize.width * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
                                height: screenSize.height * 0.041,
                                width: screenSize.width * 0.091,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Container(
                              height: screenSize.height * 0.041,
                              width: screenSize.width * 0.091,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              height: screenSize.height * 0.041,
                              width: screenSize.width * 0.091,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              height: screenSize.height * 0.041,
                              width: screenSize.width * 0.091,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenSize.height * 0.008,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              ' +50 ',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Michael Kouadio',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Optional: You can use a SizedBox for some spacing between the text and the icon.
                          SizedBox(width: 8),
                          Icon(
                            Icons.mic, // Microphone icon
                            color: Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      const Text(
                        'Eva Assemian',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Junior Coulibaly',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Optional: You can use a SizedBox for some spacing between the text and the icon.
                          SizedBox(width: 8),
                          Icon(
                            Icons.mic, // Microphone icon
                            color: Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      const Text(
                        'Ali Dramera',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GridParticipant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0, // Horizontal spacing
          mainAxisSpacing: 8.0, // Vertical spacing
          childAspectRatio:
              1.0, // Square items (use different value if you want different proportions)
          children: buildRoundItems(
              context, 7, [true, false, true, false, true, true, false]),
        ),
      ),
    );
  }

  List<Widget> buildRoundItems(
      BuildContext context, int count, List<bool> hasGreenBorder) {
    List<Widget> items = [];
    for (int i = 0; i < count; i++) {
      items.add(
        Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return ParticipantLiveDetails(
                          name: "participant $i",
                          followers: '1500',
                          followings: '100',
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: hasGreenBorder[i]
                            ? Colors.green
                            : Colors.transparent, // Conditional border color
                        width: 3.0, // Border width
                      ),
                    ),
                  ),
                ),
                if (hasGreenBorder[i])
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.mic,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
              ],
            ),
            Text(
              "Participant $i", // You can replace this with actual user names from a list
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      );
    }
    return items;
  }
}

class ParticipantLiveDetails extends StatelessWidget {
  String? name;
  String? picture;
  String? followers;
  String? followings;

  ParticipantLiveDetails(
      {super.key, this.name, this.picture, this.followers, this.followings});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height * 0.41,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 15),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenSize.height * 0.01),
                      child: Text(
                        name!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 30),
                child: Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      'Suivre',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: screenSize.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Text(
                  followers!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ), // numbers of followers
                SizedBox(
                  width: screenSize.width * 0.01,
                ),
                const Text(
                  'Abonnes',
                  style: TextStyle(fontWeight: FontWeight.w200),
                ),
                SizedBox(
                  width: screenSize.width * 0.02,
                ),
                Text(
                  followings!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ), // number of following
                SizedBox(
                  width: screenSize.width * 0.01,
                ),
                const Text(
                  'Abonnemenents',
                  style: TextStyle(fontWeight: FontWeight.w200),
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.04,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Container(
                child: Text('Have fun, make mistake but dont foget to live')),
          )
        ],
      ),
    );
  }
}
