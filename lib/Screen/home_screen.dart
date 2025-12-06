import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amber),
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Center(
          child: (SizedBox(
            width: 300,
            height: 375,

            child: Card(
              color: Colors.white,

              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Card(
                      child: SizedBox(
                        width: 225,
                        height: 300,
                        child: Card(
                          color: Colors.black,
                          elevation: 100,
                          

                          borderOnForeground: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                       
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 150,
                                height: 60,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                      Colors.white,
                                    ),
                                    shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(16),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/Map_Screen");
                                  },
                                  child: Text(
                                    "Map",
                                    style: GoogleFonts.albertSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 50),

                              SizedBox(
                                width: 150,
                                height: 60,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                      Colors.red,
                                    ),
                                    shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(16),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/SoS_Screen");
                                  },
                                  child: Text(
                                    "SOS",
                                    style: GoogleFonts.albertSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                      ),
                      
                      
                    ),
                    
                  ),

                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
