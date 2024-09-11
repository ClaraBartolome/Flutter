import 'dart:convert';

import 'package:coincap/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }

}

class _HomePage extends State<StatefulWidget>{
  double? _deviceHeight, _deviceWidth;
  HttpService? _httpService;
  String _name = "Hercules";

  @override
  void initState() {
    super.initState();
    _httpService = GetIt.instance.get<HttpService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      minimum: EdgeInsets.only(top: _deviceHeight! * 0.05),
      child: Scaffold(
          appBar: AppBar(title: const Text("DisneyCharacter", style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400)),
              backgroundColor: Colors.lightBlue),
        body:
          Container(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _selectedCharDropdown(),
                  _dataWidgets()
                ],
              ),
            ),
          )
        ),
    );
  }

  Widget _selectedCharDropdown() {
    List<String> characters = [
      "Hercules",
      "Megara",
      "Hades",
      "Phil",
      "Achilles",
      "Aphrodite"
    ];
    List<DropdownMenuItem<String>> _items =
        characters.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.w500)),
        )
      ;
    }).toList();

    return Container(
      margin: const EdgeInsetsDirectional.symmetric(vertical: 10.0),
        child: DropdownButton<String>(
          value: _name,
          items: _items,
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              _name = value!;
            });
          },
          dropdownColor: Theme.of(context).primaryColor,
          iconSize: 40,
          icon: const Icon(Icons.arrow_drop_down_sharp, color: Colors.white,),
          underline: Container(),
        )
    );
  }

  Widget _dataWidgets() {
    return FutureBuilder(
        future: _httpService!.getCharacterByName("/character?", _name, "hercules"),//_httpService!.get("/character/308"),
        builder: (
          BuildContext context,
          AsyncSnapshot snapshot,
        ) {
          if(snapshot.hasData){
            Map response = jsonDecode(snapshot.data.toString(),);
            int count = response["info"]["count"];
            print(count);
            String imageUrl;
            List<String> films;
            List<String> shortFilms;
            List<String> tvShows;
            List<String> videoGames;
            imageUrl = response["data"]["imageUrl"];
            films = List<String>.from(response["data"]["films"] as List);
            shortFilms = List<String>.from(response["data"]["shortFilms"] as List);
            tvShows = List<String>.from(response["data"]["tvShows"] as List);
            videoGames = List<String>.from(response["data"]["videoGames"] as List);
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _characterPicture(imageUrl),
                _characterData(_name),
                _characterAppearances(films, "Films:", topMargin: 0.0),
                _characterAppearances(shortFilms, "Short Films:"),
                _characterAppearances(tvShows, "TV Shows:"),
                _characterAppearances(videoGames, "Video games:", bottomMargin: 20.0),
              ],
            );
            
          }else{
            return const Center(child: CircularProgressIndicator(color: Colors.white,),);
          }
        });
  }

  Widget _characterPicture(String url) {
    return Container(
        width: _deviceWidth! * 0.8,
        height: _deviceHeight! * 0.3,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Image.network(url, fit: BoxFit.contain,));
  }

  Widget _characterData(String name){
    return Text(name, style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400));
  }

  Widget _characterAppearances(List<String>? items, String title,
      {double topMargin = 10.0, double bottomMargin = 0.0}){
      return Container(
        width: _deviceWidth! * 0.8,
      margin: EdgeInsets.only(top: topMargin, bottom: bottomMargin),
      child: ListView.builder(
          itemCount: items == null ? 1 : items.length + 1,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext _context, int _index) {
            if (items != null && items.isNotEmpty) {
              if (_index == 0) {
                return Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400));
              }
              _index -= 1;

              return Text(items[_index],
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400));
            }
          }),
    );
  }
}