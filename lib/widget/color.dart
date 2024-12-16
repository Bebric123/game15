import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 

class ColorSelectionScreen extends StatelessWidget {
  Color selectedColor = Colors.blue;

  void _handleColorSelection(BuildContext context, Color color) {
    Navigator.pop(context, color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Widget Color'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Select color for the widget:'),
            ElevatedButton(
              onPressed: () async {
                final Color? pickedColor = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Select Color',
                        style: GoogleFonts.roboto( 
                        color: Colors.black, 
                        fontSize: 20, 
                        fontWeight: FontWeight.bold, 
                      ), 
                        ),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text('Red'),
                              leading: const Icon(Icons.circle, color: Colors.red),
                              onTap: () {
                                _handleColorSelection(context, Colors.red);
                              },
                            ),
                            ListTile(
                              title: const Text('Orange'),
                              leading: const Icon(Icons.circle, color: Colors.orange),
                              onTap: () {
                                _handleColorSelection(context, Colors.orange);
                              },
                            ),
                            ListTile(
                              title: const Text('Yellow'),
                              leading: const Icon(Icons.circle, color: Colors.yellow),
                              onTap: () {
                                _handleColorSelection(context, Colors.yellow);
                              },
                            ),
                            ListTile(
                              title: const Text('Green'),
                              leading: const Icon(Icons.circle, color: Colors.green),
                              onTap: () {
                                _handleColorSelection(context, Colors.green);
                              },
                            ),
                            ListTile(
                              title: const Text('Cyan'),
                              leading: const Icon(Icons.circle, color: Colors.cyan),
                              onTap: () {
                                _handleColorSelection(context, Colors.cyan);
                              },
                            ),
                            ListTile(
                              title: const Text('Blue'),
                              leading: const Icon(Icons.circle, color: Colors.blue),
                              onTap: () {
                                _handleColorSelection(context, Colors.blue);
                              },
                            ),
                            ListTile(
                              title: const Text('Purple'),
                              leading: const Icon(Icons.circle, color: Colors.purple),
                              onTap: () {
                                _handleColorSelection(context, Colors.purple);
                              },
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
                if (pickedColor != null) {
                  Navigator.of(context).pop(pickedColor);
                }
              },
              child: Text(
                'Pick a color',
                style: GoogleFonts.roboto( 
                  color: Colors.black, 
                  fontSize: 10, 
                  fontWeight: FontWeight.bold, 
                ), 
                ),
            )
          ],
        ),
      ),
    );
  }
}