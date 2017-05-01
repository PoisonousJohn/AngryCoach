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
//    itemLabel.style: "title"
    text: food ? food["Name"] : ""
    valueText: food ? food.TotalCalories.toFixed(2) + qsTr(" kcal") : ""
    subText:
    {
        if (!modelItem)
        {
            return "";
        }

        return modelItem.Amount.toFixed(2) + qsTr(" g");
    }
}
