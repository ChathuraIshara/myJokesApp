class JokeDto {
  final String type;
  final String? joke;
  final String? setup;
  final String? delivery;

  JokeDto({required this.type, this.joke, this.setup, this.delivery});

  factory JokeDto.fromJson(Map<String, dynamic> json) {
    return JokeDto(
        type: json['type'],
        joke: json['joke'],
        setup: json['setup'],
        delivery: json['delivery']);
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'joke': joke,
      'setup': setup,
      'delivery': delivery,
    };
  }
}
