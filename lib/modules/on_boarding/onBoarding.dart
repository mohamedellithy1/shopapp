import 'package:flutter/material.dart';
import 'package:shopapp/modules/login/login.dart';
import 'package:shopapp/shared/style/color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<BoardingModel> boarding =[
    BoardingModel(
        image: 'assets/image/onBoarding.png',
        title: 'Online Shopping',),
    BoardingModel(
        image: 'assets/image/onBoarding1.png',
        title: 'Shopping',),
    BoardingModel(
        image: 'assets/image/onBoarding2.png',
        title: 'Shopping App',),
  ];
  var boardController = PageController();
  bool isLast = false;
  int page=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              child:Text('Skip', style: TextStyle(fontSize: 20),) ,
              onPressed:(){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=>LoginScreen()), (Route<dynamic>route)=>false);
              } ,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if( index == boarding.length -1){
                    setState(() {
                      isLast= true;
                    });
                  }
                  else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardController,
                  itemBuilder: (context, index)=>buildBoarding(boarding[index]),
                itemCount: boarding.length,
                physics: BouncingScrollPhysics(),
              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                  effect:  WormEffect(
                      spacing:  8.0,
                      radius:  8.0,
                      dotWidth:  20.0,
                      dotHeight:  18.0,
                      paintStyle:  PaintingStyle.stroke,
                      strokeWidth:  1.5,
                      dotColor:  Colors.grey,
                      activeDotColor:  defaultColor
                  ),
                    controller: boardController,
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast ){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=>LoginScreen()), (Route<dynamic>route)=>false);
                    } else{
                      boardController.nextPage(
                          duration: Duration(milliseconds: 800),
                          curve: Curves.easeInOutQuart);
                    }
                 },
                  child: Icon(Icons.arrow_forward_ios),)
              ],
            )
          ],
        ),
      )
    );
  }

  Widget buildBoarding(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
          child: Image.asset(model.image)),
      Text( model.title , style:
      TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20
      ),
      ),
    ],
  );
}
class BoardingModel{
  final String image;
  final String title;
  BoardingModel({
    @required this.image,
    @required this.title,
  });
}
