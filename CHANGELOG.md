## [0.0.2+2]

* Renamed `MBFile` to `MBMedia`.
* Added uuid to `MBFile` and `MBImage`.
* **Media Center**: added a function to get a media given its id.
* **Media Center**: added a function to get all the media of a project.

#### MBAdmin

* Added the possibility to use a media (with the UUID) when creating or editing a section.
* Added a function to upload a media to the media center of the project.
* Remove the need to specify the mime type when uploading an images element, it's automatically retireved with the mime package.