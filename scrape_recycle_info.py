from selenium import webdriver
from selenium.webdriver.chrome.options import Options


url = "https://www.stockholmvattenochavfall.se/avfall-och-atervinning/sortera-dina-sopor/sorteringsguiden/"

# Temp for database tables
all_recycleables = {}
all_synonyms = {}
all_types = {}
all_hazardous_materials = {}
all_recycle_places = {}

chrome_options = Options()
chrome_options.add_argument("--headless")
chrome_options.add_argument("--window-size=1920x1080")
driver = webdriver.Chrome(options=chrome_options)
driver.get(url)
elems = driver.find_elements_by_class_name("waste-hit")


for item in elems:
    print("-----------------------")

    name = item.get_attribute("data-item-name")
    synonyms = item.get_attribute("data-item-synonyms")
    type = item.get_attribute("data-item-type")
    this_type_id = len(all_types)
    id = len(all_recycleables)

    # Retrieve info of associated hazardous materials
    info = item.find_element_by_xpath('.//*[@class="toggle-target"]')
    associated_hazardous_materials = info.find_elements_by_xpath('.//div[contains(@class ,"hazardous-material")]')
    hazardous_materials = []
    hazardous_materials_ids = []
    for material_info in associated_hazardous_materials:
        material = material_info.get_attribute("title")
        # Check if material is already stored
        if material in all_hazardous_materials:
            hazardous_materials_ids.append(all_hazardous_materials[material])
        else:
            all_hazardous_materials.update({material: len(all_hazardous_materials)})
            hazardous_materials_ids.append(all_hazardous_materials[material])

        hazardous_materials.append(material)

    # TODO: Get all recycle places
    recycle_place = info.find_elements_by_xpath('.//div[@class="table-cell wiki-search-info"]/*')
    for item in recycle_place:
        attr = driver.execute_script('var items = {}; for (index = 0; index < arguments[0].attributes.length; ++index) { items[arguments[0].attributes[index].name] = arguments[0].attributes[index].value }; return items;', item)
        # print(attr)

    # Check if type is already stored
    if type in all_types:
        this_type_id = all_types[type]
    else:
        all_types.update({type: len(all_types)})

    # Add recycable item
    all_recycleables.update({id: {"name": name, "type": this_type_id, "hazardous_materials": hazardous_materials_ids}})

    # Add associated synonyms of item
    synonyms = synonyms.split(",")
    for synonym in synonyms:
        all_synonyms.update({synonym: id})

    print(name, synonyms, type, hazardous_materials)


print(all_recycleables)
print(all_synonyms)
print(all_types)
print(all_hazardous_materials)

driver.quit()
