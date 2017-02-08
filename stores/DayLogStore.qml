pragma Singleton

import QtQuick 2.5
import QuickFlux 1.1

AppListener {
    property var day: dataManager.selectedDate
    property var log
    onDayChanged: {
        log = dataManager.getDayLog(day);
    }

    onDispatched: {
        switch (type) {
            case "selectDay":
                dataManager.selectedDate = message.day;
                break;
        }
    }

    Connections {
        target: dataManager
        onDayLogChanged: {
            log = dataManager.getDayLog(day)
        }
    }


}
