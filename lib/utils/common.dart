String mapToUrlParams(Map<String, dynamic> ? params) {
  params ??= {};
  return params.entries
      .map((entry) => '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value.toString())}')
      .join('&');
}

String removeTrailingNewline(String input) {
  return input.endsWith('\n') ? input.substring(0, input.length - 1) : input;
}