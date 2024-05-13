# Demo chat app

A demonstration chat app developed with flutter, This project is developed with `flutter_hooks`, `riverpod`, `go_router`, among other package. I have followed Feature First method here. I used firebase as a Backend for all purpose. 

## Deployed url

https://fir-chat-9c443.web.app

## Push notification

There is multiple way to implement Push notification, the most common way is implementing with a Server, or you can implement it with Firebase cloud function (through expensive). but the cloud function is not available to free tier. and I don't have a free Spark plan of Firebase. so didn't try to implement push notification.

## Build

If you want to build the flutter app, you need to have flutter 3.19.6 installed in your device. to run the app please run bellow command

```
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## Features
- You can Register with Username and Password and Name.
- You can login once you registered.
- You can see all the available People who have registered, in a List view.
- You can chat with anyone by selecting there name.
- You can send `Text`, `Image`, `Link` to the other party in the chat.
- Thanks for reading!