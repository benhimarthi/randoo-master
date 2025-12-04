
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/service/domain/entities/category.dart';
import 'package:myapp/features/service/domain/entities/service.dart';
import 'package:myapp/features/service/domain/entities/subscription_version.dart';
import 'package:myapp/features/service/domain/entities/town.dart';
import 'package:myapp/features/service/presentation/bloc/service_bloc.dart';
import 'package:uuid/uuid.dart';

class CreateServiceScreen extends StatefulWidget {
  const CreateServiceScreen({super.key});

  static const routeName = '/create-service';

  @override
  State<CreateServiceScreen> createState() => _CreateServiceScreenState();
}

class _CreateServiceScreenState extends State<CreateServiceScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageUrlsController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ServiceCategory? _selectedCategory;
  Town? _selectedTown;
  SubscriptionVersion? _selectedSubscription;
  bool _status = true;

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    imageUrlsController.dispose();
    addressController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Service'),
      ),
      body: BlocConsumer<ServiceBloc, ServiceState>(
        listener: (context, state) {
          if (state is ServiceError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
          } else if (state is ServiceCreated) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text('Service Status'),
                      value: _status,
                      onChanged: (value) {
                        setState(() {
                          _status = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Service Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a service name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: descriptionController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'Service Description',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a service description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<ServiceCategory>(
                      value: _selectedCategory,
                      hint: const Text('Select a category'),
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      items: ServiceCategory.values
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.label),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<Town>(
                      value: _selectedTown,
                      hint: const Text('Select a town'),
                      decoration: const InputDecoration(
                        labelText: 'Town',
                        border: OutlineInputBorder(),
                      ),
                      items: Town.values
                          .map((town) => DropdownMenuItem(
                                value: town,
                                child: Text(town.label),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedTown = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a town';
                        }
                        return null;
                      },
                    ),
                     const SizedBox(height: 20),
                    DropdownButtonFormField<SubscriptionVersion>(
                      value: _selectedSubscription,
                      hint: const Text('Select a Subscription'),
                      decoration: const InputDecoration(
                        labelText: 'Subscription',
                        border: OutlineInputBorder(),
                      ),
                      items: SubscriptionVersion.values
                          .map((sub) => DropdownMenuItem(
                                value: sub,
                                child: Text(sub.label),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedSubscription = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a subscription';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: imageUrlsController,
                      decoration: const InputDecoration(
                        labelText: 'Image URLs (comma-separated)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final user = FirebaseAuth.instance.currentUser;
                          if (user == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'You must be logged in to create a service.'),
                              ),
                            );
                            return;
                          }
                          final imageUrls = imageUrlsController.text.trim().isEmpty
                              ? <String>[]
                              : imageUrlsController.text.split(',').map((e) => e.trim()).toList();
                          final service = Service(
                            id: const Uuid().v4(),
                            name: nameController.text.trim(),
                            description: descriptionController.text.trim(),
                            category: _selectedCategory!,
                            town: _selectedTown!,
                            address: addressController.text.trim(),
                            phoneNumber: phoneController.text.trim(),
                            email: emailController.text.trim(),
                            ownerId: user.uid,
                            imageUrls: imageUrls,
                            averageRating: 0.0,
                            createdAt: DateTime.now(),
                            status: _status,
                            subVersion: _selectedSubscription!,
                          );
                          context
                              .read<ServiceBloc>()
                              .add(CreateServiceEvent(service));
                        }
                      },
                      child: state is CreatingService
                          ? const CircularProgressIndicator()
                          : const Text('Create Service'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
