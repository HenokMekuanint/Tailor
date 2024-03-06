import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile/core/routing/route_names.dart';
import 'package:mobile/features/nearest_tailors/data/models/nearest_tailor_detail.dart';
import 'package:mobile/features/order/domain/entities/create_order_entity.dart';
import 'package:mobile/features/order/presentation/bloc/order_bloc.dart';

class ServiceBookPage extends StatefulWidget {
  ServiceBookPage({super.key, required this.tailorDetail});

  NearestTailorDetail tailorDetail;

  @override
  State<ServiceBookPage> createState() => _ServiceBookPageState();
}

class _ServiceBookPageState extends State<ServiceBookPage> {
  String? selectedService;
  int? selectedServiceID;
  Set<String> selectedServices = Set();
  late String? selectedDate;
  DropOffDates? selectedDropOffDate;
  PickupDates? selectedPickUpDate;

  @override
  void initState() {
    super.initState();

    // Set the initial value for selectedDropOffDate
    if (widget.tailorDetail.dropOffDates!.isNotEmpty) {
      selectedDropOffDate = widget.tailorDetail.dropOffDates![0];
    }
    if (widget.tailorDetail.pickupDates!.isNotEmpty) {
      selectedPickUpDate = widget.tailorDetail.pickupDates![0];
    }
  }

