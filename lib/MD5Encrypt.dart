import 'package:simple_rsa/simple_rsa.dart';
import 'Model/GameData.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

Future<String> MD5Encrypt(String toEncrypt) async {
  return md5.convert(utf8.encode(toEncrypt)).toString();
}

Future objectEncrypt(GameData dataToSave) async{
  var futures = List<Future>();
  futures.add(MD5Encrypt(dataToSave.allianceColor));
  futures.add(MD5Encrypt(dataToSave.winningAlliance));
  futures.add(MD5Encrypt(dataToSave.startingPosition));
  futures.add(MD5Encrypt(dataToSave.autoInnerScore.toString()));
  futures.add(MD5Encrypt(dataToSave.autoOuterScore.toString()));
  futures.add(MD5Encrypt(dataToSave.autoUpperShoot.toString()));
  futures.add(MD5Encrypt(dataToSave.autoBottomScore.toString()));
  futures.add(MD5Encrypt(dataToSave.autoBottomShoot.toString()));
  futures.add(MD5Encrypt(dataToSave.autoPowerCellsOnRobotEndOfAuto.toString()));
  futures.add(MD5Encrypt(dataToSave.climb1BallCollected.toString()));
  futures.add(MD5Encrypt(dataToSave.climb2BallCollected.toString()));
  futures.add(MD5Encrypt(dataToSave.climb3BallCollected.toString()));
  futures.add(MD5Encrypt(dataToSave.climb4BallCollected.toString()));
  futures.add(MD5Encrypt(dataToSave.climb5BallCollected.toString()));
  futures.add(MD5Encrypt(dataToSave.trench1BallCollected.toString()));
  futures.add(MD5Encrypt(dataToSave.trench2BallCollected.toString()));
  futures.add(MD5Encrypt(dataToSave.trench3BallCollected.toString()));
  futures.add(MD5Encrypt(dataToSave.trench4BallCollected.toString()));
  futures.add(MD5Encrypt(dataToSave.trench5BallCollected.toString()));
  futures.add(MD5Encrypt(dataToSave.trenchSteal1BallCollected.toString()));
  futures.add(MD5Encrypt(dataToSave.trenchSteal2BallCollected.toString()));
  futures.add(MD5Encrypt(dataToSave.autoLine.toString()));
  futures.add(MD5Encrypt(dataToSave.teleopInnerScore.toString())); //22
  futures.add(MD5Encrypt(dataToSave.teleopOuterScore.toString())); //23
  futures.add(MD5Encrypt(dataToSave.teleopUpperShoot.toString()));//24
  futures.add(MD5Encrypt(dataToSave.teleopBottomScore.toString()));//25
  futures.add(MD5Encrypt(dataToSave.teleopBottomShoot.toString()));//26
  futures.add(MD5Encrypt(dataToSave.fouls.toString()));//27
  futures.add(MD5Encrypt(dataToSave.preventedBalls.toString()));//28
  futures.add(MD5Encrypt(dataToSave.trenchRotate.toString()));//29
  futures.add(MD5Encrypt(dataToSave.trenchStop.toString()));//30
  futures.add(MD5Encrypt(dataToSave.didDefense.toString()));//31
  futures.add(MD5Encrypt(dataToSave.ballsRP.toString()));//32
  futures.add(MD5Encrypt(dataToSave.climbStatus.toString()));//33
  futures.add(MD5Encrypt(dataToSave.climbLocation.toString()));//34
  futures.add(MD5Encrypt(dataToSave.whyDidntClimb.toString()));//35
  futures.add(MD5Encrypt(dataToSave.climbRP.toString()));//36

  var teleopUpperDataTemp = List<Future>();
  dataToSave.teleopUpperData.forEach((element) {
    var temp = List<Future>();
    temp.add(MD5Encrypt(element.innerPort.toString()));
    temp.add(MD5Encrypt(element.outerPort.toString()));
    temp.add(MD5Encrypt(element.powerCellsShoot.toString()));
    temp.add(MD5Encrypt(element.shotFrom['x'].toString()));
    temp.add(MD5Encrypt(element.shotFrom['y'].toString()));
    teleopUpperDataTemp.add(Future.wait(temp));
  });
  futures.add(Future.wait(teleopUpperDataTemp));

  var autoUpperDatTemp = List<Future>();
  dataToSave.autoUpperData.forEach((element) {
    var temp = List<Future>();
    temp.add(MD5Encrypt(element.innerPort.toString()));
    temp.add(MD5Encrypt(element.outerPort.toString()));
    temp.add(MD5Encrypt(element.powerCellsShoot.toString()));
    autoUpperDatTemp.add(Future.wait(temp));
  });
  futures.add(Future.wait(autoUpperDatTemp));

  var res =  await Future.wait(futures);
  return res;
}


