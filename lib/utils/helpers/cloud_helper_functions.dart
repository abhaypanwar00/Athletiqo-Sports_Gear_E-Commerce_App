import 'package:flutter/material.dart';

/// Helper functions for cloud-related operations.
class AppCloudHelperFunctions {
  /// Helper function to check the state of a single database record.
  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data == null) {
      return const Center(child: Text('No Data Found!'));
    }

    if (snapshot.hasError) {
      return const Center(child: Text('Something went wrong.'));
    }

    return null;
  }

  /// Helper function to check the state of multiple (list) database records.
  static Widget? checkMultiRecordState<T>({
    required AsyncSnapshot<List<T>> snapshot,
    Widget? loader,
    Widget? error,
    Widget? nothingFound,
  }) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return loader ?? const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      return nothingFound ?? const Center(child: Text('No Data Found!'));
    }

    if (snapshot.hasError) {
      return error ?? const Center(child: Text('Something went wrong.'));
    }

    return null;
  }

  /// Cloudinary note: Since Cloudinary returns the image URL immediately after upload,
  /// there is typically no need to fetch a URL later using a reference.
  /// Store the returned URL in Firestore at the time of upload and retrieve it directly.
}