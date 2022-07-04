import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';

class CacheDataRepository {
  final APICacheManager cacheInstance = APICacheManager();
  static const String cacheData = "keyOne";
  void addCarFromCache(String response) async {
    await cacheInstance
        .addCacheData(APICacheDBModel(key: cacheData, syncData: response));
  }

  Future<String> getCarFromCacheData() async {
    final response = await cacheInstance.getCacheData(cacheData);
    final data = response.syncData;
    return data;
  }

  Future<bool> cheackKeyIsThere() async {
    final response = await cacheInstance.isAPICacheKeyExist(cacheData);
    return response;
  }
}
