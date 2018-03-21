import qbs

Project {
    minimumQbsVersion: "1.7.1"
    qbsSearchPaths: ["fluid/qbs/shared"]

    references: [
        "quickflux.qbs",
    ]

    SubProject {
        filePath: "fluid/fluid.qbs"

        Properties {
            prefix: ""
            useSystemQbsShared: false
            autotestEnabled: false
            deploymentEnabled: false
            withDocumentation: false
            withDemo: false
        }
    }

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
            "quickflux",
            "fluid/qbs/shared"
//            ,"fluid/qbs/local"
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
            "*.h",
            "*.cpp",
            "thirdParty/jenson/src/*.h",
            "thirdParty/jenson/src/*.hpp",
            "thirdParty/jenson/src/*.cpp",
            "persistent/*.h",
            "persistent/*.cpp",
            "qml.qrc"
        ]

        Group {     // Properties for the produced executable
            fileTagsFilter: product.type
            qbs.install: true
        }
    }
}
