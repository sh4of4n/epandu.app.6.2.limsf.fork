// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmergencyContactAdapter extends TypeAdapter<SosContact> {
  @override
  final typeId = 1;

  @override
  SosContact read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SosContact(
      iD: fields[0] as String,
      sosContactType: fields[1] as String,
      sosContactSubtype: fields[2] as String,
      sosContactCode: fields[3] as String,
      sosContactName: fields[4] as String,
      add: fields[5] as String,
      phone: fields[6] as String,
      latitude: fields[7] as String,
      longtitude: fields[8] as String,
      areaCode: fields[9] as String,
      skipCall: fields[10] as String,
      createUser: fields[11] as String,
      editUser: fields[12] as String,
      editDate: fields[13] as String,
      compCode: fields[14] as dynamic,
      branchCode: fields[15] as dynamic,
      rowKey: fields[16] as String,
      lastupload: fields[17] as dynamic,
      transtamp: fields[18] as String,
      deleted: fields[19] as String,
      lastEditedBy: fields[20] as String,
      createdBy: fields[21] as String,
      createDate: fields[22] as String,
      remark: fields[23] as String,
      distance: fields[24] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SosContact obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.iD)
      ..writeByte(1)
      ..write(obj.sosContactType)
      ..writeByte(2)
      ..write(obj.sosContactSubtype)
      ..writeByte(3)
      ..write(obj.sosContactCode)
      ..writeByte(4)
      ..write(obj.sosContactName)
      ..writeByte(5)
      ..write(obj.add)
      ..writeByte(6)
      ..write(obj.phone)
      ..writeByte(7)
      ..write(obj.latitude)
      ..writeByte(8)
      ..write(obj.longtitude)
      ..writeByte(9)
      ..write(obj.areaCode)
      ..writeByte(10)
      ..write(obj.skipCall)
      ..writeByte(11)
      ..write(obj.createUser)
      ..writeByte(12)
      ..write(obj.editUser)
      ..writeByte(13)
      ..write(obj.editDate)
      ..writeByte(14)
      ..write(obj.compCode)
      ..writeByte(15)
      ..write(obj.branchCode)
      ..writeByte(16)
      ..write(obj.rowKey)
      ..writeByte(17)
      ..write(obj.lastupload)
      ..writeByte(18)
      ..write(obj.transtamp)
      ..writeByte(19)
      ..write(obj.deleted)
      ..writeByte(20)
      ..write(obj.lastEditedBy)
      ..writeByte(21)
      ..write(obj.createdBy)
      ..writeByte(22)
      ..write(obj.createDate)
      ..writeByte(23)
      ..write(obj.remark)
      ..writeByte(24)
      ..write(obj.distance);
  }
}
