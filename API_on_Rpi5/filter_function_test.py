import requests

BASE_URL = "https://www.themealdb.com/api/json/v1/1"

# Filter sind hier:
"""provisorisch
def get_meals_by_ingredients(ingredients):
    """"""Fetch meals that include ALL specified ingredients.""""""
    if not ingredients:
        return []

    # Start with meals from the first ingredient
    base_meals = fetch_meals_for_ingredient(ingredients[0])
    if not base_meals:
        return []

    # Convert to dict for fast lookup
    base_ids = {meal["idMeal"]: meal for meal in base_meals}

    # Intersect with meals from other ingredients
    for ingredient in ingredients[1:]:
        other_meals = fetch_meals_for_ingredient(ingredient)
        other_ids = {meal["idMeal"] for meal in other_meals}
        base_ids = {id_: meal for id_, meal in base_ids.items() if id_ in other_ids}

    return list(base_ids.values())
    """

def search_meal_by_name(name):
    # meal nach string suchen im Verzeichnis, keine response heisst keines gefunden.
    """Search for a meal by its name."""
    url = f"{BASE_URL}/search.php?s={name}"
    response = requests.get(url)
    if response.status_code == 200:
        return response.json().get("meals", []) or []
    return []

def get_meals_by_category(category_name):
    # meal nach Kategorie im Verzeichnis suchen, z.b. Vegetarisch odr so
    url = f"{BASE_URL}/filter.php?c={category_name}"
    response = requests.get(url)
    if response.status_code == 200:
        return response.json().get("meals", []) or []
    return []


# Informationen für Darstellung in Flutter sind hier:

def get_meal_details(meal_id):
    #informationen in JSON über Meal
    """Fetch full details of a meal by its ID."""
    url = f"{BASE_URL}/lookup.php?i={meal_id}"
    response = requests.get(url)
    if response.status_code == 200:
        meals = response.json().get("meals", [])
        return meals[0] if meals else None
    return None

def get_meal_picture_by_id(meal_id):
    #Bild von Meal in JSON
    """Return the image URL of a meal given its ID."""
    details = get_meal_details(meal_id)
    if details:
        return details.get("strMealThumb")
    return None

# Daten in Dictionary umwandeln

def fetch_and_transform_meals_by_category(category_name):
    """
    Holt alle Meals einer Kategorie, lädt ihre Details und wandelt sie in saubere Dictionaries um.
    """
    raw_meals = get_meals_by_category(category_name)
    transformed_meals = []

    for meal in raw_meals:
        meal_id = meal.get("idMeal")
        full_details = get_meal_details(meal_id)
        clean_meal = transform_meal_details(full_details)
        if clean_meal:
            transformed_meals.append(clean_meal)

    return transformed_meals

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

# BI IM ZIMMER , KEI AKKU, AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH TAMISIECH
#TAMISIIECH IG CHUM ÜBERE HUERE AFF
#HF

"""
Test script if needed
if __name__ == "__main__":
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
            """