import Material.ListItems 0.1

Subtitled {
    property var food;
    property var modelItem;

    implicitHeight: height
    itemLabel.style: "title"
    text: food ? food["Name"] : ""
    valueText: Math.round(food["FoodCalories"]["TotalCalories"] * (modelItem["Amount"] / 100) ) + qsTr(" kcal")
    subText:
    {
        if (!modelItem)
        {
            return "";
        }

        modelItem["Amount"] + qsTr(" g")
    }
}
