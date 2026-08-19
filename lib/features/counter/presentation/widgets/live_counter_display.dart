// lib/features/counter/presentation/widgets/live_counter_display.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/counter_bloc.dart';
import '../bloc/counter_state.dart';

class LiveCounterDisplay extends StatelessWidget {
  const LiveCounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<CounterBloc, CounterState>(
      builder: (context, state) {
        if (state is CounterLoading || state is CounterInitial) {
          return Center(
            child: CircularProgressIndicator(
              color: theme.primaryColor,
              strokeWidth: 4.0,
            ),
          );
        } else if (state is CounterLoaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.circle,
                      color: theme.primaryColor,
                      size: 14.0,
                    ),
                    const SizedBox(width: 12.0),
                    Text(
                      'LIVE ONLINE USERS',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),
              Text(
                '${state.onlineUsersCount}',
                style: theme.textTheme.displayLarge?.copyWith(
                  fontSize: 110.0,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                  letterSpacing: -2.0,
                  color: theme.textTheme.bodyLarge?.color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        } else if (state is CounterError) {
          return Center(
            child: Text(
              'System Failure',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
