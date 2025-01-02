import 'dart:io';

import 'package:html/parser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main(List<String> arguments) async {
  await getShowsInfos('https://3isk.biz/genre/series-mudablij-118/', 1);
}

List<Show> finalListShow = [];

Future<void> getShowsInfos(String url, int page) async {
  var link = Uri.parse(url);
  var response = await http.get(link);
  if (response.statusCode != 200) {
    print('page = ${page - 1}');
    finalListShow.sort((a, b) => b.episodes.compareTo(a.episodes));
    final output =
        finalListShow.map((e) {
          return {
            'name': e.name,
            'url': e.url,
            'episodes': e.episodes,
            'image': e.image,
          };
        }).toList();
    final toWrite = jsonEncode(output);
    await File('shows_list.json').writeAsString(toWrite);
    print("Done");
    return;
  }
  final document = parse(response.body);
  final showList = document.getElementsByClassName("type_item_box");

  List<Show> finalList = [];
  for (var e in showList) {
    final uri = Uri.parse(e.querySelector('a')?.attributes['href'] ?? '');
    final showLengthPage = await http.get(uri).then((v) => parse(v.body));
    final length = showLengthPage.getElementsByClassName('ep-num').length;

    finalList.add(
      Show(
        name: e.querySelector('a')?.attributes['title']?.trim() ?? '',
        url: e.querySelector('a')?.attributes['href'] ?? '',
        image: e.querySelector('img')?.attributes['data-image'] ?? '',
        episodes: length,
      ),
    );
  }
  print(finalList);
  finalListShow.addAll(finalList);
  page = page + 1;
  final path = Uri.parse(
    'https://3isk.biz/genre/series-mudablij-118/page/$page/',
  );
  getShowsInfos(path.toString(), page);
}

class Show {
  final String name;
  final String url;
  final String image;
  final int episodes;
  const Show({
    required this.name,
    required this.url,
    required this.image,
    required this.episodes,
  });
  @override
  String toString() => '.$name. : .$episodes. \n';
}
