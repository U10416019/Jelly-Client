import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import com.company.client 1.0
//import QtQuick.VirtualKeyboard 2.3

Rectangle {
    id: chatR
    width: parent.width
    height: parent.height

    property string friendID: ""
    property string friendName: ""
    property string friendImage: ""
    property string message: ""
    property string sender: ""
    property string roomID: ""
    property string userID: ""
    property string userName: ""
    property int xMsg: 0
    property int yMsg: 0
    property int xFriendMsg: 0
    property int yFriendMsg: 0
    property int count: 0

    function getChatRoomInfo(friend_id, friend_name, friend_image, user_id, user_name){
        friendID = friend_id
        friendName = friend_name
        friendImage = friend_image
        userID = user_id
        userName = user_name
        console.log("in get chat room info")

        textFriendName.text = friendName
    }

    function getChatRoomID(room_id){
        roomID = room_id
        console.log("room id: " + roomID);
    }

    function appendChatRoomMessage(_friend_image, _friend_id, _friend_name, _friend_message, _send_time, _read_type, _user_message, _type){
        chatRoomMsgModel.append({"friend_image":_friend_image, "friend_id":_friend_id, "friend_name":_friend_name, "friend_message":_friend_message, "send_time":_send_time, "read_type":_read_type, "user_message":_user_message, "type":_type})
        console.log("in appendChartRoomMessage")
    }

//    function messageSize(msg_width){
//        if(msg_width > 250){
//            label_message.width = 250
//            label_message.height = label_message.contentHeight
//        }
//    }

/*    function chatRecordUserAppend(_userMessage, _userSender){
        //listViewRoom.delegate = roomDelegate
        roomModel.append({"userMessage":_userMessage, "userSender":_userSender})
        //label_message.text = _userMessage
        //???  listViewRoom.delegate = roomDelegate
        recRoomMsg.anchors.right = scrollViewRoom.right
        roomMsgImage.visible = false
    }*/

/*    function getMsgXY(_xMsg, _yMsg){
        console.log("xMsg : " + xMsg + "yMsg : " + yMsg)
        if(count == 0){
            xMsg = 320 - _xMsg
            yMsg = 0
        }
        else{
            xMsg = 320 - _xMsg
            yMsg += _yMsg + 10
        }
        count++

        if(yMsg >= 420){
            recChat.height = recChat.height + _yMsg + 10
            //scrollViewRoom.flickableItem.contentY =  recChat.height - scrollViewRoom.height//flickableItem.contentHeight - height// - scrollViewRoom.height
            //recChat.y = scrollViewRoom.height - recChat.height
        }
    }

    function getFriendMsgXY(_xFriendMsg, _yFriendMsg){
        console.log("xFriendMsg : " + _xFriendMsg + "yFriendMsg : " + _yFriendMsg)
        if(count == 0){
            xFriendMsg = 0
            yFriendMsg = 0
        }
        else{
            xFriendMsg = 0
            yMsg += _yFriendMsg +  + 10
        }
        count++

        if(yMsg >= 420){
            recChat.height = recChat.height + _yFriendMsg + 10
            console.log("in getFriendMsaXY: " + recChat.height)
        }
    }

    function newUserMessage(){
        //在rectangle裡新增rectangle
        var newUserRec = Qt.createQmlObject('import QtQuick 2.9;
            Rectangle {color: "white";
                //Text{id: recUserMsg; text: textFieldMessage.text; width: contentWidth; height: contentHeight;}
                //textUserMsg.width: recUserMsg.width;
                //textUserMsg.height: recUserMsg.height;

                MouseArea{anchors.fill: parent;
                    onClicked: {console.log("clicked recUser : " + recUserMsg.text)}
                }
                //client.roomMsgXY(recUserMsg.width, recUserMsg.height);

            }', recChat);

        var newUserMsg = Qt.createQmlObject('import QtQuick 2.9;
                Text{//id: recUserMsg; text: textUserMsg.text; width: contentWidth; height: contentHeight;

                //client.roomMsgXY(recUserMsg.width, recUserMsg.height);

            }', newUserRec);

        getMsgXY(textUserMsg.width, textUserMsg.height)
        newUserMsg.text = textUserMsg.text
        newUserMsg.width = textUserMsg.width
        newUserMsg.height = textUserMsg.height
        newUserRec.width = textUserMsg.width
        newUserRec.height = textUserMsg.height
        newUserRec.x = xMsg
        newUserRec.y = yMsg
    }

    function loadUserMessage(userMessage){
        message = userMessage
        //在rectangle裡新增rectangle
        var loadUserRec = Qt.createQmlObject('import QtQuick 2.9;
            Rectangle {color: "white";
                MouseArea{anchors.fill: parent;
                    onClicked: {console.log("clicked recUser : " + recUserMsg.text)}
                }
            }', recChat);

        var loadUserMsg = Qt.createQmlObject('import QtQuick 2.9;
                Text{text:message;
            }', loadUserRec);

        getMsgXY(textLoadUserMsg.width, textLoadUserMsg.height)
        loadUserMsg.text = textLoadUserMsg.text
        loadUserMsg.width = textLoadUserMsg.width
        loadUserMsg.height = textLoadUserMsg.height
        loadUserRec.width = textLoadUserMsg.width
        loadUserRec.height = textLoadUserMsg.height
        loadUserRec.x = xMsg
        loadUserRec.y = yMsg
    }

    function loadFriendMessage(friendMessage){
        mainPage.changeTypeOfMessage(roomID)
        message = friendMessage
        //在rectangle裡新增rectangle
        var loadFriendRec = Qt.createQmlObject('import QtQuick 2.9;
            Rectangle {color: "white";
                MouseArea{anchors.fill: parent;
                    onClicked: {console.log("clicked recUser : " + recUserMsg.text)}
                }
            }', recChat);

        var loadFriendMsg = Qt.createQmlObject('import QtQuick 2.9;
                Text{text:message;
            }', loadFriendRec);

        getFriendMsgXY(textLoadUserMsg.width, textLoadUserMsg.height)
        loadFriendMsg.text = textLoadUserMsg.text
        loadFriendMsg.width = textLoadUserMsg.width
        loadFriendMsg.height = textLoadUserMsg.height
        loadFriendRec.width = textLoadUserMsg.width
        loadFriendRec.height = textLoadUserMsg.height
        loadFriendRec.x = xFriendMsg
        loadFriendRec.y = yMsg
    }*/






    function newUserMessage(_friend_image, _friend_id, _friend_name, _friend_message, _send_time, _read_type, _user_message, _type){
        console.log("in newUserMessage=>  friend_image: " + _friend_image + "  friend_id: " + _friend_id + "  friend_name: " + _friend_name + "  friend_message: " + _friend_message + "  send_time: " + _send_time + "  read_type: " + _read_type + "  user_message: " + _user_message + "  type: " + _type)
        appendChatRoomMessage(_friend_image, _friend_id, _friend_name, _friend_message, _send_time, _read_type, _user_message, _type)
        chatRoomMsgListView.positionViewAtEnd()
        //chatRoomMsgModel.clear()
        //client.loadRoomMessage(roomID, userID)
    }

    function loadUserMessage(_friend_image, _friend_id, _friend_name, _friend_message, _send_time, _read_type, _user_message, _type){
        console.log("in loadUserMessage=>  friend_image: " + _friend_image + "  friend_id: " + _friend_id + "  friend_name: " + _friend_name + "  friend_message: " + _friend_message + "  send_time: " + _send_time + "  read_type: " + _read_type + "  user_message: " + _user_message + "  type: " + _type)
        appendChatRoomMessage(_friend_image, _friend_id, _friend_name, _friend_message, _send_time, _read_type, _user_message, _type)
        chatRoomMsgListView.positionViewAtEnd()
    }

    function loadFriendMessage(_friend_image, _friend_id, _friend_name, _friend_message, _send_time, _read_type, _user_message, _type, _room_id){
        if(roomID == _room_id){
            mainPage.changeTypeOfMessage(roomID)
            console.log("in loadFriendMessage=>  friend_image: " + _friend_image + "  friend_id: " + _friend_id + "  friend_name: " + _friend_name + "  friend_message: " + _friend_message + "  send_time: " + _send_time + "  read_type: " + _read_type + "  user_message: " + _user_message + "  type: " + _type)
            appendChatRoomMessage(_friend_image, _friend_id, _friend_name, _friend_message, _send_time, _read_type, _user_message, _type)
            chatRoomMsgListView.positionViewAtEnd()
        }
    }

    function clearAllMessage(){
//        xMsg = 0
//        yMsg = 0
//        xFriendMsg = 0
//        yFriendMsg = 0
//        count = 0


        roomID = ""
        chatRoomMsgModel.clear()

        //recChat.children.destroy()
        //delete recChat.children
        //destroyed(recChat)

//        recChat = test
//        recChat.visible = true
    }

    function clearModel(){
        chatRoomMsgModel.clear()
    }
    function reloadMsg(){
        client.loadRoomMessage(roomID, userID);
    }

//    Rectangle{
//        id: test
//        width: 320
//        height: 420
//        clip: true
//        color: "#ffe4f2"
//        visible: false
//    }

    ListModel{
        id: chatRoomMsgModel
    }

    Component{
        id: chatRoomMsgDelegate

        Rectangle{
            id: recDelegate
            width: parent.width
            height: recChatRoomFriendMsg.height + textChatRoomFriendName.height
            //color: "#ffefef"
            //border.color: "#d3c3c3"
            //border.width: 1.5
//ListView: spacing: 5

//            state: friend_message == "" ? (recChatRoomFriendMsg.width = parent.width - 75,
//                                           textGetFriendMessageWidth.width >= parent.width - recChatRoomFriendImage.width - 50 ? (recChatRoomFriendMsg.width = parent.width - recChatRoomFriendImage.width - 50) : (recChatRoomFriendMsg.width = textGetFriendMessageWidth.width + 10),
//                                           recChatRoomFriendMsg.x = parent.width - textChatRoomFriendMsg.width - 30,
//                                           recChatRoomFriendImage.visible = false,
//                                           textChatRoomFriendName.visible = false,
//                                           textChatRoomFriendSendTime.x = parent.width - recChatRoomFriendMsg.x - textChatRoomFriendSendTime.width - 10,
//                                           textMsgReadType.x = parent.width - recChatRoomFriendMsg.x - textMsgReadType.width - 10,
//                                           textChatRoomFriendMsg.text = user_message) : (recChatRoomFriendMsg.x = recChatRoomFriendImage.width + 10,
//                                                                                   textMsgReadType.visible = false,
//                                                                                   textChatRoomFriendMsg.text = friend_message)


            state: (friend_message == "") ? (recDelegate.height = recChatRoomUserMsg.height,
                                           recChatRoomFriendImage.visible = false,
                                           textChatRoomFriendName.visible = false,
                                           recChatRoomFriendMsg.visible = false,
                                           textChatRoomFriendSendTime.visible = false) : (recChatRoomUserMsg.visible = false,
                                                                                          textMsgReadType.visible = false,
                                                                                          textChatRoomUserSendTime.visible = false)


            Rectangle{
                id: recChatRoomFriendImage
//                x: 10
//                width: 30
//                height: 30
                x: parent.width / 320 * 10
                width: parent.width / 320 * 30
                height: parent.width / 320 * 30
                color: "#e0dfdf"
                radius: parent.width / 320 * 20

                Image {
                    id: chatRoomFriendImage
                    width: parent.width
                    height: parent.height
                    source: friend_image
                }
            }


            Text {
                id: textChatRoomFriendName
                width: contentWidth
                height: contentHeight
                x: recChatRoomFriendImage.width + parent.width / 320 * 10
                //y: 20
                text: friend_name
                font.pointSize: 10
            }

            Rectangle{
                //id: recChatRoomFriendMsg
                id: recChatRoomFriendMsg
                width: parent.width - recChatRoomFriendImage.width - 50
                height: textChatRoomFriendMsg.height + parent.width / 320 * 10
                x: recChatRoomFriendImage.width + parent.width / 320 * 10
                y: textChatRoomFriendName.height + parent.width / 320 * 2
                color: "#ffefef"
                radius: parent.width / 320 * 15

                state: textGetFriendMessageWidth.width >= parent.width - recChatRoomFriendImage.width - parent.width / 320 * 50 ? (recChatRoomFriendMsg.width = parent.width - recChatRoomFriendImage.width - parent.width / 320 * 50) : (recChatRoomFriendMsg.width = textGetFriendMessageWidth.width + parent.width / 320 * 10)


                Text {
                    id: textChatRoomFriendMsg
                    height: contentHeight
                    width: parent.width - (textChatRoomFriendMsg.x * 2)
                    x: chatR.width / 320 * 5
                    y: chatR.width / 320 * 5
                    text: friend_message
                    font.pointSize: 14
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WordWrap
                    lineHeight: 1.5
                    //horizontalAlignment: Text.AlignRight
                }

                MouseArea {
                    anchors.fill: parent

                    onPressAndHold: {
                        console.log("press friend message")
                        chatRoomMsgInfo.visible = true
                        chatRoomMsgInfo.getChatRoomMsgInfo(friendID, friendName, roomID, userID, userName, friend_message)
                    }
                }
            }

            Text {
                id: textChatRoomFriendSendTime
                width: contentWidth
                height: contentHeight
                x: recChatRoomFriendMsg.x + recChatRoomFriendMsg.width + parent.width / 320 * 5
                y: recChatRoomFriendMsg.height + textChatRoomFriendName.height - textChatRoomFriendSendTime.height
                text: send_time
                font.pointSize: 10
            }

            Text {
                id: textGetFriendMessageWidth
                height: contentHeight
                width: contentWidth
                text: friend_message
                font.pointSize: 14
                verticalAlignment: Text.AlignVCenter
                visible: false
            }








            Rectangle{
                id: recChatRoomUserMsg
                width: parent.width - parent.width / 320 * 75
                height: textChatRoomUserMsg.height + parent.width / 320 * 10
                x: parent.width - recChatRoomUserMsg.width - parent.width / 320 * 10
                color: "#ffefef"
                radius: parent.width / 320 * 15

                state: textGetUserMessageWidth.width >= parent.width - parent.width / 320 * 75 ? (recChatRoomUserMsg.width = parent.width - parent.width / 320 * 75) : (recChatRoomUserMsg.width = textGetUserMessageWidth.width + parent.width / 320 * 10)


                Text {
                    id: textChatRoomUserMsg
                    height: contentHeight
                    width: parent.width - (textChatRoomUserMsg.x * 2)
                    x: chatR.width / 320 * 5
                    y: chatR.width / 320 * 5
                    text: user_message
                    font.pointSize: 14
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WordWrap
                    lineHeight: 1.5
                }

                MouseArea {
                    anchors.fill: parent

                    onPressAndHold: {
                        console.log("press user message")
                        chatRoomMsgInfo.visible = true
                        chatRoomMsgInfo.getChatRoomMsgInfo(userID, userName, roomID, userID, userName, user_message)
                    }
                }
            }

            Text {
                id: textMsgReadType
                width: contentWidth
                height: contentHeight
                x: recChatRoomUserMsg.x - textMsgReadType.width - parent.width / 320 * 5
                y: recChatRoomUserMsg.height - textChatRoomUserSendTime.height - textMsgReadType.height
                text: read_type
                font.pointSize: 10
            }

            Text {
                id: textChatRoomUserSendTime
                width: contentWidth
                height: contentHeight
                x: recChatRoomUserMsg.x - textChatRoomUserSendTime.width - parent.width / 320 * 5
                y: recChatRoomUserMsg.height - textChatRoomUserSendTime.height

                text: send_time
                font.pointSize: 10
            }

            Text {
                id: textGetUserMessageWidth
                height: contentHeight
                width: contentWidth
                text: user_message
                font.pointSize: 14
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                visible: false
                lineHeight: 1.5
            }

//            MouseArea {
//                anchors.fill: parent
//                onClicked: {
//                    console.log("click test")
//                    //mainFriendRecBackground.color = "#ff2929"
//                }
//            }
        }
    }

/*    Component{
        //id: chatRoomDelegate

        Rectangle {
            width: label_message.width + 25
            height: label_message.height

            Rectangle{
                id: roomMsgImage
                width: 25
                height: 25

                Image {
                    id: charRoomFriendImage
                    width: parent.width
                    height: parent.height
                    source: friend_image
                }
            }

            Rectangle{
                id:recRoomMsg
                width: label_message.width
                height: label_message.height
                anchors.left: roomMsgImage.right

                Text {
                    id: label_message
                    text: message
                    width: contentWidth
                    height: contentHeight
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("click the message : " + label_message.text)
                        //console.log("friend id : " + friendid.text)

                        //friendInfoMessageChat.getFriendInfoChat(friendid.text, friendname.text, userID.text)
                        //friendInfoMessageChat.visible = true
                        //recBlackBackground.visible = true
                        //frameMain.enabled = false
                    }
                }
            }
        }
    }*/




    Rectangle {
        id: recTitle
        width: parent.width
        height: parent.width / 320 * 85
        color: "#e0dfdf"
        anchors.top: chatR.top

        Rectangle {
//            x: 45
//            y: 10
//            width: 65
//            height: 65
            x: parent.width / 320 * 45
            y: parent.width / 320 * 10
            width: parent.width / 320 * 65
            height: parent.width / 320 * 65
            radius: parent.width / 320 * 20

            Image {
                id: image
                width: parent.width
                height: parent.height
                source: "Jelly.png"
            }
        }

        Text {
            id: textFriendName
//            x: 120
//            y: 10
//            width: 150
//            height: 33
            x: parent.width / 320 * 120
            y: parent.width / 320 * 10
            width: parent.width / 320 * 150
            height: parent.width / 320 * 33
            text: qsTr("~ friend name ~")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 18
        }

        Text {
//            x: 120
//            y: 42
//            width: 150
//            height: 33
            x: parent.width / 320 * 120
            y: parent.width / 320 * 42
            width: parent.width / 320 * 150
            height: parent.width / 320 * 33
            text: qsTr("功能                ")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 14
        }

        Rectangle{
            id: recChatRoomFriendNote
            x: parent.width / 320 * 230
            y: parent.width / 320 * 47
            width: parent.width / 320 * 25
            height: recChatRoomFriendNote.width / 9 * 10
            radius: parent.width / 320 * 15

            Image {
                width: parent.width
                height: parent.height
                scale: 1
                sourceSize.width: 0
                fillMode: Image.Stretch
                source: "Jelly_mainNote.png"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("click note")
                    note.clearNoteModel()
                    client.loadFriendNote(userInformation.userInfoID, roomID)
                    userInformation.visible = false
                    bell.visible = false
                    note.visible = true
                }
            }
        }

        Rectangle{
            id: recChatRoomFriendTodoList
            x: parent.width / 320 * 183
            y: parent.width / 320 * 47
            width: parent.width / 320 * 25
            height: recChatRoomFriendNote.width / 9 * 10
            radius: parent.width / 320 * 15

            Image {
                width: parent.width
                height: parent.height
                scale: 1
                sourceSize.width: 0
                fillMode: Image.Stretch
                source: "Jelly_mainToDoList.png"
            }
        }

    }



