import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_thumb_getter/src/image_format.dart';
import 'package:video_thumb_getter/video_thumbnail.dart';

void main() {
  const channel = MethodChannel('video_thumbnail');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      final m = methodCall.method;
      final a = methodCall.arguments as Map<String, dynamic>;

      return '$m=${a["video"]}:${a["path"]}:${a["format"]}:${a["maxhow"]}:${a["quality"]}';
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('thumbnailData', () async {
    expect(
      await VideoThumbnail.thumbnailFile(
        video: 'video',
        thumbnailPath: 'path',
        imageFormat: ImageFormat.JPEG,
        maxWidth: 123,
        maxHeight: 123,
        quality: 45,
      ),
      'file=video:path:0:123:45',
    );
  });
}
