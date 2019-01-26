import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import com.company.client 1.0

Rectangle {
    id: recFriLis
    width: parent.width
    height: parent.height


    property int countInvite: 0
    property int countFriendList: 0

    function friendListInfo(friend_id, friend_name, friend_image){
        friendListModel.append({"friendID":friend_id, "friendName":friend_name, "friendImage":friend_image})
        console.log("append friend list " + friend_id + friend_name + friend_image)
//        textFriendID.text = friend_id
//        textFriendName.text = friend_name
//        imageFriend.source = friend_image
    }

    function friendListAddInfo(friend_add_id, friend_add_name, friend_add_image){
        friendListAddModel.append({"friendAddID":friend_add_id, "friendAddName":friend_add_name, "friendAddImage":friend_add_image})
        console.log("append friend add list " + friend_add_id + friend_add_name + friend_add_image)
//        textFriendAddID.text = friend_add_id
//        textFriendAddName.text = friend_add_name
//        imageFriendAdd.source = friend_add_image
    }

    function friendListClear(){
        friendListModel.clear()
        friendListAddModel.clear()
    }

    ListModel{
        id: friendListModel
    }

    ListModel{
        id: friendListAddModel
    }

    Component{
        id: friendListDelegate

        Rectangle {
            width: parent.width
            height: recFriLis.height / 550 * 50

            Rectangle {
                id: recFriendListImg
                x: parent.width / 320 * 10
                y: 0
                width: parent.width / 320 * 50
                height: parent.width / 320 * 50
                radius: parent.height / 50 * 15

                Image {
                    id: imageFriend
                    width: parent.width
                    height: parent.height
                    fillMode: Image.Stretch
                    //source: "Jelly.png"
                    source: friendImage
                }
            }

            Rectangle {
                width: parent.width - recFriendListImg.width
                height: parent.height
                anchors.left: recFriendListImg.right

                Text {
                    id: textFriendName
                    width: parent.width
                    height: parent.height
                    //text: qsTr("friend name :3")
                    text: friendName
                    verticalAlignment: Text.AlignVCenter
                    x: recFriLis.width / 320 * 20
                    y: 0
                    font.pointSize: 16
                }
            }

            Text {
                id: textFriendID
                //text: "friend id"
                text: qsTr(friendID)
                visible: false
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("click friend list")
                    console.log("friend id : " + textFriendID.text)

                    friendInfoMsgChat.getFriendInfo(textFriendID.text, textFriendName.text,imageFriend.source, userInformation.userInfoID)
                    friendInfoMsgChat.visible = true
                    friendInfoMsgChat.stopOtherActive()
                }
            }
        }
    }

    Component{
        id: friendListAddDelegate

        Rectangle {
            width: parent.width
            height: recFriLis.height / 550 * 50

            Rectangle {
                id: recFriendAddListImg
                x: parent.width / 320 * 10
                y: 0
                width: parent.width / 320 * 50
                height: parent.width / 320 * 50
                radius: parent.height / 50 * 15

                Image {
                    id: imageFriendAdd
                    width: parent.width
                    height: parent.height
                    fillMode: Image.Stretch
                    //source: "Jelly.png"
                    source: friendAddImage
                }
            }

            Rectangle {
                width: parent.width - recFriendAddListImg.width
                height: parent.height
                anchors.left: recFriendAddListImg.right

                Text {
                    id: textFriendAddName
                    //text: qsTr("friend add name :3")
                    text: friendAddName
                    width: parent.width
                    height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    x: recFriLis.width / 320 * 20
                    y: 0
                    font.pointSize: 16
                }
            }

            Text {
                id: textFriendAddID
                //text: "friend id"
                text: qsTr(friendAddID)
                visible: false
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("click friend add list")
                    console.log("friend id : " + textFriendAddID.text)

                    friendInfoMsgConfirm.getFriendInfo(textFriendAddID.text, textFriendAddName.text,imageFriendAdd.source, userInformation.userInfoID)
                    friendInfoMsgConfirm.visible = true
                    friendInfoMsgConfirm.stopOtherActive()
                }
            }
        }
    }

    ScrollView {
        id: scrollViewFriend
        x: 0
        y: parent.height / 550 * 95
        width: parent.width
        //height: parent.height - scrollViewFriend.y
        height: parent.height / 550 * 455
        clip: true


//        Rectangle{
//            id: recInvite
//            width: parent.width
//            height: listViewAddFriendList.contentHeight + 25

            Rectangle{
                id: labelInvite
                width: parent.width
                height: parent.height / 455 * 25

                Text{
                    //width: parent.width
                    height: parent.height
                    text: "邀請群組/申請好友"
                    //anchors.left: labelInvite.left
                    verticalAlignment: Text.AlignVCenter
                    x: parent.width / 320 * 10
                    y: 0
                    font.pointSize: 16
                }

                Rectangle {
                    width: parent.width / 320 * 25
                    height: parent.width / 320 * 25
                    anchors.right: labelInvite.right

                    Text {
                        width: parent.width
                        height: parent.height
                        text: qsTr("箭頭")
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            countInvite++;
                            if(countInvite % 2 == 1){
                                listViewAddFriendList.visible = false
                                recFriendList.anchors.top = labelInvite.bottom
                                //recFriendList.anchors.topMargin = 20
                            }
                            else{
                                listViewAddFriendList.visible = true
                                recFriendList.anchors.top = listViewAddFriendList.bottom
                            }
                        }
                    }
                }
            }

            ListView {
                id: listViewAddFriendList
                width: parent.width
                height: contentHeight
                anchors.top: labelInvite.bottom
                //clip: true
                model: friendListAddModel
                delegate: friendListAddDelegate
            }
        //}

        Rectangle{
            id: recFriendList
            width: parent.width
            anchors.top: listViewAddFriendList.bottom

            Rectangle{
                id: labelFriendList
                width: parent.width
                height: scrollViewFriend.height / 455 * 25

                Text{
                    text: "好友名單"
                    //anchors.left: labelFriendList.left
                    height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    x: parent.width / 320 * 10
                    y: 0
                    font.pointSize: 16
                }

                Rectangle {
                    width: parent.width / 320 * 25
                    height: parent.width / 320 * 25
                    anchors.right: labelFriendList.right

                    Text {
                        width: parent.width
                        height: parent.height
                        text: qsTr("箭頭")
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            countFriendList++;
                            if(countFriendList % 2 == 1)
                                listViewFriendList.visible = false
                            else
                                listViewFriendList.visible = true
                        }
                    }
                }
            }

            ListView {
                id: listViewFriendList
                width: parent.width
                height: contentHeight

                clip: true
                anchors.top: labelFriendList.bottom
                model: friendListModel
                delegate: friendListDelegate
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
