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

    function getChatRoomMsgInfo(_friend_id, _friend_name, _room_id, _user_id, _user_name, _message){
        friend_id = _friend_id
        friend_name = _friend_name
        room_id = _room_id
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
//            width: parent.width / 320 * 200
//            height: parent.height / 550 * 50
//            radius: parent.height / 550 * 15
            width: parent.width
            height: parent.height / 150 * 50
            radius: parent.height / 150 * 15

            Text {
                text: qsTr("刪除此訊息")
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

//                    chatRoom.clearAllMessage()
//                    client.button_FriendChat_clicked(friend_name, friend_id, userInformation.userInfoName, userInformation.userInfoID)
//                    chatRoom.visible = true
//                    userInformation.visible = false
//                    chatRoom.getChatRoomMsgInfo(friend_id, friend_name, friend_image, userInformation.userInfoID, userInformation.userInfoName)

                }
            }
        }

        Rectangle{
            width: parent.width
            height: parent.height / 150 * 50
            radius: parent.height / 150 * 15

            Text {
                text: qsTr("將此訊息加到記事本")
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
//c++ client 傳socket到server
                    client.button_AddMessageToNote_clicked(room_id, friend_id, friend_name, user_id, user_name, message)
                }
            }
        }


    }



}