/*
    ScrollView{
        id: scrollViewRoom
        //x: 0
        //y: 85
        width: parent.width
        height: 420
        contentHeight: recChat.height
        //contentWidth: recChat.width
        clip: true
        anchors.top: recTitle.bottom
        anchors.bottom: recBottom.top
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn

//        Flickable{
//            id: flickableScroll
//            width: parent.width
//            height: parent.height

//            //contentHeight: recChat.height - scrollViewRoom.height


//        }

        Rectangle{
            id: recChat
            width: 320
            height: 420
            //anchors.top: scrollViewRoom.top
            clip: true
            color: "#ffe4f2"

//            Flickable{
//                width: parent.width
//                height: parent.height
//            }
        }

//        Component.onCompleted: {
//            flickableItem.contentY = flickableItem.contentHeight - height
//            flickableItem.contentX = flickableItem.contentWidth / 2 - width / 2
//        }
    }*/

//    Text{id: textUserMsg; text: textFieldMessage.text; width: contentWidth; height: contentHeight; visible: false}
//    Text{id: textLoadUserMsg; text: message; width: contentWidth; height: contentHeight; visible: false}





    ScrollView{
        id: chatRoomMsgScrollView
        //x: 0
        //y: 85
        width: parent.width
        //height: 420
        height: parent.height - recTitle.height - recBottom.height
        //contentHeight: recChat.height
        contentWidth: chatRoomMsgListView.width
        clip: true
        anchors.top: recTitle.bottom
        anchors.bottom: recBottom.top
        //ScrollBar.vertical.policy: ScrollBar.AlwaysOn



        ListView {
            id: chatRoomMsgListView
            width: parent.width
            //height: contentHeight

            model: chatRoomMsgModel
            delegate: chatRoomMsgDelegate

            spacing: parent.width / 320 * 10

/*            Component.onCompleted: {
                console.log("This prints just fine!")
                chatRoomMsgListView.positionViewAtEnd()
            }


            onHeightChanged: {
                console.log("in on height changed")
                var newIndex = chatRoomMsgListView.count - 1; // last index
                chatRoomMsgListView.positionViewAtEnd();
                chatRoomMsgListView.currentIndex = newIndex;
            }*/
        }
    }




    Rectangle {
        id: recBottom
        width: parent.width
        height: parent.height / 550 * 45
        color: "#f2f2f2"
        anchors.bottom: chatR.bottom

        TextField {
            id: textFieldMessage
            //x: 80
            //y: 5
            y: parent.height / 2 - textFieldMessage.height / 2
            width: parent.width / 320 * 200
            height: parent.height / 45 * 35
            text: qsTr("")
            anchors.left: recBottomFunction.right
            anchors.right: recSend.left
        }

        Rectangle {
            id: recSend
            width: parent.width / 320 * 60
            height: parent.height / 45 * 45
            color: "#ffffff"
            anchors.right: recBottom.right

            Text {
                id: text2
                width: parent.width
                height: parent.height
                text: qsTr("發送")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 14
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    console.log("send message : " + textFieldMessage.text)
                    client.button_SendMessage_clicked(roomID, friendID, friendName, userID, userName, textFieldMessage.text)
                    textFieldMessage.text = ""
                }
            }
        }

        Rectangle {
            id: recBottomFunction
            width: parent.width / 320 * 60
            height: parent.height / 45 * 45
            color: "#ffffff"
            anchors.left: recBottom.left

            Text {
                width: parent.width
                height: parent.height
                text: qsTr("功能")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 14
            }
        }
    }

/*    InputPanel {
        id: inputPanel
        z: 99
        //更改x,y即可更改键盘位置
        x: 0
        y: window.height
        //更改width即可更改键盘大小
        width: window.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: window.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }*/


//    TextInput {
//        id: myInput
//        EnterKey.enabled: myInput.text.length > 0 || myInput.inputMethodComposing
//        EnterKey.label: "Next"
////        EnterKeyAction.enabled: myInput.text.length > 0 || myInput.inputMethodComposing
////        EnterKeyAction.label: "Next"
//        Keys.onReleased: {
//            if (event.key === Qt.Key_Return) {
//                // execute action
//            }
//        }
//    }

//    InputPanel {
//        id: inputPanel
//        visible: active
//        y: active ? parent.height - inputPanel.height : parent.height
//        anchors.left: parent.left
//        anchors.right: parent.right
//    }



//    SidePull{
//        id:sp
//        visible: true
//    }






}
