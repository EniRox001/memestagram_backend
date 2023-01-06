import 'package:dart_frog/dart_frog.dart';
import '../cloud/db.dart';

Future<Response> onRequest(RequestContext context) async {
  //Initialize the database when the app opens
  await connectDB();
  return Response(body: 'Database connected successfully');
}
