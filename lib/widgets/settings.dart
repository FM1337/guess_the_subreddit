import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_subreddit/providers/settings_provider.dart';

class SettingsWidget extends ConsumerWidget {
  SettingsWidget({super.key});

  final roundOptions = [5, 10, 15, 20, 25, 30];
  final timeOptions = [15, 30, 45, 60, 75, 90, 105, 120];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return Center(
      child: Column(
        children: [
          const Icon(Icons.settings, size: 100, color: Colors.blue),
          const Text(
            "Settings",
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Number of Rounds:"),
              const SizedBox(width: 10),
              DropdownButton<int>(
                value: settings.rounds,
                onChanged: (int? value) {
                  ref.read(settingsProvider.notifier).setRounds(value!);
                },
                items: roundOptions
                    .map((option) => DropdownMenuItem<int>(
                          value: option,
                          child: Text("$option"),
                        ))
                    .toList(),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text("Timer Enabled:"),
            const SizedBox(width: 10),
            Switch(
              value: settings.timerEnabled,
              onChanged: (bool value) {
                ref.read(settingsProvider.notifier).toggleTimer();
              },
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Timer Duration:"),
              const SizedBox(width: 10),
              DropdownButton<int>(
                value: settings.timePerRound,
                onChanged: (int? value) {
                  ref.read(settingsProvider.notifier).setTimePerRound(value!);
                },
                items: timeOptions
                    .map((option) => DropdownMenuItem<int>(
                          value: option,
                          child: Text("$option"),
                        ))
                    .toList(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Life Lines:"),
              const SizedBox(width: 10),
              DropdownButton<int>(
                value: settings.lifeLines,
                onChanged: (int? value) {
                  ref.read(settingsProvider.notifier).setLifeLines(value!);
                },
                items: List.generate(5, (index) {
                  return DropdownMenuItem<int>(
                    value: index + 1,
                    child: Text("${index + 1}"),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
