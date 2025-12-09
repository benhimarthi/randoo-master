import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/serviceMetadata/presentation/bloc/service_metadata_bloc.dart';

class ServiceMetadataDisplay extends StatelessWidget {
  const ServiceMetadataDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceMetadataBloc, ServiceMetadataState>(
      builder: (context, state) {
        if (state is ServiceMetadataLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AllServiceMetadataLoaded) {
          if (state.metadata.isEmpty) {
            return const Center(child: Text('No service statistics found.'));
          }
          return ListView.builder(
            itemCount: state.metadata.length,
            itemBuilder: (context, index) {
              final metadata = state.metadata[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Service ID: ${metadata.serviceId}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatColumn(
                            context,
                            'Clicks',
                            metadata.clicks.toString(),
                          ),
                          _buildStatColumn(
                            context,
                            'Reviews',
                            metadata.reviewsCount.toString(),
                          ),
                          _buildStatColumn(
                            context,
                            'Avg Rating',
                            metadata.averageRating.toStringAsFixed(1),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is ServiceMetadataError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No metadata available.'));
        }
      },
    );
  }

  Widget _buildStatColumn(BuildContext context, String title, String value) {
    return Column(
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(value, style: Theme.of(context).textTheme.headlineMedium),
      ],
    );
  }
}
