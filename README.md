# Frontend

![dark_logo](https://user-images.githubusercontent.com/69918609/136712595-77589669-b92d-4d69-bade-ccb2b95f0f56.png)

<img src="https://img.shields.io/github/stars/InnoTutor/Frontend?style=social">ᅠ ![License](https://img.shields.io/badge/license-MIT-green.svg)  ᅠ
 [![Hits-of-Code](https://hitsofcode.com/github/InnoTutor/Frontend?branch=main)](https://hitsofcode.com/github/InnoTutor/Frontend/view?branch=main)
<br><br><br>
**Authors**: Emil Khabibulin, Tasneem Toolba
<br><br>

## Contents
- [Requirements](#requirements)
- [API](#api)
- [Getting Started](#getting-started)
- [Services folder](#services-folder)
- [Deployment](#deployment)
- [You can test the app from here](#you-can-test-the-app-from-here)
- [Want to contribute?](#want-to-contribute)

This is the frontend part of InnoTutor, it's done by Flutter.

Check the main README for glossary, stakeholder roles, and diagrams used here: https://github.com/InnoTutor/README

# Requirements
**Technical Stack**: <br>
* **Flutter (FrontEnd)**: UI cross-platform applications for Android, IOS, and WEB
  * Visual Studio Code and Android Studio are used as an IDE
> For this open-source project, we used the simplest registration way via Google [Firebase](https://firebase.google.com)
> - as a website user, you need to have a Google account
> - as a developer, who is going to host this project version, you need to get your own Google credentials.
> 
> In case of using this project in **Innopolis University** we'll change authentication to **innopolis email** login page.

## Stakeholders and their roles 👤
* **Backend Development Team**
  * **Developer 1** – Frontend developer. Integrate backend with frontend and implement the logic of UI elements.
  * **Developer 2** – Frontend developer. Create and implement a user-friendly design using Flutter, containing all the features made on the backend where all developers will test their parts before integrating parts. <br>
 **Stake**: Development process

# API
There is documentation with all requests which backend supports. So frontend must communicate with it via API.
You can read about API documentation [here](https://documenter.getpostman.com/view/16213957/UUy65PgU)

# Getting Started
## Setup Flutter
- Android Studio: https://flutter.dev/docs/get-started/editor
- Visual Studio Code: https://flutter.dev/docs/get-started/editor

## Clone the repo
You can git clone using the repository link
git clone https://github.com/InnoTutor/Frontend.git

## Get dependencies 
flutter pub get

## Build model files that are used for JSON serialization
flutter pub run build_runner build --delete-conflicting-outputs

all .g.dart files are generated using this command, so in order to change them,
you need to change the model then run the command above, considering the synchronisation of the models and file names.
for more info, check: 
https://flutter.dev/docs/development/data-and-backend/json

## Build the website through
flutter run -d chrome --web-hostname localhost --web-port 7357 --web-renderer=html

# Services folder
 ## AuthServices
 The used method in logging in is google API, by adding the localhost link in OAuth2.0 here https://console.cloud.google.com/apis/credentials , mentioning the used port (7357 in this case).
 ## Database
 It's for getting data from the backend(you can check the backend repo for more information). 
 it follows the backend documentation, https://documenter.getpostman.com/view/16213957/UUy65PgU , 
 consider the order of classes and functions as in the backend documentation to avoid any confusion. 

# Deployment
To generate the release files of the web version that you need to deploy, you need to apply,

flutter build web --release

Github Pages is used to deploy the website version of the Flutter app, you need to cd build/web, then init a new repo and push files there to a new branch, that you would mention/choose in GitHub pages.
It's worth mentioning that you need to add the generated link by GitHub pages to the Authorised JavaScript origins in the credentials to be able to use Google login API as mentioned in AuthServices above.

# You can test the app from here
https://innotutor.github.io/Frontend/

# Want to contribute?
You can contribute to this project. Just fork the repository from the `develop` branch, implement changes you want to propose and make a pull request.
Also, there are [issues](https://github.com/InnoTutor/Frontend/issues), so feel free to submit a new one or participate in existing.
