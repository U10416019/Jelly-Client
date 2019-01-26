import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import com.company.client 1.0

Rectangle {
    id: msgInfo
    width: parent.width
    height: parent.height
    color: "#b3424242"


    property string friend_id: ""
    property string friend_name: ""
    property string room_id: ""
    property string user_id: ""
    property string user_name: ""
    property string message: ""

    function getNoteMsgInfo(_friend_id, _friend_name, _user_id, _user_name, _message){
        friend_id = _friend_id
        friend_name = _friend_name
        user_id = _user_id
        user_name = _user_name
        message = _message
        stopOtherActive()
    }

    function stopOtherActive(){
        login.enabled = false
        roomList.enabled = false
        friendList.enabled = false
        searchFriend.enabled = false
        sidePull.enabled = false
        userInformation.enabled = false
    }

    function startOtherActive(){
        login.enabled = true
        roomList.enabled = true
        friendList.enabled = true
        searchFriend.enabled = true
        sidePull.enabled = true
        userInformation.enabled = true
    }


    MouseArea{
        anchors.fill: parent
        onClicked: {
            msgInfo.visible = false
            startOtherActive()
        }
    }


    ColumnLayout{
        width: parent.width - parent.width / 320 * 60 * 2
        height: parent.height - parent.height / 550 * 400
        x: parent.width / 320 * 60
        y: parent.height / 550 * 150
        spacing: 15

        Rectangle{
            width: parent.width
            height: parent.height / 150 * 50
            radius: parent.height / 150 * 15

            Text {
                text: qsTr("刪除此內容")
                font.pointSize: 14
                width: parent.width
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    msgInfo.visible = false
                    startOtherActive()
                    client.button_DeleteNoteMessage_clicked(friend_id, friend_name, user_id, user_name, message)
                    mainPage.unreadMessageClear()
                }
            }
        }

        Rectangle{
            width: parent.width
            height: parent.height / 150 * 50
            radius: parent.height / 150 * 15

            Text {
                text: qsTr("編輯內容")
                font.pointSize: 14
                width: parent.width
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    msgInfo.visible = false
                    startOtherActive()
                }
            }
        }


    }



}
