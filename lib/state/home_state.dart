import 'package:provider/repositories/home_repository.dart';

class HomeState {
  final HomeRepository _homeRepository;
  HomeState(this._homeRepository):assert(_homeRepository != null);
      Future<bool> serviceCheck()
      {
        return _homeRepository.serviceCheck();
      }
}