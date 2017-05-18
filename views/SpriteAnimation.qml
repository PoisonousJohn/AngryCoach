import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import Material 0.3
import Material.ListItems 0.1
import "UIHelpers.js" as UIHelpers

AnimatedSprite {
    id: spriteAnimation
    property var frameSequence;
    property int currentFrameInSequence;
    signal advanceToNextFrame;
    onAdvanceToNextFrame: {
    }

    paused: true

    Component.onCompleted: {
        currentFrame = frameSequence[0]
    }

    Timer {
        id: timer
        interval: 1000 / spriteAnimation.frameRate
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: {
            if (currentFrameInSequence >= frameSequence.length)
            {
                currentFrameInSequence = 0;
            }

            currentFrame = frameSequence[currentFrameInSequence]
            currentFrameInSequence++;
        }
    }
}
