String databaseUrl(String databaseId) {
  return 'https://api.notion.com/v1/databases/$databaseId/query';
}

String pageUrl(String pageId) {
  return 'https://api.notion.com/v1/pages/$pageId';
}