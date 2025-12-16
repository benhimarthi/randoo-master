import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/auth/presentation/providers/user_provider.dart';
import 'package:myapp/features/home/presentation/views/home_screen.dart';
import 'package:myapp/features/service/presentation/cubit/service_cubit.dart';
import 'package:myapp/features/service/presentation/widgets/service_list_item.dart';

class ReviewedServicesScreen extends StatefulWidget {
  const ReviewedServicesScreen({super.key});

  static const routeName = '/reviewed-services';

  @override
  State<ReviewedServicesScreen> createState() => _ReviewedServicesScreenState();
}

class _ReviewedServicesScreenState extends State<ReviewedServicesScreen> {
  @override
  void initState() {
    super.initState();
    final user = context.read<UserProvider>().user;
    if (user != null) {
      context.read<ServiceCubit>().getReviewedServices(user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Services You've Reviewed"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(HomeScreen.routeName);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: BlocBuilder<ServiceCubit, ServiceState>(
        builder: (context, state) {
          if (state is GettingServices) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ReviewedServicesLoaded) {
            if (state.services.isEmpty) {
              return const Center(
                child: Text("You haven't reviewed any services yet."),
              );
            }
            return ListView.builder(
              itemCount: state.services.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceListItem(service: state.services[index]),
                );
              },
            );
          }
          if (state is ServiceError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Something went wrong.'));
        },
      ),
    );
  }
}
