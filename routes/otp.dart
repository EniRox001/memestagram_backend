import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../cloud/db.dart';

Future<Response> onRequest(RequestContext context) async {
  // Access the incoming request.
  final request = context.request;

  // Access the request body as a `String`.
  final body = await request.body();

  // Create a response instance that will be overriden and set to the client
  var responseMessage = '';

  //Check if the incoming data is a phone number or email
  if (body.contains('@')) {
    //Execute the following code if the response provided was in email format
    await userCollection.find(where.eq('email', body)).toList().then(
          (value) => value.isEmpty
              ? responseMessage = 'redirect to email otp screen'
              : responseMessage = 'user with email already exists',
        );
  } else {
    //Execute the following code if the response provided was in numeric format
    await userCollection.find(where.eq('number', body)).toList().then(
          (value) => value.isEmpty
              ? responseMessage = 'redirect to number otp screen'
              : responseMessage = 'user with number already exists',
        );
  }

  return Response(body: responseMessage);
}
