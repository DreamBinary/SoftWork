import 'dart:async';

import 'package:account/app/component/loading_page.dart';
import 'package:account/app/component/mytopbar.dart';
import 'package:account/app/component/version_ctrl.dart';
import 'package:account/app/data/net/api_sound.dart';
import 'package:account/app/theme/app_text_theme.dart';
import 'package:account/res/assets_res.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../routes/app_pages.dart';
import 'audio_item.dart';

const int tSampleRate = 44000;

class SoundPage extends StatefulWidget {
  const SoundPage({super.key});

  @override
  _SoundPageState createState() => _SoundPageState();
}

class _SoundPageState extends State<SoundPage> {
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mRecorderIsInited = false;
  String? _mPath;
  StreamSubscription? _mRecordingDataSubscription;

  Future<void> _openRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await _mRecorder!.openRecorder();

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
      AVAudioSessionCategoryOptions.allowBluetooth |
      AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
      AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    setState(() {
      _mRecorderIsInited = true;
    });
  }

  @override
  void initState() {
    super.initState();
    // Be careful : openAudioSession return a Future.
    // Do not access your FlutterSoundPlayer or FlutterSoundRecorder before the completion of the Future
    _openRecorder();
  }

  @override
  void dispose() {
    stopRecorder();
    _mRecorder!.closeRecorder();
    _mRecorder = null;
    super.dispose();
  }

  Future<void> record() async {
    assert(_mRecorderIsInited);
    var tempDir = await getTemporaryDirectory();
    _mPath = '${tempDir.path}/sound_tmp${ext[Codec.pcm16WAV.index]}';
    await _mRecorder!.startRecorder(
      toFile: _mPath,
      codec: Codec.pcm16WAV,
    );
    setState(() {});
  }

  Future<void> stopRecorder() async {
    await _mRecorder!.stopRecorder();
    if (_mRecordingDataSubscription != null) {
      await _mRecordingDataSubscription!.cancel();
      _mRecordingDataSubscription = null;
    }
  }

  // _Fn? getRecorderFn() {
  //   if (!_mRecorderIsInited) {
  //     return null;
  //   }
  //   return _mRecorder!.isStopped
  //       ? record
  //       : () {
  //           stopRecorder().then((value) => setState(() {}));
  //         };
  // }
  bool started = false;

  @override
  Widget build(BuildContext context) {
    int version = VersionCtrl
        .of(context)
        ?.version ?? 0;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsRes.SOUND_BG),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyTopBar(
          middle: Text(
            started ? "正在录音" : "请说话",
            style: AppTS.normal,
          ),
          trailing: version == 0
              ? null
              : Padding(
            padding: const EdgeInsets.all(8),
            child: Material(
              color: Colors.white,
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: IconButton(
                padding: const EdgeInsets.all(5),
                icon: const Icon(Icons.add),
                onPressed: () {
                  Get.toNamed(Routes.add);
                },
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                started ? "松开结束" : "长按录音",
                style: AppTS.small,
              ),
            ),
            Center(
              child: AudioItem(
                onLongPress: () {
                  setState(() {
                    started = true;
                  });
                  record();
                },
                onLongPressEnd: (_) async {
                  setState(() {
                    started = false;
                  });
                  await stopRecorder();
                  Get.to(LoadingPage(future: ApiSound.upSound(_mPath!)))?.then(
                          (value) => Get.toNamed(Routes.add, arguments: value));
                  // var words = await ApiSound.upSound(_mPath!);
                  // Get.toNamed(Routes.add, arguments: words);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Column(
//   children: [
//
//     // Container(
//     //   margin: const EdgeInsets.all(3),
//     //   padding: const EdgeInsets.all(3),
//     //   height: 80,
//     //   width: double.infinity,
//     //   alignment: Alignment.center,
//     //   decoration: BoxDecoration(
//     //     color: Color(0xFFFAF0E6),
//     //     border: Border.all(
//     //       color: Colors.indigo,
//     //       width: 3,
//     //     ),
//     //   ),
//     //   child: Row(children: [
//     //     ElevatedButton(
//     //       onPressed: getRecorderFn(),
//     //       //color: Colors.white,
//     //       //disabledColor: Colors.grey,
//     //       child: Text(_mRecorder!.isRecording ? 'Stop' : 'Record'),
//     //     ),
//     //     SizedBox(
//     //       width: 20,
//     //     ),
//     //     Text(_mRecorder!.isRecording
//     //         ? 'Recording in progress'
//     //         : 'Recorder is stopped'),
//     //     ElevatedButton(
//     //       onPressed: () async {
//     //         print(_mPath);
//     //         String? path = await ApiSound.upSound(_mPath!);
//     //         print(path);
//     //       },
//     //       //color: Colors.white,
//     //       //disabledColor: Colors.grey,
//     //       child: Text(_mRecorder!.isRecording ? 'Stop' : 'Record'),
//     //     ),
//     //   ]),
//     // ),
//     // ChipsChoice.multiple(
//     //   wrapped: true,
//     //   choiceStyle: C2ChipStyle.filled(
//     //     selectedStyle: C2ChipStyle(
//     //       borderRadius: BorderRadius.circular(10),
//     //     ),
//     //   ),
//     //   value: tags,
//     //   onChanged: (value) {setState(() {
//     //     tags = value;
//     //   });},
//     //   choiceItems: List.generate(words.length, (index) =>
//     //     C2Choice(value: index, label: words[index], selected: false),
//     //   ),
//     // )
//   ],
// ),
