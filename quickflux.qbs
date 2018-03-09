import qbs

Project {
    name: "quickflux"
    minimumQbsVersion: "1.7.1"

    StaticLibrary {
        name: "quickflux"

        Depends { name: "Qt.core" }
        Depends { name: "Qt.quick" }
        Depends { name: "Qt.qml" }

        // Additional import path used to resolve QML modules in Qt Creator's code model
        property pathList qmlImportPaths: [
        ]

        cpp.cxxLanguageVersion: "c++11"
        cpp.includePaths: [
            "quickflux",
            "quickflux/priv"
        ]
        files: [
            "quickflux/*.cpp",
            "quickflux/*.h",
            "quickflux/priv/*.h",
            "quickflux/priv/*.cpp",
        ]


        cpp.defines: []

        FileTagger {
            patterns: ["qmldir"]
            fileTags: ["qml"]
        }


        Group {     // Properties for the produced executable
            // fileTagsFilter: product.type
            qbs.install: true
            qbs.installDir: "quickflux"
            fileTagsFilter: ["staticlibrary", "qml"]
        }
    }

}
