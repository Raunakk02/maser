
# MASER - Mentoring App with Sentiments and Emotion Recognition


![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/Raunakk02/maser?include_prereleases)
![GitHub last commit](https://img.shields.io/github/last-commit/Raunakk02/maser)
![GitHub issues](https://img.shields.io/github/issues-raw/Raunakk02/maser)
![GitHub pull requests](https://img.shields.io/github/issues-pr/Raunakk02/maser)
![GitHub](https://img.shields.io/github/license/Raunakk02/maser?label=license)
[![Codemagic build status](https://api.codemagic.io/apps/60e9d55b8daa78e3923a903a/60e9d55b8daa78e3923a9039/status_badge.svg)](https://codemagic.io/apps/60e9d55b8daa78e3923a903a/60e9d55b8daa78e3923a9039/latest_build)

<p align="center">
<img src="assets/images/app_logo.png" height="200" width="200">
</p>


MASER aims to provide a platform for the specific stratum of society which still lacks the resources and guidance to overcome any failure in their life. People can now share stories of how they failed at some point in their life and then gradually moved on to build a better self. People having the same kind of problems can discuss ways to solve them, and people who have already gone through a particular class of situations can guide others over those situations. 

MASER provide the users with the features like sharing their stories, ability to like the stories that resonate with them, chat with the author of the story to get more insights about the situation it faced, and the way it approached the solution to that situation.
This application also guide users to develop a positive attitude towards life by sharing their
thoughts, and getting feedback from the community on the same.

The core features of this application includes:

- Viewing all stories 
- Sharing your own story
- Saving favorite stories
- Ability to like the stories
- Messaging with the authors of the stories
- Analyzing the emotions and sentiments of an individual

We aim to provide many more emotionally supporting as well as personal analysis features as a future
scope of this project.

# Table of contents
- [MASER - Mentoring App with Sentiments and Emotion Recognition](#maser---mentoring-app-with-sentiments-and-emotion-recognition)
- [Table of contents](#table-of-contents)
- [Demo-Preview](#demo-preview)
- [Development](#development)
  - [Prerequisites](#prerequisites)
  - [Command Line Steps](#command-line-steps)
- [Contribute](#contribute)

# Demo-Preview

<table>
  <tr>
    <td>View all the stories</td>
    <td>Add your own story</td>
    <td>View all the details of a story</td>
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/56073198/124927551-639ef500-e01c-11eb-9e47-8dcc68dd8212.png"</td>
    <td><img src="https://user-images.githubusercontent.com/56073198/124927690-892bfe80-e01c-11eb-99be-2034302f253e.png"</td>
    <td><img src="https://user-images.githubusercontent.com/56073198/124930348-df9a3c80-e01e-11eb-9805-214036ff4895.png"</td>
  </tr>
 </table>

 <hr>

 <table>
  <tr>
    <td>All your chats at one place</td>
    <td>Seek guidance from authors over chats</td>
    <td>Capture images to predict sentiments of the person</td>
    <td>View your user profile</td>
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/56073198/124928304-1f602480-e01d-11eb-939a-cf0704d00a3f.png"></td>
    <td><img src="https://user-images.githubusercontent.com/56073198/124929567-3d7a5480-e01e-11eb-9e14-a2b4754e2452.png"></td>
    <td><img src="https://user-images.githubusercontent.com/56073198/124929933-86320d80-e01e-11eb-95ea-d1b51e47cdb9.png"></td>
    <td><img src="https://user-images.githubusercontent.com/56073198/124930764-3d2e8900-e01f-11eb-836d-f048d0670012.png"></td>
  </tr>
 </table>

# Development
[(Back to top)](#table-of-contents)

## Prerequisites

You'll need to setup the IDE and mobile device emulator on your local system.

1. **Development Environment**: You'll need to have the following installed:
    1. [Flutter SDK](https://flutter.dev/docs/get-started/install)
    2. [Android Studio](https://developer.android.com/studio)
   
2. **Firebase Integration**: You will need to create a new firebase project in your own firebase console. 
    1. While creating the project, also provide the `SHA-1` and `SHA-256` debug keys. 
    2. Follow the steps mentioned in the console, and **don't forget** to replace the google-services.json file in `android/app` folder with the one you downloaded from your firebase console.

## Command Line Steps

The process to run this project on your system is quite simple. Here's what you need to do.

1. Clone and change into the project.
    ```sh
    $ git clone https://github.com/Raunakk02/maser.git
    $ cd maser
    ```
1. Install packages
    ```sh
    $ flutter pub get
    ```
1. Start developing!

**Note**: If you face any build errors, then follow these steps:

    1. Try deleting the `pubspec.lock` file.
    2. After that, run `flutter clean` to remove the previous build.
    3. Finally run `flutter pub get`, to fetch all the packages in `pubspec.yaml` file.
    4. Now try to run the project with `flutter run`.


# Contribute
[(Back to top)](#table-of-contents)

Any type of contribution is **welcome**!
Please feel free to raise any new feature requests or report bugs in the issues section of this repository.

