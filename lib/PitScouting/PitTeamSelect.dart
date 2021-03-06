import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pit_scout/PitScouting/PitDataConsume.dart';

class PitTeamSelect extends StatelessWidget{
  final String tournament;
  final String userId;

  PitTeamSelect({Key key, this.tournament, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Container(
        padding: EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('tournaments').document(tournament).collection('teams').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text('Loading...');
              default:
                return ListView(
                  children: snapshot.data.documents
                      .map((DocumentSnapshot document) {
                    return  ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PitDataConsume(teamName: document['team_name'], teamNumber: document.documentID, tournament: tournament, saved: document['pit_scouting_saved'], userId: this.userId,)),
                        );
                      },
                      title: Text(document.documentID + " - " + document['team_name']),
                      leading: Icon(Icons.build,
                          color: document['pit_scouting_saved']
                              ? Colors.blue : Colors.red
                      ),
                    );
                  }).toList(),
                );
            }
          },
        ),
      ),
      ),
    );
  }

}

