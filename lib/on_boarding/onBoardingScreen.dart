import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login/login.dart';
import 'boarding_item.dart' show BoardingItem;

class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,

  });
}
class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
var boardController = PageController();

  List<BoardingModel> boarding =[
    BoardingModel(
      image: 'assets/onboarding1.png',
      title: 'Connect people around the world',
      body: 'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form.',
    ),
    BoardingModel(
      image: 'assets/onboarding2.png',
      title: ' Live your life smarter with us!',
      body: 'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form.',
    ),
    BoardingModel(
      image: 'assets/onboarding3.png',
      title: ' Get a new experience of imagination',
      body: 'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form.',
    ),
  ];
 bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Text('SKIP')
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index){
                  if(index ==boarding.length-1)
                    {
                      setState(() {
                        isLast = true;
                      });
                      print('last page');
                    }else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context,index)=>BoardingItem(model: boarding[index]),
              itemCount: boarding.length,
              ),
            ),
           Row(
             children: [
               SmoothPageIndicator(
                   controller: boardController,
                   effect: ExpandingDotsEffect(
                     dotColor: Colors.grey,
                     dotHeight: 10,
                     dotWidth: 10,
                     expansionFactor: 4,
                     spacing: 5,
                   ),
                   count: boarding.length,
               ),
               Spacer(),
               FloatingActionButton(onPressed: (){
                 if(isLast==true){
                    Navigator.pushReplacement(
                      context,
                         MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                               ),
                                 );
                 }else
                    {
                 boardController.nextPage(
                     duration: Duration(
                       milliseconds: 750
                     ),
                     curve: Curves.fastEaseInToSlowEaseOut);
               }

                },

               child: Icon(Icons.arrow_forward_ios),
               )
             ],
           )
          ],
        ),
      ),
    );
  }

}

