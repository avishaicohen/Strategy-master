

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:pit_scout/Model/GameData.dart';
import 'package:flutter/material.dart';

import '../DataPackages.dart';

class GameDataModel extends ChangeNotifier {
  GameData gameData = new GameData();

  void setWinningAlliance(String _winningAlliance){
    this.gameData.winningAlliance = _winningAlliance;
  }

  void setGameData(String _qualNumber, String _tournament, String _userId, String _teamNumber, String _teamName,
      String allianceColor) {
    this.gameData.qualNumber = _qualNumber;
    this.gameData.tournament = _tournament;
    this.gameData.userId = _userId;
    this.gameData.teamNumber = _teamNumber;
    this.gameData.teamName = _teamName;
    this.gameData.allianceColor = allianceColor;
  }

  void setPreGameData(String _startingPosition) {
    this.gameData.startingPosition = _startingPosition;
    print(this.gameData.startingPosition);
  }

  void setAutoGameData(int _innerScore, int _outerScore, int _bottomScore, int _autoPowerCellsOnRobotEndOfAuto,
      int _upperShoot, int _bottomShoot, List<AutoUpperTargetData> _upperData,
      bool _climb1BallCollected, bool _climb2BallCollected, bool _climb3BallCollected, bool _climb4BallCollected,
      bool _climb5BallCollected, bool _trench1BallCollected, bool _trench2BallCollected, bool _trench3BallCollected,
      bool _trench4BallCollected, bool _trench5BallCollected) {
    this.gameData.autoInnerScore = _innerScore;
    this.gameData.autoOuterScore = _outerScore;
    this.gameData.autoBottomScore = _bottomScore;
    this.gameData.autoPowerCellsOnRobotEndOfAuto = _autoPowerCellsOnRobotEndOfAuto;
    this.gameData.autoUpperShoot = _upperShoot;
    this.gameData.autoBottomShoot = _bottomShoot;
    this.gameData.autoUpperData = _upperData;
    this.gameData.climb1BallCollected = _climb1BallCollected;
    this.gameData.climb2BallCollected = _climb2BallCollected;
    this.gameData.climb3BallCollected = _climb3BallCollected;
    this.gameData.climb4BallCollected = _climb4BallCollected;
    this.gameData.climb5BallCollected = _climb5BallCollected;
    this.gameData.trench1BallCollected = _trench1BallCollected;
    this.gameData.trench2BallCollected = _trench2BallCollected;
    this.gameData.trench3BallCollected = _trench3BallCollected;
    this.gameData.trench4BallCollected = _trench4BallCollected;
    this.gameData.trench5BallCollected = _trench5BallCollected;
  }

  void setTeleopGameData(int _innerScore, int _outerScore, int _bottomScore, bool _trenchRotate,
      bool _trenchStop, int _upperShoot, int _bottomShoot, List<TeleopUpperTargetData> _upperData) {
    this.gameData.teleopInnerScore = _innerScore;
    this.gameData.teleopOuterScore = _outerScore;
    this.gameData.teleopBottomScore = _bottomScore;
    this.gameData.trenchRotate = _trenchRotate;
    this.gameData.trenchStop = _trenchStop;
    this.gameData.teleopUpperShoot = _upperShoot;
    this.gameData.teleopBottomShoot = _bottomShoot;
    this.gameData.teleopUpperData = _upperData;
  }

  void setEndGameData(String _climbStatus, int _climbLocation, String _whyDidntClimb) {
    this.gameData.climbStatus = _climbStatus;
    this.gameData.climbLocation = _climbLocation;
    this.gameData.whyDidntClimb = _whyDidntClimb;
  }

  String getUserId(){
    return this.gameData.userId;
  }

  void resetGameData() {
    this.gameData = new GameData();
  }

  void saveGameData(GameData dataToSave) {
    if (dataToSave.climbLocation==301){
      dataToSave.climbLocation=300;
    }
    Firestore.instance.collection('tournaments').document(dataToSave.tournament).collection('teams')
        .document(dataToSave.teamNumber).collection('games').document(dataToSave.qualNumber)
        .setData({
      'Game scouting': {
        'allianceColor' : dataToSave.allianceColor,
        'PreGame' : {
          'startingPosition': dataToSave.startingPosition,
        },
        'Auto' : {
          'innerScore': dataToSave.autoInnerScore,
          'outerScore': dataToSave.autoOuterScore,
          'bottomScore': dataToSave.autoBottomScore,
          'bottomShoot': dataToSave.autoBottomShoot,
          'upperShoot': dataToSave.autoUpperShoot,
          'autoPowerCellsOnRobotEndOfAuto': dataToSave.autoPowerCellsOnRobotEndOfAuto,
          'climb1BallCollected': dataToSave.climb1BallCollected,
          'climb2BallCollected': dataToSave.climb2BallCollected,
          'climb3BallCollected': dataToSave.climb3BallCollected,
          'climb4BallCollected': dataToSave.climb4BallCollected,
          'climb5BallCollected': dataToSave.climb5BallCollected,
          'trench1BallCollected': dataToSave.trench1BallCollected,
          'trench2BallCollected': dataToSave.trench2BallCollected,
          'trench3BallCollected': dataToSave.trench3BallCollected,
          'trench4BallCollected': dataToSave.trench4BallCollected,
          'trench5BallCollected': dataToSave.trench5BallCollected,
          'upperData' : autoUpperTargetDataToData(dataToSave.autoUpperData),
        },
        'Teleop' : {
          'Sum' : {
            'innerScore': dataToSave.teleopInnerScore,
            'outerScore': dataToSave.teleopOuterScore,
            'upperShoot' : dataToSave.teleopUpperShoot,
            'bottomScore': dataToSave.teleopBottomScore,
            'bottomShoot' : dataToSave.teleopBottomShoot,
            'trenchRotate': dataToSave.trenchRotate,
            'trenchStop': dataToSave.trenchStop,
          },
          'upperData' : teleopUpperTargetDataToData(dataToSave.teleopUpperData),
        },
        'EndGame' : {
          'climbStatus': dataToSave.climbStatus,
          'climbLocation': dataToSave.climbLocation,
          'climbLocation': dataToSave.climbStatus=='טיפס בהצלחה'
              ? dataToSave.climbLocation
              : null,
          'whyDidntClimb': dataToSave.climbStatus=='ניסה ולא הצליח'
              ? dataToSave.whyDidntClimb
              : null,
        },
      },
    });
    Firestore.instance.collection('users').document(dataToSave.userId).collection('tournaments').document(dataToSave.tournament)
        .collection('gamesToScout').document(dataToSave.qualNumber).updateData({
      'saved': true,
    });
  }

  List<Map<String, dynamic>> teleopUpperTargetDataToData(List<TeleopUpperTargetData> list) {
    List<Map<String, dynamic>> listToReturn = [];
    for (int i = 0; i < list.length; i++){
      listToReturn.add({
        'innerScore': list[i].innerPort,
        'outerScore': list[i].outerPort,
        'shoot': list[i].powerCellsShoot,
        'x': double.parse(list[i].shotFrom['x'].toStringAsFixed(5)),
        'y': double.parse(list[i].shotFrom['y'].toStringAsFixed(5)),
      });
    }
    return listToReturn;
  }

  List<Map<String, int>> autoUpperTargetDataToData(List<AutoUpperTargetData> list) {
    List<Map<String, int>> listToReturn = [];
    for (int i = 0; i < list.length; i++){
      listToReturn.add({
        'innerScore': list[i].innerPort,
        'outerScore': list[i].outerPort,
        'shoot': list[i].powerCellsShoot,
      });
    }
    return listToReturn;
  }
}