import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoware_assignment/blocs/audio/audio_bloc.dart';
import 'package:infoware_assignment/blocs/audio/audio_event.dart';
import 'package:infoware_assignment/blocs/audio/audio_state.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AudioBloc(),
      child: Scaffold(
        
        backgroundColor: Colors.teal.shade50,
        body: Center(
          child: BlocBuilder<AudioBloc, AudioState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.teal.shade100,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.shade200,
                          blurRadius: 10,
                          offset: const Offset(0, 7),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.music_note,
                        size: 80,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  const Text(
                    'Sample Music',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  Text(
                    _getStatusText(state),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.teal.shade700,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildControlButton(
                        context,
                        _getPlayPauseIcon(state),
                        () => _handlePlayPause(context, state),
                        isLarge: true,
                      ),
                      const SizedBox(width: 20),
                      _buildControlButton(
                        context,
                        Icons.stop,
                        () => context.read<AudioBloc>().add(StopAudio()),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
  
  String _getStatusText(AudioState state) {
    if (state is AudioPlaying) {
      return 'Playing';
    } else if (state is AudioPaused) {
      return 'Paused';
    } else if (state is AudioStopped) {
      return 'Stopped';
    } else {
      return 'Tap to Play';
    }
  }
  
  IconData _getPlayPauseIcon(AudioState state) {
    if (state is AudioPlaying) {
      return Icons.pause;
    } else {
      return Icons.play_arrow;
    }
  }
  
  void _handlePlayPause(BuildContext context, AudioState state) {
    if (state is AudioPlaying) {
      context.read<AudioBloc>().add(PauseAudio());
    } else {
      context.read<AudioBloc>().add(PlayAudio());
    }
  }
  
  Widget _buildControlButton(
    BuildContext context,
    IconData icon,
    VoidCallback onPressed, {
    bool isLarge = false,
  })
   {
    return Container(
      
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isLarge ? 35 : 30),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.shade200.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          icon,
          size: isLarge ? 35 : 30,
          color: Colors.teal.shade700,
        ),
        onPressed: onPressed,
      ),
    );
  }
}