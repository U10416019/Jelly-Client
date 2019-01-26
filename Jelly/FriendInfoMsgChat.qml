import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import com.company.client 1.0

Rectangle {
    id: msgChat
    width: parent.width
    height: parent.height
    color: "#b3424242"


    property string friendID: ""
    property string friendName: ""
    property string friendImage: ""
    property string user_ID: ""
    property string room_id: ""

    function getFriendInfo(friend_id, friend_name, friend_image, user_id){
        friendID = friend_id
        friendName = friend_name
        friendImage = friend_image
        user_ID = user_id
        console.log("in get friend info chat")
        textFriendName.text = friendName
        imageFriend.source = friendImage

/*        if(friendImage == "qrc:/.......Jelly.png"){
            //pink
            recTitle.color = "#f966b0"
            recTitleBottom.color = "#f966b0"
        }
        else if(friendImage === "錯誤"){
            //red
            recTitle.color = "#f96666"
            recTitleBottom.color = "#f96666"
        }
        else if(msgTitle === "警告"){
            //orange
            recTitle.color = "#f9c066"
            recTitleBottom.color = "#f9c066"
        }
        else if(msgTitle === "通知"){
            //blue
            recTitle.color = "#57bfe7"
            recTitleBottom.color = "#57bfe7"
        }*/
    }

    function stopOtherActive(){
        login.enabled = false
        friendList.enabled = false
        roomList.enabled = false
        searchFriend.enabled = false
        sidePull.enabled = false
        userInformation.enabled = false
    }

    function startOtherActive(){
        login.enabled = true
        friendList.enabled = true
        roomList.enabled = true
        searchFriend.enabled = true
        sidePull.enabled = true
        userInformation.enabled = true
    }


    MouseArea{
        anchors.fill: parent
        onClicked: {
            msgChat.visible = false
            startOtherActive()
        }
    }

    Rectangle {
        id: rectangleBackground
//        x: 40
//        y: 100
//        width: 240
//        height: 350
        x: parent.width / 2 - rectangleBackground.width / 2
        y: parent.height / 550 * 100
        width: parent.width / 320 * 240
        height: parent.height / 550 * 350
        color: "#ffffff"
        radius: parent.height / 550 * 20

        MouseArea{
            anchors.fill: parent
            onClicked: {
                msgChat.visible = true
            }
        }

        Rectangle {
            id: recTitleBottom
//            x: 0
//            y: 40
//            width: 240
//            height: 35
            x: 0
            y: recTitle.height / 2
            width: parent.width
            height: recTitle.height / 2
            color: "#f966b0"
        }

        Rectangle {
            id: recTitle
            width: parent.width
            height: parent.height / 350 * 75
            //pink
            color: "#f966b0"
            //blue
            //color: "#57bfe7"
            //orange
            //color: "#f9c066"
            radius: parent.height / 350 * 20

            Text {
                id: textFriendName
                width: parent.width
                height: parent.height
                text: qsTr("～～朋友名～～")
                font.bold: true
                font.pointSize: 25
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "#ffffff"
            }
        }


/*        Rectangle {
            x: 120
            y: 295
            width: 120
            height: 35
            color: "#d9d8d8"
        }
        Rectangle {
            x: 120
            y: 330
            width: 60
            height: 20
            color: "#d9d8d8"
        }
        Rectangle {
            x: 0
            y: 295
            width: 120
            height: 35
            color: "#d9d8d8"
        }
        Rectangle {
            x: 60
            y: 330
            width: 60
            height: 20
            color: "#d9d8d8"
        }*/

        Rectangle{
            id: recButtonUp
            x: 0
            y: recChat.y
            width: recChat.width * 2
            height: recChat.height / 2
            color: "#d9d8d8"
        }

        Rectangle{
            id: recButtonMid
            x: recChat.width / 2
            y: recChat.y
            width: recChat.width
            height: recChat.height
            color: "#d9d8d8"
        }


        Rectangle {
            id: recChat
//            x: 120
//            y: 295
//            width: 120
//            height: 55
            x: parent.width / 2
            y: parent.height / 350 * 295
            width: parent.width / 2
            height: parent.height / 350 * 55
            color: "#d9d8d8"
            radius: parent.height / 350 * 20

            Text {
                width: parent.width
                height: parent.height
                color: "#0c0c0c"
                text: qsTr("聊天")
                font.pointSize: 18
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    msgChat.visible = false
                    startOtherActive()
                    client.button_FriendChat_clicked(friendName, friendID, userInformation.userInfoName, user_ID)
                    chatRoom.visible = true
                    userInformation.visible = false

                    chatRoom.getChatRoomInfo(friendID, friendName, friendImage, user_ID, userInformation.userInfoName)
                }
            }
        }

        Rectangle {
            id: recFriendInfo
//            x: 0
//            y: 295
//            width: 120
//            height: 55
            x: 0
            y: parent.height / 350 * 295
            width: parent.width / 2
            height: parent.height / 350 * 55
            color: "#d9d8d8"
            radius: parent.height / 350 * 20

            Text {
                width: parent.width
                height: parent.height
                color: "#0c0c0c"
                text: qsTr("朋友資訊")
                font.pointSize: 18
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    msgChat.visible = false
                    startOtherActive()
                }
            }
        }

        Rectangle {
//            x: 119
//            y: 295
//            width: 2
//            height: 55
            x: parent.width / 2 - parent.width / 240
            y: recChat.y
            width: parent.width / 240 * 2
            height: recChat.height
            color: "#949494"
        }

        Rectangle {
            id: recImageFriend
//            x: 50
//            y: 115
//            width: 140
//            height: 140
            x: parent.width / 2 - recImageFriend.width / 2
            y: (parent.height + recTitle.height - recChat.height) / 2 - recImageFriend.height / 2
            width: parent.width / 320 * 160
            height: parent.width / 320 * 160

            Image {
                id: imageFriend
                width: parent.width
                height: parent.height
                source: "Jelly.png"
            }
        }
    }


    ChatRoom{
        id: charRoom
        visible: false
    }
}
