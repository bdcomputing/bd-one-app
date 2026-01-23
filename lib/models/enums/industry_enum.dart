enum Industry {
  agriculture,
  automotive,
  construction,
  education,
  energy,
  finance,
  healthcare,
  hospitality,
  manufacturing,
  realEstate,
  retail,
  technology,
  transportation,
  other
}

extension IndustryExtension on Industry {
  String get displayName {
    switch (this) {
      case Industry.agriculture:
        return 'Agriculture';
      case Industry.automotive:
        return 'Automotive';
      case Industry.construction:
        return 'Construction';
      case Industry.education:
        return 'Education';
      case Industry.energy:
        return 'Energy';
      case Industry.finance:
        return 'Finance';
      case Industry.healthcare:
        return 'Healthcare';
      case Industry.hospitality:
        return 'Hospitality';
      case Industry.manufacturing:
        return 'Manufacturing';
      case Industry.realEstate:
        return 'Real Estate';
      case Industry.retail:
        return 'Retail';
      case Industry.technology:
        return 'Technology';
      case Industry.transportation:
        return 'Transportation';
      case Industry.other:
        return 'Other';
    }
  }

  String get value {
    // Convert to SCREAMING_SNAKE_CASE for backend
    switch (this) {
      case Industry.realEstate:
        return 'REAL_ESTATE';
      default:
        return toString().split('.').last.toUpperCase();
    }
  }

  static Industry fromString(String value) {
    final upperValue = value.toUpperCase();
    switch (upperValue) {
      case 'AGRICULTURE':
        return Industry.agriculture;
      case 'AUTOMOTIVE':
        return Industry.automotive;
      case 'CONSTRUCTION':
        return Industry.construction;
      case 'EDUCATION':
        return Industry.education;
      case 'ENERGY':
        return Industry.energy;
      case 'FINANCE':
        return Industry.finance;
      case 'HEALTHCARE':
        return Industry.healthcare;
      case 'HOSPITALITY':
        return Industry.hospitality;
      case 'MANUFACTURING':
        return Industry.manufacturing;
      case 'REAL_ESTATE':
        return Industry.realEstate;
      case 'RETAIL':
        return Industry.retail;
      case 'TECHNOLOGY':
        return Industry.technology;
      case 'TRANSPORTATION':
        return Industry.transportation;
      default:
        return Industry.other;
    }
  }
}
