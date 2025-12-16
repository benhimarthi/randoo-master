import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/services/notification.service.dart';
import 'package:myapp/core/services/service_locator.dart' as di;
import 'package:myapp/core/theme/theme.dart';
import 'package:myapp/core/theme/theme_provider.dart';
import 'package:myapp/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:myapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:myapp/features/auth/presentation/providers/user_provider.dart';
import 'package:myapp/features/auth/presentation/views/register_regular_user_screen.dart';
import 'package:myapp/features/auth/presentation/views/register_screen.dart';
import 'package:myapp/features/auth/presentation/views/reset_password_page.dart';
import 'package:myapp/features/auth/presentation/views/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/features/home/presentation/views/home_screen.dart';
import 'package:myapp/features/imageService/presentation/cubit/imageCubit.dart';
import 'package:myapp/features/notifications/data/data_source/notification.data.service.dart';
import 'package:myapp/features/service/domain/entities/category.dart';
import 'package:myapp/features/service/domain/entities/service.dart';
import 'package:myapp/features/service/domain/entities/town.dart';
import 'package:myapp/features/service/presentation/cubit/service_cubit.dart';
import 'package:myapp/features/service/presentation/views/all_services_screen.dart';
import 'package:myapp/features/service/presentation/views/create_service_screen.dart';
import 'package:myapp/features/service/presentation/views/edit_service_screen.dart';
import 'package:myapp/features/service/presentation/views/reviewed_services_screen.dart';
import 'package:myapp/features/service/presentation/views/service_details_screen.dart';
import 'package:myapp/features/service/presentation/views/services_screen.dart';
import 'package:myapp/features/serviceMetadata/presentation/bloc/service_metadata_bloc.dart';
import 'package:myapp/features/serviceMetadata/presentation/pages/service_metadata_page.dart';
import 'package:myapp/features/home/presentation/views/privacy_policy_screen.dart';
import 'package:myapp/firebase_options.dart';
import 'package:provider/provider.dart';

import 'core/services/service_locator.dart';
import 'features/notifications/presentation/notification.listenner.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.init();
  await di.init();
  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
        BlocProvider(create: (_) => di.sl<ServiceCubit>()),
        BlocProvider(create: (_) => di.sl<ServiceMetadataBloc>()),
        BlocProvider(create: (_) => di.sl<Imagecubit>()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          if (context.read<AuthBloc>().state is AuthInitial) {
            context.read<AuthBloc>().add(IsLoggedInEvent());
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'My App',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeProvider.themeMode,
            home: const HomeScreen(),
            navigatorKey: navigatorKey,
            routes: {"/service": (context) => ServicesScreen()},
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case '/home':
                  return MaterialPageRoute(
                    builder: (_) {
                      return BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return state is Authenticated || state is SignedIn
                              ? const HomeScreen()
                              : const SignInScreen();
                        },
                      );
                    },
                  );
                case "/notifications_view":
                  var t = sl<AuthLocalDataSource>().getToken();
                  final notif = NotificationDataService(
                    context.read<UserProvider>().user!.id,
                  );
                  return MaterialPageRoute(
                    builder: (_) =>
                        NotificationsScreen(notificationService: notif),
                  );
                case ServicesScreen.routeName:
                  return MaterialPageRoute(
                    builder: (_) => const ServicesScreen(),
                  );
                case ResetPasswordPage.routeName:
                  return MaterialPageRoute(
                    builder: (_) => const ResetPasswordPage(),
                  );
                case AllServicesScreen.routeName:
                  final args = settings.arguments as Map<String, dynamic>;
                  return MaterialPageRoute(
                    builder: (_) => AllServicesScreen(
                      initialCategory: args['category'] as ServiceCategory,
                      initialTown: args['town'] as Town?,
                      initialSearchQuery: args['searchQuery'] as String,
                    ),
                  );
                case SignInScreen.routeName:
                  return MaterialPageRoute(
                    builder: (_) => const SignInScreen(),
                  );
                case RegisterScreen.routeName:
                  return MaterialPageRoute(
                    builder: (_) => const RegisterScreen(),
                  );
                case RegisterRegularUserScreen.routeName:
                  return MaterialPageRoute(
                    builder: (_) => const RegisterRegularUserScreen(),
                  );
                case CreateServiceScreen.routeName:
                  return MaterialPageRoute(
                    builder: (_) => const CreateServiceScreen(),
                  );
                case EditServiceScreen.routeName:
                  final service = settings.arguments as Service;
                  return MaterialPageRoute(
                    builder: (_) => EditServiceScreen(service: service),
                  );
                case ServiceDetailsScreen.routeName:
                  final service = settings.arguments as Service;
                  return MaterialPageRoute(
                    builder: (_) => ServiceDetailsScreen(service: service),
                  );
                case ServiceMetadataPage.routeName:
                  return MaterialPageRoute(
                    builder: (_) => const ServiceMetadataPage(),
                  );
                case ReviewedServicesScreen.routeName:
                  return MaterialPageRoute(
                    builder: (_) => const ReviewedServicesScreen(),
                  );
                case PrivacyPolicyScreen.routeName:
                  return MaterialPageRoute(
                    builder: (_) => const PrivacyPolicyScreen(),
                  );
                default:
                  return null;
              }
            },
          );
        },
      ),
    );
  }
}
