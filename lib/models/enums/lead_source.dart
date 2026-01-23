enum LeadSourceEnum {
  website('website'),
  referral('referral'),
  socialMedia('social_media'),
  emailCampaign('email_campaign'),
  event('event'),
  advertisement('advertisement'),
  phone('phone'),
  walkIn('walk_in'),
  other('other');

  final String value;
  const LeadSourceEnum(this.value);

  static LeadSourceEnum fromString(String value) {
    return LeadSourceEnum.values.firstWhere(
      (e) => e.value == value,
      orElse: () => LeadSourceEnum.website,
    );
  }
}
