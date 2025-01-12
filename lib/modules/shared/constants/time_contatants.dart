class GrowTimes {
  static const Map<String, int> cropTimes = {
    "sunflower": 60, // 1 min
    "potato": 300, // 5 min
    "pumpkin": 1800, // 30 min
    "carrot": 3600, // 1 hour
    "cabbage": 7200, // 2 hours
    "soybean": 10800, // 3 hours
    "beetroot": 14400, // 4 hours
    "cauliflower": 28800, // 8 hours
    "parsnip": 43200, // 12 hours
    "eggplant": 57600, // 16 hours
    "corn": 72000, // 20 hours
    "radish": 86400, // 24 hours
    "wheat": 86400, // 24 hours
    "kale": 129600, // 36 hours
    "barley": 172800, // 48 hours
    "rice": 115200, // 32 hours
    "olive": 158400, // 44 hours
    "tomato": 7200, // 2 hours
    "lemon": 14400, // 4 hours
    "blueberry": 21600, // 6 hours
    "orange": 28800, // 8 hours
    "apple": 43200, // 12 hours
    "banana": 43200, // 12 hours
    "grape": 43200, // 12 hours
    "tree": 7200, // 2 hours
    "stone": 14400, // 4 hours
    "iron": 28800, // 8 hours
    "gold": 86400, // 24 hours
    "crimstone": 86400, // 24 hours
    "oil": 72000, // 20 hours
    "sunstone": 259200, // 72 hours
    "fruitPatch": 7200, // 2 hours
    "red pansy": 86400, // 24 hours
    "yellow pansy": 86400, // 24 hours
    "purple pansy": 86400, // 24 hours
    "white pansy": 86400, // 24 hours
    "blue pansy": 86400, // 24 hours
    "red cosmos": 86400, // 24 hours
    "yellow cosmos": 86400, // 24 hours
    "purple cosmos": 86400, // 24 hours
    "white cosmos": 86400, // 24 hours
    "blue cosmos": 86400, // 24 hours
    "petal prism": 86400, // 24 hours
    "red balloon flower": 172800, // 48 hours
    "yellow balloon flower": 172800, // 48 hours
    "purple balloon flower": 172800, // 48 hours
    "white balloon flower": 172800, // 48 hours
    "blue balloon flower": 172800, // 48 hours
    "red daffodil": 172800, // 48 hours
    "yellow daffodil": 172800, // 48 hours
    "purple daffodil": 172800, // 48 hours
    "white daffodil": 172800, // 48 hours
    "blue daffodil": 172800, // 48 hours
    "celestial frostbloom": 172800, // 48 hours
    "red carnation": 432000, // 120 hours (5 days)
    "yellow carnation": 432000, // 120 hours (5 days)
    "purple carnation": 432000, // 120 hours (5 days)
    "white carnation": 432000, // 120 hours (5 days)
    "blue carnation": 432000, // 120 hours (5 days)
    "red lotus": 432000, // 120 hours (5 days)
    "yellow lotus": 432000, // 120 hours (5 days)
    "purple lotus": 432000, // 120 hours (5 days)
    "white lotus": 432000, // 120 hours (5 days)
    "blue lotus": 432000, // 120 hours (5 days)
    "primula enigma": 432000, // 120 hours (5 days)
    "mushroomRegular": 57600, // 16 hours
    "mushroomMagic": 86400, // 24 hours
  };
}

