import 'package:myapp/features/service/domain/entities/category.dart';
import 'package:myapp/features/service/domain/entities/service.dart';
import 'package:myapp/features/service/domain/entities/subscription_version.dart';
import 'package:myapp/features/service/domain/entities/town.dart';
import 'package:myapp/features/service/presentation/widgets/service_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ServiceCategory _selectedCategory = ServiceCategory.values.first;
  Town? _selectedTown;

  @override
  Widget build(BuildContext context) {
    final List<Service> proposedServices = [
      Service(
        id: '1',
        name: 'Transport Premium CAN',
        town: Town.casablanca,
        category: ServiceCategory.driver,
        description:
            'Service de transport privé avec chauffeurs professionnels pour tous vos déplacements...',
        phoneNumber: '+212 6 12 34 56 78',
        email: 'contact@transportpremium.ma',
        createdAt: DateTime.now(),
        subVersion: SubscriptionVersion.regular,
        address: '',
        averageRating: 0,
        imageUrls: [],
        ownerId: '',
        status: false,
      ),
      Service(
        id: '2',
        name: 'Restaurant Le Marocain',
        town: Town.marrakech,
        category: ServiceCategory.restaurant,
        description:
            'Cuisine marocaine authentique dans un cadre traditionnel. Spécialités: tajines,...',
        phoneNumber: '+212 5 24 45 67 89',
        email: 'reservation@lemarocain.ma',
        createdAt: DateTime.now(),
        subVersion: SubscriptionVersion.regular,
        address: '',
        averageRating: 0,
        imageUrls: [],
        ownerId: '',
        status: false,
      ),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF9881F), Color(0xFFF9A825)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Row(
                    children: [
                      Icon(Icons.emoji_events, color: Colors.white, size: 40),
                      SizedBox(width: 10),
                      Text(
                        'CAN 2025\nMaroc',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Votre annuaire complet des services au Maroc',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Trouvez facilement chauffeurs, restaurants, appartements, coiffeurs et bien plus encore dans toutes les villes du Royaume',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(51),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Rechercher un service...',
                    icon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: ServiceCategory.values.map((category) {
                  return _buildCategoryChip(
                    context,
                    category.label,
                    _getIconForCategory(category),
                    _selectedCategory == category,
                    () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Town>(
                    value: _selectedTown,
                    isExpanded: true,
                    hint: const Text('Toutes les villes'),
                    onChanged: (Town? newValue) {
                      setState(() {
                        _selectedTown = newValue;
                      });
                    },
                    items: Town.values.map((Town town) {
                      return DropdownMenuItem<Town>(
                        value: town,
                        child: Text(town.label),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Services proposés',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: proposedServices.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ServiceListItem(service: proposedServices[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(
    BuildContext context,
    String label,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepOrange : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.deepOrange : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.black, size: 20),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForCategory(ServiceCategory category) {
    switch (category) {
      case ServiceCategory.driver:
        return Icons.directions_car;
      case ServiceCategory.restaurant:
        return Icons.restaurant;
      case ServiceCategory.apartment:
        return Icons.home;
      case ServiceCategory.barberShop:
        return Icons.cut;
      case ServiceCategory.touristicGuide:
        return Icons.map;
      case ServiceCategory.transport:
        return Icons.bus_alert;
    }
  }
}
