class Version {
  final int major;
  final int minor;
  final int? patch;

  const Version({
    required this.major,
    required this.minor,
    this.patch,
  });

  static Version fromJson(List<dynamic> version) => Version(
        major: version[0],
        minor: version[1],
        patch: version[2],
      );

  static Version fromText(String version) {
    final split = version.split('.');
    return Version(
      major: int.parse(split[0]),
      minor: int.parse(split[1]),
      patch: split.length < 3 ? null : int.parse(split[2]),
    );
  }

  static List<dynamic> toJson(Version version) => [
        version.major,
        version.minor,
        version.patch,
      ];

  static String toText(Version version) => version.toString();

  @override
  String toString() => '$major.$minor${patch == null ? '' : '.$patch'}';
}
