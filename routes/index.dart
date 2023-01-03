import 'package:dart_frog/dart_frog.dart';
import '../cloud/db.dart';

Response onRequest(RequestContext context) {
  //Initialize the database when the app opens
  connectDB();
  return Response(body: 'Database connected successfully');
}
