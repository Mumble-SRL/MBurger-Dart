<p align="center" >
<img src="https://raw.githubusercontent.com/Mumble-SRL/MBurgerSwift/master/Images/mburger-icon.png" alt="MBurger Logo" title="MBurger Logo">
</p>


# MBurger-Flutter

MBurger Flutter client.

You can use this library to interact with the [MBurger](https://www.mburger.cloud) platform. 

If you're new to MBurger you can use [this tutorial](https://web.mburger.cloud/article/how-to-deliver-contents-to-your-flutter-app) as a starting point.

<a href="https://web.mburger.cloud/article/how-to-deliver-contents-to-your-flutter-app">
   <img alt="Qries" src="https://cdn.mburger.cloud/184523/Features-Model-content-–-2.png" height=200>
</a>

# Installation

You can install the MBurger SDK using pub, add this to your `pubspec.yaml` file:

```yaml
dependencies:
  mburger: ^2.0.0
```

And then install packages from the command line with:

```
$ flutter pub get
```

# Initialization

To initialize the SDK you have to create a token through the [dashboard](https://mburger.cloud/).

Click on the settings icon on the top-right and create an API Key specifying the permissions.

Then, in your `main.dart` initialize the MBManager with the token created, here's an example:

```dart
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    MBManager.shared.apiToken = "YOUR_API_TOKEN";

    super.initState();
  }
}
```

All the functions to retrive objects are in the `MBManager` singleton, are async functions and retuns `Future` objects.

If there is an error during the request the SDK will raise a `MBException` with the status code and message of the error. 

# Fetch the project

You can retrieve the information of the project like this:

```dart
MBProject project = await MBManager.shared.getProject();
```

You can include the contracts for the project setting the `includeContracts` parameter to `true`.

```dart
MBProject project = await MBManager.shared.getProject(includeContracts: true);
```

# Fetch blocks

You can retrieve the blocks of the project with the function `MBManager.shared.getBlocks()` like this:

```dart
MBPaginatedResponse<MBBLock> blocks = await MBManager.shared.getBlocks();
```

The parameter named `parameters` is an optional array of objects that conforms to the `MBParameter` protocol that will be passed to the MBurger api as parameter. 

The majority of the parameters that can be passed to the apis are already implemented in the SDK and can be used after the initialization:

- MBSortParameter
- MBPaginationParameter
- MBFilterParameter
- MBGeofenceParameter

If you want to pass another type of parameter you can use the MBGeneralParameter class that can be initialized with a key and a value that will be passed to the apis.

So if you want to include a pagination parameter you can do this:

```dart
MBPaginationParameter paginationParam =
        MBPaginationParameter(skip: 0, take: 10);
MBPaginatedResponse<MBBlock> blocks =
        await MBManager.shared.getBlocks(parameters: [paginationParam]);
```

If you set the `includeSections` parameter you can include also the sections of the blocks, if you set also `includeElements` parameter also the elements will be included in the response.

So, you could retrieve the information of all the blocks, all the sections of the blocks, and all the elements of the sections with this call:

```dart
MBPaginationParameter paginationParam =
      MBPaginationParameter(skip: 0, take: 10);
MBPaginatedResponse<MBBlock> blocks = await MBManager.shared.getBlocks(
      parameters: [paginationParam],
      includeSections: true,
      includeElements: true,
);
```

# Fetch sections

You can retrieve the blocks of the project with the function `MBManager.shared.getSections()` like this:

```dart
MBPaginatedResponse<MBSection> sections =
    await MBManager.shared.getSections(blockId: THE_BLOCK_ID);
```

The `parameters` value is an array of `MBParameter` objects as described in the previous section.

You can set the `includeElements` parameter to true if you want to include also the elements of the sections.

If you want to retrieve all the sections of a block and their elements you can call:

```dart
MBPaginatedResponse<MBSection> sections =
      await MBManager.shared.getSections(
      blockId: THE_BLOCK_ID,
      includeElements: true,
      );
```

# Media

You can retrieve a media stored on MBurger with its id:

```dart
MBMedia media = await MBManager.shared.getMedia(MEDIA_ID);
```

To retrieve all the media that are saved in MBurger you can use this function:

```dart
List<MBMedia> media = await MBManager.shared.getAllMedia();
```


# MBAdmin

If you need to create blocks and sections in your MBurger project you can use the MBAdmin package that comes with this SDK. 

```dart
import 'package:mburger/mb_admin/mb_admin.dart';
```

## Add/Edit a section

You can add a section to a block with the function `MBAdmin.shared.addSectionToBlock()`.

To call this function you need to create an array of elements confrom to `MBUploadableElementProtocol`.

A `MBUploadableElementsFactory` is allocated with a locale identifier and creates object with this locale identifier

> All the integrity controls of the server are still present in the APIs, and you will find the description of the error in the object passed to the failure block. 

Below is an example code to create a section.

```dart
MBUploadableElementsFactory factory = MBUploadableElementsFactory('it');
List<MBUploadableElement> elements = [
  factory.createTextElement('name', 'text'),
  factory.createImageElement(
    'image',
    '/path/to/image',
    MediaType.parse('img/jpg'),
  )
];
MBAdmin.shared.addSectionToBlock(BLOCK_ID, elements);
```

> To create images or files you'll need to specify a MediaType, and you will need to include the http_parser package

With a `MBUploadableElementsFactory` you can create:

* an array or a single of image with `MBUploadableImagesElement`
* a text with `MBUploadableTextElement`
* a checkbox element with `MBUploadableCheckboxElement`

The edit function is very similar to the add. 

> It will modify only the fields passed and the other elements will remain untouched.

## Delete a section

To delete a section with an id:

```dart
await MBAdmin.shared.deleteSection(SECTION_ID);
```

## Upload a media

You can upload a media, or an array of media, to the media center of MBurger with this 2 functions, providing the path to the files.

```dart
// Upload a file
MBMedia media = await MBAdmin.shared.uploadMedia(FILE_PATH);

// Upload a list of files
List<MBMedia> media = await MBAdmin.shared.uploadMediaList([FILE_PATH1, FILE_PATH2]);
```

## Delete a media

> You can delete a media (an image or a video), giving its id with the function. 

```dart
await MBAdmin.shared.deleteMedia(mediaId);
```

The id of the media is the field id of the objects `MBImage` and `MBMedia`.

# MBAuth

All the authentication apis are contained in the `MBAuth` package. 

You can register a user to MBurger, authenticate that user, and retrieve its information.

```dart
import 'package:mburger/mb_auth/mb_auth.dart';
```

## Register a user

To register a user, call `MBAuth.registerUser()`.

> The fields, name , surname , email and password are required, while the other are optional. 
> The field data is an arbitrary object (array or dictionary) representing additional data that you want to pass when registering the user. It will be returned when retrieving the profile.
> 

```dart
await MBAuth.registerUser(
      'name',
      'surname',
      'email',
      'password',
      phone: '1234567890',
      image: null,
      data: null,
    );
```

## Authenticate a user

### Email and password

After registering the user, you can authenticate it with its email and password. 

> All the communication with the server is made in https, so all the data is encrypted. 
> If the authentication is correct, the api will return the access token. 

This token will be put in the `Authorization` header for each subsequent call to all the `MBurger` apis.

```dart
await MBAuth.authenticateUser('email', 'password');
```

### Social

MBurger offers the possibility to authenticate a user with social networks too.

Socials currently supported:

* Google
* Facebook
* Apple

```dart
await MBAuth.authenticateUserWithSocial(
      'socialToken',
      MBAuthSocialLoginType.facebook,
    );
```

> If the user logs in with apple you need to pass to this function also the name and surname because those cannot be retrieved by the server.

### How to know if user is logged in

You can see if a user is currently authenticated with `MBAuth.userLoggedIn()`.

If a user is authenticated you can retrieve its access token with `MBAuth.userToken()` else this will return `null`.

To logout the current user:

```dart
await MBAuth.logoutCurrentUser();
```

`MBAuth` saves the user information using the [flutter secure storage](https://pub.dev/packages/flutter_secure_storage) package. 

## Retrieve user information

You can retrieve the information of the current user with `MBAuth.getUserProfile()`.

```dart
MBUser user = await MBAuth.getUserProfile();
```

## Update user profile

You can update some data of the profile of the current `MBUser`. In case of success it returns an updated `MBUser`.

```dart
MBUser newUser = await MBAuth.updateUser(
  name: 'name',
  surname: 'surname',
  phone: '1234567890',
  image: null,
  data: null,
);
```

# MBurger Documentation
You can find the documentation for MBurger [here](https://docs.mumbleideas.it)