class User_info_model {
  final String fir_name;

  final String sec_name;

  final String mobile;
  final String user_id;

  final String Zone;

  User_info_model(
      {required this.fir_name,
      required this.sec_name,
      required this.mobile,
      required this.Zone,
      required this.user_id});

  static User_info_model fromMap(Map<String, Object?> map) {
    final fir_name = map['first_name'] as String;

    final sec_name = map['sec_name'] as String;

    final zone = map['zone'] as String;
    final mobile = map['mobile'] as String;
    final user_id = map['User_id'] as String;
    return User_info_model(
        fir_name: fir_name,
        sec_name: sec_name,
        mobile: mobile,
        Zone: zone,
        user_id: user_id);
  }
}
