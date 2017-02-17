import Material 0.3
import Material.ListItems 0.1

Subtitled {
    property var food;
    property var modelItem;

    ThinDivider {
        opacity: 0.1
        anchors.bottom: parent.bottom
    }

    implicitHeight: height
    itemLabel.style: "title"
    text: food ? food["Name"] : ""
    valueText: food ? Math.round(food.TotalCalories) + qsTr(" kcal") : ""
    subText:
    {
        if (!modelItem)
        {
            return "";
        }

        return modelItem.Amount + qsTr(" g");
    }
}
