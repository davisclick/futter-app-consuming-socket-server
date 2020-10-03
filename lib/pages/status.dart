import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:band_names/services/socket_service.dart';


class StatusPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Text('Server Status: ${ socketService.serverStatus }')
          ]
        )
     ),
     floatingActionButton: FloatingActionButton(
       onPressed: (){
         socketService.emit('flutter-message', { 
           'name': 'Flutter', 
           'message' : 'Hello from Flutter!' 
          });
       },
       child: Icon( Icons.message ),
       elevation: 1,
      ),
       
   );
  }
}