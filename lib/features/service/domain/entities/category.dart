enum ServiceCategory {
  driver('Chauffeur'),
  restaurant('Restaurant'),
  apartment('Appartement'),
  barberShop('Barbier'),
  touristicGuide('Guide Touristique'),
  transport('Transport'),
  all('Tous');

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
      case 'BarberShop':
      case 'Barber Shop':
        return ServiceCategory.barberShop;
      case 'TouristicGuide':
      case 'Touristic Guide':
        return ServiceCategory.touristicGuide;
      case 'Transport':
        return ServiceCategory.transport;
      default:
        return ServiceCategory.all; 
    }
  }
}
