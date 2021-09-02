import 'package:firebase_core/firebase_core.dart';
import 'package:fiu/bloc/blocs.dart';
import 'package:fiu/bloc/movie_bloc.dart';
import 'package:fiu/services/services.dart';
import 'package:fiu/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.userStream,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PageBloc()),
          BlocProvider(create: (_) => UserBloc()),
          BlocProvider(create: (_) => MovieBloc()..add(GetMovies())),
          BlocProvider(create: (_) => TicketBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fiu',
          theme: ThemeData(
              primarySwatch: Colors.grey,
              textTheme: GoogleFonts.openSansTextTheme()),
          home: Wrapper(),
        ),
      ),
    );
  }
}
