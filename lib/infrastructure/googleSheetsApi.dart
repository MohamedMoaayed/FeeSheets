import 'package:fee_sheets/infrastructure/savedValues.dart';
import 'package:gsheets/gsheets.dart';
import 'package:fee_sheets/infrastructure/locator.dart';

// your google auth credentials
const _credentials = r'''
{
  "type": "service_account",
  "project_id": "feesheets",
  "private_key_id": "b8a3c7edaa4c52f64f0f2639cd15ef059ca12e93",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCnkmpxq5cRLkHd\nzjVsjUhKRqt746DEYIcoGLl6eVgs51vZekDHbh1p7mgLUdpz1LxEPH4WffKltTNV\no7JJrtjKjaaMDn0elGoYskxsUSUba7NQOPTvkJWZyMZMVfYlzBPxTJEmWc5EyGUO\ncxe2xygWSlG02jWdVa6QalkXaKfaA5UIOD8EKdKAM54oQgPdstZDJ83jYIcK4Cw6\nvLwCzWsn4GVGDKjWCjrZ4GNtarFoZGGPaD+uPtGIW/aKa7YqkAfZ6YfPVoZzVXLI\nUoAescFfkf6WMbwEciTZMMt2+MWEhvr6LUJvZe4GrjTk9UEIw1DYMad2wbfIpSoN\n3KiyoVCjAgMBAAECggEASqxT89CPsq/G2UU9iGCTIMpKO5yNtUUApa0S5lFxqhz1\nUL4KZPScdeqwAa9ZpjlcJhpA49v/R7muJREb73rTj7u8xnfkaL6hYtz9cl1cqFH/\np5WiDKmFCPEv8K9zz5cYIfTJT+pAIWWdpulB3Yj1Q62dqHZ+4txePGuvxN81wVAT\nvi8Q4NSATXMlqTkGx5BOM3dThEeLjWbDzefq7YiRWk2e3Ab5jxH2Fzqxgw53so/p\nlyyrZMzUmCkfwOi6ZsMZ8YXyUghbBTMg/qaReJabt8kdGc85zpe9yl3OD1Y75SlR\ngAWYdhXk4nFv8LNLwEa/jv7lMecZeVj3+w8tJ4/1FQKBgQDQB9r3+bglDfOmaVFY\nNL8XC5or4xHLmBVFdB0gWK0FU6LA/jsvcFxrs/FGtQW3ss9DJn1mal8RMVYeEEpL\ny9MQs9BQ6V3cA3Nh92Gigt0fbJD5ginka7TYXjHJpOmfu9ubWxBgE9fnsnyVAX5l\nf4SXBsVF++031SsbuEWZv7X67QKBgQDONkMsKDazQ0dnkC1uM80dJg1Zq2SZk/Ni\nZwbBoSnhAt7cQeldVCtMbmpsLgkhO+HGLVxF1pfzqeI+gqfIhxdjDwukW1E0OKqJ\nhdXPHPZ/GhHzsSd8T7zYDXHucUutdz4HIekUIeqt3/lzPAb2gN1tXp9xsaGQH9hh\nsBUHiQy3zwKBgQDL86eeDlmXGoKR2BdEHxJpiZpxBIHh1Qyltx0HJWkcG88o3xcv\nfz1c6mHWLIuaedfxwb6XthnWRURk3Ru6C+62JVRKv0Ch/1AT7/Ds3tfjgxDvTcm8\nhEwdBNxTETdqv0ainTkEuO+n3Ll/bKN65vYbCyxFXKRJZNiKqLKz9dx4UQKBgE+/\nenDcSHNBRJ8PihJBZESuj6ErAGfIaOqYT2uYqTqEwq1JrDdUsr4HQY7+qrc4klLy\n/elgWTl5bK6iFsMdQ3Uiv2zbh+b7NzCiGpLTb5yt911YGJ4htDWV1YbSN+Mo50sY\n2SvZBgoiQTVIdKTmJzwByQXOHV5Ago0c7LUSUmHPAoGBALvba8OgzYWqCY6uaLfH\nkJKSSZkwR0f51Y5iRor+hVDqN9MxAQaw1iQHEF/5CMYtL4JlYXsIceGwwzRPJc9L\nwYL7774QTeLh2L+JCgvYToGqCTJW1XPh8KtuYkxzl7fC0k4yeKQz3lLUqUjl2lxD\nmoo92GMgZ43igq1PMZOa7daZ\n-----END PRIVATE KEY-----\n",
  "client_email": "feesheets@feesheets.iam.gserviceaccount.com",
  "client_id": "116138292296255253048",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/feesheets%40feesheets.iam.gserviceaccount.com"
}

''';
// your spreadsheet id
const _spreadsheetId = '1ziddAKRQzZ6jVMvmPhJgKAPAcWywMKTK-mLmdvh7lHY';
var savedInfo = locator<SavedValues>();
List<Map> rows;
var numberOfRows;
var rowToBeDeleted;

void insertIntoSheet() async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  // get worksheet by its title
  var sheet = await ss.worksheetByTitle('Sheet1');
  // create worksheet if it does not exist yet
  sheet ??= await ss.addWorksheet('Sheet1');
  final newRow = {
    'name': savedInfo.name,
    'mobile': savedInfo.mobile,
    'model': savedInfo.model,
    'date': savedInfo.date,
    'email': savedInfo.email,
  };
  await sheet.values.map.appendRow(newRow);

  print(await sheet.values.map.lastRow());
}

void fetchSheet() async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  // get worksheet by its title
  var sheet = await ss.worksheetByTitle('Sheet1');

  final cellsRow = await sheet.values.map.allRows();
  rows = cellsRow;
  numberOfRows = rows.length;
  print(cellsRow);
}

void deleteRow() async {
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  // get worksheet by its title
  var sheet = await ss.worksheetByTitle('Sheet1');
  // create worksheet if it does not exist yet
  sheet ??= await ss.addWorksheet('Sheet1');
  await sheet.deleteRow(rowToBeDeleted + 2);
}
