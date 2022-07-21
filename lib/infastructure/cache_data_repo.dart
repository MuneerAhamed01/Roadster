import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';

class CacheDataRepository {
  final APICacheManager cacheInstance = APICacheManager();
  // static const String cacheData = "keyOne";

  Future addCarFromCache(String response,String cacheData) async {
    await cacheInstance
        .addCacheData(APICacheDBModel(key: cacheData, syncData: response));
  }

  Future<String> getCarFromCacheData(String cacheData) async {
    final response = await cacheInstance.getCacheData(cacheData);
    final data = response.syncData;
    return data;
  }

  Future<bool> cheackKeyIsThere(String cacheData) async {
    final response = await cacheInstance.isAPICacheKeyExist(cacheData);
    return response;
  }
  Future addCarFromCacheWatchlist(String response,String cacheData) async {
    await cacheInstance
        .addCacheData(APICacheDBModel(key: cacheData, syncData: response));
  }

  Future<String> getCarFromCacheDataWatchlist(String cacheData) async {
    final response = await cacheInstance.getCacheData(cacheData);
    final data = response.syncData;
    return data;
  }

  Future<bool> cheackKeyIsThereWatchlist(String cacheData) async {
    final response = await cacheInstance.isAPICacheKeyExist(cacheData);
    return response;
  }
}
