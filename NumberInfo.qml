import QtQuick 2.15
import QtQuick.Controls 2.15

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Number " + currentNumber)
    modality: Qt.ApplicationModal
    property int currentNumber
    property int currentMode
    property int currentDay

    function getData() {
        var xmlhttp = new XMLHttpRequest();
        var url = "http://numbersapi.com/" + currentNumber

        if(currentMode === 2) //Math
            url += "/math"
        else if (currentMode === 3) //date
            url += "/" + currentDay + "/date"
        else if(currentMode === 4)
            url = "http://numbersapi.com/random/trivia"

        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState == XMLHttpRequest.DONE && xmlhttp.status == 200) {

                txtLabel.text = xmlhttp.responseText
            }
        }
        xmlhttp.open("GET", url, true);
        xmlhttp.send();
    }

    Component.onCompleted: getData()

    Label{
        id: txtLabel
        anchors.centerIn: parent
        width: window.width / 2
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
    }

    Button{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: txtLabel.bottom
        anchors.topMargin: txtLabel.height
        text: qsTr("Close")
        background: Rectangle{
            anchors.fill: parent
            color: parent.down? "green" : (parent.hovered? "#d6d6d6" : "#f6f6f6")
        }

        onClicked: {
            opacityAnimation.start()
        }
    }

    PropertyAnimation{
        id: opacityAnimation
        targets: window
        property: "opacity"
        to: 0
        duration: 500
        onFinished: window.destroy()
    }
}
