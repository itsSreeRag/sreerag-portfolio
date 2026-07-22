import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/about/viewmodels/about_viewmodel.dart';
import 'features/contact/viewmodels/contact_viewmodel.dart';
import 'features/experience/viewmodels/experience_viewmodel.dart';
import 'features/home/viewmodels/home_viewmodel.dart';
import 'features/projects/viewmodels/projects_viewmodel.dart';
import 'features/shell/viewmodels/shell_viewmodel.dart';
import 'features/skills/viewmodels/skills_viewmodel.dart';
import 'repositories/portfolio_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SreeragPortfolioApp());
}

class SreeragPortfolioApp extends StatelessWidget {
  const SreeragPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final portfolioRepository = PortfolioRepository();

    return MultiProvider(
      providers: [
        Provider<PortfolioRepository>.value(value: portfolioRepository),
        ChangeNotifierProvider(create: (_) => ShellViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => AboutViewModel()),
        ChangeNotifierProvider(
          create: (_) => SkillsViewModel(repository: portfolioRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => ProjectsViewModel(repository: portfolioRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => ExperienceViewModel(repository: portfolioRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => ContactViewModel(repository: portfolioRepository),
        ),
      ],
      child: MaterialApp.router(
        title: 'Sreerag Portfolio',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
