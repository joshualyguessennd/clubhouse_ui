import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Salon extends StatefulWidget {
  @override
  SalonState createState() => SalonState();
}

class SalonState extends State<Salon> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
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
    );
  }
}
