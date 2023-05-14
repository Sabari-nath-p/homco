import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:homco/screen/estimation/estimationPage.dart';
import 'package:homco/screen/splash/itemCard.dart';
import 'package:homco/screen/splash/loginDetails.dart';

List Categories = [
  "Mother Tincture",
  "Oil",
  "Oinment",
  "Syrup",
  "Dilution",
  "Tituration",
  "Bio Chemic",
  "Globule"
];

class splashMain extends StatefulWidget {
  const splashMain({super.key});

  @override
  State<splashMain> createState() => _splashMainState();
}

class _splashMainState extends State<splashMain> {
  @override
  Widget build(BuildContext context) {
    double ratio =
        MediaQuery.of(context).size.width / MediaQuery.of(context).size.width;
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Image.asset(
                  "assets/image/splash_main.png",
                  fit: BoxFit.fill,
                )),
            Positioned(
                left: 110,
                top: 350,
                child: Column(
                  children: [
                    for (var v in Categories)
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => estimationPage(value: v)));
                        },
                        child: Container(
                          width: 250,
                          height: 35,
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 35,
                                  height: 35,
                                  child:
                                      Image.asset("assets/image/medicine.png")),
                              Text(
                                v,
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(.7)),
                              ),
                            ],
                          ),
                        ),
                      )
                  ],
                )),
            Positioned(
              right: 125,
              top: 300,
              child: loginDetails(context),
            )
          ],
        ),
      ),
    );
  }
}
