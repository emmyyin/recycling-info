import sqlite

DB = "database.db"

def get_all_types(connection):
    result = sqlite.read(connection, f"SELECT * from TYPES")
    print("----")
    print(f"found {len(result)} types:")
    for line in result:
        print(line)

def get_recycleable(connection, id):
    result = sqlite.read(connection, f"SELECT * from RECYCLEABLES where ID = {id}")
    print("----")
    print("recycleable:")
    print(result)

def get_synonyms(connection, id):
    result = sqlite.read(connection, f"SELECT NAME from SYNONYMS where ID = {id}")
    print("----")
    print("all synonyms:")
    print(result)

def get_hazarduos_materials(connection, id):
    result = sqlite.read(connection, f"SELECT NAME from ASSOCIATED_HAZARDUOS_MATERIALS INNER JOIN ALL_HAZARDUOS_MATERIALS ON ASSOCIATED_HAZARDUOS_MATERIALS.MATERIAL = ALL_HAZARDUOS_MATERIALS.ID where ASSOCIATED_HAZARDUOS_MATERIALS.ITEM = {id}")
    print("----")
    print("associated hazardous materials:")
    print(result)

def main():
    connection = sqlite.connect(DB)
    get_all_types(connection)
    get_recycleable(connection, 15)
    get_synonyms(connection, 15)
    get_hazarduos_materials(connection, 0)
    connection.close()

if __name__ == "__main__":
    main()
