
class Section {
  final String title;
  final List<Home> homes;

  Section({required this.title, required this.homes});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      title: json['title'],
      homes: (json['homes'] as List).map((home) => Home.fromJson(home)).toList(),
    );
  }

  get length => null;
}
class Home {
  final String image;
  final String price;
  final String type;
  final String location;

  Home({required this.image, required this.price, required this.type, required this.location});

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
      image: json['image'],
      price: json['price'],
      type: json['type'],
      location: json['location'],
    );
  }
}
class HomeSponsers extends Home {
  HomeSponsers({
    required String image,
    required String price,
    required String type,
    required String location,
  }) : super(image: image, price: price, type: type, location: location);

  factory HomeSponsers.fromJson(Map<String, dynamic> json) {
    return HomeSponsers(
      image: json['image'],
      price: json['price'],
      type: json['type'],
      location: json['location'],
    );
  }
}