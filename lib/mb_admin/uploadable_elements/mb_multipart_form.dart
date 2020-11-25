import 'package:http_parser/http_parser.dart';

/// This class represents an object that will be uploaded using multipart method
class MBMultipartForm {
  /// If this class represents a file.
  final bool isFile;

  /// The name of the parameter
  final String name;

  /// The value of the parameter, if it's not a file
  final String value;

  /// If it's a file, the path of the file
  final String path;

  /// If it's a file, the mimeType of the file
  final MediaType mimeType;

  /// Initializes a `MBMultipartForm` object with a name and a string value
  MBMultipartForm.name(
    this.name,
    this.value,
  )   : this.isFile = false,
        this.path = null,
        this.mimeType = null;

  /// Initializes a `MBMultipartForm` object with name and a file
  MBMultipartForm.file(
    this.name,
    this.path,
    this.mimeType,
  )   : this.isFile = true,
        this.value = null;
}
