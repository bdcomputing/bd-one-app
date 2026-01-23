enum ProjectTypeEnum {
  product('product'),
  service('service');

  final String value;
  const ProjectTypeEnum(this.value);

  static ProjectTypeEnum fromString(String value) {
    return ProjectTypeEnum.values.firstWhere(
      (e) => e.value == value,
      orElse: () => ProjectTypeEnum.service,
    );
  }
}
