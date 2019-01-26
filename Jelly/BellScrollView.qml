import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3

Rectangle {
    id: bellSV
    width: parent.width
    height: parent.height
    color: "#ccffffff"

    property var bellMessage: []



    function insertBellMessage(_sender_image, _sender_id, _sender, _room_id, _message, _send_time, _type){
        console.log("in bellScrollView insertBellMsg=>  sender_image: " + _sender_image + "  sender_id: " + _sender_id + "  sender: " + _sender + "  room_id: " + _room_id + "  message: " + _message + "  send_time: " + _send_time + "  type: " + _type)
        bellMessage.push({sender: _sender, sender_id: _sender_id, sender_image: _sender_image, room_id: _room_id, message: _message, send_time: _send_time, type: _type})
    }

    function appendBellListView(_friend_image, _friend_id, _friend_name, _friend_message, _room_id, _send_time, _type){
        console.log("in bellScrollView appendBellListView")
        console.log("in appendBellListView=>  friend_image: " + _friend_image + "  friend_id: " + _friend_id + "  friend_name: " + _friend_name + "  friend_message: " + _friend_message + "  room_id: " + _room_id + "  send_time: " + _send_time + "  type: " + _type)
        bellModel.append({"friend_image":_friend_image, "friend_id":_friend_id, "friend_name":_friend_name, "friend_message":_friend_message, "room_id":_room_id, "send_time":_send_time, "type":_type})
    }

    function refreshBellListView(_room_id){
        console.log("in bellScrollView refreshBellListView")
        bellModel.clear()

        var i = 0
        for(i = 0; i < bellMessage.length; i++){
            if(bellMessage[i].room_id == _room_id){
                bellMessage.splice(i, 1)
            }
        }

        for(i = 0; i < bellMessage.length; i++){
            appendBellListView(bellMessage[i].sender_image, bellMessage[i].sender_id, bellMessage[i].sender, bellMessage[i].message, bellMessage[i].room_id, bellMessage[i].send_time, bellMessage[i].type)
        }
    }




    ListModel{
        id: bellModel
    }

    Component{
        id: bellDelegate

        Rectangle{
            id: recAll
            width: parent.width
            height: recBellFriendMsg.height + textBellFriendName.height + bellSV.height / 550 * 20
            color: "#ccffffff"
            border.color: "#d3c3c3"
            border.width: 1.5

            Rectangle{
                id: recBellFriendImage
                x: bellSV.width / 320 * 10
                y: bellSV.width / 320 * 10
                width: bellSV.width / 320 * 30
                height: bellSV.width / 320 * 30
                color: "#e0dfdf"
                radius: bellSV.height / 550 * 20

                Image {
                    id: bellFriendImage
                    width: parent.width
                    height: parent.height
                    source: friend_image
                }
            }


            Text {
                id: textBellFriendName
                width: contentWidth
                height: contentHeight
                x: recBellFriendImage.x + recBellFriendImage.width + bellSV.width / 320 * 10
                y: bellSV.width / 320 * 10
                //y: 20
                text: friend_name
                font.pointSize: 8
            }

            Rectangle{
                id: recBellFriendMsg
                width: parent.width - recBellFriendImage.width - bellSV.width / 320 * 30
                height: textBellFriendMsg.height + bellSV.height / 550 * 10
                x: recBellFriendImage.x + recBellFriendImage.width + bellSV.width / 320 * 10
                y: textBellFriendName.height + bellSV.height / 550 * 2 + recBellFriendImage.y
                color: "#ffefef"
                radius: bellSV.height / 550 * 15

                state: textGetFriendMessageWidth.width >= parent.width - recBellFriendImage.width - bellSV.width / 320 * 30 ? (recBellFriendMsg.width = parent.width - recBellFriendImage.width - bellSV.width / 320 * 30) : (recBellFriendMsg.width = textGetFriendMessageWidth.width + bellSV.width / 320 * 10)


                Text {
                    id: textBellFriendMsg
                    height: contentHeight
                    width: parent.width - (textBellFriendMsg.x * 2)
                    x: bellSV.width / 320 * 5
                    y: bellSV.width / 320 * 5
                    text: friend_message
                    font.pointSize: 12
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WordWrap
                    lineHeight: 1.5
                    //horizontalAlignment: Text.AlignRight
                }
            }

/*            Text {
                id: textBellFriendSendTime
                width: contentWidth
                height: contentHeight
                x: recBellFriendMsg.x + recBellFriendMsg.width + 5
                y: recBellFriendMsg.height + textBellFriendName.height - textBellFriendSendTime.height
                text: send_time
                font.pixelSize: 8
            }*/

            Text {
                id: textGetFriendMessageWidth
                height: contentHeight
                width: contentWidth
                text: friend_message
                font.pointSize: 12
                verticalAlignment: Text.AlignVCenter
                visible: false
            }

            Text {
                id: textBellFriendID
                text: friend_id
                visible: false
            }

            Text {
                id: textBellFriendImage
                text: friend_image
                visible: false
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    bellScrollView.visible = false
                    refreshBellListView(room_id)

                    chatRoom.clearAllMessage()
                    console.log("in bell delegate mousearea onclicked button_FriendChat_clicked=>  friend_name: " + textBellFriendName.text + "  friend_id: " + textBellFriendID.text + "  user_name: " + userInformation.userInfoName + "  user_id: " + userInformation.userInfoID)
                    client.button_FriendChat_clicked(textBellFriendName.text, textBellFriendID.text, userInformation.userInfoName, userInformation.userInfoID)
                    chatRoom.visible = true
                    userInformation.visible = false
                    console.log("in bell delegate mousearea onclicked getChatRoomInfo=>  friend_id: " + friend_id + "  friend_name: " +  friend_name + "  friend image: " + friend_image + "  user_id: " + userInformation.userInfoID + "  user_name: " + userInformation.userInfoName)
                    chatRoom.getChatRoomInfo(textBellFriendID.text, textBellFriendName.text, textBellFriendImage.text, userInformation.userInfoID, userInformation.userInfoName)
                }
            }
        }
    }






    ScrollView{
        id: bellScrollV
        width: bellSV.width
        height: bellSV.height
        clip: true
        x: 0
        y: 0

        Rectangle{
            id:recTemp
            visible: false
        }

        ListView{
            id: bellListView
            width: parent.width
            height: contentHeight
            anchors.top: recTemp.top

            model: bellModel
            delegate: bellDelegate
        }

        Rectangle{
            id: recCloseBellScrollView
            width: bellSV.width
            height: bellSV.height / 550 * 20
            color: "#c27cfa"
            anchors.top: bellListView.bottom
            //anchors.topMargin: 0

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    bellSV.visible = false
                }
            }
        }

    }







}
