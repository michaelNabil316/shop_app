import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic.dart/home_cubit/home_cubit.dart';
import 'package:shop_app/business_logic.dart/home_cubit/home_states.dart';
import 'package:shop_app/presentation/components/loading_shimmer.dart';

class HomePage extends StatefulWidget {
  final String newtoken;
  const HomePage({Key? key, required this.newtoken}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final homebloc = HomeBloc.get(context);
    return BlocConsumer<HomeBloc, HomeStates>(
      listener: (context, state) {
        if (state is ChangeFavSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.changeModel.message),
            backgroundColor: Colors.grey,
          ));
        }
        if (state is ChangeFavError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            backgroundColor: Colors.amber[300],
          ));
        }
      },
      builder: (context, state) {
        homebloc.changeToken(widget.newtoken);
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: const Text('Michael app'),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child:
                  homebloc.homemodel != null && homebloc.catagoriesModel != null
                      ? homebloc.screens[homebloc.currentIndex]
                      : const Loading(),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: homebloc.bottomNavItems,
            currentIndex: homebloc.currentIndex,
            onTap: (value) => homebloc.changeBtmNavBar(value),
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.blue[200],
          ),
        );
      },
    );
  }
}
