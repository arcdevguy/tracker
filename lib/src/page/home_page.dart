import 'dart:math' as math show pi;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../provider/location_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Tracking: ${context.watch<LocationProvider>().isTracking ? 'yes' : 'no'}'),
        actions: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              if (context.read<LocationProvider>().isTracking) {
                return Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.loop),
                  ),
                );
              }
              return const Gap(1);
            },
          )
        ],
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            if (context.read<LocationProvider>().isTracking) {
              return SizedBox.expand(
                child: ListView.builder(
                  itemCount: context.read<LocationProvider>().logs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(context.read<LocationProvider>().logs[index]);
                  },
                ),
              );
            }
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  child: Icon(Icons.no_cell_outlined),
                ),
                Text('not tracking'),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<LocationProvider>().isTracking
            ? context.read<LocationProvider>().stopTracking()
            : context.read<LocationProvider>().startTracking(),
        child:
            context.read<LocationProvider>().isTracking ? const Icon(Icons.stop) : const Icon(Icons.play_arrow_sharp),
      ),
    );
  }
}
