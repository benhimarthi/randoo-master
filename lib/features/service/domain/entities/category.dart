enum ServiceCategory {
  driver('Driver'),
  restaurant('Restaurant'),
  apartment('Apartment'),
  barberShop('Barber Shop'),
  touristicGuide('Touristic Guide'),
  transport('Transport');

  const ServiceCategory(this.label);
  final String label;
}