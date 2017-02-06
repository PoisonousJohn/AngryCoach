pragma Singleton

import QuickFlux 1.1

Store {
    property alias food: foodStore

    bindSource: AppDispatcher

    FoodStore {
        id: foodStore
    }
}
