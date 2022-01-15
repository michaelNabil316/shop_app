import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic.dart/home_cubit/home_cubit.dart';
import 'package:shop_app/business_logic.dart/home_cubit/home_states.dart';
import 'package:shop_app/presentation/models/favourites_get_model.dart';
import 'favoutite_icon.dart';

class FavItem extends StatelessWidget {
  final Product favorite;
  final int index;
  const FavItem({Key? key, required this.favorite, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myMedia = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: myMedia.width < 400
                ? myMedia.width * 0.3
                : myMedia.width * 0.25,
            width: myMedia.width < 400
                ? myMedia.width * 0.25
                : myMedia.width * 0.2,
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Stack(
              children: [
                Image(
                  image: NetworkImage(favorite.image!),
                  height: myMedia.width < 400
                      ? myMedia.width * 0.3
                      : myMedia.width * 0.25,
                  width: myMedia.width < 400
                      ? myMedia.width * 0.25
                      : myMedia.width * 0.2,
                ),
                favorite.discount != 0
                    ? Container(
                        width: 40,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          color: Colors.blue[200],
                        ),
                        child: Center(child: Text('${favorite.discount}%')),
                      )
                    : const SizedBox(width: 10),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(myMedia.width < 400 ? 10 : 20),
              child: Column(
                children: [
                  Text(
                    favorite.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    favorite.description!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(myMedia.width < 400 ? 10 : 25),
            child: BlocBuilder<HomeBloc, HomeStates>(builder: (context, state) {
              return HomeBloc.get(context).favourites[favorite.id] ?? false
                  ? FavouriteIcon(
                      iconColor: Colors.redAccent,
                      productId: favorite.id!,
                      favInx: index,
                    )
                  : FavouriteIcon(
                      iconColor: Colors.grey,
                      productId: favorite.id!,
                    );
            }),
          ),
        ],
      ),
    );
  }
}
