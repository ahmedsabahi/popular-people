import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popular_people/cubits/peopleListCubit/people_cubit.dart';
import 'package:popular_people/cubits/personImagesCubit/images_cubit.dart';
import 'package:popular_people/ui/peopleList/people_list_screen.dart';
import 'package:popular_people/utils/my_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PeopleCubit>(
          create: (_) => PeopleCubit(),
        ),
        BlocProvider<ImagesCubit>(
          create: (_) => ImagesCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Popular People',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.orange,
          ).copyWith(
            secondary: Colors.redAccent,
          ),
        ),
        home: const PeopleListScreen(),
      ),
    );
  }
}
