enum ServiceCategory {
  driver('Driver'),
  restaurant('Restaurant'),
  apartment('Apartment'),
  barberShop('Barber shop'),
  touristicGuide('Touristic guide'),
  shop('Shop'),
  other('Other');

  const ServiceCategory(this.label);
  final String label;

  factory ServiceCategory.fromString(String value) {
    switch (value) {
      case 'Driver':
        return ServiceCategory.driver;
      case 'Restaurant':
        return ServiceCategory.restaurant;
      case 'Apartment':
        return ServiceCategory.apartment;
      case 'Barber shop':
        return ServiceCategory.barberShop;
      case 'Touristic guide':
        return ServiceCategory.touristicGuide;
      case 'Shop':
        return ServiceCategory.shop;
      case 'Other':
        return ServiceCategory.other;
      default:
        return ServiceCategory.other;
    }
  }
}
