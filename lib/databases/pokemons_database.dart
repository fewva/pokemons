import 'package:pokemons/models/pokemon.dart';
import 'package:sqflite/sqflite.dart';

class PokemonsDB {

  Database _database;

  Future<Database> get database async {

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();
    return await openDatabase(
      dbPath + "pokemons.db",
      version: 1,
      onCreate: (Database database, int version) async {
        await database.execute('''
          Create table IF NOT EXISTS Pokemons (
            id INT PRIMARY KEY,
            name TEXT,
            base_experience INT,
            height INT,
            is_default bool[3],
            weight INT
          )
          ''');
      },
    );
  }

  Future <bool> delete() async {
    String path = await getDatabasesPath(); 
    deleteDatabase(path + "pokemons.db");
    print('deleted');
    return true;
  }

  Future <void> insertPokemons(List <Pokemon> l) async {

    final db = await database;
    for (var pokemon in l) {
      db.insert(
        "Pokemons", pokemon.toDBjson(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  Future <void> updatePokemon(Pokemon pokemon) async {

    final db = await database;
      db.update(
        "Pokemons", pokemon.toDBjson(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }
  
  Future <List<Pokemon>> getPokemons() async {
    final db = await database;

    List _l = await db.rawQuery('SELECT * FROM Pokemons');

    List newList = List.from(_l);

    return newList
        .map((e) => Pokemon.fromDB(e))
        .cast<Pokemon>()
        .toList();

  }

  Future <Pokemon> getRandomPokemon() async {
    final db = await database;
    
    final _p = await db.rawQuery('SELECT * FROM Pokemons ORDER BY RANDOM() LIMIT 1;');

    print(_p);

    return Pokemon.fromDB(_p[0]);

  }

}