class CookingTimes {
  static const Map<String, int> cookingTimes = {
    // All cooking times in seconds
    "mashedPotato": 30, // 30 sec
    "pumpkinSoup": 180, // 3 min
    "reindeerCarrot": 300, // 5 min
    "mushroomSoup": 600, // 10 min
    "popcorn": 720, // 12 min
    "bumpkinBroth": 1200, // 20 min
    "cabbersNMash": 2400, // 40 min
    "boiledEggs": 3600, // 1 hour
    "kaleStew": 7200, // 2 hours
    "kaleOmelette": 12600, // 3.5 hours
    "gumbo": 14400, // 4 hours
    "rapidRoast": 10, // 10 sec
    "friedTofu": 5400, // 90 min
    "riceBun": 18000, // 300 min
    "antipasto": 10800, // 180 min
    "pizzaMargherita": 72000, // 20 hours
    // Kitchen Recipes (in seconds)
    "sunflowerCrunch": 600, // 10 min
    "mushroomJacketPotatoes": 600, // 10 min
    "fruitSalad": 1800, // 30 min
    "pancakes": 3600, // 1 hour
    "roastVeggies": 7200, // 2 hours
    "cauliflowerBurger": 10800, // 3 hours
    "clubSandwich": 10800, // 3 hours
    "bumpkinSalad": 12600, // 3.5 hours
    "bumpkinGanoush": 18000, // 5 hours
    "goblinsTreat": 21600, // 6 hours
    "chowder": 28800, // 8 hours
    "bumpkinRoast": 43200, // 12 hours
    "goblinBrunch": 43200, // 12 hours
    "beetrootBlaze": 30, // 30 sec
    "steamedRedRice": 14400, // 4 hours
    "tofuScramble": 10800, // 3 hours
    "friedCalamari": 18000, // 5 hours
    "fishBurger": 7200, // 2 hours
    "fishOmelette": 18000, // 5 hours
    "oceansOlive": 7200, // 2 hours
    "seafoodBasket": 18000, // 5 hours
    "fishNChips": 14400, // 4 hours
    "sushiRoll": 3600, // 1 hour
    "capreseSalad": 10800, // 3 hours
    "spaghettiAlLimone": 54000, // 15 hours
    // Bakery Recipes (in seconds)
    "applePie": 14400, // 4 hours
    "orangeCake": 14400, // 4 hours
    "kaleMushroomPie": 14400, // 4 hours
    "sunflowerCake": 23400, // 6.5 hours
    "honeyCake": 28800, // 8 hours
    "potatoCake": 37800, // 10.5 hours
    "pumpkinCake": 37800, // 10.5 hours
    "cornbread": 43200, // 12 hours
    "carrotCake": 46800, // 13 hours
    "cabbageCake": 54000, // 15 hours
    "beetrootCake": 79200, // 22 hours
    "cauliflowerCake": 79200, // 22 hours
    "parsnipCake": 86400, // 24 hours
    "eggplantCake": 86400, // 24 hours
    "radishCake": 86400, // 24 hours
    "wheatCake": 86400, // 24 hours
    "lemonCheesecake": 108000, // 30 hours
    // Deli Items (in seconds)
    "blueberryJam": 43200, // 12 hours
    "fermentedCarrots": 86400, // 24 hours
    "sauerkraut": 86400, // 24 hours
    "fancyFries": 86400, // 24 hours
    "fermentedFish": 86400, // 24 hours
    "shroomSyrup": 10, // 10 sec
    "cheese": 1200, // 20 min
    "blueCheese": 10800, // 3 hours
    "honeyCheddar": 43200, // 12 hours
    // Smoothie Shack (in seconds)
    "purpleSmoothie": 1800, // 30 min
    "orangeJuice": 2700, // 45 min
    "appleJuice": 3600, // 1 hour
    "powerSmoothie": 5400, // 1.5 hours
    "bumpkinDetox": 7200, // 2 hours
    "bananaBlast": 10800, // 3 hours
    "grapeJuice": 10800, // 3 hours
    "theLot": 12600, // 3.5 hours
    "carrotJuice": 3600, // 1 hour
    "quickJuice": 1800, // 30 min
    "slowJuice": 86400, // 24 hours
    "sourShake": 3600, // 1 hour
    // Base Times (in seconds)
    "compostBin": 21600, // 6 hours
    "turboComposter": 28800, // 8 hours
    "premiumComposter": 43200, // 12 hours
    // Egg Boost Times (in seconds)
    "compostBinEggBoost": 7200, // 2 hours
    "turboComposterEggBoost": 10800, // 3 hours
    "premiumComposterEggBoost": 14400, // 4 hours
  };
}

int getCropGrowTime(String cropName) {
  return GrowTimes.cropTimes[cropName] ?? 0;
}

int getCookingTime(String cookingName) {
  return CookingTimes.cookingTimes[cookingName] ?? 0;
}
