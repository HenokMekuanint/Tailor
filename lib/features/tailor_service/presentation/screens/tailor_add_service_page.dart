// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile/core/routing/route_names.dart';
import 'package:mobile/features/categories/domain/entities/category_entity.dart';
import 'package:mobile/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:mobile/features/tailor_service/domain/entities/service_entity.dart';
import 'package:mobile/features/tailor_service/presentation/bloc/service_bloc.dart';

class TailorAddService extends StatefulWidget {
  const TailorAddService({super.key});

  @override
  State<TailorAddService> createState() => _TailorAddServiceState();
}

class _TailorAddServiceState extends State<TailorAddService> {
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<String> options = [
    "Category 1",
    'Category 2',
    'Category 3',
    'Category 4'
  ];

  List<String> currencies = [
    "USD",
    "GBP",
  ];

  String selectedCurrency = "GBP";
  int? selectedCatId;
  String? selectedName;

  @override
  void initState() {
    BlocProvider.of<CategoriesBloc>(context).add(const GetCategoriesEvent());
    super.initState();
  }

  handleAddService() {
    final String name = _serviceNameController.text;
    final double price = double.parse(_priceController.text);
    final String description = _descriptionController.text;

    final ServiceEntity service = ServiceEntity(
      categoryId: selectedCatId!,
      price: price,
      name: name,
      description: description,
    );

    BlocProvider.of<ServiceBloc>(context).add(
      CreateServiceEvent(service: service),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/${AppRouteNames.tailorHome}');
          },
          icon: const Icon(
            Icons.keyboard_arrow_left_outlined,
            color: Colors.white,
          ),
        ),
        elevation: 10,
        centerTitle: true,
        toolbarHeight: 80.h,
        backgroundColor: Color(0xFF000080),
        shadowColor: Colors.white,
        title: Text(
          "Add Service",
          style: TextStyle(
              fontFamily: "Roboto-Medium", fontSize: 30.h, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     IconButton(
            //       onPressed: () {
            //         context.go('/${AppRouteNames.tailorHome}');
            //       },
            //       icon: const Icon(Icons.keyboard_arrow_left_outlined),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(
            //         left: 20.0,
            //         top: 30,
            //         bottom: 30,
            //       ),
            //       child: Text(
            //         "Add Service",
            //         style: TextStyle(
            //           fontSize: 30.h,
            //           fontFamily: "Roboto-Medium",
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Container(
              margin: EdgeInsets.only(
                top: 60.h,
                bottom: 20.h,
                left: 30.w,
              ),
              child: Text(
                "Service Name",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: 'Roboto-Regular',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 30.h,
                left: 30.w,
              ),
              width: 320.w,
              height: 80.h,
              padding: const EdgeInsets.only(
                left: 20,
                top: 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFECECEC),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                controller: _serviceNameController,
                style: TextStyle(fontSize: 20.h),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "",
                  hintStyle: TextStyle(fontSize: 20.h),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10.h,
                bottom: 20.h,
                left: 30.w,
              ),
              child: Text(
                "Price",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: 'Roboto-Regular',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 30.h,
                left: 30.w,
              ),
              width: 320.w,
              height: 80.h,
              padding: const EdgeInsets.only(
                left: 20,
                top: 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFECECEC),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                controller: _priceController,
                style: TextStyle(fontSize: 20.h),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: Container(
                        margin: EdgeInsets.only(left: 10.w),
                        child: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          size: 35.r,
                        ),
                      ),
                      value: selectedCurrency, // Initially selected value
                      onChanged: (String? newValue) {
                        // Handle dropdown value change
                        setState(
                          () {
                            selectedCurrency = newValue ?? "GBP";

                            print('Selected currency: $selectedCurrency');
                          },
                        );
                      },
                      items: currencies.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                                value), // Display only the name of the currency
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  hintText: "",
                  hintStyle: TextStyle(fontSize: 20.h),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10.h,
                bottom: 20.h,
                left: 30.w,
              ),
              child: Text(
                "Category",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: 'Roboto-Regular',
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                left: 30.w,
                bottom: 10,
                right: 30.w,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: const Color(0xFFECECEC),
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: BlocConsumer<CategoriesBloc, CategoriesState>(
                listener: (context, state) {
                  if (state is GetCategoriesErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is GetCategoriesLoadedState) {
                    if (state.categories.isEmpty) {
                      return const Center(
                        child: Text(
                          'No Categories Found',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      );
                    } else {
                      print('Categories Found are ${state.categories}');
                      return DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: DropdownButton<String>(
                            hint: const Text(
                              'Select Category',
                            ),
                            icon: Container(
                              margin: EdgeInsets.only(left: 40.w),
                              child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                size: 35.r,
                              ),
                            ),
                            value: selectedName, // Initially selected value
                            onChanged: (String? newValue) {
                              // Handle dropdown value change
                              setState(
                                () {
                                  selectedName = newValue;
                                  selectedCatId = state.categories
                                      .firstWhere(
                                        (element) =>
                                            element.name == selectedName,
                                      )
                                      .id;
                                  print('Selected name: $selectedName');
                                  print('Selected id: $selectedCatId');
                                },
                              );
                            },
                            items: state.categories
                                .map<DropdownMenuItem<String>>(
                                    (CategoryEntity category) {
                              return DropdownMenuItem<String>(
                                value: category.name,
                                child: Text(
                                    category.name), // Display only the name
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    }
                  } else if (state is GetCategoriesErrorState) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'Loading Categories...',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.h, bottom: 20.h, left: 30.w),
              child: Text(
                "Description",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: 'Roboto-Regular',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30.h, left: 30.w),
              width: 320.w,
              height: 120.h,
              padding: const EdgeInsets.only(left: 20, top: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFECECEC),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                style: TextStyle(fontSize: 20.h, height: 2),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Description",
                  hintStyle: TextStyle(fontSize: 20.h),
                ),
              ),
            ),
            BlocConsumer<ServiceBloc, ServiceState>(
              listener: (context, state) {
                if (state is ServiceSuccessState) {
                  EasyLoading.showSuccess('Service Created Successfully!',
                      duration: const Duration(seconds: 2), dismissOnTap: true);
                } else if (state is ServiceFailureState) {
                  EasyLoading.showError(state.failureMessage,
                      duration: const Duration(seconds: 2), dismissOnTap: true);
                }
              },
              builder: (context, state) {
                if (state is ServiceLoadingState) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 40.h),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fixedSize: Size(300.w, 70.h),
                          backgroundColor: const Color(0xFF000080),
                        ),
                        child: LoadingAnimationWidget.fourRotatingDots(
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  );
                } else if (state is ServiceSuccessState) {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 40.h),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              handleAddService();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fixedSize: Size(300.w, 70.h),
                              backgroundColor: const Color(0xFF000080),
                            ),
                            child: Text(
                              "Add Another Service",
                              style: TextStyle(
                                fontSize: 25.h,
                                color: Colors.white,
                                fontFamily: "Roboto-Medium",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 40.h),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              handleAddService();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fixedSize: Size(300.w, 70.h),
                              backgroundColor: const Color(0xFF000080),
                            ),
                            child: Text(
                              "Add",
                              style: TextStyle(
                                fontSize: 25.h,
                                color: Colors.white,
                                fontFamily: "Roboto-Medium",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
