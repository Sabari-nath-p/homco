import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:homco/screen/estimation/estimationPage.dart';
import 'package:homco/screen/splash/itemCard.dart';
import 'package:homco/screen/splash/loginDetails.dart';

class splashMain extends StatefulWidget {
  const splashMain({super.key});

  @override
  State<splashMain> createState() => _splashMainState();
}

class _splashMainState extends State<splashMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(left: 60, top: 60, child: loginDetails()),
            Positioned(
                right: 60,
                top: 60,
                left: 550,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (int i = 0; i < 7; i++)
                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => estimationPage())));
                          },
                          child: item())
                  ],
                )),
            Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                height: 200,
                child: Image.network(
                  'https://homcokerala.com/imgs/homco-logo.jpg',
                  fit: BoxFit.fill,
                ))
          ],
        ),
      ),
    );
  }
}
