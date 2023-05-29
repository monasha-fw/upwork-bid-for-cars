import 'package:auto_route/auto_route.dart';
import 'package:bid_for_cars/core/entities/car_thumbnail.dart';
import 'package:bid_for_cars/core/extensions/dartz.dart';
import 'package:bid_for_cars/injection.dart';
import 'package:bid_for_cars/presentation/common/widgets/ui_blocks/common/car_thumbnail/index.dart';
import 'package:bid_for_cars/presentation/extensions/context.dart';
import 'package:bid_for_cars/presentation/features/home/bloc/home_cubit.dart';
import 'package:bid_for_cars/presentation/features/home/widgets/home_bottom_navigation.dart';
import 'package:bid_for_cars/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _activePage = 0;
  late final TabController _controller;

  @override
  void initState() {
    _controller = TabController(vsync: this, length: 3)..addListener(onTabChange);
    super.initState();
  }

  @override
  void dispose() {
    _controller
      ..removeListener(onTabChange)
      ..dispose();
    super.dispose();
  }

  void onTabChange() {
    final newPage = _controller.index;
    if (_activePage != newPage) setState(() => _activePage = newPage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..init(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: context.theme.colorScheme.background,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.transparent,
              titleSpacing: 0.0,
              centerTitle: true,
              toolbarHeight: kToolbarHeight + 20,
              title: Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: context.theme.colorScheme.background,
                    ),
                    child: TabBar(
                      controller: _controller,
                      labelColor: Colors.white,
                      unselectedLabelColor: AppColors.kTextSecondary,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: context.theme.colorScheme.primary,
                      ),
                      tabs: const [
                        Tab(text: 'All Cars'),
                        Tab(text: 'Live'),
                        Tab(text: 'Expired'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: TabBarView(
                controller: _controller,
                // physics: const NeverScrollableScrollPhysics(),
                children: [
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state.processingAllCars) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final List<CarThumbnail> cars =
                          state.allCars.isSome() && state.allCars.asSome().isRight()
                              ? state.allCars.asSome().asRight()
                              : [];
                      return ListView.builder(
                        itemCount: cars.length,
                        itemBuilder: (BuildContext context, int index) {
                          final car = cars[index];
                          return CarThumbnailItem(key: Key(car.id), car);
                        },
                      );
                    },
                  ),

                  /// live
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state.processingLiveCars) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final List<CarThumbnail> cars =
                          state.liveCars.isSome() && state.liveCars.asSome().isRight()
                              ? state.liveCars.asSome().asRight()
                              : [];
                      return ListView.builder(
                        itemCount: cars.length,
                        itemBuilder: (BuildContext context, int index) {
                          final car = cars[index];
                          return CarThumbnailItem(key: Key(car.id), car);
                        },
                      );
                    },
                  ),

                  /// expired
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state.processingExpiredCars) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final List<CarThumbnail> cars =
                          state.expiredCars.isSome() && state.expiredCars.asSome().isRight()
                              ? state.expiredCars.asSome().asRight()
                              : [];

                      return ListView.builder(
                        itemCount: cars.length,
                        itemBuilder: (BuildContext context, int index) {
                          final car = cars[index];
                          return CarThumbnailItem(key: Key(car.id), car);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            bottomNavigationBar: HomeBottomNavigation(
              activePage: _activePage,
              onTap: (p) => setState(() => _controller.animateTo(p)),
            ),
          );
        },
      ),
    );
  }
}
