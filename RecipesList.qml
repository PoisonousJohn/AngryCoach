import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.2
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle
import 'singletons'

EditableItemsList {
    id: recipesList
    model: dataManager.recipes
    title: qsTr("Choose recipe to add")
    onAdd: {
        AppActions.openRecipePage(null);
//        addRecipe.loadPage({ recipeId: "" });
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
