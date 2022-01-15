import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shop_app/data/shared_prefs.dart';
import 'package:shop_app/presentation/components/page_view_item.dart';
import 'package:shop_app/presentation/models/page_boarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'login_screen.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController pageControl = PageController();
  late Timer timer;
  int currentpage = 0;
  bool isLastPage = false;
  List<PageModel> pagesList = [
    PageModel(imgPath: 'assets/images/shopping1.PNG', title: 'on boarding 1'),
    PageModel(imgPath: 'assets/images/shopping2.PNG', title: 'on boarding 2'),
    PageModel(imgPath: 'assets/images/shopping3.PNG', title: 'on boarding 3'),
  ];

  @override
  void initState() {
    super.initState();
    bool end = false;
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentpage == 0) {
        end = false;
      }
      if (currentpage == (pagesList.length - 1)) {
        end = true;
      }
      if (currentpage < pagesList.length && end == false) {
        currentpage++;
        pageControl.animateToPage(currentpage,
            duration: const Duration(milliseconds: 750),
            curve: Curves.easeInOutQuart);
      }

      if (end == true) {
        currentpage--;
        pageControl.animateToPage(currentpage,
            duration: const Duration(milliseconds: 750),
            curve: Curves.easeInOutQuart);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  //on click skip or login will save in sharedprefs to not open this screen again
  void onSubmit() {
    SharedPrefHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value == true) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: onSubmit,
            child: const Text('Skip'),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: pageControl,
                onPageChanged: (int index) {
                  if (index == pagesList.length - 1) {
                    setState(() {
                      isLastPage = true;
                    });
                  } else {
                    setState(() {
                      isLastPage = false;
                    });
                  }
                },
                itemBuilder: (context, index) => PageViewItem(
                  pageInfo: pagesList[index],
                ),
                itemCount: pagesList.length,
              ),
            ),
            const SizedBox(height: 25),
            SmoothPageIndicator(
              controller: pageControl,
              count: pagesList.length,
              effect: const ExpandingDotsEffect(
                dotColor: Colors.grey,
                dotWidth: 10,
                dotHeight: 10,
              ),
            ),
            const SizedBox(height: 100),
            InkWell(
              onTap: () {
                if (isLastPage) {
                  onSubmit();
                } else {
                  pageControl.nextPage(
                      duration: const Duration(milliseconds: 750),
                      curve: Curves.easeInOutQuart);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blueAccent),
                child: isLastPage
                    ? const Text(
                        'start',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
              ),
            ),
            const SizedBox(height: 35)
          ],
        ),
      ),
    );
  }
}
