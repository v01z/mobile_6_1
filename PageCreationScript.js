function create_page(parent, number, mode, day) {

    var component = Qt.createComponent("NumberInfo.qml")
    var newWindow = component.createObject(parent,
        { currentNumber: number, currentMode: mode, currentDay: day })

    if (newWindow === null)
    {
        console.log("Error creating object.")
    }
}
