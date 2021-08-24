class Character {
  int charId;
  String name;
  String birthday;
  List<String> occupation;
  String image;
  String status;
  String nickname;
  List<int> appearance;
  String actorName;
  String category;
  List<dynamic> betterCallSaulAppearance;

  Character({
    required this.charId,
    required this.name,
    required this.birthday,
    required this.occupation,
    required this.image,
    required this.status,
    required this.nickname,
    required this.appearance,
    required this.actorName,
    required this.category,
    required this.betterCallSaulAppearance,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        charId: json["char_id"],
        name: json["name"],
        birthday: json["birthday"],
        occupation: List<String>.from(json["occupation"].map((x) => x)),
        image: json["img"],
        status: json["status"],
        nickname: json["nickname"],
        appearance: List<int>.from(json["appearance"].map((x) => x)),
        actorName: json["portrayed"],
        category: json["category"],
        betterCallSaulAppearance: List<dynamic>.from(
            json["better_call_saul_appearance"].map((x) => x)),
      );

  // Map<String, dynamic> toJson() => {
  //       "char_id": charId,
  //       "name": name,
  //       "birthday": birthday,
  //       "occupation": List<dynamic>.from(occupation.map((x) => x)),
  //       "img": image,
  //       "status": status,
  //       "nickname": nickname,
  //       "appearance": List<dynamic>.from(appearance.map((x) => x)),
  //       "portrayed": actorName,
  //       "category": category,
  //       "better_call_saul_appearance":
  //           List<dynamic>.from(betterCallSaulAppearance.map((x) => x)),
  //     };
}
