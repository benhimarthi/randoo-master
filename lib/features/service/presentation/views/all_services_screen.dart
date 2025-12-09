import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/service/domain/entities/category.dart';
import 'package:myapp/features/service/domain/entities/town.dart';
import 'package:myapp/features/service/presentation/cubit/service_cubit.dart';
import 'package:myapp/features/service/presentation/widgets/service_list_item.dart';

class AllServicesScreen extends StatefulWidget {
  const AllServicesScreen({
    super.key,
    required this.initialCategory,
    required this.initialTown,
    required this.initialSearchQuery,
  });

  static const routeName = '/all-services';

  final ServiceCategory initialCategory;
  final Town? initialTown;
  final String initialSearchQuery;

  @override
  State<AllServicesScreen> createState() => _AllServicesScreenState();
}

class _AllServicesScreenState extends State<AllServicesScreen> {
  late ServiceCategory _selectedCategory;
  late Town? _selectedTown;
  late String _searchQuery;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    _selectedTown = widget.initialTown;
    _searchQuery = widget.initialSearchQuery;
    _searchController.text = _searchQuery;
    context.read<ServiceCubit>().getServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Services'),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Rechercher un service...',
                icon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
          ),
          // Category Chips
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
          // Town Dropdown
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
          // Service List
          Expanded(
            child: BlocBuilder<ServiceCubit, ServiceState>(
              builder: (context, state) {
                if (state is GettingServices) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ServiceError) {
                  return Center(child: Text(state.message));
                }
                if (state is ServicesLoaded) {
                  final filteredServices = state.services.where((service) {
                    final matchesCategory =
                        _selectedCategory == ServiceCategory.all ||
                            service.category == _selectedCategory;
                    final matchesTown =
                        _selectedTown == null || service.town == _selectedTown;
                    final matchesSearch = service.name
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase());
                    return matchesCategory && matchesTown && matchesSearch;
                  }).toList();

                  if (filteredServices.isEmpty) {
                    return const Center(
                      child: Text('Aucun service trouvé.'),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: filteredServices.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ServiceListItem(
                          service: filteredServices[index],
                        ),
                      );
                    },
                  );
                }
                return const Center(child: Text('Aucun service à afficher pour le moment.'));
              },
            ),
          ),
        ],
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
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.black,
              size: 20,
            ),
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
      case ServiceCategory.all:
        return Icons.public;
    }
  }
}
