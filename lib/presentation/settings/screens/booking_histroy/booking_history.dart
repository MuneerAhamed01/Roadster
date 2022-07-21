
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_ster/application/booking_history/bookinghistory_bloc.dart';
import 'package:road_ster/domain/core/list_for_carousel.dart';
import 'package:road_ster/domain/core/widgets/border_radius.dart';
import 'package:road_ster/domain/core/widgets/text_car.dart';
import '../../../../application/get_single_car/getsinglecarbid_cubit.dart';
import '../../../../domain/core/colors.dart';
import '../../../../domain/core/sizedboxes.dart';
import '../../../../domain/models/booking_history.dart';

class BookingHistory extends StatelessWidget {
  const BookingHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 1000),
      length: 3,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                BookinghistoryBloc()..add(GetBookingHistoryEvent()),
          ),
          BlocProvider(
            create: (context) => GetsinglecarbidCubit(),
          ),
        ],
        child: Scaffold(
          appBar: _appbarBookingHistory(),
          body: BlocBuilder<BookinghistoryBloc, BookinghistoryState>(
            builder: (context, state) {
              return TabBarView(
                children: [
                  _pageOne(stateValue: state, indexOf: 1),
                  _pageTwo(indexOf: 2, state: state),
                  _pageThree(indexOf: 3, state: state)
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _pageOne({required int indexOf, required stateValue}) {
    // log("${stateValue.runtimeType}");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          h20,
          // if(stateValue is BookinghistoryOnDone )
          Visibility(
            visible: stateValue is BookinghistoryOnDone,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ListViewBuilderForBookingHistroy(
              images: stateValue is BookinghistoryOnDone? stateValue.upcomingImage:[],
              list: stateValue is BookinghistoryOnDone
                  ? stateValue.upcoming!
                  : [],
              indexOf: indexOf,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pageTwo({required int indexOf, required dynamic state}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          h20,
          Visibility(
            visible: state is BookinghistoryOnDone,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ListViewBuilderForBookingHistroy(
              images: state is BookinghistoryOnDone? state.completedImage:[],
              list: state is BookinghistoryOnDone ? state.completed! : [],
              indexOf: indexOf,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pageThree({required int indexOf, required dynamic state}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          h20,
          Visibility(
            visible: state is BookinghistoryOnDone,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ListViewBuilderForBookingHistroy(
              images: state is BookinghistoryOnDone? state.cancelledImage:[],
              list: state is BookinghistoryOnDone ? state.cancelled! : [],
              indexOf: indexOf,
            ),
          ),
        ],
      ),
    );
  }

  AppBar _appbarBookingHistory() {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      title: Text(
        "Booking History",
        style: GoogleFonts.openSans(
            color: textColorBrown, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      bottom: const TabBar(
        tabs: [
          Tab(
            text: "Upcoming",
          ),
          Tab(
            text: "Completed",
          ),
          Tab(
            text: "Cancelled",
          ),
        ],
        // indicator:
        //     BoxDecoration(color: Colors.yellow[50], borderRadius: r10),
      ),
    );
  }
}

class ListViewBuilderForBookingHistroy extends StatelessWidget {
  const ListViewBuilderForBookingHistroy({
    Key? key,
    required this.list,
    required this.indexOf, required this.images,
  }) : super(key: key);
  final List<BookingDatum> list;
  final List<String> images;
  final int indexOf;

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return const Center(
        child: Text("No data available"),
      );
    } else {
      return ListView.separated(
          shrinkWrap: true,
          controller: ScrollController(),
          itemBuilder: (context, index) {
        
            return ListOfBookHistory(
              image: image[index],
              list: list[index],
              indexTab: indexOf,
            );
          },
          separatorBuilder: (context, index) => h10,
          itemCount: list.length);
    }
  }
}

class ListOfBookHistory extends StatelessWidget {
  const ListOfBookHistory({
    Key? key,
    required this.indexTab,
    required this.list,
    required this.image,
  }) : super(key: key);
  final int indexTab;
  final BookingDatum list;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: r10,
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            // color: Colors.amber,
            height: 200.h,
            width: 180.w,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(image),
            )),
            // child: state is GetsinglecarbidOnGet
            //     ? CircularProgressIndicator()
            //     : null,
          ),
          w20,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextForCarName(
                  carBrand: list.carname,
                  carModel: "",
                  width: 100.w,
                  fontsize: 19.sp),
              Text(
                "${list.startDate} To ${list.endDate}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
              Text(
                "\$${list.payedAmount}",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp),
              ),
              Container(
                width: 120.w,
                height: 35.h,
                // color: Colors.black,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: indexTab == 2 ? Colors.green : Colors.red),
                    borderRadius: r10),
                child: MaterialButton(
                  onPressed: () {},
                  child: Text(indexTab == 1
                      ? "Cancel"
                      : indexTab == 2
                          ? "Completed"
                          : "Cancelled"),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
