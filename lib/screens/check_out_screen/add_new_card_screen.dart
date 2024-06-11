import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({super.key});

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(context),
            SizedBox(height: 20.h),
            buildNewCard(context),
            buildAddCardButton(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, top: 40.0.h, right: 20.0.w),
      child: Row(
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
            "Add Card",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget buildNewCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150.h,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/images/card/card.png",
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(height: 20.h),
          Text("Card Holder"),
          SizedBox(height: 10.h),
          TextFormField(
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter Card holder name";
              }

              return null;
            },
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Color((0xffDEDEDE))),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Color((0xffDEDEDE))),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Color((0xffDEDEDE))),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Color((0xffDEDEDE))),
              ),
              fillColor: Color.fromRGBO(255, 255, 255, 1),
              filled: true,
              hintText: "Add Card Holder Name",
              hintStyle: TextStyle(color: Color(0xff858383)),
              border: InputBorder.none,
            ),
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 10.h),
          Text("Card Holder"),
          SizedBox(height: 10.h),
          TextFormField(
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter card number";
              }
              final numericRegex = RegExp(r'^[0-9]{13,19}$');
              if (!numericRegex.hasMatch(value)) {
                return "Please enter a valid card number";
              }

              return null;
            },
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Color((0xffDEDEDE))),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Color((0xffDEDEDE))),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Color((0xffDEDEDE))),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Color((0xffDEDEDE))),
              ),
              fillColor: Color.fromRGBO(255, 255, 255, 1),
              filled: true,
              hintText: "Please enter card number",
              hintStyle: TextStyle(color: Color(0xff858383)),
              border: InputBorder.none,
            ),
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Expiry Date"),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5.w,
                    child: TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter expiry Date";
                        }
                        final expiryDateRegex =
                            RegExp(r'^(0[1-9]|1[0-2])\/(\d{2}|\d{4})$');
                        if (!expiryDateRegex.hasMatch(value)) {
                          return "Please enter a valid expiration date in MM/YY or MM/YYYY format";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Color((0xffDEDEDE))),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Color((0xffDEDEDE))),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Color((0xffDEDEDE))),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Color((0xffDEDEDE))),
                        ),
                        fillColor: Color.fromRGBO(255, 255, 255, 1),
                        filled: true,
                        hintText: "Expiry Date",
                        hintStyle: TextStyle(color: Color(0xff858383)),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.1.w,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("CVV"),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.7.w,
                    child: TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter expiry Date";
                        }
                        final cvvRegex = RegExp(r'^\d{3,4}$');
                        if (!cvvRegex.hasMatch(value)) {
                          return "Please enter a valid CVV";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Color((0xffDEDEDE))),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Color((0xffDEDEDE))),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Color((0xffDEDEDE))),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Color((0xffDEDEDE))),
                        ),
                        fillColor: Color.fromRGBO(255, 255, 255, 1),
                        filled: true,
                        hintText: "CVV",
                        hintStyle: TextStyle(color: Color(0xff858383)),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Save Card'),
            value: isChecked,
            onChanged: (newValue) {
              setState(() {
                isChecked = newValue ?? false;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ],
      ),
    );
  }

  Widget buildAddCardButton() {
    return Form(
      key: _formKey,
      child: GestureDetector(
        // onTap: () {
        //   if (_formKey.currentState!.validate())
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => FirstCheckoutScreen(),
        //       ),
        //     );
        // },
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          width: MediaQuery.of(context).size.width,
          height: 54.h,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xff704F38),
            border: Border.all(color: const Color(0xffDEDEDE)),
          ),
          child: Center(
            child: Text(
              "ADD NEW",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
