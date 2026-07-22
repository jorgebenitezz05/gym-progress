import 'package:flutter/material.dart';

import '../widgets/premium_feature_card.dart';
import 'exercise_list_screen.dart';
import 'routine_list_screen.dart';
import 'stats_screen.dart';
import 'workout_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showContent = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 220), () {
      if (mounted) setState(() => _showContent = true);
    });
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => screen,
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(begin: const Offset(0.04, 0), end: Offset.zero).animate(animation),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final featureItems = [
      _FeatureData(
        title: 'Ejercicios',
        subtitle: 'Explora todos los ejercicios del gimnasio.',
        icon: Icons.fitness_center_rounded,
        color: const Color(0xFF22C55E),
        screen: const ExerciseListScreen(),
        heroTag: 'feature-exercises',
      ),
      _FeatureData(
        title: 'Rutinas',
        subtitle: 'Organiza tus entrenamientos.',
        icon: Icons.list_alt_rounded,
        color: const Color(0xFFF59E0B),
        screen: const RoutineListScreen(),
        heroTag: 'feature-routines',
      ),
      _FeatureData(
        title: 'Entrenamientos',
        subtitle: 'Registra cada serie y repetición.',
        icon: Icons.sports_gymnastics_rounded,
        color: const Color(0xFF60A5FA),
        screen: const WorkoutListScreen(),
        heroTag: 'feature-workouts',
      ),
      _FeatureData(
        title: 'Estadísticas',
        subtitle: 'Explora tus métricas próximas.',
        icon: Icons.bar_chart_rounded,
        color: const Color(0xFFA78BFA),
        screen: const StatsScreen(),
        heroTag: 'feature-stats',
      ),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0E0E0E), Color(0xFF121212)],
          ),
        ),
        child: SafeArea(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 420),
            opacity: _showContent ? 1 : 0,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(theme),
                        const SizedBox(height: 24),
                        const Text('Descubre', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 14),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = featureItems[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: PremiumFeatureCard(
                            icon: item.icon,
                            title: item.title,
                            subtitle: item.subtitle,
                            color: item.color,
                            heroTag: item.heroTag,
                            onTap: () => _navigateTo(context, item.screen),
                          ),
                        );
                      },
                      childCount: featureItems.length,
                    ),
                  ),
                ),
                const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF111111), Color(0xFF171717)],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 20)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('GymProgress', style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text('Entrena más inteligente.', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70)),
                  ],
                ),
              ),
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withValues(alpha: 31)),
                ),
                child: const Icon(Icons.person_rounded, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              height: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&w=900&q=60'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}

class _FeatureData {
  const _FeatureData({required this.title, required this.subtitle, required this.icon, required this.color, required this.screen, required this.heroTag});

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Widget screen;
  final String heroTag;
}
