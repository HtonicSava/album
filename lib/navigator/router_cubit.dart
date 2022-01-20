import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';


part 'router_state.dart';

class RouterCubit extends Cubit<RouterState> {
  RouterCubit() : super(const PageAlbumsState());
  void goToPageAlbums([String? text]) => emit(PageAlbumsState(text));
  void goToPageSearch([String? text]) => emit(PageSearchState(text));
  void goToPageBucket([String? text]) => emit(PageBucketState(text));
  void goToPagePersonalAccount([String? text]) => emit(PagePersonalAccountState(text));
  void goToPageTheAlbum([String? text]) => emit(PageTheAlbumState(text));
  
  void popExtra() {
    if (state is PageSearchState) {
      print(state);
      goToPageSearch();
    } else if (state is PageBucketState) {
      print(state);
      goToPageBucket();
    } else if (state is PagePersonalAccountState) {
      print(state);
      goToPagePersonalAccount();
    } else if (state is PageTheAlbumState) {
      print(state);
      goToPageAlbums('amogus');
    }
    else {
      print(state);
      goToPageAlbums();
    }
  }
}