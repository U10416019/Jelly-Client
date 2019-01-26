import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3

Rectangle {
    width: parent.width / 320 * 25
    height: parent.height / 550 * 30
    x: parent.width / 320 * 10
    y: parent.height / 550 * 25




    function showBellImage(){
        bellAnimation.visible = false
        bellImage.visible = true
    }

    function showBellAnimation(){
        bellAnimation.visible = true
        bellImage.visible = false
    }






    Image {
        id: bellImage
        width: parent.width
        height: parent.height
        //sourceSize.width: 60
        //sourceSize.height: 40
        fillMode: Image.PreserveAspectCrop
        source: "bell.gif"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                bellScrollView.visible = true
            }
        }
    }

    AnimatedImage {
        id: bellAnimation
        width: parent.width
        height: parent.height
        //sourceSize.width: 60
        //sourceSize.height: 40
        fillMode: Image.PreserveAspectCrop
        source: "bell.gif"
        visible: false

        MouseArea {
            anchors.fill: parent
            onClicked: {
                bellAnimation.visible = false
                bellImage.visible = true
                bellScrollView.visible = true
            }
        }
    }



}