  List<String> options = [
    "Jan 20,2023. 10:00PM-11:00AM",
    'feb 21,2023. 7:00PM-8:00AM',
    'mar 21,2023. 7:00PM-8:00AM',
    'Apr 21,2023. 7:00PM-8:00AM'
  ];
  String dropDownValue = "Jan 20,2023. 10:00PM-11:00AM";
  // List<String> intialdates = [dropDownValue];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        elevation: 10,
        centerTitle: true,
        toolbarHeight: 80.h,
        backgroundColor: Color(0xFF000080),
        shadowColor: Colors.white,
        title: Text(
          "Book Appointment",
          style: TextStyle(
              fontFamily: "Roboto-Medium", fontSize: 30.h, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   padding: EdgeInsets.all(10),
            //   child: InkWell(
            //       onTap: () {
            //         context.pop();
            //       },
            //       child: Icon(
            //         Icons.arrow_back,
            //       )),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: 20.0, bottom: 30),
            //   child: Text(
            //     "Book",
            //     style: TextStyle(fontSize: 30.h, fontFamily: "Roboto-Medium"),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 60.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Text(
                    "Service",
                    style:
                        TextStyle(fontFamily: "Roboto-Medium", fontSize: 25.h),
                  ),
                  Text(
                    "Price",
                    style:
                        TextStyle(fontFamily: "Roboto-Medium", fontSize: 25.h),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.tailorDetail.services!
                    .length, // Adjust the number of services as needed
                itemBuilder: (context, index) {
                  final serviceName = widget.tailorDetail.services![index].name;
                  final price = widget.tailorDetail.services![index].price;
                  final serviceId = widget.tailorDetail.services![index].id;
                  return ServiceEntry(
                    serviceName: serviceName,
                    price: price.toString(),
                    isSelected: selectedService == serviceName,
                    onSelectionChanged: () {
                      setState(() {
                        selectedService = serviceName;
                        selectedServiceID = serviceId;
                      });
                    },
                  );
                },
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 30.w, bottom: 20, top: 20),
                child: Text("Drop of Date")),
            Container(
                margin: EdgeInsets.only(left: 30.w, bottom: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Color(0xFFECECEC),
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: DropdownButtonHideUnderline(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: DropdownButton<DropOffDates>(
                      icon: Container(
                        margin: EdgeInsets.only(left: 40.w),
                        child: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          size: 35.r,
                        ),
                      ),
                      value: selectedDropOffDate, // Initially selected value
                      onChanged: (DropOffDates? newValue) {
                        // Handle dropdown value change
                        setState(() {
                          selectedDropOffDate = newValue!;
                        });
                      },
                      items: widget.tailorDetail.dropOffDates!
                          .map<DropdownMenuItem<DropOffDates>>(
                              (DropOffDates date) {
                        return DropdownMenuItem<DropOffDates>(
                          value: date,
                          child: Text(parseDate(date.dropOffDateTime)),
                        );
                      }).toList(),
                    ),
                  ),
                )),
            Container(
                margin: EdgeInsets.only(left: 30.w, bottom: 20, top: 20),
                child: Text("Pick Up date")),
            Container(
              margin: EdgeInsets.only(left: 30.w, bottom: 30),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Color(0xFFECECEC),
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: DropdownButtonHideUnderline(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButton<PickupDates>(
                    icon: Container(
                      margin: EdgeInsets.only(left: 40.w),
                      child: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 35.r,
                      ),
                    ),
                    value: selectedPickUpDate, // Initially selected value
                    onChanged: (PickupDates? newValue) {
                      // Handle dropdown value change
                      setState(() {
                        selectedPickUpDate = newValue!;
                      });
                    },
                    items: widget.tailorDetail.pickupDates!
                        .map<DropdownMenuItem<PickupDates>>((PickupDates date) {
                      return DropdownMenuItem<PickupDates>(
                        value: date,
                        child: Text(parseDate(date.pickUpDateTime)),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 10, left: 20.w, right: 20.w),
                child: BlocConsumer<OrderBloc, OrderState>(
                  listener: (context, state) {
                    if (state is CreateOrderSuccessState) {
                      EasyLoading.showSuccess('Order Created Successfully');
                      context.go('/${AppRouteNames.userMainPage}');
                    } else if (state is OrderFailureState) {
                      EasyLoading.showSuccess(state.failureMessage);
                    }
                  },
                  builder: (context, state) {
                    if (state is OrderLoadingState) {
                      return ElevatedButton(
                        onPressed: () {},
                        child: LoadingAnimationWidget.fourRotatingDots(
                          color: Colors.black,
                          size: 20,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fixedSize: Size(300.w, 70.h),
                          backgroundColor: Color(0xFF000080),
                        ),
                      );
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          final CreateOrderEntity orderEntity =
                              CreateOrderEntity(
                            dropOffDate: parseDateStrings(
                                selectedDropOffDate!.dropOffDateTime),
                            pickUpDate: parseDateStrings(
                                selectedPickUpDate!.pickUpDateTime),
                            serviceId: selectedServiceID!,
                            tailorId: widget.tailorDetail.id,
                          );
                          print(
                              'create order entity: ${orderEntity.tailorId}, ${orderEntity.serviceId},');
                          context.read<OrderBloc>().add(
                                CreateOrderEvent(order: orderEntity),
                              );
                        },
                        child: Text(
                          "Place Order",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.h,
                              fontFamily: "Roboto-Medium"),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fixedSize: Size(300.w, 70.h),
                          backgroundColor: Color(0xFF000080),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static List<DateTime> parseDateStrings(String dateString) {
    List<String> dateStrings = dateString.split(',');
    return dateStrings.map((dateString) => DateTime.parse(dateString)).toList();
  }

  static parseDate(String dateString) {
    List<String> dateParts = dateString.split(',');

    DateTime startDate = DateTime.parse(dateParts[0]);
    DateTime endDate = DateTime.parse(dateParts[1]);

    String formattedDate = DateFormat('MMMM d').format(startDate);
    String formattedStartTime = DateFormat('H:mm').format(startDate);
    String formattedEndTime = DateFormat('H:mm').format(endDate);

    String result = '$formattedDate, $formattedStartTime - $formattedEndTime';
    return result;
  }
}

class ServiceEntry extends StatelessWidget {
  final String serviceName;
  final String price;
  final bool isSelected;
  final VoidCallback onSelectionChanged;

  const ServiceEntry({
    required this.serviceName,
    required this.price,
    required this.isSelected,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectionChanged,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              offset: Offset(1, 0),
              color: Color.fromARGB(255, 224, 221, 221),
              blurRadius: 0.5,
              spreadRadius: 0.5,
            ),
            BoxShadow(
              offset: Offset(0, 1),
              color: Color.fromARGB(255, 224, 221, 221),
              blurRadius: 0.5,
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Radio<bool>(
                value: isSelected,
                groupValue: true,
                onChanged: (bool? value) {
                  onSelectionChanged();
                },
              ),
              Text(serviceName),
              Text(price),
            ],
          ),
        ),
      ),
    );
  }
}
