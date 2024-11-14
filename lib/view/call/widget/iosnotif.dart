import 'package:flutter/material.dart';

class IncomingCallScreen extends StatelessWidget {
  final String callerName;
  // final String callerImage;

  const IncomingCallScreen({super.key, required this.callerName,}); //required this.callerImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // CircleAvatar(
          //   radius: 50,
          //   backgroundImage: AssetImage(callerImage),
          // ),
          const SizedBox(height: 20),
          const Text(
            'Incoming Call',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          const SizedBox(height: 10),
          Text(
            callerName,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.call_end, color: Colors.red, size: 40),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              IconButton(
                icon: const Icon(Icons.call, color: Colors.green, size: 40),
                onPressed: () {
                  // Handle call accept logic here
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
