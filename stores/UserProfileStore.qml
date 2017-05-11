import QuickFlux 1.0

AppListener {
    property var profile: getUserProfileViewModel();
    property var canGoBack;

    function getNutritionNorm(calories) {
        return {
            'Carbs' : calories * 0.50 / 4, // 4 kcal/g
            'Proteins' : calories * 0.30 / 4, // 4 kcal/g
            'Fats' : calories * 0.20 / 9, // 9 kcal/g
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

    function getUserProfileViewModel() {
        var profile = dataManager.userProfile;
        var dailyCalories = getDailyCaloriesNorm(
                    profile.Weight,
                    profile.Height,
                    profile.Age,
                    profile.Sex
        );
        var dailyNorm = getNutritionNorm(dailyCalories);
        var modifier = profile.MassModifierFactor;

        return {
            "Weight": profile.Weight,
            "Height": profile.Height,
            "Age": profile.Age,
            "Sex": profile.Sex,
            "MaxCarbs": dailyNorm.Carbs * modifier,
            "MaxProteins": dailyNorm.Proteins * modifier,
            "MaxFats": dailyNorm.Fats * modifier,
            "MaxCalories": dailyCalories * modifier,
        };
    }

    onDispatched: {
        switch(type) {
            case "updateUserProfile":
                dataManager.updateUserProfile(message.data);
                profile = getUserProfileViewModel();
                break;

        }
    }

}
