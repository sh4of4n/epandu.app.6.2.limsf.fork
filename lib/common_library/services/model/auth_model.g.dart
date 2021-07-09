// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiListAdapter extends TypeAdapter<RegisteredDiArmasterProfile> {
  @override
  final int typeId = 5;

  @override
  RegisteredDiArmasterProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegisteredDiArmasterProfile(
      iD: fields[0] as String?,
      appId: fields[1] as String?,
      merchantNo: fields[2] as String?,
      userId: fields[3] as String?,
      sponsor: fields[4] as String?,
      sponsorAppId: fields[5] as String?,
      appCode: fields[6] as String?,
      appVersion: fields[7] as String?,
      deleted: fields[8] as String?,
      createUser: fields[9] as String?,
      createDate: fields[10] as String?,
      editUser: fields[11] as String?,
      editDate: fields[12] as String?,
      compCode: fields[13] as String?,
      branchCode: fields[14] as String?,
      transtamp: fields[15] as String?,
      appBackgroundPhotoPath: fields[16] as String?,
      merchantIconFilename: fields[17] as String?,
      merchantBannerFilename: fields[18] as String?,
      merchantProfilePhotoFilename: fields[19] as String?,
      name: fields[20] as String?,
      shortName: fields[21] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RegisteredDiArmasterProfile obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.iD)
      ..writeByte(1)
      ..write(obj.appId)
      ..writeByte(2)
      ..write(obj.merchantNo)
      ..writeByte(3)
      ..write(obj.userId)
      ..writeByte(4)
      ..write(obj.sponsor)
      ..writeByte(5)
      ..write(obj.sponsorAppId)
      ..writeByte(6)
      ..write(obj.appCode)
      ..writeByte(7)
      ..write(obj.appVersion)
      ..writeByte(8)
      ..write(obj.deleted)
      ..writeByte(9)
      ..write(obj.createUser)
      ..writeByte(10)
      ..write(obj.createDate)
      ..writeByte(11)
      ..write(obj.editUser)
      ..writeByte(12)
      ..write(obj.editDate)
      ..writeByte(13)
      ..write(obj.compCode)
      ..writeByte(14)
      ..write(obj.branchCode)
      ..writeByte(15)
      ..write(obj.transtamp)
      ..writeByte(16)
      ..write(obj.appBackgroundPhotoPath)
      ..writeByte(17)
      ..write(obj.merchantIconFilename)
      ..writeByte(18)
      ..write(obj.merchantBannerFilename)
      ..writeByte(19)
      ..write(obj.merchantProfilePhotoFilename)
      ..writeByte(20)
      ..write(obj.name)
      ..writeByte(21)
      ..write(obj.shortName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
