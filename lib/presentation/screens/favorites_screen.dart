import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic.dart/home_cubit/home_cubit.dart';
import 'package:shop_app/business_logic.dart/home_cubit/home_states.dart';
import 'package:shop_app/presentation/components/favorite_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homebloc = HomeBloc.get(context);
    return BlocBuilder<HomeBloc, HomeStates>(
      builder: (context, state) {
        return homebloc.favoritesGet != null
            ? Column(
                children: [
                  homebloc.favoritesGet!.data!.data!.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(100.0),
                          child: Text('No favorites'),
                        )
                      : const SizedBox(),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => FavItem(
                            index: index,
                            favorite: homebloc
                                .favoritesGet!.data!.data![index].product!,
                          ),
                      // separatorBuilder: (context, index) =>
                      //     const Divider(color: Colors.blue, height: 1),
                      itemCount: homebloc.favoritesGet!.data!.data!.length),
                ],
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
