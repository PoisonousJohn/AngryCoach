import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import "./singletons"
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle

Loader {
    id: pageLoader
    asynchronous: false
    property string pagePath;

    function loadPage(params)
    {
        if (params)
        {
            setSource(pagePath, params)
        }
        else
        {
            setSource(pagePath)
        }

        MainPageStack.pageStack.push(item)
    }
}
