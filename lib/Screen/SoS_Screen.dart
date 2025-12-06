// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SosScreen extends StatefulWidget {
//   const SosScreen({super.key});

//   @override
//   State<SosScreen> createState() => _SosScreenState();
// }

// class _SosScreenState extends State<SosScreen> {
//   List<Map<dynamic, dynamic>> cords = [];
//   late dynamic ts;
//   final DatabaseReference _ref = FirebaseDatabase.instance.ref(
//     'devices/device_001',
//   );

//   @override
//   void initState() {
//     super.initState();

//     _ref.onValue.listen((event) {
//       final data = event.snapshot.value;

//       if (data != null && data is Map) {
//         if (data['SoS'] == true) {
//           double lat = data['lat'];
//           double lon = data['lon'];
//           final ts = data['ts'];

//           cords.add({'lat': lat, 'lon': lon, 'ts': ts});

//           setState(() {});
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("Cords length: ${cords.runtimeType}");

//     return Scaffold(
//       appBar: AppBar(title: Text("SoS History")),
//       body: Center(
//         child: cords.isEmpty
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(color: Colors.white),
//                   SizedBox(height: 10),
//                   Text(
//                     "Waiting for SoS data...",
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ],
//               )
//             : ListView.builder(
//                 itemCount: cords.length,
//                 itemBuilder: (context, index) {
//                   final cord = cords[index];
//                   // print(cord['ts']);

//                   return SizedBox(
//                     width: 500,
//                     child: Card(
//                       elevation: 10,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       color: const Color.fromARGB(77, 175, 168, 168),
//                       child: ListTile(
//                         leading: SizedBox(
//                           width: 100,
//                           child: Text(
//                             "Time : ${cord['ts']}",

//                             style: GoogleFonts.albertSans(
//                               color: Colors.white,
//                               fontSize: 15,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         title: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             elevation: 10,
//                             backgroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadiusGeometry.all(
//                                 Radius.circular(16),
//                               ),
//                             ),
//                           ),
//                           onPressed: () {
//                             // Navigator.pushNamed(
//                             //   context,
//                             //   '/SoS_location',
//                             //   arguments: {cord},
//                             // );
//                           },
//                           child: Text(
//                             "Show",
//                             style: GoogleFonts.albertSans(
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         trailing: SizedBox(
//                           width: 110,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               elevation: 10,
//                               backgroundColor: Colors.red,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadiusGeometry.all(
//                                   Radius.circular(16),
//                                 ),
//                               ),
//                             ),
//                             onPressed: () {
//                               cords.removeAt(index);
//                               setState(() {});
//                             },
//                             child: Text(
//                               "Remove",
//                               style: GoogleFonts.albertSans(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class SosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        width: 500,
        height: 350,
        child: Image.asset(
          "assets/Working on website.gif",
          alignment: AlignmentGeometry.center,
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
