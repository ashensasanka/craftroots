import 'package:json_annotation/json_annotation.dart';
part 'addVideo.g.dart';

@JsonSerializable()
class AddVideo {
  @JsonKey(name:"id")
  String? id;

  @JsonKey(name:"by")
  String? by;

  @JsonKey(name:"level")
  String? level;

  @JsonKey(name:"name")
  String? name;

  @JsonKey(name:"thumb")
  String? thumb;

  @JsonKey(name:"timeStamp")
  DateTime? timeStamp;

  @JsonKey(name:"url")
  String? url;


  AddVideo({
    this.id,
   this.by,
   this.level,
   this.name,
    this.thumb,
    this.timeStamp,
    this.url
});

  factory AddVideo.fromJson(Map<String, dynamic> json) => _$AddVideoFromJson(json);

  Map<String, dynamic> toJson() => _$AddVideoToJson(this);

}