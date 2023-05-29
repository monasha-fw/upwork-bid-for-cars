<a name="readme-top"></a>

<!-- PROJECT SHIELDS -->

[comment]: <> ([![Contributors][contributors-shield]][contributors-url])

[comment]: <> ([![Forks][forks-shield]][forks-url])

[comment]: <> ([![Stargazers][stars-shield]][stars-url])

[comment]: <> ([![Issues][issues-shield]][issues-url])

[comment]: <> ([![MIT License][license-shield]][license-url])

[comment]: <> ([![LinkedIn][linkedin-shield]][linkedin-url])

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/monasha-fw/upwork-bid-for-cars">
    <img src="public/images/logo.png" alt="Logo" height="200">
  </a>

<h3 align="center">Carsxchange</h3>

  <p align="center">
    Sample project proposal for the Carsxchange
    <br />
    <a href="https://github.com/monasha-fw/upwork-bid-for-cars"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a >View Demo</a>
    <br />
    <a href="https://github.com/monasha-fw/upwork-bid-for-cars/issues">Report Bug</a>
    <br />
    <a href="https://github.com/monasha-fw/upwork-bid-for-cars/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#how-to-use">How to Use</a></li>
      </ul>
    </li>
    <li><a href="#hide-generated-files">Hide Generated Files</a></li>
    <li>
      <a href="#features">Features</a>
      <ul>
        <li><a href="#completed-features">Completed Features</a></li>
        <li><a href="#in-progress-features">In-Progress Features</a></li>
        <li><a href="#up-coming-features">Up-Coming Features</a></li>
      </ul>
    </li>
    <li><a href="#libraries-and-tools-used">Libraries and Tools Used</a></li>
    <li><a href="#folder-structure">Folder Structure</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->

## About The Project
[![Sample_Screenshot][product-screenshot-2]](https://github.com/monasha-fw/upwork-bid-for-cars)
[![Sample_Screenshot][product-screenshot-3]](https://github.com/monasha-fw/upwork-bid-for-cars)
[![Sample_Screenshot][product-screenshot-4]](https://github.com/monasha-fw/upwork-bid-for-cars)
[![Sample_Screenshot][product-screenshot-5]](https://github.com/monasha-fw/upwork-bid-for-cars)
[![Sample_Screenshot][product-screenshot-6]](https://github.com/monasha-fw/upwork-bid-for-cars)

Bid for cars

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With

[![Flutter][Flutter]][Flutter-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->

## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### Prerequisites

Please visit [Flutter website][https://docs.flutter.dev/get-started/install] and install the
required software.

### How to Use

**Step 1:**

Download or clone this repo by using the link below:

Branch - "main"

```
https://github.com/monasha-fw/upwork-bid-for-cars
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get 
```

**Step 3:**

This project uses multiple `inject` libraries that works with code generation, execute the following
command to generate files:

* build_command
```
flutter packages pub run build_runner build -d
```

or watch command in order to keep the source code synced automatically:

(Note: For the first use, `build_command` command is required.)

* watch_command
```
flutter packages pub run build_runner watch
```

## Update translations

Use this to rebuild the translations json file.
```
flutter pub run slang
```

## Optional Steps
### Hide Generated Files

In-order to hide generated files, navigate
to `Android Studio` -> `Preferences` -> `Editor` -> `File Types` and paste the below lines
under `ignore files and folders` section:

```
*.inject.summary;*.inject.dart;*.g.dart;
```

In Visual Studio Code, navigate to `Preferences` -> `Settings` and search for `Files:Exclude`. Add
the following patterns:

```
**/*.inject.summary
**/*.inject.dart
**/*.g.dart
```

## Features
### Completed Features:

* Splash
* Onboarding
* Login
* Forgot Password
* Reset Forgotten Password
* Register
* Home
  * All Cars
  * Live Cars
  * Expired Cars

### In-Progress Features:
* Change Language
  * Internationalization already implemented, once the language change page is finished. Just have add translations json files for all the required languages. 

### Up-Coming Features:

* Car Details
* Bid
* Account
* Account Settings
* My Offers
* Notifications
* Change Password

### Libraries and Tools Used 
(few more to add...)

* [Dio](https://github.com/flutterchina/dio) (API calls)
* [Dio](https://github.com/flutterchina/dio) (API MOCK calls)
* [FlutterBloc](https://github.com/felangel/bloc/) (State Management)
* [Freezed](https://pub.dev/packages/freezed)
* [Injectable](https://pub.dev/packages/injectable) (Dependency Injection)

### Folder Structure

Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- assets
    |- svgs
        |- icons
    |- illustrations
|- ios
|- lib
    |- core
    |- i18n
    |- infrastructure
    |- presentation
```

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[contributors-shield]: https://img.shields.io/github/contributors/github_username/repo_name.svg?style=for-the-badge

[contributors-url]: https://github.com/monasha-fw/upwork-bid-for-cars/graphs/contributors

[forks-shield]: https://img.shields.io/github/forks/github_username/repo_name.svg?style=for-the-badge

[forks-url]: https://github.com/monasha-fw/upwork-bid-for-cars/network/members

[stars-shield]: https://img.shields.io/github/stars/github_username/repo_name.svg?style=for-the-badge

[stars-url]: https://github.com/monasha-fw/upwork-bid-for-cars/stargazers

[issues-shield]: https://img.shields.io/github/issues/github_username/repo_name.svg?style=for-the-badge

[issues-url]: https://github.com/monasha-fw/upwork-bid-for-cars/issues

[license-shield]: https://img.shields.io/github/license/github_username/repo_name.svg?style=for-the-badge

[license-url]: https://github.com/monasha-fw/upwork-bid-for-cars/blob/master/LICENSE.txt

[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555

[linkedin-url]: https://linkedin.com/in/linkedin_username

[product-logo]: public/images/logo.png

[product-screenshot-2]: public/images/screenshot_2.png
[product-screenshot-3]: public/images/screenshot_3.png
[product-screenshot-4]: public/images/screenshot_4.png
[product-screenshot-5]: public/images/screenshot_5.png
[product-screenshot-6]: public/images/screenshot_6.png

[Flutter]: https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white

[Flutter-url]: https://flutter.dev/
