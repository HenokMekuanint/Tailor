import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile/core/common_widgets/show_toast_dialog.dart';
import 'package:mobile/core/routing/route.dart';
import 'package:mobile/features/tailor_service/domain/entities/service_entity.dart';
import 'package:mobile/features/tailor_service/presentation/bloc/service_bloc.dart';
import 'package:mobile/features/tailor_service/presentation/screens/tailor_service_page.dart';

class EditServicePage extends StatefulWidget {
  const EditServicePage({super.key, required this.service});

  final ServiceEntity service;

  @override
  State<EditServicePage> createState() => _EditServicePageState();
}

class _EditServicePageState extends State<EditServicePage> {
  late ServiceEntity service;
  late TextEditingController _serviceNameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late int categoryId;
  late int? serviceId;

  void initState() {
    super.initState();
    _descriptionController =
        TextEditingController(text: widget.service.description);
    _serviceNameController = TextEditingController(text: widget.service.name);
    _priceController = TextEditingController(
      text: widget.service.price.toString(),
    );
    categoryId = widget.service.categoryId;
    serviceId = widget.service.id;
  }

  List<String> options = [
    "Category 1",
    'Category 2',
    'Category 3',
    'Category 4'
  ];
  String dropDownValue = "Category 1";
  List<String> currencies = [
    "USD",
    "GBP",
  ];

  String selectedCurrency = "GBP";

  handleEditService() {
    final String name = _serviceNameController.text;
    final double price = double.parse(_priceController.text);
    final String description = _descriptionController.text;

    final ServiceEntity service = ServiceEntity(
      categoryId: categoryId,
      price: price,
      name: name,
      description: description,
      id: serviceId,
    );

    BlocProvider.of<ServiceBloc>(context).add(
      EditServiceEvent(service: service),
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
          "Edit Service",
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
            //         onPressed: () {
            //           context.go('/${AppRouteNames.tailorHome}');
            //         },
            //         icon: const Icon(Icons.keyboard_arrow_left_outlined)),
            //     Padding(
            //       padding:
            //           const EdgeInsets.only(left: 20.0, top: 30, bottom: 30),
            //       child: Text(
            //         "Edit Service",
            //         style: TextStyle(fontSize: 30.h, fontFamily: "Roboto-Medium"),
            //       ),
            //     ),
            //   ],
            // ),
            Container(
              margin: EdgeInsets.only(top: 60.h, bottom: 20.h, left: 30.w),
              child: Text(
                "Service Name",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: 'Roboto-Regular',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30.h, left: 30.w),
              width: 320.w,
              height: 80.h,
              padding: const EdgeInsets.only(left: 20, top: 10),
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
                  fontSize: 20.sp,
                  fontFamily: 'Roboto-Regular',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30.h, left: 30.w),
              width: 320.w,
              height: 80.h,
              padding: const EdgeInsets.only(left: 20, top: 10),
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
                  "Description",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: 'Roboto-Regular',
                  ),
                )),
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
                print('Edit State : $state');
                if (state is ServiceSuccessState) {
                  ShowToastDialog.showToast(
                    "Service Edited Successfully",
                  );

                  Future.delayed(const Duration(seconds: 3), () {
                    context.go('/${AppRouteNames.tailorHome}');
                  });
                } else if (state is ServiceFailureState) {
                  ShowToastDialog.showToast(
                    state.failureMessage,
                  );
                }
              },
              builder: (context, state) {
                if (state is ServiceLoadingState) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 40.h),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // handleAddService();
                        },
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
                } else {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 40.h),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          handleEditService();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fixedSize: Size(300.w, 70.h),
                          backgroundColor: const Color(0xFF000080),
                        ),
                        child: Text(
                          "Edit Service",
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
            ),
          ],
        ),
      ),
    );
  }
}
