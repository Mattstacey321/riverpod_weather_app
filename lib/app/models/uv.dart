class UV {
  double value;
  UV({required this.value});
  factory UV.fromJSON(Map<String, dynamic> json) {
    return UV(value: json["value"]);
  }
}
