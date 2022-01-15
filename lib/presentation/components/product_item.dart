import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic.dart/home_cubit/home_cubit.dart';
import 'package:shop_app/business_logic.dart/home_cubit/home_states.dart';
import 'package:shop_app/presentation/models/home_data_model.dart';

import 'favoutite_icon.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myMedia = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //sale precentage
              product.discount != 0
                  ? Container(
                      width: 50,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        color: Colors.blue[200],
                      ),
                      child: Center(child: Text('${product.discount}%')),
                    )
                  : const SizedBox(width: 10),
              //favourite icon
              BlocBuilder<HomeBloc, HomeStates>(builder: (context, state) {
                return HomeBloc.get(context).favourites[product.id] ?? false
                    ? FavouriteIcon(
                        iconColor: Colors.redAccent,
                        productId: product.id,
                      )
                    : FavouriteIcon(
                        iconColor: Colors.grey,
                        productId: product.id,
                      );
              }),
            ],
          ),
          Image(
            image: NetworkImage(product.image),
            width: myMedia.width * 0.3,
            height: myMedia.width * 0.3,
          ),
          Text(
            product.name,
            maxLines: 2,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            '${product.price}LE',
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
