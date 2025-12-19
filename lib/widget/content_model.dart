class UnboardingContent{
  String image;
  String title;
  String description;
  UnboardingContent({required this.description, required this.image,required this.title});
}

List<UnboardingContent>contents=[
  UnboardingContent(
      description:' Pickup your food from our Menu',
      image: 'assets/images/fullmeal.png',
      title: 'Select from Our Menu'),
  UnboardingContent(
      description:' You can pay cash on delivery method and card approach',
      image: 'assets/images/fullmeal.png',
      title: 'SEasy Online Payment'),
  UnboardingContent(
      description:' Delivery your food at doorstep',
      image: 'assets/images/fullmeal.png',
      title: 'Pick the order from your door'),
];