import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic.dart/home_cubit/home_cubit.dart';
import 'package:shop_app/business_logic.dart/home_cubit/home_states.dart';

class FavouriteIcon extends StatelessWidget {
  final Color iconColor;
  final int productId;
  final int? favInx;
  const FavouriteIcon({
    Key? key,
    required this.iconColor,
    required this.productId,
    this.favInx,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeStates>(builder: (context, state) {
      return InkWell(
        onTap: () {
          if (favInx != null) HomeBloc.get(context).removeFav(favInx);
          HomeBloc.get(context).changeFavoutire(productId);
        },
        child: Icon(
          Icons.favorite,
          color: iconColor,
        ),
      );
    });
  }
}
