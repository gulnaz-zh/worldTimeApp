import 'package:flutter/material.dart';
import 'package:worldtime/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation>{

  TextEditingController editingController = TextEditingController();

  final List<WorldTime> duplicate_locations = [
    WorldTime(url: 'Asia/Almaty', location: 'Almaty', flag: 'kz.png'),
    WorldTime(url: 'Europe/Athens', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'America/Mexico_City', location: 'Mexico City', flag: 'mexico.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Europe/Paris', location: 'Paris', flag: 'france.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Africa/Tunis', location: 'Tunis', flag: 'tunisia.png'),
    WorldTime(url: 'America/Toronto', location: 'Toronto', flag: 'canada.png'),
  ];
  var locations = List<WorldTime>();

  @override
  void initState() {
    locations.addAll(duplicate_locations);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<WorldTime> dummySearchList = List<WorldTime>();
    dummySearchList.addAll(duplicate_locations);
    if(query.isNotEmpty) {
      List<WorldTime> dummyListData = List<WorldTime>();
      dummySearchList.forEach((item) {
        if(item.location.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        locations.clear();
        locations.addAll(duplicate_locations);
      });
      return;
    } else {
      setState(() {
        locations.clear();
        locations.addAll(duplicate_locations);
      });
    }
  }

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: locations.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          updateTime(index);
                        },
                        title: Text(locations[index].location),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('images/${locations[index].flag}'),
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
