// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TelcoAdapter extends TypeAdapter<TelcoComm> {
  @override
  final int typeId = 2;

  @override
  TelcoComm read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TelcoComm(
      iD: fields[0] as String?,
      telcoName: fields[1] as String?,
      telcoImageUri: fields[2] as String?,
      acctNo: fields[3] as String?,
      prepaidAccessMenu: fields[4] as String?,
      sponsorMarkupRate1: fields[5] as String?,
      sponsorMarkupRateUom1: fields[6] as String?,
      sponsorMarkupRate2: fields[7] as String?,
      sponsorMarkupRateUom2: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TelcoComm obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.iD)
      ..writeByte(1)
      ..write(obj.telcoName)
      ..writeByte(2)
      ..write(obj.telcoImageUri)
      ..writeByte(3)
      ..write(obj.acctNo)
      ..writeByte(4)
      ..write(obj.prepaidAccessMenu)
      ..writeByte(5)
      ..write(obj.sponsorMarkupRate1)
      ..writeByte(6)
      ..write(obj.sponsorMarkupRateUom1)
      ..writeByte(7)
      ..write(obj.sponsorMarkupRate2)
      ..writeByte(8)
      ..write(obj.sponsorMarkupRateUom2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TelcoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BillAdapter extends TypeAdapter<ServiceComm> {
  @override
  final int typeId = 3;

  @override
  ServiceComm read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServiceComm(
      iD: fields[0] as String?,
      telcoName: fields[1] as String?,
      telcoImageUri: fields[2] as String?,
      acctNo: fields[3] as String?,
      prepaidAccessMenu: fields[4] as String?,
      markupRate: fields[5] as String?,
      markupRateUom: fields[6] as String?,
      sponsorMarkupRate1: fields[7] as String?,
      sponsorMarkupRateUom1: fields[8] as String?,
      sponsorMarkupRate2: fields[9] as String?,
      sponsorMarkupRateUom2: fields[10] as String?,
      memberDiscRate: fields[11] as String?,
      memberDiscRateUom: fields[12] as String?,
      incentiveRate: fields[13] as String?,
      incentiveRateUom: fields[14] as String?,
      servChrg: fields[15] as String?,
      servChrgUom: fields[16] as String?,
      servChrgEntitle: fields[17] as String?,
      servChrgEntitleUom: fields[18] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ServiceComm obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.iD)
      ..writeByte(1)
      ..write(obj.telcoName)
      ..writeByte(2)
      ..write(obj.telcoImageUri)
      ..writeByte(3)
      ..write(obj.acctNo)
      ..writeByte(4)
      ..write(obj.prepaidAccessMenu)
      ..writeByte(5)
      ..write(obj.markupRate)
      ..writeByte(6)
      ..write(obj.markupRateUom)
      ..writeByte(7)
      ..write(obj.sponsorMarkupRate1)
      ..writeByte(8)
      ..write(obj.sponsorMarkupRateUom1)
      ..writeByte(9)
      ..write(obj.sponsorMarkupRate2)
      ..writeByte(10)
      ..write(obj.sponsorMarkupRateUom2)
      ..writeByte(11)
      ..write(obj.memberDiscRate)
      ..writeByte(12)
      ..write(obj.memberDiscRateUom)
      ..writeByte(13)
      ..write(obj.incentiveRate)
      ..writeByte(14)
      ..write(obj.incentiveRateUom)
      ..writeByte(15)
      ..write(obj.servChrg)
      ..writeByte(16)
      ..write(obj.servChrgUom)
      ..writeByte(17)
      ..write(obj.servChrgEntitle)
      ..writeByte(18)
      ..write(obj.servChrgEntitleUom);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
