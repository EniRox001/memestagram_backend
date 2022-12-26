import 'package:mongo_dart/mongo_dart.dart';

late DbCollection userCollection;

Future<void> connectDB() async {
  final db = await Db.create(
    'mongodb+srv://enirox:Pwafukadi@cluster0.4iczrsa.mongodb.net/?retryWrites=true&w=m.0 k20   ajority',
  );
  await db.open();

  final userDatabase = db.collection('users');

  userCollection = userDatabase;
}
