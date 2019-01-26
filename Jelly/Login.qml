import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import com.company.client 1.0

Rectangle {
    width: parent.width
    height: parent.height

    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#ffedf6"
        }

        GradientStop {
            position: 0.517
            color: "#ffa5dc"
        }

        GradientStop {
            position: 1
            color: "#f58181"
        }

    }

    Rectangle {
        id: rectangle_all
//        x: 40
//        y: 75
        x: parent.width / 8
        y: parent.height / 8
//        width: 240
//        height: 300
        width: rectangle_all.x * 6
        height: parent.height / 8 * 5 - userImage.height / 2
        color: "#99ffffff"
        radius: parent.width / 320 * 30
        border.color: "#dacfec"
        border.width: 3

        TextField {
            id: textFieldAccount
//            x: 23
//            y: 61
            x: parent.width / 11
            y: parent.height / 5
//            width: 195
//            height: 35
            width: textFieldAccount.x * 9
            height: parent.height / 8.8
            text: qsTr("")
            font.pointSize: 15
            placeholderText: "請輸入帳號"
        }

        TextField {
            id: textFieldPassword
//            x: 23
//            y: 123
            x: textFieldAccount.x
            y: textFieldAccount.y + textFieldAccount.height * 1.7
//            width: 195
//            height: 35
            width: textFieldAccount.width
            height: textFieldAccount.height
            text: qsTr("")
            font.pointSize: 15
            placeholderText: "請輸入密碼"
        }

        Rectangle {
            id: rectangle_signup
//            x: 23
//            y: 215
            x: (parent.width / 2 - parent.height / 8) / 3
            y: textFieldPassword.y + textFieldPassword.height + parent.height / 4
//            width: 90
//            height: 40
            width: parent.width / 3
            height: parent.height / 8
            color: "#f3ecec"
            radius: parent.width / 320 * 20
            border.color: "#d3c3c3"
            border.width: 2

            Text {
                width: parent.width
                height: parent.height
                color: "#313131"
                text: qsTr("註冊")
                font.pointSize: 15
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("點選註冊")
                    client.button_Signup_clicked(textFieldAccount.text, textFieldPassword.text, userImage.source)
                }
            }
        }

        Rectangle {
            id: rectangle_login
//            x: 128
//            y: 215
            x: parent.width - rectangle_signup.x - rectangle_signup.width
            y: rectangle_signup.y
//            width: 90
//            height: 40
            width: rectangle_signup.width
            height: rectangle_signup.height
            color: "#f3ecec"
            radius: parent.width / 320 * 20
            border.color: "#d3c3c3"
            border.width: 2

            Text {
                width: parent.width
                height: parent.height
                color: "#313131"
                text: qsTr("登入")
                font.pointSize: 15
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("點選登入")
                    client.button_Login_clicked(textFieldAccount.text, textFieldPassword.text)
                }
            }
        }
    }

    Rectangle {
        id: rectangle1
//        x: 110
//        y: 31
        x: rectangle_all.x + rectangle_all.width / 2 - rectangle_all.width / 5
        y: rectangle_all.y - rectangle_all.width / 5
//        width: 100
//        height: 100
        width: rectangle_all.width / 5 * 2
        height: rectangle_all.width / 5 * 2
        color: "#00ffffff"
        radius: 15

        Image {
            id: userImage
            width: parent.width
            height: parent.height
            source: "Jelly.png"
        }

        //AnimatedImage { id: animation; source: "bell.gif"; width: 150; height: 100}
    }



}
