class DoggoBreed {
  final int id;
  final String name;
  final String weight; //metric
  final String height; //metric
  final String lifeSpan;
  final String referenceImageId;
  String? temperament;
  String? bredFor;
  String? breedGroup;

  DoggoBreed({
    required this.id,
    required this.name,
    required this.weight,
    required this.height,
    required this.lifeSpan,
    required this.referenceImageId,
    this.temperament,
    this.bredFor,
    this.breedGroup,
  });

  factory DoggoBreed.fromJson(Map<String, dynamic> json) {
    return DoggoBreed(
        id: json['id'],
        name: json['name'],
        weight: json['weight']['metric'],
        height: json['height']['metric'],
        lifeSpan: json['life_span'],
        referenceImageId: json['reference_image_id'],
        temperament: json['temperament'],
        bredFor: json['bred_for'],
        breedGroup: json['breed_group']);
  }
}
