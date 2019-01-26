import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import com.company.client 1.0

ApplicationWindow {
    id: mainPage
    visible: true
    width: 320
    height: 550

//    width: parent.width
//    height: parent.height
    color: "#fff2f9"
    opacity: 1
    title: qsTr("Jelly")



    Client{
        id: client
    }
    Connections {
        target: client
        //onTest: testText.color = color
        onChangeMainPage: {
            login.visible = false
            userInformation.visible = true
            sidePull.visible = true
            bell.visible = true
        }
        onCallMessageBox: {
            console.log("in onCallMsgBox")
            messageBox.visible = true
            messageBox.getMsgBoxInfo(msgBoxTitle, msgBoxInfo)
            messageBox.stopOtherActive()
        }
        onUserInfo: {
            userInformation.getUserInformation(user_id, user_name, user_image)
            //friendList.friendListUserInfo(userID, userName)
            //roomList.friendListUserInfo(userID, userName)
        }
        onLoadMainUnreadMsg: {
            getUnreadMsgInfo(sender, sender_id, sender_image, user_id, room_id, send_time, type , message, determine)
        }
        onLoadFriendInfo: {
            friendList.friendListInfo(friend_id, friend_name, friend_image)
        }
        onLoadAddFriendInfo: {
            friendList.friendListAddInfo(friend_id, friend_name, friend_image)
        }
        onShowSearchFriendName: {
            searchFriend.getSearchFriendInfo(friend_id, friend_name)
        }/*
        onQmlMsgSize: {
            frameRoom.messageSize(_width)
        }*/
        onGetChatRoomID: {
            chatRoom.getChatRoomID(room_id)
            changeTypeOfMessage(room_id)
        }
        onRoomNewUserMsg: {
            chatRoom.newUserMessage(sender_image, sender_id, sender, friend_message, send_time, read_type, user_message, type)
        }
        onLoadRoomUserMsg: {
            chatRoom.loadUserMessage(sender_image, sender_id, sender, friend_message, send_time, read_type, user_message, type)
        }
        onLoadRoomFriendMsg: {
            chatRoom.loadFriendMessage(sender_image, sender_id, sender, friend_message, send_time, read_type, user_message, type, room_id)
        }
        onLoadRoomListInfo: {
            roomList.loadRoomListInfo(room_id, last_sender_id, last_sender_name, room_name, room_image, lastMessage, lastSendTime, lastTimeFormat, lastType, unread_count, friend_id, friend_name)
        }
        onReloadChatRoomMsg:{
            chatRoom.clearModel()
            chatRoom.reloadMsg()
        }
        onLoadMainNote:{
            mainPage.mainNoteAppend(friend_id, friend_name, friend_image, message)
        }
        onLoadUserNote:{
            note.noteAppend(friend_id, friend_name, friend_image, message)
        }
        /*
        onRoomAppendUserMsg: {
            frameRoom.chatRecordUserAppend(message, userShowName)
        }
        onRoomAppendFriendMsg: {
            frameRoom.appendRoomMessage(message, friendShowName)
        }*/
    }





//    property string sender: ""
//    property string sender_id: ""
    property string user_id: ""
//    property string room_id: ""
//    property string send_time: ""
//    property int type: 1
//    property string message: ""
    //property var unreadMsgInfo: [{sender: "abc", sender_id: "2349876543345"}, {sender: "def", sender_id: "895934089560998"}]
    property var unreadMsgInfo: []
    property var countUnreadMsg: []

    property int i: 0
    property int y: 0
    property int checkSenderCount: 0
    property int unreadCount: 0
    property string unreadFriend: ""

    function getUnreadMsgInfo(_sender, _sender_id, _sender_image, _user_id, _room_id, _send_time, _type , _message, _determine){
        checkSenderCount = 0
        user_id = _user_id
        unreadMsgInfo.push({sender: _sender, sender_id: _sender_id, sender_image: _sender_image, user_id: _user_id, room_id: _room_id, send_time: _send_time, type: _type, message: _message})
        console.log("in unreadMsgInfo => sender: " + _sender + "  sender_id: " + _sender_id + "  sender_image: " + _sender_image + "  user_id: " + _user_id + "  room_id: " + _room_id + "  send_time:" + _send_time + "  type: " + _type + "  message: " + _message)
        //console.log("unreadMsgInfo...  sender: " + unreadMsgInfo[0].sender + "  room_id: " + unreadMsgInfo[0].room_id + "  send_time: " + unreadMsgInfo[0].send_time + "  type: " + unreadMsgInfo[0].type + "  message: " + unreadMsgInfo[0].message)//print "abc"
        //console.log("unreadMsgInfo...  sender: " + unreadMsgInfo[1].sender + "  room_id: " + unreadMsgInfo[1].room_id + "  send_time: " + unreadMsgInfo[1].send_time + "  type: " + unreadMsgInfo[1].type + "  message: " + unreadMsgInfo[1].message)

        if(_determine == "newMessage"){
            console.log("in determine = newMessage")
            bell.showBellAnimation()
            bellScrollView.insertBellMessage(_sender_image, _sender_id, _sender, _room_id, _message, _send_time, _type)
            bellScrollView.appendBellListView(_sender_image, _sender_id, _sender, _message, _room_id, _send_time, _type)
        }
        else if(_determine == "tempQueueMessage"){
            console.log("in determine = tempQueueMessage")
            bell.showBellAnimation()
            bellScrollView.insertBellMessage(_sender_image, _sender_id, _sender, _room_id, _message, _send_time, _type)
            bellScrollView.appendBellListView(_sender_image, _sender_id, _sender, _message, _room_id, _send_time, _type)
        }
        else if(_determine == "unreadMessage"){
            console.log("in determine = unreadMessage")
            bell.showBellImage()
        }

        //每次進來先把modle清掉，最後再呼叫一個function重建
        mainUnreadFriendModel.clear()
        mainUnreadFriendMessageModel.clear()

        unreadFriend = unreadMsgInfo[unreadCount].room_id
        console.log("unreadFriend: " + unreadFriend)
        if(unreadCount == 0){
            //firstUnreadFriend = unreadMsgInfo[0].sender
            console.log("unread friend: " + unreadMsgInfo[0].sender)
            countUnreadMsg.push({sender: _sender, sender_id: _sender_id, sender_image: _sender_image, room_id: _room_id, msg_count: 1})
            console.log("countUnreadMsg[0].msg_count : " + countUnreadMsg[0].msg_count)
            //mainUnreadFriendInfo(unreadMsgInfo[0].sender, unreadMsgInfo[0].sender_id, unreadMsgInfo[0].sender_image, unreadMsgInfo[0].room_id)


            //mainUnreadFriendInfo(_sender, _sender_id, _sender_image, _room_id)

        }
        else{
            for(i = 0; i < unreadMsgInfo.length - 1; i++){
                if(unreadFriend == unreadMsgInfo[i].room_id){
                    for(y = 0; y < countUnreadMsg.length; y++){
                        if(unreadFriend == countUnreadMsg[y].room_id){
                            countUnreadMsg[y].msg_count += 1
                            console.log("countUnreadMsg[i].msg_count : " + countUnreadMsg[y].msg_count)
                        }
                    }

                    break
                }
                else{
                    checkSenderCount++;
                    //console.log("checkSenderCount: " + checkSenderCount)
                }

                if(checkSenderCount == unreadMsgInfo.length - 1){
                    console.log("unread friend: " + unreadMsgInfo[i + 1].sender)
                    //countUnreadMsg.push({room_id: _room_id, msg_count: 1})
                    countUnreadMsg.push({sender: _sender, sender_id: _sender_id, sender_image: _sender_image, room_id: _room_id, msg_count: 1})


                    //mainUnreadFriendInfo(unreadMsgInfo[i + 1].sender, unreadMsgInfo[i + 1].sender_id, unreadMsgInfo[i + 1].sender_image, unreadMsgInfo[i + 1].room_id)


                    //mainUnreadFriendInfo(_sender, _sender_id, _sender_image, _room_id)

                }
            }
        }

        appendFriendModel()
        unreadCount += 1
    }

    function appendFriendModel(){
        for(i = countUnreadMsg.length - 1; i >= 0; i--){
            mainUnreadFriendInfo(countUnreadMsg[i].sender, countUnreadMsg[i].sender_id, countUnreadMsg[i].sender_image, countUnreadMsg[i].room_id, countUnreadMsg[i].msg_count)
        }
    }

    function mainUnreadFriendInfo(_sender, _sender_id, _sender_image, _room_id, _msg_count){
        mainUnreadFriendModel.append({"sender":_sender, "sender_id":_sender_id, "sender_image":_sender_image, "room_id":_room_id, "msg_count":_msg_count})
        console.log("append main unread friend " + _sender + _sender_id + _sender_image + _room_id)
//        textFriendID.text = friend_id
//        textFriendName.text = friend_name
//        imageFriend.source = friend_image
    }

    function mainUnreadFriendMessageInfo(_sender, _type , _message){
        mainUnreadFriendMessageModel.append({"sender":_sender, "type":_type, "message":_message})
        console.log("append main unread friend message " + _sender + _type + _message)
        //type = _type

        //mainFriendListView.currentIndex
    }

    function getUnreadFriendMessageInfo(_room_id){
        for(i = 0; i < unreadMsgInfo.length; i++){
            if(unreadMsgInfo[i].room_id == _room_id){
                console.log("temp friend msg: " + unreadMsgInfo[i].message)

                if(unreadMsgInfo[i].type == 0){
                    mainUnreadFriendMessageInfo(unreadMsgInfo[i].sender, unreadMsgInfo[i].type, unreadMsgInfo[i].message)
                }
                else if(unreadMsgInfo[i].type == 1){
                    mainUnreadFriendMessageInfo(unreadMsgInfo[i].sender, unreadMsgInfo[i].type, "向您傳送了一個檔案")
                }
                else if(unreadMsgInfo[i].type == 2){
                    mainUnreadFriendMessageInfo(unreadMsgInfo[i].sender, unreadMsgInfo[i].type, "向您傳送了一張圖片")
                }
            }
        }
    }

    function changeTypeOfMessage(_room_id){
        var friend_temp_id = "0"
        for(i = 0; i < unreadMsgInfo.length; i++){
            if(unreadMsgInfo[i].room_id == _room_id){
                console.log("in change type of message: unreadMsgInfo.send_time")
                friend_temp_id = unreadMsgInfo[i].sender_id
                client.responseMessage(_room_id, unreadMsgInfo[i].sender_id, unreadMsgInfo[i].send_time, unreadMsgInfo[i].type, unreadMsgInfo[i].message)
                unreadMsgInfo.splice(i, 1)

                unreadCount--;
                i--;

                //delete unreadMsgInfo[i]

//                for(y = i; y < unreadMsgInfo.length - 1; y++){
//                    unreadMsgInfo[y] = unreadMsgInfo[y + 1]
//                }
            }
        }

        for(i = 0; i < countUnreadMsg.length; i++){
            if(countUnreadMsg[i].room_id == _room_id){
                countUnreadMsg.splice(i, 1)
                break
            }
        }

        bellScrollView.refreshBellListView(_room_id)

        mainUnreadFriendModel.clear()
        mainUnreadFriendMessageModel.clear()
        appendFriendModel()

        client.changFriendMsgType(_room_id, friend_temp_id);
    }

    function unreadMessageClear(){
        mainUnreadFriendModel.clear()
        mainUnreadFriendMessageModel.clear()
        mainNoteModel.clear()
        note.clearNoteModel()
        //appendFriendModel()
/*        for(i = 0; i < unreadMsgInfo.length; i++){
            unreadMsgInfo.splice(i, 1)
//            if(i < countUnreadMsg.length){

//            }
        }
        for(i = 0; i < countUnreadMsg.length; i++){
            countUnreadMsg.splice(i, 1)
        }*/
        unreadMsgInfo.splice(0, unreadMsgInfo.length)
        countUnreadMsg.splice(0, countUnreadMsg.length)

        //console.log("unreadMsgInfo.length = " + unreadMsgInfo.length)
        //console.log("countUnreadMsg.length = " + countUnreadMsg.length)

        unreadCount = 0
        client.loadQueue(userInformation.userInfoID)
        client.loadNote(userInformation.userInfoID)
    }

    function mainNoteAppend(_friend_id, _friend_name, _friend_image, _message){
        mainNoteModel.append({"note_friend_id":_friend_id, "note_friend_name":_friend_name, "note_friend_image":_friend_image, "note_message":_message})
        console.log("append main note " + _friend_id + _friend_name + _message)
    }



    ListModel{
        id: mainUnreadFriendModel
    }

    ListModel{
        id: mainUnreadFriendMessageModel
    }

    ListModel{
        id: mainNoteModel
    }

    Component{
        id: mainFriendDelegate

        Rectangle{
            id: mainFriendRecBackground
//            width: 70
//            height: 70
            width: mainPage.width / 320 * 70
            height: mainPage.width / 320 * 70
            //color: ListView.isCurrentItem ? "steelblue" : "white"
            //color: mainFriendListView.

            Rectangle {
                id: rectangleImg
//                x: 10
//                y: 0
                x: parent.width / 2 - rectangleImg.width / 2
                y: 0
//                width: 45
//                height: 45
                width: mainPage.width / 320 * 45
                height: mainPage.width / 320 * 45
                color: "#e4e4e4"
                radius: mainPage.width / 320 * 15

                Image {
                    id: imageMainUnreadFriend
                    width: parent.width
                    height: parent.height
                    scale: 1
                    sourceSize.width: 0
                    fillMode: Image.Stretch
                    source: sender_image
                }

                Rectangle {
                    id: rectangleMsgCount
                    x: parent.width - rectangleMsgCount.width / 2
                    y: 0
//                    width: 17
//                    height: 17
                    width: mainPage.width / 320 * 17
                    height: mainPage.width / 320 * 17
                    color: "#ff2929"
                    radius: mainPage.width / 320 * 100

                    Text {
                        id: textUnreadFriendMsgCount
                        //x: 2
                        //y: 1
                        width: parent.width
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        text: msg_count
                        font.pointSize: 12
                        color: "#ffffff"
                        font.bold: true
                    }
                }


            }
            Text {
                id: textUnreadFriendName
                width: rectangleImg.width
                height: parent.height - rectangleImg.height
//                x: 10
//                y: 48
                x: rectangleImg.x
                y: rectangleImg.height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                //text: qsTr("name")
                text: sender
                font.pointSize: 15
            }

            Text {
                id: textUnreadFriendID
                text: sender_id
                visible: false
            }
            Text {
                id: textUnreadFriendRoomID
                text: room_id
                visible: false
            }
            Text {
                id: textUnreadFriendImage
                text: sender_image
                visible: false
            }



            MouseArea {
                anchors.fill: parent

                onClicked: {
                    console.log("unread frined name: " + textUnreadFriendName.text + "  id: " + textUnreadFriendID.text + "  room_id: " + textUnreadFriendRoomID.text)
                    //mainFriendRecBackground.color = "#ff2929"

                    mainUnreadFriendMessageModel.clear()
                    getUnreadFriendMessageInfo(textUnreadFriendRoomID.text)
                    //mainFriendRecBackground.color = mainFriendListView.isCurrentItem ? "#efffef" : "#ffffff"

                    //mainFriendRecBackground.color = "#efefff"

                }

                onPressAndHold: {
                    console.log("press and hold success")
                    unreadInfoMsgBox.visible = true
                    unreadInfoMsgBox.getUnreadMsgBoxInfo(textUnreadFriendID.text, textUnreadFriendName.text, textUnreadFriendImage.text, textUnreadFriendRoomID.text, unreadMsgInfo)
                }
            }
        }



    }

    Component{
        id: mainMessageDelegate

        Rectangle{
            width: mainPage.width
            //height: 30
            height: textUnreadMessage.height
            color: "#ffefef"
            border.color: "#d3c3c3"
            border.width: 1.5

            //state: type == "0" ? (textUnreadMessage.horizontalAlignment = Text.AlignRight) : (textUnreadMessage.horizontalAlignment = Text.AlignLeft)

            Text {
                id: textUnreadMsgFriendName
                height: textUnreadMessage.height
                x: mainPage.width / 320 * 10
                //y: 20
                text: sender
                font.pointSize: 16
                font.bold: true
                verticalAlignment: Text.AlignVCenter
            }

            Text {
                //state: textGetUnreadMessageWidth.width >= parent.width - textUnreadMsgFriendName.width - 30 ? (textUnreadMessage.horizontalAlignment = Text.AlignLeft) : (textUnreadMessage.horizontalAlignment = Text.AlignRight)

                id: textUnreadMessage
                //height: textGetUnreadMessageHeight.height
                height: contentHeight
                width: mainPage.width - textUnreadMessage.x - mainPage.width / 320 * 10
                //x: textUnreadMsgFriendName.width + 30
                x: textUnreadMsgFriendName.width + mainPage.width / 320 * 30
                text: message
                font.pointSize: 14
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                lineHeight: 1.5
                //horizontalAlignment: Text.AlignRight
            }

            Text {
                id: textGetUnreadMessageWidth
                //height: parent.height
                width: contentWidth
                text: message
                font.pointSize: 14
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                visible: false
                lineHeight: 1.5
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("click test")
                    //mainFriendRecBackground.color = "#ff2929"
                }
            }
        }
    }

    Component{
        id: mainNoteDelegate

        Rectangle{
            id: recMainNote
            width: mainNoteScrollView.width
            height: mainNoteScrollView.height / 6
            color: "#00ffffff"
            //border.color: "#d3c3c3"
            //border.width: 1.5

            Rectangle{
                id: recNoteFriendImage
                x: 0
                width: mainPage.width / 320 * 18
                height: recNoteFriendImage.width
                color: "#e0dfdf"
                radius: mainPage.width / 320 * 20

                Image {
                    id: noteFriendImage
                    width: parent.width
                    height: parent.height
                    source: note_friend_image
                }
            }

            Rectangle{
                id: recNoteFriendName
                width: textNoteFriendName.width
                height: parent.height
                x: recNoteFriendImage.width + mainPage.width / 320 * 5
                color: "#00ffffff"
                //anchors.left: recNoteFriendImage.right + mainPage.width / 320 * 5

                Text {
                    id: textNoteFriendName
                    height: parent.height
                    text: note_friend_name
                    font.pointSize: 12
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Rectangle{
                id: recNoteFriendMessage
                width: textNoteFriendMessage.width
                height: parent.height
                x: recNoteFriendName.width + recNoteFriendName.x + mainPage.width / 320 * 5
                color: "#00ffffff"
                //anchors.left: recNoteFriendName.right + mainPage.width / 320 * 5

                Text {
                    id: textNoteFriendMessage
                    height: parent.height
                    //anchors.left: textNoteFriendName.right + textNoteFriendName.x
                    text: note_message
                    font.pointSize: 12
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }

















    /*Rectangle {
        id: rectangle1
        x: 40
        y: 11
        width: 240
        height: 68
        color: "#e0dfdf"
        radius: 15

        Image {
            id: image1
            x: 8
            y: 8
            width: 52
            height: 52
            source: "Jelly.png"
        }

        Text {
            id: text1
            x: 73
            y: 8
            width: 159
            height: 22
            text: qsTr("User Name")
            renderType: Text.QtRendering
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: 12
        }

        Text {
            id: text2
            x: 73
            y: 30
            width: 159
            height: 30
            text: qsTr("個人資訊")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
        }
    }*/

    Rectangle {
        id: recMainNote
//        x: 167
//        y: 385
//        width: 135
//        height: 155
        x: mainPage.width / 320 * 167
        y: mainPage.height / 550 * 385
        width: mainPage.width / 320 * 135
        height: mainPage.height / 550 * 155
        //color: "#fefea1"
        radius: mainPage.height / 550 * 15
        visible: false

        Image {
            id: image
            x: 0
            y: 0
            width: parent.width
            height: parent.height
            scale: 1
            sourceSize.width: 0
            fillMode: Image.Stretch
            source: "Jelly_mainNote.png"
        }

        ScrollView {
            id: mainNoteScrollView
            x: mainPage.width / 320 * 10
            y: mainPage.height / 550 * 20
            width: parent.width - mainNoteScrollView.x * 2
            height: parent.height - mainNoteScrollView.y - parent.height / 155 * 10
            clip: true

            ListView {
                id: mainNoteListView

                model: mainNoteModel
                delegate: mainNoteDelegate

            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("click note")

//                    note.clearNoteModel()
//                    client.loadNote(userInformation.userInfoID)
                userInformation.visible = false
                bell.visible = false
                note.visible = true
            }
        }
    }

    Rectangle {
        id: recMainToDoList
//        x: 16
//        y: 385
//        width: 135
//        height: 155
        x: mainPage.width / 320 * 16
        y: mainPage.height / 550 * 385
        width: mainPage.width / 320 * 135
        height: mainPage.height / 550 * 155
        //color: "#fcc7c7"
        radius: mainPage.height / 550 * 15
        visible: false

        Image {
            id: image2
            x: 0
            y: 0
            width: parent.width
            height: parent.height
            source: "Jelly_mainToDoList.png"
        }
    }



    ScrollView {
        id: mainFriendScrollView
//        x: 0
//        y: 94
//        width: 320
//        height: 75
        x: 0
        y: parent.height / 550 * 94
        width: mainPage.width
        height: mainPage.height / 550 * 75
        clip: true

        ListView {
            id: mainFriendListView
            //width: contentWidth
            //height: mainPage.height / 320 * 70
            orientation: ListView.Horizontal
//            anchors.fill: parent
            //clip: true
            //focus: true

            model: mainUnreadFriendModel
            delegate: mainFriendDelegate

        }
    }

    ScrollView{
        id: mainMessageScrollView
//        x: 0
//        y: 169
//        width: 320
//        height: 355
        x: 0
        width: mainPage.width
        height: mainPage.height / 550 * 355
        anchors.top: mainFriendScrollView.bottom
        clip: true

        ListView {
            id: mainMessageListView
            //width: parent.width
            //height: contentHeight
            orientation: ListView.Vertical
            //            anchors.fill: parent
            //clip: true
            //focus: true

            model: mainUnreadFriendMessageModel
            delegate: mainMessageDelegate

//            anchors {
//                margins: 20
//            }
            spacing: 5

//            onContentHeightChanged: {
//                if(type == 0){
//                    textUnreadMessage.horizontalAlignment = Text.AlignRight
//                }
//            }
//            ListModel.append: {
//                if(type == 0){
//                    textUnreadMessage.horizontalAlignment = Text.AlignRight
//                }
//            }
//            ListView.onAdd: {
//                if(type == 0){
//                    textUnreadMessage.horizontalAlignment = Text.AlignRight
//                }
//            }
        }
    }

    Rectangle {
        id: recMainOpen
//        x: 0
//        y: 530
//        width: 320
//        height: 20
        x: 0
        y: mainPage.height - recMainOpen.height
        width: mainPage.width
        height: mainPage.height / 550 * 20
        color: "#ffffff"

        MouseArea {
            anchors.fill: parent
            onClicked: {//185
                console.log("展開")
                mainMessageScrollView.height = mainPage.height / 550 * 185
                recMainNote.visible = true
                recMainToDoList.visible = true
                recMainOpen.visible = false
                recMainClose.visible = true
                //mainFriendRecBackground.color = "#ff2929"
            }
        }
    }

    Rectangle {
        id: recMainClose
//        x: 0
//        y: 360
//        width: 320
//        height: 20
        x: 0
        y: recMainNote.y - recMainClose.height - mainPage.height / 550 * 10
        width: recMainOpen.width
        height: recMainOpen.height
        color: "#ffffff"
        visible: false

        MouseArea {
            visible: true
            anchors.fill: parent
            onClicked: {//185
                console.log("縮起")
                mainMessageScrollView.height = mainPage.height / 550 * 355
                recMainNote.visible = false
                recMainToDoList.visible = false
                recMainOpen.visible = true
                recMainClose.visible = false
                //mainFriendRecBackground.color = "#ff2929"
            }
        }
    }


    /*Rectangle {
        id: recSidePullRight
        x: 293
        y: 27
        width: 27
        height: 36
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
        x: 163
        y: 27
        width: 27
        height: 36
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
        x: 190
        y: 0
        width: 130
        height: 550
        color: "#cc5a4f67"
        visible: false

        Text {
            id: text3
            x: 8
            y: 45
            width: 114
            height: 453
            color: "#ffffff"
            text: qsTr("聊天室\n朋友/群組列表\n搜尋好友\n建群組\n主頁\n\n\n待辦事項\n記事本\n\n\n\n個人檔案\n登出")
            lineHeight: 1.5
            font.family: "Times New Roman"
            font.pixelSize: 12
        }

        Rectangle {
            id: recSidePullRoomList
            x: 0
            y: 42
            width: 130
            height: 25
            color: "#ffffff"
            opacity: 0.0

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("聊天室")
                    frameRoomList.visible = true
                }
            }
        }

        Rectangle {
            id: recSidePullFriendList
            x: 0
            y: 67
            width: 130
            height: 25
            color: "#ffffff"
            opacity: 0.0

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("朋友/群組列表")
                }
            }
        }

        Rectangle {
            id: recSidePullSearchFriend
            x: 0
            y: 92
            width: 130
            height: 25
            color: "#ffffff"
            opacity: 0.0

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("搜尋好友")
                }
            }
        }

        Rectangle {
            id: recSidePullCreateGroup
            x: 0
            y: 117
            width: 130
            height: 25
            color: "#ffffff"
            opacity: 0.0

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("建群組")
                }
            }
        }

        Rectangle {
            id: recSidePullMain
            x: 0
            y: 142
            width: 130
            height: 25
            color: "#ffffff"
            opacity: 0.0

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("主頁")
                }
            }
        }

    }*/




//    Rectangle{
//        id: recBackground
//        width: parent.width
//        height: parent.height
//        color: "#b3424242"
//        visible: true

//        MouseArea{
//            anchors.fill: parent
//            onClicked: {
//                console.log("click background rec")
//                recBackground.visible = false
//                messageBox.visible = false
//            }
//        }
//    }

    Login{
        id: login
        visible: true
    }

    RoomList{
        id: roomList
        visible: false
    }

    FriendList{
        id: friendList
        visible: false
    }

    SearchFriend{
        id: searchFriend
        visible: false
    }

    ChatRoom{
        id: chatRoom
        visible: false
    }

    Note{
        id: note
        visible: false
    }

    UserInformation{
        id: userInformation
        visible: false
    }

    SidePull{
        id: sidePull
        visible: false
    }

    Bell{
        id:bell
        visible: false
    }

    BellScrollView{
        id: bellScrollView
        visible: false
    }

    MessageBox{
        id: messageBox
        visible: false
    }

    UnreadInfoMsgBox{
        id:unreadInfoMsgBox
        visible: false
    }

    ChatRoomMsgInfo{
        id: chatRoomMsgInfo
        visible: false
    }

    FriendInfoMsgConfirm{
        id: friendInfoMsgConfirm
        visible: false
    }

    FriendInfoMsgChat{
        id: friendInfoMsgChat
        visible: false
    }

    NoteMsgInfo{
        id: noteMsgInfo
        visible: false
    }



    onClosing: {
        console.log("close the application …")
        client.closeAPP()
    }
}
