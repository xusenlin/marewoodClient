String mapToUrlParams(Map<String, dynamic> ? params) {
  params ??= {};
  return params.entries
      .map((entry) => '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value.toString())}')
      .join('&');
}