import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../puzzles/planet/planet.dart';
import '../../utils/app_logger.dart';
import 'package:rive/rive.dart';

part 'puzzle_init_state.dart';

class PuzzleInitCubit extends Cubit<PuzzleInitState> {
  PlanetPuzzleBloc _planetPuzzleBloc;
  final int _puzzleSize;

  int get _lastTileKey => _puzzleSize * _puzzleSize - 1;

  PuzzleInitCubit(this._puzzleSize, this._planetPuzzleBloc)
      : super(const PuzzleInitLoading());

  final Map<int, SimpleAnimation> _riveController = {};

  RiveAnimationController getRiveControllerFor(int tileKey) {
    if (tileKey == 0) {
      // we call this function when we need to load the rive widgets
      emit(const PuzzleInitLoading());
    }

    if (_riveController.containsKey(tileKey)) return _riveController[tileKey]!;

    final controller = SimpleAnimation('revolution');
    _riveController[tileKey] = controller;

    return controller;
  }

  void _startAnimating() async {
    // for performance reasons
    await Future.delayed(const Duration(milliseconds: 50));

    _riveController.forEach((_, controller) {
      controller.reset();
    });

    emit(const PuzzleInitReady());
  }

  void onInit(int tileKey) {
    final hasStarted =
        _planetPuzzleBloc.state.status == PlanetPuzzleStatus.started;

    AppLogger.log('puzzle_init_cubit: onInit: hasStarted: $hasStarted');

    if (tileKey == _lastTileKey) {
      _startAnimating();
    }

    if (hasStarted && tileKey == _lastTileKey - 1) {
      // during the game, if screen is resized
      _startAnimating();
    }
  }
}
