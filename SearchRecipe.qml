import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.2
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle

ChooseFood {
    id: searchRecipe
    model: dataManager.recipes
    title: qsTr("Choose recipe to add")
    onAdd: {
        addRecipe.loadPage({ recipeId: "" });
    }

    PageLoader {
        id: chooseRecipeAmount
        pagePath: "ChooseRecipeAmount.qml"
    }

    PageLoader {
        id: addRecipe
        pagePath: "AddRecipe.qml"
    }

    
    onItemSelected: {
        chooseRecipeAmount.loadPage({recipe: item});
    }
    onEditItem: {
        addRecipe.loadPage({ recipeId: itemId });
    }
    onDeleteItem: {
        recipeDeleteDialog.itemId = itemId
        recipeDeleteDialog.show(qsTr("Delete recipe?", "Do you really want to delete this item?"));
    }

    DialogLoader {
        id: recipeDeleteDialog
        property string itemId;
        onAccepted: {
            dataManager.removeRecipe(itemId)
        }
    }
}
