import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3

Rectangle{
    anchors.right: parent.right
//    width: 157
//    height: 550
    width: parent.width / 2
    height: parent.height
    color: "#00ffffff"


/*    function stopOtherActive(){
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
            recSidePull.visible = false
            recSidePullRight.visible = true
            recSidePullLeft.visible = false
        }
    }*/

    Rectangle {
        id: recSidePullRight
//        x: 130
//        y: 27
        x: parent.width - recSidePullRight.width
        y: recSidePullRight.width
//        width: 27
//        height: 36
        width: parent.width * 0.16875
        height: recSidePullRight.width * 1.4
        color: "#948686"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("側拉右")
                recSidePull.visible = true
                recSidePullRight.visible = false
                recSidePullLeft.visible = true
                //mainFriendRecBackground.color = "#ff2929"
            }
        }
    }

    Rectangle {
        id: recSidePullLeft
//        x: 0
//        y: 27
        x: 0
        y: recSidePullRight.y
//        width: 27
//        height: 36
        width: recSidePullRight.width
        height: recSidePullRight.height
        color: "#948686"
        visible: false

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("側拉左")
                recSidePull.visible = false
                recSidePullRight.visible = true
                recSidePullLeft.visible = false
                //mainFriendRecBackground.color = "#ff2929"
            }
        }
    }

    Rectangle {
        id: recSidePull
//        x: 27
//        y: 0
//        width: 130
//        height: 550
        x: parent.width - recSidePull.width
        y: 0
        width: parent.width - recSidePullRight.width
        height: parent.height
        color: "#cc5a4f67"
        visible: false

        Text {
            id: text3
//            x: 8
//            y: 45
//            width: 114
//            height: 453
            x: parent.width / 130 * 8
            y: parent.height / 550 * 45
            width: parent.width / 130 * 114
            height: parent.height / 550453
            color: "#ffffff"
            text: qsTr("\n\n\n\n\n\n\n\n\n待辦事項\n記事本\n\n\n\n個人檔案\n登出")
            //font.bold: true
            lineHeight: 1.5
            font.family: "Times New Roman"
            font.pointSize: 16
        }

        Rectangle {
            id: recSidePullRoomList
//            x: 0
//            y: 42
//            width: 130
//            height: 30
            x: 0
            y: parent.height / 550 * 42
            width: recSidePull.width
            height: parent.height / 550 * 30
            color: "#00ffffff"
            //opacity: 0.0

            Text {
//                x:8
                x:parent.width / 130 * 8
                height: parent.height
                text: qsTr("聊天室")
                verticalAlignment: Text.AlignVCenter
                color: "#ffffff"
                //lineHeight: 1.5
                font.family: "Times New Roman"
                font.pointSize: 16
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("聊天室")
                    roomList.roomListClear()
                    client.loadRoom(userInformation.userInfoID)
                    roomList.visible = true
                    friendList.visible = false
                    searchFriend.visible = false
                    chatRoom.visible = false
                    chatRoom.clearAllMessage()
                    recSidePull.visible = false
                    recSidePullRight.visible = true
                    recSidePullLeft.visible = false
                    userInformation.visible = true
                    bell.visible = true
                    note.visible = false
                }
            }
        }

        Rectangle {
            id: recSidePullFriendList
//            x: 0
//            y: 72
//            width: 130
//            height: 30
            x: 0
            width: parent.width
            height: parent.height / 550 * 30
            anchors.top: recSidePullRoomList.bottom
            color: "#00ffffff"
            //opacity: 0.0

            Text {
//                x:8
                x:parent.width / 130 * 8
                height: parent.height
                text: qsTr("朋友/群組列表")
                verticalAlignment: Text.AlignVCenter
                color: "#ffffff"
                //lineHeight: 1.5
                font.family: "Times New Roman"
                font.pointSize: 16
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("朋友/群組列表")
                    roomList.visible = false
                    friendList.visible = true
                    friendList.friendListClear()
                    client.refreshFriendList()
                    searchFriend.visible = false
                    chatRoom.visible = false
                    chatRoom.clearAllMessage()
                    //chatRoom.deleteLater()
                    recSidePull.visible = false
                    recSidePullRight.visible = true
                    recSidePullLeft.visible = false
                    userInformation.visible = true
                    bell.visible = true
                    note.visible = false
                }
            }
        }

        Rectangle {
            id: recSidePullSearchFriend
//            x: 0
//            y: 102
//            width: 130
//            height: 30
            x: 0
            width: parent.width
            height: parent.height / 550 * 30
            anchors.top: recSidePullFriendList.bottom
            color: "#00ffffff"
            //opacity: 0.0

            Text {
                x: parent.width / 130 * 8
                height: parent.height
                text: qsTr("搜尋好友")
                verticalAlignment: Text.AlignVCenter
                color: "#ffffff"
                //lineHeight: 1.5
                font.family: "Times New Roman"
                font.pointSize: 16
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("搜尋好友")
                    roomList.visible = false
                    friendList.visible = false
                    searchFriend.cleanSearchFriendName()
                    searchFriend.visible = true
                    chatRoom.visible = false
                    chatRoom.clearAllMessage()
                    recSidePull.visible = false
                    recSidePullRight.visible = true
                    recSidePullLeft.visible = false
                    userInformation.visible = true
                    bell.visible = true
                    note.visible = false
                }
            }
        }

        Rectangle {
            id: recSidePullCreateGroup
//            x: 0
//            y: 132
//            width: 130
//            height: 30
            x: 0
            width: parent.width
            height: parent.height / 550 * 30
            anchors.top: recSidePullSearchFriend.bottom
            color: "#00ffffff"
            //opacity: 0.0

            Text {
                x: parent.width / 130 * 8
                height: parent.height
                text: qsTr("建群組")
                verticalAlignment: Text.AlignVCenter
                color: "#ffffff"
                //lineHeight: 1.5
                font.family: "Times New Roman"
                font.pointSize: 16
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("建群組")
                }
            }
        }

        Rectangle {
            id: recSidePullMain
//            x: 0
//            y: 162
//            width: 130
//            height: 30
            x: 0
            width: parent.width
            height: parent.height / 550 * 30
            anchors.top: recSidePullCreateGroup.bottom
            color: "#00ffffff"
            //opacity: 0.0

            Text {
                x: parent.width / 130 * 8
                height: parent.height
                text: qsTr("主頁")
                verticalAlignment: Text.AlignVCenter
                color: "#ffffff"
                //lineHeight: 1.5
                font.family: "Times New Roman"
                font.pointSize: 16
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("主頁")
                    mainPage.unreadMessageClear()

                    roomList.visible = false
                    friendList.visible = false
                    searchFriend.visible = false
                    chatRoom.visible = false
                    chatRoom.clearAllMessage()
                    recSidePull.visible = false
                    recSidePullRight.visible = true
                    recSidePullLeft.visible = false
                    userInformation.visible = true
                    bell.visible = true
                    note.visible = false

                    //client.getQueueMessage()
                }
            }
        }

    }
}
