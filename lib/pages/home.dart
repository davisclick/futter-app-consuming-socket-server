import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:band_names/models/band.dart';



class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'Metalica 1 ', votes: 5),
    Band(id: '2', name: 'Metalica 2', votes: 2),
    Band(id: '3', name: 'Metalica 3', votes: 10),
    Band(id: '4', name: 'Metalica 4', votes: 3)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames', style: TextStyle( color: Colors.black87 ) ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder:  ( context, i ) => _bandTile(bands[i])
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() { addNewBand(); },
        elevation: 1,
        child: Icon( Icons.add ),
      ),
   );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key( band.id ),
      direction: DismissDirection.startToEnd,
      onDismissed: ( direction ) {
        print('direction: $direction');
      },
      background: Container(
        padding: EdgeInsets.only( left: 8.0 ),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete Band', style: TextStyle( color: Colors.white ),),
        )
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text( band.name.substring(0,2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text('${ band.votes }', style: TextStyle( fontSize: 20 )),
        onTap: (){
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    
    final textController = new TextEditingController();

    if( Platform.isAndroid ){
        showDialog(
          context: context,
          builder: ( context ){
            return AlertDialog(
              title: Text('New Band Name'),
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                  child: Text( 'Add' ),
                  elevation: 5,
                  textColor: Colors.blue,
                  onPressed: () => addBandToList( textController.text )
                )
              ],
            );
          }
        );
    }
    else if( Platform.isIOS ){
      showCupertinoDialog(
        context: null, 
        builder: ( _ ) {
          return CupertinoAlertDialog(
            title: Text('New Band Name'),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget> [
              CupertinoDialogAction(
                isDefaultAction:  true,
                child: Text('Add'),
                onPressed: () => addBandToList( textController.text )
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text('Dismiss'),
                onPressed: () => Navigator.pop(context)
              )
            ],
          );
        }
      );
    }
  }

  void addBandToList( String name ){

    if( name.length > 1){
      this.bands.add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }

}