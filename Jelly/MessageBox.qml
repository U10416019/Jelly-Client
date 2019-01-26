import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import com.company.client 1.0

Rectangle {
    id: msgBox
    width: parent.width
    height: parent.height
    color: "#b3424242"


    property string msgTitle: ""
    property string msgInfo: ""

    function getMsgBoxInfo(msgBoxTitle, msgBoxInfo){
        console.log("msgBox: title = " + msgBoxTitle + ", info = " + msgBoxInfo)
        msgTitle = msgBoxTitle
        msgInfo = msgBoxInfo
        textTitle.text = msgTitle
        textInfo.text = msgInfo

        if(msgTitle === "錯誤"){
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


//    MouseArea{
//        anchors.fill: parent
//        onClicked: {
//            msgBox.visible = false
//        }
//    }

    Rectangle {
        id: rectAll
//        x: 40
//        y: 150
        x: parent.width / 8
        y: parent.height * 3 / 11
//        width: 240
//        height: 170
        width: parent.width * 3 / 4
        height: parent.height * 3.5 / 11
        color: "#ffffff"
        radius: parent.width / 320 * 25

        MouseArea{
            anchors.fill: parent
            onClicked: {
                msgBox.visible = true
            }
        }

        Rectangle {
            id: recTitleBottom
            x: 0
            y: recTitle.y + recTitle.height / 2
            width: recTitle.width
            height: recTitle.height / 2
            color: "#f96666"
            //orange
            //color: "#f9c066"
        }

        Rectangle {
            id: recTitle
            width: rectAll.width
            height: rectAll.height / 4
            //red
            color: "#f96666"
            //blue
            //color: "#57bfe7"
            //orange
            //color: "#f9c066"
            radius: parent.width / 320 * 25

            Text {
                id: textTitle
                width: parent.width
                height: parent.height
                text: qsTr("錯誤")
                font.bold: true
                font.pointSize: 23
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "#ffffff"
            }
        }

        Rectangle {
            id: recOKButton
//            x: 74
//            y: 120
            x: rectAll.width / 2 - recOKButton.width / 2
            y: rectAll.height * 0.68
//            width: 93
//            height: 34
            width: rectAll.width * 0.4
            height: rectAll.height * 0.2
            color: "#d9d8d8"
            radius: parent.width / 320 * 15

            Text {
                width: parent.width
                height: parent.height
                color: "#0c0c0c"
                text: qsTr("確認")
                font.pointSize: 20
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    msgBox.visible = false
                    startOtherActive()
                }
            }
        }


        Rectangle {
            id: rectangle4
//            x: 18
//            y: 54
            x: rectAll.width * 0.1
            y: rectAll.height * 0.3
            width: rectAll.width * 0.8
            height: rectAll.height * 0.3
            color: "#ffffff"

            Text {
                id: textInfo
                width: parent.width
                height: parent.height
                text: qsTr("message box")
                font.pointSize: 18
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }



    }




}
