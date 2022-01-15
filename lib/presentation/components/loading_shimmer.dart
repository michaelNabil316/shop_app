import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myMedia = MediaQuery.of(context).size;
    return SizedBox(
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey[300]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Center(child: customContainer(myMedia.width * 0.9, 250)),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(left: 20),
              height: 125,
              child: ListView.separated(
                itemBuilder: (context, index) => Container(
                  width: 120,
                  height: 120,
                  color: Colors.white,
                  child: const SizedBox(),
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 15),
                itemCount: 5,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customContainer(myMedia.width * 0.35, 200),
                customContainer(myMedia.width * 0.35, 200),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget customContainer(double width, double height) {
  return Container(
    width: width,
    height: height,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(25)),
      color: Colors.white,
    ),
    child: const SizedBox(),
  );
}
