import qbs

Project {
    minimumQbsVersion: "1.7.1"

    references: [
        "quickflux.qbs"
    ]

    CppApplication {
        Depends { name: "Qt.widgets" }
        Depends { name: "Qt.core" }
        Depends { name: "Qt.quick" }
        Depends { name: "quickflux" }

        // Additional import path used to resolve QML modules in Qt Creator's code model
        property pathList qmlImportPaths: [
            "$$PWD",
            "views",
            "qmlComponents",
            "quickflux"
        ]

        cpp.cxxLanguageVersion: "c++11"
        cpp.includePaths: [
            product.sourceDirectory + "/quickflux",
            product.sourceDirectory + "/thirdParty",
            product.sourceDirectory + "/persistent",
            product.sourceDirectory + "/thirdParty/jenson/src"
        ]


        cpp.defines: [
            //"QUICK_FLUX_DISABLE_AUTO_QML_REGISTER",
            // The following define makes your compiler emit warnings if you use
            // any feature of Qt which as been marked deprecated (the exact warnings
            // depend on your compiler). Please consult the documentation of the
            // deprecated API in order to know how to port your code away from it.
            "QT_DEPRECATED_WARNINGS"

            // You can also make your code fail to compile if you use deprecated APIs.
            // In order to do so, uncomment the following line.
            // You can also select to disable deprecated APIs only up to a certain version of Qt.
            //"QT_DISABLE_DEPRECATED_BEFORE=0x060000" // disables all the APIs deprecated before Qt 6.0.0
        ]

        files: [
            "persistent/Ingredient.h",
            "persistent/Food.h",
            "persistent/Calories.h",
            "persistent/DataManager.h",
            "persistent/DayLog.h",
            "persistent/JensonHelper.h",
            "persistent/AppData.h",
            "persistent/CustomQHashSerializer.h",
            "persistent/FoodMap.h",
            "persistent/DayLogCache.h",
            "QmlDataProvider.h",
            "persistent/FoodAmount.h",
            "persistent/FoodRecipe.h",
            "persistent/RecipeMap.h",

            "thirdParty/jenson/src/jenson.h",
            "thirdParty/jenson/src/jenson_global.hpp",
            "thirdParty/jenson/src/qmemory.hpp",
            "thirdParty/jenson/src/jenson.cpp",
            "main.cpp",
            "persistent/Ingredient.cpp",
            "persistent/Food.cpp",
            "persistent/Calories.cpp",
            "persistent/DataManager.cpp",
            "persistent/DayLog.cpp",
            "persistent/AppData.cpp",
            "persistent/FoodMap.cpp",
            "persistent/DayLogCache.cpp",
            "QmlDataProvider.cpp",
            "persistent/FoodAmount.cpp",
            "persistent/FoodRecipe.cpp",
            "persistent/RecipeMap.cpp",

            "qml.qrc"
        ]

        Group {     // Properties for the produced executable
            fileTagsFilter: product.type
            qbs.install: true
        }
    }
}
