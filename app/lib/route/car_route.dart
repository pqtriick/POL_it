class CarRoute {

  String name;

  CarRoute(this.name);

  factory CarRoute.fromJson(Map<String, dynamic> json) => CarRoute(json["name"]);

  Map<String, dynamic> toJson() => {
    "name": name,
  };

}