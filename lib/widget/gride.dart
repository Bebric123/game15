import 'package:flutter/material.dart'; 
import 'package:google_fonts/google_fonts.dart'; 
import 'package:flutter_application_1/widget/color.dart'; 

class gride extends StatefulWidget { 
  final List<int> number; 
  final Function(int) onClick;  

  gride(this.number, this.onClick, {Key? key}) : super(key: key); 

  @override
  _grideState createState() => _grideState();
}

class _grideState extends State<gride> {
  Color widgetColor = Colors.black;

  @override 
  Widget build(BuildContext context) { 
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container( 
          height: MediaQuery.of(context).size.height * 0.63, 
          width: MediaQuery.of(context).size.width * 0.23, 
          child: GridView.builder( 
            itemCount: widget.number.length, 
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( 
              crossAxisCount: 4, 
            ), 
            itemBuilder: (context, index) { 
              return widget.number[index] != 16 
                  ? GestureDetector( 
                      onTap: () { 
                        widget.onClick(index);
                      }, 
                      child: Card( 
                        elevation: 10, 
                        color: widgetColor, 
                        shape: RoundedRectangleBorder( 
                          borderRadius: BorderRadius.circular(8), 
                        ), 
                        child: Container( 
                          height: 30, 
                          width: 30, 
                          decoration: BoxDecoration( 
                            color: widgetColor, 
                            borderRadius: BorderRadius.circular(8), 
                          ), 
                          child: Center( 
                            child: FittedBox( 
                              child: Text( 
                                widget.number[index].toString(), 
                                style: GoogleFonts.roboto( 
                                  color: Colors.white, 
                                  fontSize: 60, 
                                  fontWeight: FontWeight.bold, 
                                ), 
                              ), 
                            ), 
                          ), 
                        ), 
                      ), 
                    ) 
                  : const SizedBox.shrink(); 
            }, 
          ), 
        ),
        
        ElevatedButton(
          onPressed: () async {
            final selectedColor = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ColorSelectionScreen(),
              ),
            );
            if (selectedColor != null) {
              setState(() {
                widgetColor = selectedColor; 
              });
            }
          },
          child: Text(
            'Настройки',
            style: GoogleFonts.roboto( 
              color: Colors.black, 
              fontSize: 20, 
              fontWeight: FontWeight.bold, 
              ), 
            ),
        )
      ],
    );
  } 
}