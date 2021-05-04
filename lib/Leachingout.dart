import 'dart:ui';

import 'package:Soil_Salinity/FarmerHome.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class LeachingOut extends StatefulWidget {
  String ans;
  LeachingOut(this.ans);

  @override
  _LeachingOutState createState() => _LeachingOutState();
}

class _LeachingOutState extends State<LeachingOut> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 180,
              ),
              Text(
                widget.ans,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              widget.ans == "Not Required"
                  ? CircularPercentIndicator(
                      radius: 130.0,
                      lineWidth: 22.0,
                      percent: 1,
                      center: new Text("0%"),
                      progressColor: Colors.white,
                    )
                  : widget.ans == "Lightly Required"
                      ? CircularPercentIndicator(
                          radius: 130.0,
                          lineWidth: 22.0,
                          percent: .25,
                          center: new Text("25%"),
                          progressColor: Colors.green,
                        )
                      : widget.ans == "Medium Required"
                          ? CircularPercentIndicator(
                              radius: 130.0,
                              lineWidth: 22.0,
                              percent: .50,
                              center: new Text("50%"),
                              progressColor: Colors.orange,
                            )
                          : widget.ans == "Heavily Required"
                              ? CircularPercentIndicator(
                                  radius: 130.0,
                                  lineWidth: 22.0,
                                  percent: .75,
                                  center: new Text("75%"),
                                  progressColor: Colors.red[600],
                                )
                              : CircularPercentIndicator(
                                  radius: 130.0,
                                  lineWidth: 22.0,
                                  percent: 1.0,
                                  center: new Text("100%"),
                                  progressColor: Colors.red,
                                ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FarmerHome(),
                            ),
                          ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text(
                          "Auto  ",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () => {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FarmerHome(),
                              ),
                            )
                          },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text(
                          "Manual",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
