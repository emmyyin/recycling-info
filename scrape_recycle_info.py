from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager

url = "https://www.stockholmvattenochavfall.se/avfall-och-atervinning/sortera-dina-sopor/sorteringsguiden/"

data = []

driver = webdriver.Chrome(ChromeDriverManager().install())
driver.get(url)
elems = driver.find_elements_by_class_name("waste-hit")

counter = 0
for item in elems:
    attr = driver.execute_script('var items = {}; for (index = 0; index < arguments[0].attributes.length; ++index) { items[arguments[0].attributes[index].name] = arguments[0].attributes[index].value }; return items;', item)
    name = item.find_element_by_tag_name("span").text

    # name = item.find_element_by_xpath("//span[@class='text item-name']").text
    print(attr)

print(len(elems))

driver.quit()
