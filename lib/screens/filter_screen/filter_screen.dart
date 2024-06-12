import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String selectedBrand = 'All';
  String selectedGender = 'All';
  String selectedSort = 'Popular';
  RangeValues priceRange = RangeValues(2, 150);
  double selectedRating = 4.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAppBar(context),
                  SizedBox(height: 10.h),
                  _buildFilterSection(
                    'Brands',
                    ['All', 'Nike', 'Adidas', 'Puma'],
                    selectedBrand,
                    (value) => setState(() => selectedBrand = value),
                  ),
                  _buildFilterSection(
                    'Gender',
                    ['All', 'Men', 'Women'],
                    selectedGender,
                    (value) => setState(() => selectedGender = value),
                  ),
                  _buildFilterSection(
                    'Sort by',
                    ['Most Recent', 'Popular', 'Price High'],
                    selectedSort,
                    (value) => setState(() => selectedSort = value),
                  ),
                  Text('Pricing Range',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  RangeSlider(
                    values: priceRange,
                    min: 2,
                    max: 150,
                    divisions: 20,
                    labels: RangeLabels(
                      '\u{20B9}${priceRange.start.round()}',
                      '\u{20B9}${priceRange.end.round()}',
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        priceRange = values;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text('Reviews',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  _buildRatingSection(),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(198, 235, 230, 230),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _resetFilters,
                    child: Text(
                      'Reset Filter',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.brown
                            : const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Colors.transparent,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Apply',
                      style: TextStyle(color: Colors.white),
                    ),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
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
                      color: Color(0xffE6E6E6),
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
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 50.w),
              Text(
                "Filter",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterSection(String title, List<String> options,
      String selectedValue, Function(String) onSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: options.map((option) {
              bool isSelected = option == selectedValue;
              return Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: ChoiceChip(
                  showCheckmark: false,
                  label: Text(option),
                  selected: isSelected,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                  onSelected: (_) => onSelected(option),
                  selectedColor: Colors.brown,
                  backgroundColor: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildRatingSection() {
    List<double> ratings = [4.5, 4.0, 3.5, 3.0, 2.5];
    return Column(
      children: ratings.map((rating) {
        return ListTile(
          title: Row(
            children: [
              ...List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  size: 20,
                  color: index < rating ? Colors.amber : Colors.grey.shade300,
                );
              }),
              SizedBox(width: 10),
              Text('$rating and above'),
            ],
          ),
          trailing: Radio<double>(
            activeColor: Color(0xff704F38),
            value: rating,
            groupValue: selectedRating,
            onChanged: (value) {
              setState(() {
                selectedRating = value!;
              });
            },
          ),
        );
      }).toList(),
    );
  }

  void _resetFilters() {
    setState(() {
      selectedBrand = 'All';
      selectedGender = 'All';
      selectedSort = 'Popular';
      priceRange = RangeValues(2, 150);
      selectedRating = 4.5;
    });
  }
}
