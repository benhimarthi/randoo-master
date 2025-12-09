import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/auth/presentation/providers/user_provider.dart';
import 'package:myapp/features/auth/presentation/views/profile_screen.dart';
import 'package:myapp/features/auth/presentation/views/sign_in_screen.dart';
import 'package:myapp/features/service/domain/entities/category.dart';
import 'package:myapp/features/service/domain/entities/town.dart';
import 'package:myapp/features/service/presentation/cubit/service_cubit.dart';
import 'package:myapp/features/service/presentation/views/all_services_screen.dart';
import 'package:myapp/features/service/presentation/views/reviewed_services_screen.dart';
import 'package:myapp/features/service/presentation/widgets/service_list_item.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ServiceCategory _selectedCategory = ServiceCategory.all;
  Town? _selectedTown;
  String _searchQuery = '';
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<ServiceCubit>().getServices();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              if (user != null)
                IconButton(
                  icon: const Icon(
                    Icons.reviews,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(ReviewedServicesScreen.routeName);
                  },
                ),
              IconButton(
                icon: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  if (user != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  } else {
                    Navigator.of(context).pushNamed(SignInScreen.routeName);
                  }
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 10),
                    const Text(
                      'Votre annuaire complet des services au Maroc',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),
                PreferredSize(
                  preferredSize: const Size.fromHeight(60.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    child: Container(
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'Rechercher un service...',
                            icon: Icon(Icons.search),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Services proposés',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          BlocBuilder<ServiceCubit, ServiceState>(
            builder: (context, state) {
              if (state is GettingServices) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (state is ServiceError) {
                return SliverToBoxAdapter(
                  child: Center(child: Text(state.message)),
                );
              }
              if (state is ServicesLoaded) {
                final filteredServices = state.services.where((service) {
                  final matchesCategory =
                      _selectedCategory == ServiceCategory.all ||
                      service.category == _selectedCategory;
                  final matchesTown =
                      _selectedTown == null || service.town == _selectedTown;
                  final matchesSearch = service.name.toLowerCase().contains(
                    _searchQuery.toLowerCase(),
                  );
                  return matchesCategory && matchesTown && matchesSearch;
                }).toList();

                if (filteredServices.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text('Aucun service trouvé.'),
                      ),
                    ),
                  );
                }

                final servicesToShow = filteredServices.take(4).toList();

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == servicesToShow.length) {
                        if (filteredServices.length > 4) {
                          return Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  AllServicesScreen.routeName,
                                  arguments: {
                                    'category': _selectedCategory,
                                    'town': _selectedTown,
                                    'searchQuery': _searchQuery,
                                  },
                                );
                              },
                              child: const Text('See More'),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: ServiceListItem(service: servicesToShow[index]),
                      );
                    },
                    childCount:
                        servicesToShow.length +
                        (filteredServices.length > 4 ? 1 : 0),
                  ),
                );
              }
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
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
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForCategory(ServiceCategory category) {
    switch (category) {
      case ServiceCategory.all:
        return Icons.category;
      case ServiceCategory.driver:
        return Icons.directions_car;
      case ServiceCategory.restaurant:
        return Icons.restaurant;
      case ServiceCategory.apartment:
        return Icons.home;
      case ServiceCategory.barberShop:
        return Icons.content_cut;
      case ServiceCategory.touristicGuide:
        return Icons.map;
      case ServiceCategory.transport:
        return Icons.local_taxi;
      default:
        return Icons.category;
    }
  }
}
