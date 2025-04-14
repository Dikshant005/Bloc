import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import 'audio_event.dart' as custom_audio_event;
import 'audio_state.dart';

class AudioBloc extends Bloc<custom_audio_event.AudioEvent, AudioState> {
  final AudioPlayer _player = AudioPlayer();

  AudioBloc() : super(AudioInitial()) {
    on<custom_audio_event.PlayAudio>((event, emit) async {
      final assetPath = 'assets/audio/sample-15s (1).mp3';
      
      try {
        await _player.play(AssetSource(assetPath));
        emit(AudioPlaying());
      } catch (e) {
        emit(AudioStopped()); 
      }
    });

    on<custom_audio_event.PauseAudio>((event, emit) async {
      await _player.pause();
      emit(AudioPaused());
    });

    on<custom_audio_event.StopAudio>((event, emit) async {
      await _player.stop();
      emit(AudioStopped());
    });
  }

  @override
  Future<void> close() {
    _player.dispose();
    return super.close();
  }
}
