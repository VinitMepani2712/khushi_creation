import 'package:flutter/material.dart';

class ShippingTypeModel extends StatelessWidget {
  final String type;
  final String estimatedDate;
  final String value;
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  const ShippingTypeModel({
    Key? key,
    required this.type,
    required this.estimatedDate,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.location_on,
            color: Color(0xff704F38),
          ),
          SizedBox(width: 8), // Adds some spacing between the icon and the text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        estimatedDate,
                        softWrap: true,
                      ),
                    ),
                    Radio<String>(
                      value: value,
                      groupValue: groupValue,
                      onChanged: onChanged,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
