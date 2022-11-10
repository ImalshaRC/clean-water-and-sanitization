class SurveyFModel {
  String id = '';
  final String province;
  final String district;
  final String city;
  final String problem;
  final String description;
  final String population;
  final String families;

  SurveyFModel({
    required this.id,
    required this.province,
    required this.district,
    required this.city,
    required this.problem,
    required this.description,
    required this.population,
    required this.families,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'province' : province,
    'district' : district,
    'city' : city,
    'problem' : problem,
    'description' : description,
    'population' : population,
    'families' : families
  };

  static SurveyFModel fromJson(Map<String, dynamic> json) => SurveyFModel(
      id: json['id'],
      province: json['province'],
      district: json['district'],
      city: json['city'],
      problem: json['problem'],
      description: json['description'],
      population: json['population'],
      families: json['families']
  );
}