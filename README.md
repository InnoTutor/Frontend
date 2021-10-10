# InnoTutor
This is the frontend part of InnoTutor, it's done by Flutter.
## Check the main readme for glossary, stackholder roles, and diagrams used
you can check it here: https://github.com/InnoTutor/README

# Used IDE
Visual Studio Code, and Android studio.

# Getting Started
## Setup Flutter
- Android Studio: https://flutter.dev/docs/get-started/editor
- Visual Studio Code: https://flutter.dev/docs/get-started/editor

## Clone the repo
You can git clone using the repository link
git clone https://github.com/InnoTutor/Frontend.git

## Get dependencies 
flutter pub get

## Build model files that are used for json serialization
flutter pub run build_runner build --delete-conflicting-outputs

all .g.dart files are generated using this command, so in order to change them,
you need to change the model then run the command above, considering the synchronisation of the models and file names.
for more info, check: 
https://flutter.dev/docs/development/data-and-backend/json

## Build the website through
flutter run -d chrome --web-hostname localhost --web-port 7357 --web-renderer=html

 # Services folder
 ## AuthServices
 The used method in logging in is google api, by adding the localhost link in OAuth2.0 here https://console.cloud.google.com/apis/credentials , mentioning the used port (7357 in this case).
 ## Database
 It's for getting data from the backend(you can check the backend repo for more information). 
 it follows the backend documentation, https://documenter.getpostman.com/view/16213957/UUy65PgU , 
 consider the order of classes and functions as in the backend documentation to avoid any confusions. 

# Deployment
To generate the release files of the web version that you need to deploy, you need to apply,
flutter build web --release

Github Pages is used to deploy the website version of the flutter app, you need to cd build/web, then init a new repo and push files there to a new branch, that you would mention/choose in github pages.
It's worth mentioning that you need to add the generated link by github pages to the Authorised JavaScript origins in the credentials to be able to use google login api as mentioned in AuthServices above.

# You can test the app from here
https://innotutor.github.io/Frontend/
