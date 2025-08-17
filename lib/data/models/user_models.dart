import 'package:athletiqo/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String username;
  final String email;
  final String role;
  String firstName;
  String lastName;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profilePicture,
  });

  // Getter for full name
  String get fullName => '$firstName $lastName';

  static List<String> nameParts(fullName) => fullName.split(" ");

  // Getter for formatted phone number
  String get formattedPhoneNumber =>
      AppFormatter.formatPhoneNumber(phoneNumber);

  // Generate a username from full name
  static String generateUsername(String fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";
    return "gs_$firstName$lastName";
  }

  // Empty user model
  static UserModel empty() => UserModel(
    id: "",
    username: "",
    email: "",
    role: "",
    firstName: "",
    lastName: "",
    phoneNumber: "",
    profilePicture: "",
  );

  // Convert model to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Username': username,
      'Email': email,
      'Role': role,
      'FirstName': firstName,
      'LastName': lastName,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  // Create UserModel from Firestore document
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return UserModel(
      id: doc.id,
      username: data['Username'] ?? '',
      email: data['Email'] ?? '',
      role: data['Role'] ?? '',
      firstName: data['FirstName'] ?? '',
      lastName: data['LastName'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      profilePicture: data['ProfilePicture'] ?? '',
    );
  }
}
