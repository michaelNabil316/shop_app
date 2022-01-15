import 'package:flutter/material.dart';

Widget catagoryItem(catagBloc) {
  return SizedBox(
    height: 125,
    child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
              width: 125,
              height: 120,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: Image(
                      image:
                          NetworkImage(catagBloc!.data.dataList[index].image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: Color.fromARGB(120, 0, 0, 0),
                    ),
                    child: Text(
                      catagBloc.data.dataList[index].name,
                      maxLines: 1,
                      style: const TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: catagBloc.data.dataList.length),
  );
}
