
.pragma library

function getNutritionNorm(calories) {
    return {
        'Carbs' : calories * 0.45 / 4, // 4 kcal/g
        'Proteins' : calories * 0.25 / 4, // 4 kcal/g
        'Fats' : calories * 0.30 / 9, // 9 kcal/g
    }
}

function getDailyCaloriesNorm(weight, height, age, sex) {
    if (sex === 'Male')
    {
        return 10 * weight + 6.25 * height - 5 * age + 5;
    }
    else
    {
        return 10 * weight + 6.25 * height - 5 * age - 161;
    }
}
