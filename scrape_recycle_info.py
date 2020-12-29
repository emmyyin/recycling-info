from selenium import webdriver
from selenium.webdriver.chrome.options import Options
        

url = "https://www.stockholmvattenochavfall.se/avfall-och-atervinning/sortera-dina-sopor/sorteringsguiden/"

data = {}

chrome_options = Options()
chrome_options.add_argument("--headless")
chrome_options.add_argument("--window-size=1920x1080")
driver = webdriver.Chrome(options=chrome_options)
driver.get(url)
elems = driver.find_elements_by_class_name("waste-hit")

id = 0
for item in elems:
    print("-----------------------")

    name = item.get_attribute("data-item-name")
    synonyms = item.get_attribute("data-item-synonyms")
    type = item.get_attribute("data-item-type")

    info = item.find_element_by_xpath('.//*[@class="toggle-target"]')
    associated_hazardous_materials = info.find_elements_by_xpath('.//div[contains(@class ,"hazardous-material")]')
    hazardous_materials = []
    for material in associated_hazardous_materials:
        hazardous_materials.append(material.get_attribute("title"))

    recycle_place = info.find_elements_by_xpath('.//div[@class="table-cell wiki-search-info"]/*')
    for item in recycle_place:
        attr = driver.execute_script('var items = {}; for (index = 0; index < arguments[0].attributes.length; ++index) { items[arguments[0].attributes[index].name] = arguments[0].attributes[index].value }; return items;', item)
        print(attr)

    data.update({id: {"name": name, "synonyms": synonyms, "type": type, "hazardous_materials": hazardous_materials}})
    print(name, synonyms, type, hazardous_materials)

    id += 1

print(len(elems))
print(data)

driver.quit()
