import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import com.company.client 1.0

Rectangle {
    id: unreadMsgBox
    width: parent.width
    height: parent.height
    color: "#b3424242"


    property string friend_id: ""
    property string friend_name: ""
    property string friend_image: ""
    property string room_id: ""
    property var unreadInfoArray: []

    function getUnreadMsgBoxInfo(_friend_id, _friend_name, _friend_image, _room_id, _unreadInfoArray){
        friend_id = _friend_id
        friend_name = _friend_name
        friend_image = _friend_image
        room_id = _room_id
        unreadInfoArray = _unreadInfoArray
        stopOtherActive()
    }

    function cleanAllUnreadMsg(){
        var i = 0
        for(i = 0; i < unreadInfoArray.length; i++){
            mainPage.changeTypeOfMessage(unreadInfoArray[i].room_id)
        }
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
            unreadMsgBox.visible = false
            startOtherActive()
        }
    }


    ColumnLayout{
        width: parent.width - parent.width / 320 * 60 * 2
        height: parent.height - parent.height / 550 * 150 * 2
        x: parent.width / 320 * 60
        y: parent.height / 550 * 150
        spacing: 15

        Rectangle{
//            width: parent.width / 320 * 200
//            height: parent.height / 550 * 50
//            radius: parent.height / 550 * 15
            width: parent.width
            height: parent.height / 250 * 50
            radius: parent.height / 250 * 15

            Text {
                text: qsTr("進入聊天室")
                font.pointSize: 14
                width: parent.width
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    unreadMsgBox.visible = false
                    startOtherActive()

                    chatRoom.clearAllMessage()
                    client.button_FriendChat_clicked(friend_name, friend_id, userInformation.userInfoName, userInformation.userInfoID)
                    chatRoom.visible = true
                    userInformation.visible = false
                    chatRoom.getChatRoomInfo(friend_id, friend_name, friend_image, userInformation.userInfoID, userInformation.userInfoName)
                }
            }
        }

        Rectangle{
            width: parent.width
            height: parent.height / 250 * 50
            radius: parent.height / 250 * 15

            Text {
                text: qsTr("將此訊息標示為已讀")
                font.pointSize: 14
                width: parent.width
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    unreadMsgBox.visible = false
                    startOtherActive()

                    mainPage.changeTypeOfMessage(room_id)
                }
            }
        }

        Rectangle{
            width: parent.width
            height: parent.height / 250 * 50
            radius: parent.height / 250 * 15

            Text {
                text: qsTr("將所有聊天室訊息標示為已讀")
                font.pointSize: 14
                width: parent.width
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    unreadMsgBox.visible = false
                    startOtherActive()

                    cleanAllUnreadMsg()
                }
            }
        }
    }





}
