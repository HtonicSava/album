part of 'router_cubit.dart';

abstract class RouterState extends Equatable {
  const RouterState();
  @override
  List<Object?> get props => [];
}
class PageAlbumsState extends RouterState {
  final String? extraPageContent;
  const PageAlbumsState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}
class PageSearchState extends RouterState {
  final String? extraPageContent;
  const PageSearchState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}
class PageBucketState extends RouterState {
  final String? extraPageContent;
  const PageBucketState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}
class PagePersonalAccountState extends RouterState {
  final String? extraPageContent;
  const PagePersonalAccountState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}
class PageTheAlbumState extends RouterState {
  final String? extraPageContent;
  const PageTheAlbumState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}
