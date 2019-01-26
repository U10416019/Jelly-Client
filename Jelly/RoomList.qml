import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import com.company.client 1.0

Rectangle {
    id: recRoomList
    width: parent.width
    height: parent.height

    property int i: 0
    property var roomListInfo: []
    property string tempSendTime: ""
    property string tempSendTime2: ""

    function loadRoomListInfo(room_id, last_sender_id, last_sender_name, room_name, room_image, lastMessage, lastSendTime, lastTimeFormat, lastType, unread_count, friend_id, friend_name){
        roomListInfo.push({room_id: room_id, last_sender_id: last_sender_id, last_sender_name: last_sender_name, room_name: room_name, room_image: room_image, lastMessage: lastMessage, lastSendTime: lastSendTime, lastTimeFormat:lastTimeFormat, lastType: lastType, unread_count: unread_count, friend_id: friend_id, friend_name: friend_name})
         tempSendTime = lastSendTime
        for(i = 0; i < roomListInfo.length; i++){
            tempSendTime2 = roomListInfo[i].lastSendTime
            if(tempSendTime > tempSendTime2){
                roomListInfo.splice(i, 0, roomListInfo[roomListInfo.length - 1])
                roomListInfo.splice(roomListInfo.length - 1, 1)
            }
        }

        roomListModel.clear()
        for(i = 0; i < roomListInfo.length; i++){
            console.log("in loadRoomListInfo=>  room_id: " + roomListInfo[i].room_id + "  last_sender_id: " + roomListInfo[i].last_sender_id + "  last_sender_name: " + roomListInfo[i].last_sender_name + "  room_name: " + roomListInfo[i].room_name + "  room_image: " + roomListInfo[i].room_image + "  lastMessage: " + roomListInfo[i].lastMessage + "  lastSendTime: " + roomListInfo[i].lastSendTime + "  lastTimeFormat: " + roomListInfo[i].lastTimeFormat + "  lastType: " + roomListInfo[i].lastType + "  unread_count: " + roomListInfo[i].unread_count)
            appendRoomList(roomListInfo[i].room_id, roomListInfo[i].last_sender_id, roomListInfo[i].last_sender_name, roomListInfo[i].room_name, roomListInfo[i].room_image, roomListInfo[i].lastMessage, roomListInfo[i].lastSendTime, roomListInfo[i].lastTimeFormat, roomListInfo[i].lastType, roomListInfo[i].unread_count, roomListInfo[i].friend_id, roomListInfo[i].friend_name)
        }
    }


    function appendRoomList(_room_id, _last_sender_id, _last_sender_name, _room_name, _room_image, _lastMessage, _lastSendTime, _lastTimeFormat, _lastType, _unread_count, _friend_id, _friend_name){
        console.log("append room list " + _room_id + _last_sender_id + _last_sender_name + _room_name + _room_image + _lastMessage + _lastSendTime + _lastTimeFormat + _lastType + _unread_count + _friend_id + _friend_name)
        if(_lastType == 1){
            _lastMessage = _friend_name + "向您傳送了一個檔案"
        }
        else if(_lastType == 2){
            _lastMessage = _friend_name + "向您傳送了一張圖片"
        }

        if(_room_name != ""){
            roomListModel.append({"room_id":_room_id, "room_name":_room_name, "room_image":_room_image, "friend_id":_friend_id, "friend_name":_friend_name, "last_sender_id:":_last_sender_id, "last_sender_name":_last_sender_name, "last_message":_lastMessage, "last_time_format":_lastTimeFormat, "unread_count":_unread_count})
        }
    }

    function roomListClear(){
        roomListModel.clear()
        roomListInfo.splice(0, roomListInfo.length)
    }

    ListModel{
        id: roomListModel
    }

    Component{
        id: roomListDelegate

        Rectangle{
            width: recRoomList.width
            height: recRoomList.height / 550 * 50
            color: "#ffffff"

            state: textUnreadCount.text == "0" ? recRoomListUnreadNumber.visible = false : recRoomListUnreadNumber.visible = true

            Rectangle {
                id: recRoomListImg
                x: parent.width / 320 * 10
                y: 0
                width: parent.width / 320 * 50
                height: parent.width / 320 * 50
                //color: "#e0dfdf"
                radius: parent.height / 50 * 15
                //visible: false
                //anchors.left: parent.left

                Image {
                    id: roomImage
                    x: 0
                    y: 0
                    width: parent.width
                    height: parent.height
                    scale: 1
                    sourceSize.width: 0
                    fillMode: Image.Stretch
                    source: room_image
                }
            }

            Rectangle{
                id: recRoomListName
                width: parent.width / 320 * 200
                height: parent.height / 50 * 15
                anchors.left: recRoomListImg.right
                anchors.top: parent.top

                Text {
                    id: textRoomName
                    width: parent.width
                    height: parent.height
                    x: parent.width / 200 * 10
                    text: room_name
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 12
                }
            }

            Rectangle{
                id: recRoomListTime
                width: parent.width / 320 * 60
                height: parent.height / 50 * 15
                anchors.left: recRoomListName.right
                anchors.top: parent.top

                Text {
                    width: parent.width
                    height: parent.height
                    text: last_time_format
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 12
                }
            }

            Rectangle{
                id: recRoomListMsg
                width: parent.width / 320 * 200
                height: parent.height / 50 * 35
                anchors.left: recRoomListImg.right
                anchors.top: recRoomListName.bottom

                Text {
                    width: parent.width
                    height: parent.height
                    x: parent.width / 200 * 10
                    text: last_message
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 14
                    wrapMode: Text.NoWrap
                }
            }

            Rectangle{
                id: recRoomListUnreadNumber
                width: parent.width / 320 * 60
                height: parent.height / 50 * 35
                anchors.left: recRoomListMsg.right
                anchors.top: recRoomListTime.bottom

                Rectangle{

                    width: parent.width / 60 * 17
                    height: parent.width / 60 * 17
                    x: parent.width - parent.width / 60 * 30
                    y: parent.height - parent.width / 60 * 30
                    //anchors.right: parent.right
                    //anchors.top: recRoomListTime.bottom
                    radius: parent.width / 60 * 100
                    color: "#ff2929"

                    Text {
                        id: textUnreadCount
                        text: unread_count
                        width: parent.width
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pointSize: 14
                    }
                }
            }

            Text {
                id: textFriendName
                text: friend_name
                visible: false
            }

            Text {
                id: textFriendID
                text: friend_id
                visible: false
            }

            Text {
                id: textFriendImage
                text: room_image
                visible: false
            }


//            Text {
//                //id: text1
//                x: 10
//                //y: 20
//                text: qsTr("~~ unread message ~~")
//                font.pixelSize: 12
//            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("聊天室名單成員")
                    //mainFriendRecBackground.color = "#ff2929"
                    roomList.visible = false
                    chatRoom.clearAllMessage()
                    client.button_FriendChat_clicked(textFriendName.text, textFriendID.text, userInformation.userInfoName, userInformation.userInfoID)
                    chatRoom.visible = true
                    userInformation.visible = false
                    chatRoom.getChatRoomInfo(textFriendID.text, textFriendName.text, textFriendImage.text, userInformation.userInfoID, userInformation.userInfoName)
                }
            }
        }
    }









    ScrollView{
        //id: mainMessageScrollView
//        x: 0
//        y: 95
//        width: 320
//        height: 455
        x: 0
        y: parent.height / 550 * 95
        width: parent.width
        height: parent.height / 550 * 455
        //opacity: 1
        clip: true
        //ScrollBar.vertical.policy: ScrollBar.AlwaysOn

        ListView {
            //id: listView
            x: 0
            y: 0
            //width: parent.width
            //height: contentItem
            orientation: ListView.Vertical
            //            anchors.fill: parent
            //clip: true
            //focus: true

            model: roomListModel
            delegate: roomListDelegate

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
