
import 'package:flutterrestaurant/viewobject/common/ps_object.dart';
import 'package:quiver/core.dart';

class UserInfo extends PsObject<UserInfo> {
  UserInfo({
    this.isBanned,
  });

  String isBanned;

  @override
  bool operator ==(dynamic other) =>
      other is UserInfo && isBanned == other.isBanned;

  @override
  int get hashCode => hash2(isBanned.hashCode, isBanned.hashCode);

  @override
  String getPrimaryKey() {
    return isBanned;
  }

  @override
  List<UserInfo> fromMapList(List<dynamic> dynamicDataList) {
    final List<UserInfo> subCategoryList = <UserInfo>[];

    if (dynamicDataList != null) {
      for (dynamic dynamicData in dynamicDataList) {
        if (dynamicData != null) {
          subCategoryList.add(fromMap(dynamicData));
        }
      }
    }
    return subCategoryList;
  }

  @override
  UserInfo fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return UserInfo(
        isBanned: dynamicData['is_banned'],
      );
    } else {
      return null;
    }
  }

  @override
  Map<String, dynamic> toMap(UserInfo object) {
    if (object != null) {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['is_banned'] = object.isBanned;

      return data;
    } else {
      return null;
    }
  }

  @override
  List<Map<String, dynamic>> toMapList(List<UserInfo> objectList) {
    final List<Map<String, dynamic>> mapList = <Map<String, dynamic>>[];
    if (objectList != null) {
      for (UserInfo data in objectList) {
        if (data != null) {
          mapList.add(toMap(data));
        }
      }
    }
    return mapList;
  }
}
