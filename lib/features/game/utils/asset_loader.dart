import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:swift4lyf/domain/models/album.dart';

class AssetLoader {
  static final DefaultCacheManager _cacheManager = DefaultCacheManager();
  static final Map<String, ImageProvider> _imageCache = {};

  // Lazy load and cache album images
  static Future<ImageProvider> loadAlbumImage(Album album) async {
    // Check memory cache first
    if (_imageCache.containsKey(album.id)) {
      return _imageCache[album.id]!;
    }

    // Check if it's a network image
    if (album.imageUrl.startsWith('http')) {
      final file = await _cacheManager.getSingleFile(album.imageUrl);
      final provider = FileImage(file);
      _imageCache[album.id] = provider;
      return provider;
    }

    // Local asset
    final provider = AssetImage(album.imageUrl);
    _imageCache[album.id] = provider;
    return provider;
  }

  // Preload next round's images
  static Future<void> preloadNextRoundAssets(List<Album> albums) async {
    for (final album in albums) {
      await loadAlbumImage(album);
    }
  }

  // Clear cached assets
  static Future<void> clearCache() async {
    _imageCache.clear();
    await _cacheManager.emptyCache();
  }

  // Remove specific album from cache
  static void removeFromCache(String albumId) {
    _imageCache.remove(albumId);
  }
}
