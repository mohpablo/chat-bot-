import 'package:chat_bot/core/api/dio_consumer.dart';
import 'package:chat_bot/core/database/cache_hepler.dart';
import 'package:chat_bot/core/utils/cubit/theme_cubit.dart';
import 'package:chat_bot/views/chat_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/ai_chat_cubit.dart';
import 'cubit/chat_history_cubit.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHepler.init();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => ChatHistoryCubit()),
        BlocProvider(
          create: (_) => AiChatCubit(apiConsumer: DioConsumer(Dio())),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'Ai Chat Bot',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeState is ThemeDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const ChatScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
