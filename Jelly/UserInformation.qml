import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3

Rectangle {
    id: recUserInfo
//    width: 240
//    height: 68
    width: parent.width / 320 * 240
    height: parent.height / 550 * 68
    color: "#00ffffff"
//    x: 40
//    y: 11
    x: parent.width / 2 - recUserInfo.width / 2
    y: parent.height / 550 * 11

    property string userInfoID: ""
    property string userInfoName: ""
    property string userInfoImage: ""

    function getUserInformation(user_id, user_name, user_image){
        console.log("userInfo: userID = " + user_id + ", userName = " + user_name + ", userImage = " + user_image)
        userInfoID = user_id
        userInfoName = user_name
        userInfoImage = user_image
        textUserName.text = userInfoName
        userImage.source = userInfoImage
    }

    Rectangle {
//        width: 240
//        height: 68
        width: parent.width
        height: parent.height
        color: "#e0dfdf"
        radius: parent.width / 240 * 20

        Image {
            id: userImage
//            x: 8
//            y: 8
//            width: 52
//            height: 52
            x: parent.width / 240 * 8
            y: parent.width / 240 * 8
            width: parent.width / 240 * 52
            height: parent.width / 240 * 52
            source: "Jelly.png"
        }

        Text {
            id: textUserInfo
//            x: 66
//            y: 8
//            width: 155
//            height: 22
            x: parent.width / 240 * 66
            y: parent.height / 68 * 8
            width: parent.width / 240 * 155
            height: parent.height / 68 * 22
            text: qsTr("個人資訊")
            renderType: Text.QtRendering
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 12
        }

        Text {
            id: textUserName
//            x: 66
//            y: 30
//            width: 155
//            height: 30
            x: textUserInfo.x
            width: textUserInfo.width
            height: parent.height / 68 * 30
            anchors.top: textUserInfo.bottom
            text: qsTr("User Name")
            lineHeight: 1
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 16
        }
    }
}
