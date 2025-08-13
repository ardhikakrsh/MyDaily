// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoodEntryAdapter extends TypeAdapter<MoodEntry> {
  @override
  final int typeId = 0;

  @override
  MoodEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoodEntry(
      mood: fields[0] as String,
      feeling: fields[1] as String,
      reasonActivity: fields[2] as String,
      note: fields[3] as String,
      createdAt: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MoodEntry obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.mood)
      ..writeByte(1)
      ..write(obj.feeling)
      ..writeByte(2)
      ..write(obj.reasonActivity)
      ..writeByte(3)
      ..write(obj.note)
      ..writeByte(4)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
