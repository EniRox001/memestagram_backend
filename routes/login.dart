import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../cloud/db.dart';

Future<Response> onRequest(RequestContext context) async {
  // Access the incoming request.
  final request = context.request;

  // Access the request body as a `String`.
  final body = await request.body();

  // Initialize response to an empty string
  var responseMessage = '';

  // Split the string gotten into a new array
  final splitString = body.split(' ');

  await connectDB();

  // Initialize variables to the splitString array
  var objectId = '';
  var username = splitString[0].trim().toLowerCase();
  var password = splitString[1].trim();

  // Find the user collection based on the data gotten

  await userCollection
      .find({
        'username': username,
        'password': password,
      })
      .toList()
      .then((value) async {
        // Add new user to database if user does not exist;
        if (value.isEmpty) {
          responseMessage = 'no user found';
        } else {
          // If user exists retrieve the data to local variables
          objectId = value[0]['_id'].toString();
          username = value[0]['username'].toString();
          password = value[0]['password'].toString();
          responseMessage = 'user successfully retrieved';
        }
      });

  // Return the response to the frontend
  if (responseMessage == 'user successfully retrieved') {
    return Response.json(
      body: {
        'message': 'user successfully retrieved',
        'userId': objectId,
      },
    );
  } else {
    return Response(body: responseMessage);
  }
}
