import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/services/service_locator.dart';
import 'package:myapp/features/serviceMetadata/presentation/bloc/service_metadata_bloc.dart';
import 'package:myapp/features/serviceMetadata/presentation/widgets/service_metadata_display.dart';

class ServiceMetadataPage extends StatelessWidget {

  const ServiceMetadataPage({super.key});

  static const routeName = '/service-metadata';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Statistics'),
      ),
      body: BlocProvider(
        create: (_) => sl<ServiceMetadataBloc>()..add(const GetAllServiceMetadataEvent()),
        child: const ServiceMetadataDisplay(),
      ),
    );
  }
}
