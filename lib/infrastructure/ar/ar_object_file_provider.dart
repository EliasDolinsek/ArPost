import 'package:ar_post/app/ar/ar_actions_bloc.dart';

String getFileUrlOfArObject(ArObject arObject){
  switch (arObject) {
    case ArObject.helloWorldText:
      return "models.scnassets/hello_world.dae";
    case ArObject.helloWorldGoldText:
      return "models.scnassets/hello_world_gold.dae";
    case ArObject.file:
      return "models.scnassets/file.dae";
    default: throw Exception("Can't find url for ArObject $arObject");
  }
}