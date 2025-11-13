import 'package:hive/hive.dart';
import '../models/developer_model.dart';

abstract class DeveloperLocalDataSource {
  Future<void> cacheDevelopers(List<DeveloperModel> developers);
  Future<List<DeveloperModel>> getCachedDevelopers();
  Future<void> cacheDeveloperDetail(DeveloperModel developer);
  Future<void> toggleFavorite(DeveloperModel developer);
}

class DeveloperLocalDataSourceImpl implements DeveloperLocalDataSource {
  static const _developersBox = 'developers_box';

  @override
  Future<void> cacheDevelopers(List<DeveloperModel> developers) async {
    final box = await Hive.openBox<DeveloperModel>(_developersBox);
    for (var dev in developers) {
      await box.put(dev.username, dev);
    }
  }

  @override
  Future<List<DeveloperModel>> getCachedDevelopers() async {
    final box = await Hive.openBox<DeveloperModel>(_developersBox);
    return box.values.toList();
  }

  @override
  Future<void> cacheDeveloperDetail(DeveloperModel developer) async {
    final box = await Hive.openBox<DeveloperModel>(_developersBox);
    await box.put(developer.username, developer);
  }

  @override
  Future<void> toggleFavorite(DeveloperModel developer) async {
    final box = await Hive.openBox<DeveloperModel>(_developersBox);

    // final updated = DeveloperModel(
    //   username: developer.username,
    //   avatarUrl: developer.avatarUrl,
    //   name: developer.name,
    //   bio: developer.bio,
    //   followers: developer.followers,
    //   following: developer.following,
    //   publicRepos: developer.publicRepos,
    //   isFavorite: !developer.isFavorite,
    // );

    await box.put(developer.username, developer);
  }
}
