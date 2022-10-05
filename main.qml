import QtQuick 2.15
import QtQuick.Controls 2.15
import "PageCreationScript.js" as PageCreator

Window {
    id: mainWindow
    width: textField.width * 4
    height: textField.height * 10
    visible: true
    title: qsTr("Homework 6 part 1")

    ButtonGroup{
        id: checkBoxes
        exclusive: true
        onClicked: {
            textField.text = ""
            dateTextField.text = ""
        }
    }
    CheckBox{
        id: checkBoxCommon
        anchors.bottom: checkBoxMath.top
        anchors.left: checkBoxMath.left
        text: qsTr("Common mode")
        ButtonGroup.group: checkBoxes
        checked: true
    }

    CheckBox{
        id: checkBoxMath
        anchors.bottom: checkBoxDate.top
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("Math mode")
        ButtonGroup.group: checkBoxes
    }

    CheckBox{
        id: checkBoxDate
        anchors.bottom: textField.top
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("Date mode")
        ButtonGroup.group: checkBoxes
    }

    TextField{
        id: textField
        width: 135
        anchors.centerIn: parent
        placeholderText: qsTr(checkBoxDate.checked?
                                  "Month(numbers)":
                                  "Numbers only")

        focus: true

        Keys.onEnterPressed: btn.clicked()
        Keys.onReturnPressed: btn.clicked()

        validator: RegularExpressionValidator{
            regularExpression: checkBoxDate.checked?/^(0?[1-9]|1[012])$/:/[0-9]+/
        }
    }

    TextField{
        id: dateTextField
        width: 135
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: textField.bottom
        placeholderText: qsTr("Day (numbers)")

        Keys.onEnterPressed: btn.clicked()
        Keys.onReturnPressed: btn.clicked()

        visible: checkBoxDate.checked

        validator: RegularExpressionValidator{
            regularExpression: /(0[1-9]|[12]\d|3[01])/
        }

    }

    Button{
        id: btn
        anchors.top: dateTextField.bottom
        anchors.left: textField.left
        anchors.topMargin: 10
        enabled: textField.text !== ""
        text: qsTr("Get info")
        background: Rectangle{
            anchors.fill: parent
            color: parent.down? "green" : (parent.hovered? "#d6d6d6" : "#f6f6f6")
        }

        onClicked: {
            var mode = 1 //default, commonMode

            if(checkBoxMath.checked)
                mode = 2

            if(checkBoxDate.checked)
                mode = 3

            PageCreator.create_page(mainWindow, textField.text, mode,
                (mode === 3)?dateTextField.text:0)

            textField.text = ""
            dateTextField.text = ""
        }

    }
    Button{
        anchors.top: dateTextField.bottom
        anchors.right: textField.right
        anchors.topMargin: 10
        text: qsTr("Random")
        background: Rectangle{
            anchors.fill: parent
            color: parent.down? "green" : (parent.hovered? "#d6d6d6" : "#f6f6f6")
        }

        onClicked: {
            PageCreator.create_page(mainWindow, 0, 4, 0)

            textField.text = ""
            dateTextField.text = ""
        }

    }

}
