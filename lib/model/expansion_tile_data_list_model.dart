import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExpansionTileDataFAQModel {
  final String title;
  final String description;

  ExpansionTileDataFAQModel({required this.title, required this.description});
}

List<ExpansionTileDataFAQModel> expansionTileDataListFAQModel = [
  ExpansionTileDataFAQModel(
    title: "Can I track my order's delivery status?",
    description:
        "Yes, you can track your order's delivery status by logging into your account and navigating to the 'Order History' section.",
  ),
  ExpansionTileDataFAQModel(
    title: "Is there a return policy?",
    description:
        "Yes, we have a return policy. You can return the product within 30 days of purchase if it meets our return criteria.",
  ),
  ExpansionTileDataFAQModel(
    title: "Can I save my favorite items for later?",
    description:
        "Yes, you can save your favorite items by adding them to your wishlist. Simply click the 'Add to Wishlist' button on the product page.",
  ),
  ExpansionTileDataFAQModel(
    title: "Can I share products with my friends?",
    description:
        "Yes, you can share products with your friends by clicking the 'Share' button on the product page and selecting the desired sharing option.",
  ),
  ExpansionTileDataFAQModel(
    title: "How do I contact customer support?",
    description:
        "You can contact customer support by emailing us at support@example.com or calling our toll-free number at 1-800-123-4567.",
  ),
  ExpansionTileDataFAQModel(
    title: "What payment methods are accepted?",
    description:
        "We accept various payment methods including credit/debit cards, PayPal, and online banking. You can choose your preferred payment method at checkout.",
  ),
  ExpansionTileDataFAQModel(
    title: "How to add review?",
    description:
        "You can add a review by navigating to the product page and clicking the 'Write a Review' button. Share your feedback and rate the product.",
  ),
];

class ExpansionTileDataContactModel {
  final IconData icon;
  final String title;
  final String description;

  ExpansionTileDataContactModel({
    required this.icon,
    required this.title,
    required this.description,
  });
}

List<ExpansionTileDataContactModel> expansionTileDataListContactModel = [
  ExpansionTileDataContactModel(
    icon: FontAwesomeIcons.headset,
    title: "Customer Service",
    description: "You can contact us on +91 96325 08741",
  ),
  ExpansionTileDataContactModel(
    icon: FontAwesomeIcons.whatsapp,
    title: "WhatsApp",
    description:
        "Yes, we have a return policy. You can return the product within 30 days of purchase if it meets our return criteria.",
  ),
  ExpansionTileDataContactModel(
    icon: FontAwesomeIcons.globe,
    title: "Website",
    description:
        "Yes, you can save your favorite items by adding them to your wishlist. Simply click the 'Add to Wishlist' button on the product page.",
  ),
  ExpansionTileDataContactModel(
    icon: FontAwesomeIcons.facebook,
    title: "Facebook",
    description:
        "Yes, you can share products with your friends by clicking the 'Share' button on the product page and selecting the desired sharing option.",
  ),
  ExpansionTileDataContactModel(
    icon: FontAwesomeIcons.twitter,
    title: "Twitter",
    description:
        "You can contact customer support by emailing us at support@example.com or calling our toll-free number at 1-800-123-4567.",
  ),
  ExpansionTileDataContactModel(
    icon: FontAwesomeIcons.instagram,
    title: "Instagram",
    description:
        "We accept various payment methods including credit/debit cards, PayPal, and online banking. You can choose your preferred payment method at checkout.",
  ),
];
