import QtQuick 2.5
import QtQuick.Layouts 1.1
import QuickFlux 1.0
import Material 0.2
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle
import '../singletons'

EditableItemsList {
    id: recipesList
    model: dataManager.recipes
    title: qsTr("Choose recipe to add")
    onAdd: {
        AppActions.openRecipePage(null);
    }
    
    onItemSelected: {
        AppActions.requestAddRecipeAmount(item.Id);
    }
    onEditItem: {
        AppActions.openRecipePage(itemId);
    }
    onDeleteItem: {
        AppActions.askToRemoveRecipe(itemId);
    }


    AppListener {
        onDispatched: {
            if (type === "acceptRecipeAmount" ) {
                MainPageStack.pageStack.pop();
            }
        }
    }
}
