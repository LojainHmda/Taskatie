import 'package:hive/hive.dart';
import 'package:tasktie/core/model/task_modek.dart';

class TaskAdapter extends TypeAdapter<Task> {
  @override
  Task read(BinaryReader reader) {
    return Task(
        title: reader.readString(),
        id: reader.readString(),
        note: reader.readString(),
        startTime: reader.readString(),
        endTime: reader.readString(),
        date: reader.readString(),
        iscomplet: reader.readBool(),
        color: reader.readInt());
  }

  @override
  // TODO: implement typeId
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, Task obj) {
   writer.writeString(obj.title);
  writer.writeString(obj.id);
  writer.writeString(obj.note);
  writer.writeString(obj.startTime);
  writer.writeString(obj.endTime);
  writer.writeString(obj.date);
  writer.writeBool(obj.iscomplet);
  writer.writeInt(obj.color);
  }
}
