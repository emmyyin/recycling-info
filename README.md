# recycling-info ♻️

This is a Python program to extract data about materials and how to recycle them. 🌿The data is in swedish and gathered from a [swedish website](https://www.stockholmvattenochavfall.se/avfall-och-atervinning/sortera-dina-sopor/sorteringsguiden/). The extracted data is displayed in a simple Flutter application. 📱

### How to use
#### Prerequisites
[Python 2.6, 2.7 or 3.3+](https://www.python.org/downloads/), [Selenium](https://selenium-python.readthedocs.io/) and [Chromedriver](https://chromedriver.chromium.org/) is used to scrape the information.  

[Sqlite3](https://docs.python.org/3/library/sqlite3.html) is used to store the gathered data in a SQLite database.

[Firebase Realtime Database](https://firebase.google.com/docs/database/) and [firebase_admin](https://firebase.google.com/docs/reference/admin/python) can also be used to store the data.

[Flutter](https://flutter.dev/) is used for the mobile application.

#### Creating the database
Clone the project and run following command from within the project directory:
```
python ./recycle_info_scraper/scraper.py
```

This starts the script which will scrape the web page for information and store it in a database. Change the `main` function to choose database type, see below.

#### Running the mobile app
The application uses a Firebase Realtime Database to display data. This must be set up before running the app. After set up, make sure you are in the right directory and start the flutter application with the following commands:

```
cd ./recycle_app
flutter pub get
flutter run
```

__Note:__ You need to have flutter installed and a simulator running or a phone connected. More info [HERE](https://flutter.dev/docs/get-started/install).


### Database
#### SQLite
A [SQLite](https://sqlite.org/index.html) database can be used to store the data. The setup currently consists of 6 tables in the database:

```
RECYCLEABLES (ID,  NAME, TYPE)
SYNONYMS (ID, NAME)
TYPES (ID, NAME)
RECYCLE_PLACES (ID, NAME)
ALL_HAZARDUOS_MATERIALS (ID, NAME)
ASSOCIATED_HAZARDUOS_MATERIALS (ITEM, MATERIAL)
```

#### Firebase Realtime Database
The NoSQL database provided by Firebase can also be used. A Firebase project must then be created, and credentials provided and incorporated into the project. Change the path in the `init` function in the `firebase_connect.py` file.
