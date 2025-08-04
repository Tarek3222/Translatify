import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/features/chat/data/models/chats_list_response_model.dart';
import 'package:translators/features/chat/data/repo/chats_repo.dart';
part 'chats_list_state.dart';

class ChatsListCubit extends Cubit<ChatsListState> {
  final ChatsRepo _chatsRepo;
  ChatsListCubit(this._chatsRepo) : super(ChatsListInitial());
  List<Chats> chats = [];
  bool _dataFetched = false;

  Future<void> getChatsList({bool forceRefresh = false}) async {
    if (_dataFetched && !forceRefresh) return;
    _dataFetched = true;
    emit(ChatsListLoading());
    final result = await _chatsRepo.getChatsList();
    result.fold(
      (failure) {
        emit(
          ChatsListError(errorModel: failure),
        );
      },
      (chats) {
        this.chats = chats;
        emit(
          ChatsListSuccess(
            chats: chats,
          ),
        );
      },
    );
  }

  Future<void> deleteChat({required String receiverId}) async {
    emit(DeleteChatLoading());
    final result = await _chatsRepo.deleteChat(
      receiverId: receiverId,
    );
    result.fold(
      (failure) => emit(
        DeleteChatError(errorModel: failure),
      ),
      (success) {
        emit(
          DeleteChatSuccess(),
        );
      },
    );
  }
}
