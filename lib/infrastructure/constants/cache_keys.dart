enum CacheKey {
  accessToken(key: 'accessToken'),
  refreshToken(key: 'refreshToken');

  const CacheKey({required this.key});

  final String key;
}
