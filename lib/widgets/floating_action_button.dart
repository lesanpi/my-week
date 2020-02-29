import 'package:flutter/material.dart';

class FloatingActionButtonFab extends StatefulWidget{

  final IconData iconData;
  final VoidCallback onPressed;
  final Color color;

  FloatingActionButtonFab({
    Key key,
    @required this.iconData,
    @required this.onPressed,
    @required this.color
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FloatingActionButtonFab();
  }
  
}

class _FloatingActionButtonFab extends State<FloatingActionButtonFab>{

  bool fav = false;

  /*void onPressedFav(){

      setState(() {
        fav = !fav;
      });


      Scaffold.of(context).showSnackBar(
          SnackBar(
              content: Text(fav ? "Agregado a tus favoritos" : "Quitado de tus favoritos")
          )
      );

  }*/

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FloatingActionButton(
      backgroundColor: widget.color,//Color(0xFF11DA53)//Color(0xFF4066A3), //0xFF11DA53
      mini: true,
      tooltip: "Fav",
      onPressed: widget.onPressed,
      child: Icon(
        //fav ? Icons.favorite : Icons.favorite_border,
        widget.iconData,
        color: Colors.white,
      ),
      heroTag: null,
      elevation: 0,
    );
  }

}