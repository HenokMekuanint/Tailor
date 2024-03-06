import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile/core/routing/route_names.dart';
import 'package:mobile/features/tailor_service/domain/entities/service_entity.dart';
import 'package:mobile/features/tailor_service/presentation/bloc/service_bloc.dart';
import 'package:mobile/features/tailor_service/presentation/widgets/tailor_service_card.dart';

class TailorServicePage extends StatefulWidget {
  const TailorServicePage({super.key});

  @override
  State<TailorServicePage> createState() => _TailorServicePageState();
}

class _TailorServicePageState extends State<TailorServicePage> {
  void initState() {
    BlocProvider.of<ServiceBloc>(context).add(GetServicesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        toolbarHeight: 80.h,
        backgroundColor: Color(0xFF000080),
        shadowColor: Colors.white,
        title: Text(
          "Services",
          style: TextStyle(
              fontFamily: "Roboto-Medium", fontSize: 30.h, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 50.h),
        child: CustomScrollView(
          slivers: [
            // SliverAppBar(
            //   primary: true,
            //   pinned: true,
            //   expandedHeight: 80,
            //   collapsedHeight: 80,
            //   flexibleSpace: FlexibleSpaceBar(
            //     background: Padding(
            //       padding: EdgeInsets.only(top: 50.h, left: 20.w, bottom: 20.h),
            //       child: const Text(
            //         "Services",
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 20,
            //           fontFamily: 'Poppins',
            //           fontWeight: FontWeight.w700,
            //           height: 0,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            BlocConsumer<ServiceBloc, ServiceState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is GetServicesSuccessState) {
                  final servicesByCategory =
                      groupServicesByCategory(state.services);
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: servicesByCategory.keys.length,
                      (context, index) {
                        final category =
                            servicesByCategory.keys.toList()[index];
                        final services = servicesByCategory[category]!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: 15.w,
                                top: 20.h,
                                bottom: 20.h,
                              ),
                              child: Text(
                                category,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 128),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            GridView.count(
                              // physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              children: List.generate(
                                services.length,
                                (index) {
                                  return InkWell(
                                    onTap: () {
                                      context.go(
                                          '/${AppRouteNames.tailorServiceDetailPage}',
                                          extra: services[index]);
                                    },
                                    child: TailorServiceCard(
                                        service: services[index]),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                } else if (state is ServiceLoadingState) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 300.h),
                      child: Center(
                        child: LoadingAnimationWidget.fourRotatingDots(
                          color: const Color.fromARGB(255, 12, 36, 193),
                          size: 50,
                        ),
                      ),
                    ),
                  );
                } else if (state is ServiceFailureState) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 300.h, left: 40.w, right: 40.w),
                      child: Center(
                        child: Text(state.failureMessage),
                      ),
                    ),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: Container(),
                  );
                }
              },
            ),
            SliverToBoxAdapter(child: BlocBuilder<ServiceBloc, ServiceState>(
              builder: (context, state) {
                if (state is ServiceLoadingState) {
                  return Container();
                } else {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 40.h),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          context.go('/${AppRouteNames.tailorAddServicePage}');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fixedSize: Size(300.w, 70.h),
                          backgroundColor: const Color(0xFF000080),
                        ),
                        child: Text(
                          "Add Service",
                          style: TextStyle(
                            fontSize: 25.h,
                            color: Colors.white,
                            fontFamily: "Roboto-Medium",
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            )),
          ],
        ),
      ),
    );
  }

  Map<String, List<ServiceEntity>> groupServicesByCategory(
      List<ServiceEntity> services) {
    // Group services by category
    return services.fold(
      {},
      (Map<String, List<ServiceEntity>> grouped, ServiceEntity service) {
        final category = service.catagoryName;
        if (!grouped.containsKey(category)) {
          grouped[category!] = [];
        }
        grouped[category]!.add(service);
        return grouped;
      },
    );
  }
}
