import 'package:flutter/material.dart';
import '/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldTime() async {
    WorldTime instance = WorldTime(
      location: 'Algiers',
      flag: 'dz.png',
      url: 'Africa/Algiers',
    );
    await instance.getTime();
    Navigator.pushReplacementNamed(
      // push infos into home page
      context,
      '/home',
      arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDaytime': instance.isDaytime,
      },
    );
  }

  // Shows a spinner (SpinKitFadingCube) while fetching
  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(child: SpinKitFadingCube(color: Colors.white, size: 50.0)),
    );
  }
}
