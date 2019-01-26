import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import com.company.client 1.0

Rectangle {
    id: note
    width: parent.width
    height: parent.height


    property string friend_id: ""
    property string friend_name: ""
    property string friend_image: ""
    property string message: ""

    function getNoteInfo(_friend_id, _friend_name, _friend_image, _message){
        friend_id = _friend_id
        friend_name = _friend_name
        friend_image = _friend_image
        message = _message
    }

    function noteAppend(_friend_id, _friend_name, _friend_image, _message){
        noteModel.append({"note_friend_id":_friend_id, "note_friend_name":_friend_name, "note_friend_image":_friend_image, "note_message":_message})
        console.log("append note " + _friend_id + _friend_name + _message)
    }

    function clearNoteModel(){
        noteModel.clear()
    }

//    function getRecNoteHeight(_textNoteFriendMessageHeight){
//        for(i = 2; i < 15; i++){
//            if(){

//            }
//        }
//    }



    ListModel{
        id: noteModel
    }

    Component{
        id: noteDelegate

        Rectangle{
            id: recNote
            width: noteScrollView.width
            height: noteScrollView.height / 13
            color: "#00ffffff"

            state: textNoteFriendMessageHeight.height > noteScrollView.height / 13 ? (recNote.height = noteScrollView.height / 13 * 2) : (recNote.height = noteScrollView.height / 13)

            Rectangle{
                id: recNoteFriendImage
                width: noteScrollView.height / 13 - note.width / 320 * 8
                height: recNoteFriendImage.width
                color: "#e0dfdf"
                radius: note.width / 320 * 20

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
                x: recNoteFriendImage.width + note.width / 320 * 10
                color: "#00ffffff"
                //anchors.left: recNoteFriendImage.right + note.width / 320 * 5

                Text {
                    id: textNoteFriendName
                    height: parent.height
                    text: note_friend_name
                    font.pointSize: 14
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Rectangle{
                id: recNoteFriendMessage
                width: textNoteFriendMessage.width
                height: parent.height
                x: recNoteFriendName.width + recNoteFriendName.x + note.width / 320 * 10
                color: "#00ffffff"
                //anchors.left: recNoteFriendName.right + note.width / 320 * 5

                Text {
                    id: textNoteFriendMessage
                    width: note.width - recNoteFriendImage.width - recNoteFriendName.width - note.width / 320 * 20
                    height: parent.height
                    //anchors.left: textNoteFriendName.right + textNoteFriendName.x
                    text: note_message
                    font.pointSize: 14
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WordWrap
                }
            }

            Text {
                id: textNoteFriendMessageHeight
                width: note.width - recNoteFriendImage.width - recNoteFriendName.width - note.width / 320 * 20
                height: contentHeight
                text: note_message
                font.pointSize: 14
                wrapMode: Text.WordWrap
                visible: false
            }

            Text{
                id: textNoteFriendID
                text: note_friend_id
                visible: false
            }

            MouseArea {
                anchors.fill: parent

                onPressAndHold: {
                    console.log("press and hold success")
                    noteMsgInfo.visible = true
                    noteMsgInfo.getNoteMsgInfo(textNoteFriendID.text, textNoteFriendName.text, userInformation.userInfoID, userInformation.userInfoName, textNoteFriendMessage.text)
                }
            }
        }
    }



    Image {
        id: imageNote
        width: parent.width
        height: parent.height
        scale: 1
        sourceSize.width: 0
        fillMode: Image.Stretch
        source: "Jelly_note.png"
    }

    ScrollView {
        id: noteScrollView
        x: parent.width / 320 * 20
        y: parent.height / 550 * 55
        width: parent.width - noteScrollView.x * 2
        height: parent.height - noteScrollView.y - parent.height / 550 * 10
        clip: true

        ListView {
            id: noteListView

            model: noteModel
            delegate: noteDelegate

        }
    }

}
