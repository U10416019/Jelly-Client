import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import com.company.client 1.0

Rectangle {
    width: parent.width
    height: parent.height


    property string friend_id: ""
    property string friend_name: ""

    function getSearchFriendInfo(_friend_id, _friend_name){
        friend_id = _friend_id
        friend_name = _friend_name
        recShowFriendInfo.visible = true
        textFriendName.text = friend_name
    }

    function cleanSearchFriendName(){
        recShowFriendInfo.visible = false
        textFriendName.text = ""
        textFieldFriendName.text = ""
    }

    Rectangle {
        id: rectangleLine
//        x: 5
//        y: 91
//        width: 310
//        height: 5
        x: parent.width / 2 - rectangleLine.width / 2
        y: parent.height / 550 * 91
        width: parent.width / 320 * 310
        height: parent.height / 550 * 5
        color: "#dbdbdb"
        radius: parent.height / 550 * 3
    }

    TextField {
        id: textFieldFriendName
//        x: 24
//        y: 125
//        width: 192
//        height: 35
        x: parent.width / 320 * 24
        y: parent.height / 550 * 125
        width: parent.width / 320 * 192
        height: parent.height / 550 * 35
        text: qsTr("")
        font.pointSize: 15
        placeholderText: "請輸入朋友帳號"
    }

    Rectangle {
        id: recSearch
//        x: 231
//        y: 130
//        width: 65
//        height: 27
        x: parent.width / 320 * 231
        y: parent.height / 550 * 130
        width: parent.width / 320 * 65
        height: parent.height / 550 * 27
        color: "#ffb6b6"
        radius: parent.height / 550 * 10

        Text {
            width: parent.width
            height: parent.height
            text: qsTr("搜尋")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 14
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                client.button_SearchFriend_clicked(textFieldFriendName.text)
            }
        }
    }



















    Rectangle {
        id: recShowFriendInfo
//        x: 10
//        y: 194
//        width: 300
//        height: 277
        x: parent.width / 2 - recShowFriendInfo.width / 2
        y: parent.height / 550 * 194
        width: parent.width / 320 * 300
        height: parent.height / 550 * 277
        radius: parent.height / 550 * 15
        visible: false
        gradient: Gradient {
            GradientStop {
                position: 0.398
                color: "#ffe9f4"
            }

            GradientStop {
                position: 1
                color: "#fd8fc6"
            }
        }

        Rectangle {
            id: recFriendName
//            x: 14
//            y: 18
//            width: 192
//            height: 35
            x: parent.width / 300 * 14
            y: parent.height / 277 * 18
            width: parent.width / 300 * 192
            height: parent.height / 277 * 35
            color: "#ffffff"
            radius: parent.height / 277 * 15

            Text {
                id: textFriendName
                width: parent.width
                height: parent.height
                text: qsTr("friend name")
                font.pointSize: 18
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        Rectangle {
            id: recAdd
//            x: 221
//            y: 22
//            width: 65
//            height: 27
            x: recFriendName.x + recFriendName.width + parent.width / 300 * 15
            y: recFriendName.y + recFriendName.height / 2 - recAdd.height / 2
            width: parent.width / 300 * 65
            height: parent.height / 277 * 27
            color: "#ffffff"
            radius: parent.height / 277 * 10

            Text {
                width: parent.width
                height: parent.height
                text: qsTr("加入")
                font.pointSize: 15
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    client.button_AddFriend_clicked()
                }
            }
        }
    }

//    UserInformation{
//        id: userInformation
//        visible: true
//    }

//    SidePull{
//        id: sidePull
//        visible: true
//    }




}
