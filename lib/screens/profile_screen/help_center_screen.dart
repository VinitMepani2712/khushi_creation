import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../model/expansion_tile_data_list_model.dart';

class HelpCenterScreen extends StatefulWidget {
  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen>
    with SingleTickerProviderStateMixin {
  List<bool> _isOpen = List<bool>.generate(7, (index) => false);
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    Brightness brightness =
        Theme.of(context).brightness; // Determine brightness

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 20.h),
            _buildAppBar(context, brightness),
            SizedBox(height: 20.h),
            _buildSearchBar(brightness),
            TabBar(
              indicatorColor: brightness == Brightness.dark
                  ? Colors.white
                  : Color(0xff704F38),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: brightness == Brightness.dark
                  ? Colors.white
                  : Color(0xff704F38),
              indicatorPadding: EdgeInsets.only(left: 10.w, right: 10.w),
              tabs: [
                Tab(text: 'FAQ'),
                Tab(text: 'Contact Us'),
              ],
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: TabBarView(
                children: [
                  _buildFAQTab(brightness),
                  _buildContactUsTab(brightness),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, Brightness brightness) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.0.w, top: 40.0.h, right: 20.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : Color(0xffE6E6E6),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: CircleAvatar(
                    minRadius: 20,
                    maxRadius: 20,
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.arrow_back,
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 50.w),
              Text(
                "Help Center",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(Brightness brightness) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Color(0xffDEDEDE),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Color(0xffDEDEDE),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Color(0xffDEDEDE),
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Color(0xffDEDEDE),
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Color(0xffDEDEDE),
                  ),
                ),
                prefixIcon: CircleAvatar(
                  minRadius: 25,
                  maxRadius: 25,
                  backgroundColor: Colors.transparent,
                  child: SvgPicture.asset("assets/svg/search-normal-1.svg",
                      colorFilter: ColorFilter.mode(
                          brightness == Brightness.dark
                              ? Colors.white
                              : Color(0xFF74523A),
                          BlendMode.srcIn)),
                ),
                hintText: 'Search',
                hintStyle: TextStyle(
                    color: brightness == Brightness.dark
                        ? Colors.white
                        : Color.fromARGB(255, 199, 199, 199)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQTab(Brightness brightness) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 20),
      itemCount: expansionTileDataListFAQModel.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Color.fromARGB(255, 218, 214, 214),
                width: 2,
              ),
            ),
            child: ExpansionTile(
              iconColor: Color(0xff704F38),
              collapsedBackgroundColor: brightness == Brightness.light
                  ? Colors.white
                  : Color.fromARGB(255, 0, 0, 0),
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              title: Text(
                expansionTileDataListFAQModel[index].title,
              ),
              backgroundColor: brightness == Brightness.light
                  ? Color.fromARGB(255, 255, 255, 255)
                  : Color.fromARGB(255, 0, 0, 0),
              children: [
                Divider(
                  color: Color.fromARGB(255, 224, 219, 224),
                  indent: 20,
                  endIndent: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Text(
                    expansionTileDataListFAQModel[index].description,
                    style: TextStyle(
                        fontSize: 16,
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ],
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _isOpen[index] = expanded;
                });
              },
              initiallyExpanded: _isOpen[index],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContactUsTab(Brightness brightness) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 20),
      itemCount: expansionTileDataListContactModel.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Color.fromARGB(255, 218, 214, 214),
                width: 2,
              ),
            ),
            child: ExpansionTile(
              iconColor: Color(0xff704F38),
              collapsedBackgroundColor: brightness == Brightness.light
                  ? Colors.white
                  : Color.fromARGB(255, 0, 0, 0),
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              title: Row(
                children: [
                  Icon(
                    expansionTileDataListContactModel[index].icon,
                    color: Color(0xff704F38),
                  ),
                  SizedBox(width: 10.w),
                  Wrap(
                    children: [
                      Text(
                        expansionTileDataListContactModel[index].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: brightness == Brightness.light
                              ? const Color.fromARGB(255, 0, 0, 0)
                              : Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              backgroundColor: brightness == Brightness.light
                  ? Color.fromARGB(255, 255, 255, 255)
                  : Color.fromARGB(255, 0, 0, 0),
              children: [
                Divider(
                  color: Color.fromARGB(255, 224, 219, 224),
                  indent: 20,
                  endIndent: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Text(
                    expansionTileDataListContactModel[index].description,
                    style: TextStyle(
                        fontSize: 16,
                        color: brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ],
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _isOpen[index] = expanded;
                });
              },
              initiallyExpanded: _isOpen[index],
            ),
          ),
        );
      },
    );
  }
}
