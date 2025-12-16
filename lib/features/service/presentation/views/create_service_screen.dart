import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/service/data/models/service_model.dart';
import 'package:myapp/features/service/domain/entities/category.dart';
import 'package:myapp/features/service/domain/entities/service.dart';
import 'package:myapp/features/service/domain/entities/subscription_version.dart';
import 'package:myapp/features/service/domain/entities/town.dart';
import 'package:myapp/features/service/presentation/cubit/service_cubit.dart';
import 'package:myapp/features/service/presentation/views/services_screen.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/services/notification.service.dart';
import '../../../imageService/presentation/cubit/imageCubit.dart';
import '../../../imageService/presentation/cubit/imageState.dart';
import '../../../imageService/presentation/imageUploaderWidget.dart';

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
  late List<String> myImages;
  late ServiceModel? serviceM;
  late String serviceId;

  @override
  void initState() {
    super.initState();
    serviceM = null;
    myImages = [];
    serviceId = const Uuid().v4();
  }

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
      appBar: AppBar(title: const Text('Create Service')),
      body: BlocConsumer<ServiceCubit, ServiceState>(
        listener: (context, state) {
          if (state is ServiceError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.message)));
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
                    BlocConsumer<Imagecubit, Imagestate>(
                      listener: (context, state) {
                        if (state is ImageLoaded) {
                          setState(() {
                            myImages.add(state.image);
                          });
                        }
                      },
                      builder: (context, state) {
                        return ImageUploaderWidget(displayUploadBtn: true);
                      },
                    ),
                    BlocConsumer<ServiceCubit, ServiceState>(
                      listener: (context, state) {
                        if (state is ServiceCreated) {
                          NotificationService.sendTopicNotification({
                            'id': serviceId,
                            'name': nameController.text,
                            'description': descriptionController.text,
                          });
                          Navigator.of(
                            context,
                          ).pushNamed(ServicesScreen.routeName);
                        }
                      },
                      builder: (context, state) {
                        return Container();
                      },
                    ),
                    const SizedBox(height: 20),
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
                      hint: const Text('Select a category'),
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      items: ServiceCategory.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.label),
                            ),
                          )
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
                      hint: const Text('Select a town'),
                      decoration: const InputDecoration(
                        labelText: 'Town',
                        border: OutlineInputBorder(),
                      ),
                      items: Town.values
                          .map(
                            (town) => DropdownMenuItem(
                              value: town,
                              child: Text(town.label),
                            ),
                          )
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
                      hint: const Text('Select a Subscription'),
                      decoration: const InputDecoration(
                        labelText: 'Subscription',
                        border: OutlineInputBorder(),
                      ),
                      items: SubscriptionVersion.values
                          .map(
                            (sub) => DropdownMenuItem(
                              value: sub,
                              child: Text(sub.label),
                            ),
                          )
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

                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final user = FirebaseAuth.instance.currentUser;
                          if (user == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'You must be logged in to create a service.',
                                ),
                              ),
                            );
                            return;
                          }

                          final service = Service(
                            id: serviceId,
                            name: nameController.text.trim(),
                            description: descriptionController.text.trim(),
                            category: _selectedCategory!,
                            town: _selectedTown!,
                            address: addressController.text.trim(),
                            phoneNumber: phoneController.text.trim(),
                            email: emailController.text.trim(),
                            ownerId: user.uid,
                            imageUrls: myImages,
                            averageRating: 0.0,
                            createdAt: DateTime.now(),
                            status: _status,
                            subVersion: _selectedSubscription!,
                          );
                          serviceM = ServiceModel.fromEntity(service);
                          context.read<ServiceCubit>().createService(service);
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
