# recycling-info

This is a Python program to extract data about materials and how to recycle them. ♻️ The data is in swedish and gathered from a [swedish website](https://www.stockholmvattenochavfall.se/avfall-och-atervinning/sortera-dina-sopor/sorteringsguiden/).

### How to use
#### Prerequisites
[Python 2.6, 2.7 or 3.3+](https://www.python.org/downloads/), [Selenium](https://selenium-python.readthedocs.io/) and [Chromedriver](https://chromedriver.chromium.org/) is used to scrape the information.  

[Sqlite3](https://docs.python.org/3/library/sqlite3.html) is used to store the gathered data in a SQLite database.

[Firebase Realtime Database](https://firebase.google.com/docs/database/) and [firebase_admin](https://firebase.google.com/docs/reference/admin/python) can also be used to store the data.

#### Running the program
Clone the project and run following command from within the project folder:
```
python scraper.py
```

This starts the script which will scrape the web page for information and store it in a database. Change the `main` function to choose database type.


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

##### Testing the database
Some simple tests to check what the database tables contain have been implemented in ``database_test.py``. This can be modified depending on what kind of tests need to be performed.

#### Firebase Realtime Database
The NoSQL database provided by Firebase can also be used. A Firebase project must then be created, and credentials provided and incorporated into the project. Change the path in the `init` function in the `firebase_connect.py` file.


### TODO
- [X] Store data in a database, csv- or textfile
- [ ] Get recycle place info of each material
- [ ] Make some kind of graphical interface
