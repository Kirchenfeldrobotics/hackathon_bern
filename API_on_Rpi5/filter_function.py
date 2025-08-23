import requests

BASE_URL = "https://www.themealdb.com/api/json/v1/1"
"""Dieses File enthält alle Kommunikation mit der themealdb.com api. 
Es enthält verschiedene Funktionen welche, wenn aufgerufen ,die Meals in der Datenbank filtern und schauen welche es zu den Filtern gibt.
Die empfohlenen Meals werden dann in einem sauberen Datenformat an den Call zurückgegeben. Dabei gibt es folgende Filter:
1.Essen über Ingredient
2.anhand mehrer Ingredients also vrohanderer Lebensmittel
3.Namen des Menüs
4.kategorie, z.b. vegi, alle kategorien auf: https://www.themealdb.com/api/json/v1/1/categories.php

Flutter kann folgende Werte anhand der ID Nummer einzeln beziehen:
1.Details
2.Bild

Alle erscheinen menüs zum suchfilter werden als Dictionary returned mit folgendem inhalt:
        "id": meal.get("idMeal"),
        "name": meal.get("strMeal"),
        "category": meal.get("strCategory"),
        "instructions": meal.get("strInstructions"),
        "image": meal.get("strMealThumb"),
        "tags": meal.get("strTags"),
        "ingredients": ingredients

Am Ende des Files befinden sich verschiedene Tests von ChatGPT um die funtkion zu testen.
Diese können aktiviert werden wenn sie aus Kommentar herausgenommen werden"""


"""Filter für Flutter"""
# Essen über nur ein Inhalt filtern
def get_meals_by_ingredient(ingredient):
    url = f"{BASE_URL}/filter.php?i={ingredient}"
    try:
        response = requests.get(url)
        data = response.json()
        if data["meals"]:
            return set(meal["idMeal"] for meal in data["meals"])
    except Exception as e:
        print(f"Error fetching meals for ingredient '{ingredient}': {e}")
    return set()

# filtern von menüs anhand der vorhandenen ingredients (erkennt von z.b. KI)
def find_common_meals(ingredients):
    print(f"Searching for meals with: {', '.join(ingredients)}")
    meal_sets = []

    for ing in ingredients:
        ids = get_meals_by_ingredient(ing)
        if not ids:
            print(f"No meals found for ingredient: {ing}")
            return []
        meal_sets.append(ids)

    common_ids = set.intersection(*meal_sets)
    print(f"\n✅ Found {len(common_ids)} meals that match all ingredients.\n")

    # transformierte Meals zurückgeben
    return [
        transform_meal_details(get_meal_details(meal_id))
        for meal_id in common_ids
        if get_meal_details(meal_id)
    ]

# beim (menü) namen suchen
def search_meal_by_name(name):
    url = f"{BASE_URL}/search.php?s={name}"
    try:
        response = requests.get(url)
        if response.status_code == 200:
            raw_meals = response.json().get("meals", []) or []
            return [
                transform_meal_details(meal)
                for meal in raw_meals
                if meal
            ]
    except Exception as e:
        print(f"Error searching for meal '{name}': {e}")
    return []

# kategorie
def get_meals_by_category(category_name):
    url = f"{BASE_URL}/filter.php?c={category_name}"
    try:
        response = requests.get(url)
        if response.status_code == 200:
            return response.json().get("meals", []) or []
    except Exception as e:
        print(f"Error fetching category '{category_name}': {e}")
    return []

"""Daten für Flutter"""
# Details über meal
def get_meal_details(meal_id):
    url = f"{BASE_URL}/lookup.php?i={meal_id}"
    try:
        response = requests.get(url)
        if response.status_code == 200:
            meals = response.json().get("meals", [])
            return meals[0] if meals else None
    except Exception as e:
        print(f"Error fetching details for meal ID {meal_id}: {e}")
    return None

# bild vom essen
def get_meal_picture_by_id(meal_id):
    details = get_meal_details(meal_id)
    if details:
        return details.get("strMealThumb")
    return None

"""Transformation der Suchergebnisse in Dictionary"""
# umwandeln in Dictionary
def transform_meal_details(meal):
    if not meal:
        return None

    ingredients = []
    for i in range(1, 21):
        ing = meal.get(f"strIngredient{i}")
        meas = meal.get(f"strMeasure{i}")
        if ing and ing.strip():
            ingredients.append({
                "ingredient": ing.strip(),
                "measure": meas.strip() if meas else ""
            })

    return {
        "id": meal.get("idMeal"),
        "name": meal.get("strMeal"),
        "category": meal.get("strCategory"),
        "instructions": meal.get("strInstructions"),
        "image": meal.get("strMealThumb"),
        "tags": meal.get("strTags"),
        "ingredients": ingredients
    }

# filtern und transformieren über kategorie
def fetch_and_transform_meals_by_category(category_name):
    raw_meals = get_meals_by_category(category_name)
    transformed_meals = []

    for meal in raw_meals:
        meal_id = meal.get("idMeal")
        full_details = get_meal_details(meal_id)
        clean_meal = transform_meal_details(full_details)
        if clean_meal:
            transformed_meals.append(clean_meal)

    return transformed_meals

"""Tests"""
"""#von Chatgpt kein plan ob funktioniert
if __name__ == "__main__":
    # Zutaten-Test
    ingredients = ["chicken", "garlic", "onion"]
    matching_meals = find_common_meals(ingredients)

    for meal in matching_meals:
        print(f"- {meal['name']} ({meal['area']})")
        print(f"  Category: {meal['category']}")
        print(f"  Instructions: {meal['instructions'][:100]}...")
        print(f"  Image: {meal['image']}")
        print()

    # Test category transformation
    print("🔍 Testing meal fetch and transformation for category: Vegetarian\n")
    category = "Vegetarian"
    meals = fetch_and_transform_meals_by_category(category)

    if not meals:
        print("❌ No meals found or transformation failed.")
    else:
        print(f"✅ Found {len(meals)} meals in category '{category}'\n")
        for i, meal in enumerate(meals, start=1):
            print(f"🍽️ Meal {i}: {meal['name']}")
            print(f"📸 Image: {meal['image']}")
            print(f"🧂 Ingredients: {len(meal['ingredients'])}")
            print(f"📖 Instructions (preview): {meal['instructions'][:150]}...\n")

    # Test Suche nach Name
    print("🔍 Suche nach Meal-Name: Chicken Handi\n")
    meals_by_name = search_meal_by_name("Chicken Handi")
    for meal in meals_by_name:
        print(f"🍛 {meal['name']} ({meal['area']})")
        print(f"📸 {meal['image']}")
        print(f"🧂 Zutaten: {[i['ingredient'] for i in meal['ingredients']]}")
        print()"""