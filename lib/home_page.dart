import 'package:flutter/material.dart';
import 'db/dao/person_dao.dart';
import 'db/database.dart';
import 'db/entity/person.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PersonDao _productDao = AppDatabase.instance!.personDao;
  TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ertangi vazifalar")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _productDao.people(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    final List<Person> peopleName =
                        snapshot.data as List<Person>;
                    return ListView.separated(
                      itemBuilder: (_, index) {
                        return ListTile(
                          leading: Icon(
                            Icons.circle,
                            color: Colors.green,
                          ),
                          title: Text(peopleName[index].name),
                          contentPadding: EdgeInsets.zero,
                          trailing: IconButton(
                            onPressed: () async {
                              await _productDao.deletePerson(peopleName[index]);
                            },
                            icon: Image.asset("assets/png/subway.png"),
                          ),
                        );
                      },
                      separatorBuilder: (_, index) {
                        return const Divider();
                      },
                      itemCount: peopleName.length,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      )),
                      labelText: "Name",
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (_nameController.text.trim().isEmpty) return;
                    final id = (await _productDao.findAllPeople()).length;
                    await _productDao.insertPerson(
                      Person(id + 1, _nameController.text.trim()),
                    );
                    _nameController.clear();
                  },
                  child: Container(
                    height: 65,
                    width: 65,
                    decoration: const BoxDecoration(
                      // color: Colors.white10,
                        color: Color(0xff333333),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        )),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
