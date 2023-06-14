import 'package:flutter/material.dart';
import 'package:thoughts/widget/widgets.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffC8C7B3),
      body: Column(
        children: [
          SizedBox(
            height: screenSize.height * 0.08,
          ),
          Header(),
          SizedBox(
            height: screenSize.height * 0.018,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                  ),
                ),
              ),
              const Text(
                'Salons Ouverts',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                Salon(),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                Salon(),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                Salon(),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                Salon(),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
