import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic.dart/home_cubit/home_cubit.dart';
import 'package:shop_app/business_logic.dart/home_cubit/home_states.dart';
import 'package:shop_app/presentation/components/carousel_slider.dart';
import 'package:shop_app/presentation/components/catagories_panners.dart';
import 'package:shop_app/presentation/components/custom_main_txt.dart';
import 'package:shop_app/presentation/components/product_item.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homebloc = HomeBloc.get(context);
    return BlocConsumer<HomeBloc, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCarouselSlider(homemodel: homebloc.homemodel!),
              const CustomLineTxt(txt: '  Catagories'),
              catagoryItem(homebloc.catagoriesModel),
              const CustomLineTxt(txt: '  New '),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.2,
                children: List.generate(
                  homebloc.homemodel!.data.products.length,
                  (index) => ProductItem(
                    product: homebloc.homemodel!.data.products[index],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
