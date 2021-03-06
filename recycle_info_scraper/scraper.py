from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import sqlite
import firebase_connect

URL = "https://www.stockholmvattenochavfall.se/avfall-och-atervinning/sortera-dina-sopor/sorteringsguiden/"
DB = "database.db"

def create_database(connection):
    """Initialize the database, creating the tables"""
    sqlite.update(connection, '''CREATE TABLE RECYCLEABLES
        (ID     INT PRIMARY KEY     NOT NULL,
        NAME    TEXT                NOT NULL,
        TYPE    INT                 NOT NULL,
        EXTRA   TEXT);''')

    sqlite.update(connection, '''CREATE TABLE SYNONYMS
        (ID     INT     NOT NULL,
        NAME    TEXT    NOT NULL);''')

    sqlite.update(connection, '''CREATE TABLE TYPES
        (ID     INTEGER PRIMARY KEY AUTOINCREMENT,
        NAME    TEXT    NOT NULL);''')

    sqlite.update(connection, '''CREATE TABLE RECYCLE_PLACES
        (ID     INT PRIMARY KEY     NOT NULL,
        NAME    TEXT                NOT NULL);''')

    sqlite.update(connection, '''CREATE TABLE ALL_HAZARDUOS_MATERIALS
        (ID     INTEGER PRIMARY KEY AUTOINCREMENT,
        NAME    TEXT                NOT NULL);''')

    sqlite.update(connection, '''CREATE TABLE ASSOCIATED_HAZARDUOS_MATERIALS
        (ITEM       INT     NOT NULL,
        MATERIAL    INT     NOT NULL);''')


def set_type(type, connection):
    """Return the type id"""
    result = sqlite.read(connection, f"SELECT id from TYPES where NAME = '{type}' ")
    if len(result) == 0:
        sqlite.update(connection, f"INSERT INTO TYPES (NAME) VALUES ('{type}')")
        return sqlite.read(connection, f"SELECT id from TYPES where NAME = '{type}' ")[0][0]
    else:
        return result[0][0]

def store_recyclable(id, name, type_id, connection):
    sqlite.update(connection, f"INSERT INTO RECYCLEABLES (ID,NAME,TYPE) VALUES ({id}, '{name}', {type_id})")

def store_synonyms(synonyms, id, connection):
    for synonym in synonyms:
        sqlite.update(connection, f"INSERT INTO SYNONYMS (ID,NAME) VALUES ({id}, '{synonym}')")

def store_associated_hazarduos_materials(id, hazardous_materials, connection):
    for material in hazardous_materials:
        sqlite.update(connection, f"INSERT INTO ASSOCIATED_HAZARDUOS_MATERIALS (ITEM,MATERIAL) VALUES ({id}, {material})")

def find_hazardous_materials(info, connection):
    """Return ids of the associated hazardous materials"""
    associated_hazardous_materials = info.find_elements_by_xpath('.//div[contains(@class ,"hazardous-material")]')
    hazardous_materials_ids = []
    for material_info in associated_hazardous_materials:
        material = material_info.get_attribute("title")
        # Check if material is in database, otherwise store it
        result = sqlite.read(connection, f"SELECT id from ALL_HAZARDUOS_MATERIALS where NAME = '{material}' ")
        if len(result) == 0:
            sqlite.update(connection, f"INSERT INTO ALL_HAZARDUOS_MATERIALS (NAME) VALUES ('{material}')")
            id = sqlite.read(connection, f"SELECT id from ALL_HAZARDUOS_MATERIALS where NAME = '{material}' ")[0][0]
        else:
            id = result[0][0]
        hazardous_materials_ids.append(id)
    return hazardous_materials_ids

def find_recycle_places(info_rows):
    places = []
    for row in info_rows:
        item = row.find_elements_by_xpath('.//div[starts-with(@class, "table-cell")]')
        if item[0].get_attribute("innerHTML") == "Lämnas":
            text = item[1].get_attribute("innerHTML").split('<span class="comma">, </span>')
            for elem in text:
                if len(elem) > 0:
                    places.append(elem)
    return places

def find_extra_info(info_rows):
    """Return extra 'Think about this' info if there is any"""
    for row in info_rows:
        item = row.find_elements_by_xpath('.//div[starts-with(@class, "table-cell")]')
        if item[0].get_attribute("innerHTML") == "Tänk på":
            return item[1].get_attribute("innerHTML")


def extract_info(connection):
    """Extract info and store in SQLite DB if connection is provided, or Firebase Realtime DB otherwise"""
    chrome_options = Options()
    chrome_options.add_argument("--headless")
    chrome_options.add_argument("--window-size=1920x1080")
    driver = webdriver.Chrome(options=chrome_options)
    driver.get(URL)

    elems = driver.find_elements_by_class_name("waste-hit")

    id = 0
    for item in elems:
        name = item.get_attribute("data-item-name")
        synonyms = item.get_attribute("data-item-synonyms")
        type = item.get_attribute("data-item-type")
        info = item.find_element_by_xpath('.//*[@class="toggle-target"]')
        info_rows = info.find_elements_by_xpath('.//div[@class="table-row"]')

        if connection is not None:
            # SQLite DB connection provided

            this_type_id = set_type(type, connection)

            # Retrieve info of associated hazardous materials
            hazardous_materials_ids = find_hazardous_materials(info, connection)
            store_associated_hazarduos_materials(id, hazardous_materials_ids, connection)

            # TODO: save to database
            places = find_recycle_places(info_rows)

            store_recyclable(id, name, this_type_id, connection)
            store_synonyms(synonyms.split(","), id, connection)
            id += 1

        else:
            synonyms = synonyms.split(",")
            synonyms.append(name)

            # Retrieve info of associated hazardous materials
            hazardous_materials = info.find_elements_by_xpath('.//div[contains(@class ,"hazardous-material")]')

            # Get recycle places
            places = find_recycle_places(info_rows)

            # Get extra information
            extra_info = find_extra_info(info_rows)

            # Insert info into DB
            id = firebase_connect.get_key()
            firebase_connect.insert_recycleable(id, {'type': type, 'extra': extra_info})

            for synonym in synonyms:
                if len(synonym) > 0:
                    firebase_connect.insert_name(id, {'name': synonym})

            for material_info in hazardous_materials:
                material = material_info.get_attribute("title")
                if len(material) > 0:
                    firebase_connect.insert_hazarduos_material(id, {'material': material})

            for place in places:
                firebase_connect.insert_recycle_place(id, {'place': place})

    driver.quit()


def firebase_db():
    firebase_connect.init()
    extract_info(None)

def sqlite_db():
    connection = sqlite.connect(DB)
    create_database(connection)
    extract_info(connection)
    connection.close()

def main():
    firebase_db()

if __name__ == "__main__":
    main()
