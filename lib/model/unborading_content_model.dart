class UnBoradingContentModel {
  String image;
  String title;
  String description;

  UnBoradingContentModel({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<UnBoradingContentModel> contents = [
  UnBoradingContentModel(
      image: "assets/images/on_board_screen/on_board_screen_1.png",
      title: "Seamless Shopping Experience",
      description:
          "Lorem ipsum dolor sit amet a aconsectetur. Ut proin accumsan be  tincidunt ultricies leo."),
  UnBoradingContentModel(
      image: "assets/images/on_board_screen/on_board_screen_2.png",
      title: "Wishlist: Where Fashion Dreams Begin",
      description:
          "Lorem ipsum dolor sit amet a aconsectetur. Ut proin accumsan be  tincidunt ultricies leo."),
  UnBoradingContentModel(
      image: "assets/images/on_board_screen/on_board_screen_3.png",
      title: "Swift and Reliable Delivery",
      description:
          "Lorem ipsum dolor sit amet a aconsectetur. Ut proin accumsan be  tincidunt ultricies leo."),
];
