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
            // "quickflux/*.cpp",
            // "quickflux/*.h",
            // "quickflux/priv/*.h",
            // "quickflux/priv/*.cpp",
    "quickflux/qfapplistener.h",
    "quickflux/qfappscript.h",
    "quickflux/priv/qfappscriptrunnable.h",
    "quickflux/priv/qfappscriptdispatcherwrapper.h",
    "quickflux/priv/qflistener.h",
    "quickflux/qfapplistenergroup.h",
    "quickflux/qfappscriptgroup.h",
    "quickflux/qffilter.h",
    "quickflux/qfkeytable.h",
    "quickflux/priv/qfsignalproxy.h",
    "quickflux/qfactioncreator.h",
    "quickflux/QFAppDispatcher",
    "quickflux/QFKeyTable",
    "quickflux/QuickFlux",
    "quickflux/qfobject.h",
    "quickflux/priv/qfhook.h",
    "quickflux/qfdispatcher.h",
    "quickflux/qfappdispatcher.h",
    "quickflux/priv/quickfluxfunctions.h",
    "quickflux/priv/qfmiddlewareshook.h",
    "quickflux/qfstore.h",
    "quickflux/qfhydrate.h",
    "quickflux/qfmiddleware.h",
    "quickflux/qfmiddlewarelist.h",
    "quickflux/qfapplistener.cpp",
    "quickflux/qfappscript.cpp",
    "quickflux/qfappscriptrunnable.cpp",
    "quickflux/qfappscriptdispatcherwrapper.cpp",
    "quickflux/qflistener.cpp",
    "quickflux/qfqmltypes.cpp",
    "quickflux/qfapplistenergroup.cpp",
    "quickflux/qfappscriptgroup.cpp",
    "quickflux/qffilter.cpp",
    "quickflux/qfkeytable.cpp",
    "quickflux/priv/qfsignalproxy.cpp",
    "quickflux/qfactioncreator.cpp",
    "quickflux/qfobject.cpp",
    "quickflux/priv/qfhook.cpp",
    "quickflux/qfdispatcher.cpp",
    "quickflux/qfappdispatcher.cpp",
    "quickflux/priv/quickfluxfunctions.cpp",
    "quickflux/priv/qfmiddlewareshook.cpp",
    "quickflux/qfstore.cpp",
    "quickflux/qfhydrate.cpp",
    "quickflux/qfmiddleware.cpp",
    "quickflux/qfmiddlewarelist.cpp",
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
