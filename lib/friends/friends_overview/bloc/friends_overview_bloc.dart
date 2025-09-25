import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:friends_repository/friends_repository.dart';

part 'friends_overview_event.dart';
part 'friends_overview_state.dart';

class FriendsOverviewBloc
    extends Bloc<FriendsOverviewEvent, FriendsOverviewState> {
  final FriendsRepository _friendsRepository;

  FriendsOverviewBloc({
    required FriendsRepository friendsRepository,
  })  : _friendsRepository = friendsRepository,
        super(FriendsOverviewInitial()) {
    on<LoadFriends>(_onLoadFriends);
  }

  Future<void> _onLoadFriends(
    LoadFriends event,
    Emitter<FriendsOverviewState> emit,
  ) async {
    emit(FriendsOverviewLoading());

    try {
    final friends = await _friendsRepository.getFriends();
      emit(FriendsOverviewLoaded(friends));
    } catch (e) {
      emit(FriendsOverviewError(e));
    }
  }
}
