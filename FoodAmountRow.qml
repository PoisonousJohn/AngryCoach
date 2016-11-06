import Material.ListItems 0.1

Subtitled {
    property var food;
    property var modelItem;

    itemLabel.style: "title"
    text: food ? food["Name"] : ""
    subText:
    {
        if (!modelItem)
        {
            return "";
        }

        modelItem["Amount"] + qsTr(" g") + " (" + Math.round(food["FoodCalories"]["TotalCalories"] * (modelItem["Amount"] / 100) ) + qsTr(" kcal") + ")"
    }
}
