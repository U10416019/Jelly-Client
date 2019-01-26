#include "client.h"
#include "qdatetime.h"
#include <QQmlApplicationEngine>
#include <QQmlComponent>
#include <QGuiApplication>

Client::Client(QObject *parent) : QObject(parent)
{
    socket = new QTcpSocket();
    QObject::connect(socket, &QTcpSocket::readyRead, this, &Client::socket_ReadData);

    connectSocket();
}

void Client::connectSocket()
{
        //cancel the connection
        socket->abort();
        //connect to the server
        socket->connectToHost(IP, port);

        //waiting for the connection
        if(socket->waitForConnected(3000)){
            qDebug() << "Connected!!!";
        }
        else{
            qDebug() << "Connection failed...";
            emit callMessageBox("錯誤", "連線錯誤，請確認網路連線");
            //return;
        }
}

void Client::button_Login_clicked(QString account, QString password)
{
    if(account == "" && password == ""){
        emit callMessageBox("警告", "請輸入帳號及密碼");
    }
    else if(account == ""){
        emit callMessageBox("警告", "請輸入帳號");
    }
    else if(password == ""){
        emit callMessageBox("警告", "請輸入密碼");
    }
    else{
        QString sendToServer = "USERPASS$" + account + "$" + password + "\n";
        socket->write(sendToServer.toUtf8());
        qDebug() << "Check Account... " + account + ", " + password;
        socket->flush();
    }
}

void Client::button_Signup_clicked(QString account, QString password, QString image)
{
    if(account == "" && password == ""){
        emit callMessageBox("警告", "請輸入帳號及密碼");
    }
    else if(account == ""){
        emit callMessageBox("警告", "請輸入帳號");
    }
    else if(password == ""){
        emit callMessageBox("警告", "請輸入密碼");
    }
    else{
        QString id = QDateTime::currentDateTime().toString("yyyyMMddhhmmssssss");
        userID = id;
        userName = account;
        userShowName = userName;
        userImage = image;

        QString sendToServer = "SIGNUP$" + id + "$" + userName + "$" + password + "$" + image + "\n";
        socket->write(sendToServer.toUtf8());
        qDebug() << "Create Account... " + id + ", " + userName + ", " + password + ", " + image;
        socket->flush();
    }
}

void Client::button_SearchFriend_clicked(QString friend_name){
    if(friend_name != ""){
        friendName = friend_name;

        QString sendtoServerMsg = "SEARCHFRIEND$" + userID + "$" + friendName + "\n";
        socket->write(sendtoServerMsg.toUtf8());
        socket->flush();
    }
    else{
        emit callMessageBox("警告", "請輸入好友帳號名稱");
    }

}

void Client::button_AddFriend_clicked(){
    //add friend
    QString sendtoServerMsg = "ADDFRIEND$" + userID + "$" + userName + "$" + friendID + "\n";
    socket->write(sendtoServerMsg.toUtf8());
    socket->flush();

    //add the new friend to friend list
    //emit loadFriendInfo(QString::number(friendID), friendName);
    emit callMessageBox("通知", "已發送好友訊息");
}

void Client::button_ConfirmFriend_clicked(QString newFriendID, QString user_id){
    friendID = newFriendID;
    userID = user_id;
    QString sendtoServerMsg = "CONFIRMFRIEND$" + friendID + "$" + userID + "\n";
    socket->write(sendtoServerMsg.toUtf8());
    socket->flush();
}

void Client::button_FriendChat_clicked(QString friend_name, QString friend_id, QString user_name, QString user_id){
    //create new room
    roomID = QDateTime::currentDateTime().toString("yyyyMMddhhmmssssss");
    roomName = friend_name;
    QString sendtoServerMessage = "NEWROOM$" + roomID + "$" + roomName + "$" + friend_id + "$" + user_name + "$" + user_id + "$0$0\n";
    socket->write(sendtoServerMessage.toUtf8());
    socket->flush();
}

void Client::button_SendMessage_clicked(QString room_id, QString friend_id, QString friend_name, QString user_id, QString user_name, QString message){
    roomID = room_id;
    friendID = friend_id;
    friendName = friend_name;
    userID = user_id;
    userName = user_name;
    if(message == NULL || message == ""){
        return;
    }

    bool isGroup = false;
    //check whether this room id is group
    //if group == true, 顯示的label會不同
    qDebug() << "roomID: " + roomID + "  friendID: " + friendID + "  friendName: "+ friendName + "  userID: " + userID + "  userName: " + userName + "  message: " + message;

    QString sendtoServerMessage = "MESSAGE$" + roomID + "$" + friendID + "$" + friendName + "$" + userID + "$" + userName + "$" + message + "\n";
    socket->write(sendtoServerMessage.toUtf8());
    socket->flush();
}

void Client::button_AddMessageToNote_clicked(QString room_id, QString friend_id, QString friend_name, QString user_id, QString user_name, QString message){
    QString sendtoServerMessage = "ADDNOTE$" + room_id + "$" + friend_id + "$" + friend_name + "$" + user_id + "$" + user_name + "$" + message + "\n";
    qDebug() << sendtoServerMessage;
    socket->write(sendtoServerMessage.toUtf8());
    socket->flush();
}

void Client::button_DeleteNoteMessage_clicked(QString friend_id, QString friend_name, QString user_id, QString user_name, QString message){
    //忘記加room_id & send_time惹ＱＡＱ
    QString sendtoServerMessage = "DELETENOTE$" + friend_id + "$" + friend_name + "$" + user_id + "$" + user_name + "$" + message + "\n";
    qDebug() << sendtoServerMessage;
    socket->write(sendtoServerMessage.toUtf8());
    socket->flush();
}


void Client::socket_ReadData(){
    qDebug() << "in read data";
    QString buffer;
    buffer = socket->readAll();
    QString str;
    str = buffer.section('$', 0, 0);

    if(str == "SIGNUP"){
        qDebug() << "in signup";
        str = buffer.section('$', 1, 1);
        if(str == "finish"){
            //jump to main window
//            str = buffer.section('$', 2, 2);
//            userID = str.toLong();
//            str = buffer.section('$', 3, 3);
//            userName = str;
//            str = buffer.section('$', 4, 4);
//            userImage = str;
            qDebug() << "userID: " + userID + "  userName: " + userName + "  userImage: " + userImage;

            qDebug() << "signup : change page to main";
            emit userInfo(userID, userName, userImage);
            emit callMessageBox("通知", "已註冊成功，自動跳轉到主頁面");
            emit changeMainPage();

            socket->write("LOGIN\n");
            socket->flush();
        }
        else if(str == "sameAccount\n"){
            qDebug() << "signup : same account";
            emit callMessageBox("通知", "此帳號已註冊\n請重新輸入一個新的帳號");
        }
        else if(str == "error\n"){
            qDebug() << "signup : signup error";
            emit callMessageBox("錯誤", "註冊錯誤，請重新再註冊一次");
        }
    }
    else if(str == "LOGIN"){
        str = buffer.section('$', 1, 1);
        if(str == "noExist\n"){
            qDebug() << "login : Error, The Account is not exist !";
            emit callMessageBox("錯誤", "無此帳號，請重新再輸入一次");
        }
        else if(str == "incorrect\n"){
            qDebug() << "login : Error, Password incorrect !";
            emit callMessageBox("錯誤", "密碼錯誤，請重新再輸入一次");
        }
        else if(str == "correct"){
            str = buffer.section('$', 2, 2);
            userID = str;
            QString id = str;
            str = buffer.section('$', 3, 3);
            userName = str;
            str = buffer.section('$', 4, 4);
            userShowName = str;
            str = buffer.section('$', 5, 5);
            userImage = str;
            //setUserID(userID);
            //setUserName(userName);
            //setUserShowName(userShowName);

            qDebug() << "userID: " + id + "  userName: " + userName + "  userShowName: " + userShowName + "  userImage: " + userImage;
            emit userInfo(id, userName, userImage);
            //loadAddFriend(userID);
            //loadFriend(userID);
            //loadRoom(userID);
            loadNote(userID);
            loadQueue(userID);

            qDebug() << "login : change page to main";
            emit changeMainPage();

            socket->write("LOGIN\n");
            socket->flush();
        }
    }
    else if(str == "LOADFRIEND"){
        qDebug() << "in load friend";
        int i = 1;
        int count = 0;
        str = buffer.section('$', 1, 1);

        while(str != ""){
            //get friend id and showname
            count++;
            friendID = str;
            i++;
            str = buffer.section('$', i, i);
            friendShowName = str;
            i++;
            str = buffer.section('$', i, i);
            friendImage = "Jelly.png";
            i++;
            str = buffer.section('$', i, i);

            emit loadFriendInfo(friendID, friendShowName, friendImage);
            //addFriendList(friendID, friendName, count, group);
        }
    }
    else if(str == "LOADADDFRIEND"){
        qDebug() << "in load add friend";
        //emit  userInfo(QString::number(userID), userName, userImage);
        int i = 1;
        int count = 0;
        str = buffer.section('$', 1, 1);

        while(str != ""){
            //get friend in and showname
            count++;
            friendID = str;
            i++;
            str = buffer.section('$', i, i);
            friendShowName = str;
            i++;
            str = buffer.section('$', i, i);
            friendImage = str;
            i++;
            str = buffer.section('$', i, i);

            qDebug() << "friendID: " + friendID + "  friendShowName: " + friendShowName + "  friend Image: " + friendImage;
            emit loadAddFriendInfo(friendID, friendShowName, friendImage);
            //addFriendList(friendID, friendName, count, group);
        }
    }
    else if(str == "LOADROOM"){
        qDebug() << "in load room";
        //emit  userInfo(QString::number(userID), userName);
        int i = 1;
        int count = 0;
        int isgroup = 0;
        str = buffer.section('$', 1, 1);

        while(str != ""){
            //get friend in and showname
            //count++;
            //_room_id, _friend_id, _friend_name, _room_image, _last_message, _last_send_time, _unread_msg_count
            //roomID + lastSenderID + lastSenderName + roomName + roomImage + lastRecord + lastSendTime + "  lastTimeFormat: " + lastType + unreadCount
            QString room_id = str;
            i++;
            str = buffer.section('$', i, i);
            QString lastSenderID = str;
            i++;
            str = buffer.section('$', i, i);
            QString lastSenderName = str;
            i++;
            str = buffer.section('$', i, i);
            QString room_name = str;
            i++;
            str = buffer.section('$', i, i);
            QString room_image = str;
            i++;
            str = buffer.section('$', i, i);
            QString lastMessage = str;
            i++;
            str = buffer.section('$', i, i);
            QString lastSendTime = str;
            i++;
            str = buffer.section('$', i, i);
            QString lastTimeFormat = str;
            i++;
            str = buffer.section('$', i, i);
            int lastType = str.toInt();
            i++;
            str = buffer.section('$', i, i);
            int unreadCount = str.toInt();
            i++;
            str = buffer.section('$', i, i);
            QString friend_id = str;
            i++;
            str = buffer.section('$', i, i);
            QString friend_name = str;
            i++;
            str = buffer.section('$', i, i);
/*            count = str.toInt();
            i++;
            str = buffer.section('$', i, i);
            isgroup = str.toInt();
            i++;
            str = buffer.section('$', i, i);*/

            if(room_id == 0){
                break;
            }
            else{
                qDebug() << "Send Last Message =>  room_id: " + room_id + "  lastSenderID: " + lastSenderID + "  lastSenderName: " + lastSenderName + "  roomName: " + room_name + "  roomImage: " + room_image + "  lastMessage: " + lastMessage + "  lastSendTime: " + lastSendTime + "  lastTimeFormat: " + lastTimeFormat + "  lastType: " + QString::number(lastType) + "  unreadCount: " + QString::number(unreadCount) + "  friend_id: " + friend_id + "  friend_name: " + friend_name;
                emit loadRoomListInfo(room_id, lastSenderID, lastSenderName, room_name, room_image, lastMessage, lastSendTime, lastTimeFormat, lastType, unreadCount, friend_id, friend_name);
                //addFriendList(friendID, friendName, count, group);
            }
        }

    }
    else if(str == "SEARCHFRIEND"){
        str = buffer.section('$', 1, 1);
        if(str == "NOTEXIST\n"){
            //the account is not exist
            qDebug() << "login : Error, The Account is not exist !";
            emit callMessageBox("錯誤", "無此帳號，請重新再輸入一次");
        }
        else if(str == "SELF"){
            //third token
            //get friend name (search myself)
            qDebug() << "login : Error, 搜尋的帳號為自己！";
            emit callMessageBox("警告", "搜尋的帳號為自己！");
        }
        else if(str == "HAVE"){
            //third token
            //get friend name (is already friend)
            qDebug() << "login : Error, 已為朋友！";
            emit callMessageBox("通知", "已為朋友！");
        }
        else if(str == "NEW"){
            str = buffer.section('$', 2, 2);
            friendID = str;
            str = buffer.section('$', 3, 3);
            friendName = str;

            emit showSearchFriendName(friendID, friendName);
        }
    }
    else if(str == "GETROOMID"){
        qDebug() << "in getroomid";
        roomID = buffer.section('$', 1, 1);
        roomID = roomID.section('\n', 0, 0);
        qDebug() << "room id : " + roomID + "user id : " + userID;
        emit getChatRoomID(roomID);
        //QString sendtoServerMsg = "LOADRECORD$" + QString::number(userID) + "last";
//        QString sendtoServerMsg = "LOADROOMMESSAGE$" + QString::number(roomID) + "$" + QString::number(userID) + "\n";
//        socket->write(sendtoServerMsg.toUtf8());
//        socket->flush();
        loadRoomMessage(roomID, userID);
    }
    else if(str == "LOADROOMMESSAGE"){
        //替換"LOADRECORD"，"LOADRECORD"是到Server載入尚未載入本地端的資料
        //而"LOADROOMMESSAGE"則是直接從Server讀取同個room_id的所有資料，若要修改則要在"RESPONSE"&"MESSAGE"裡加上本地端的code
        qDebug() << "in load room message";
        int i = 1;
        //int count = 0;
        str = buffer.section('$', 1, 1);

        if(str == "RECORD"){
            i++;
            str = buffer.section('$', i, i);
            while(str != "QUEUE"){
                //get friend id and showname
                //count++;
                QString sender_id = str;
                i++;
                str = buffer.section('$', i, i);
                QString sender = str;
                i++;
                str = buffer.section('$', i, i);
                QString sender_image = str;
                i++;
                str = buffer.section('$', i, i);
                QString send_time = str;
                i++;
                int type = buffer.section('$', i, i).toInt();
                i++;
                str = buffer.section('$', i, i);
                QString message = str;
                i++;
                str = buffer.section('$', i, i);

                if(sender_id == 0){
                    qDebug() << "in load message record error";
                    break;
                }

                qDebug() << "RECORD ==> sender_id: " + sender_id + "  sender: " + sender + "  sender_image: " + sender_image + "  send time: " + send_time + "  type: " + QString::number(type) + "  message: " + message;
                if(sender_id == userID){
                    emit loadRoomUserMsg(sender_image, sender_id, sender, "", send_time, "已讀", message, QString::number(type));
                }
                else{
                    emit loadRoomFriendMsg(sender_image, sender_id, sender, message, send_time, "已讀", "", QString::number(type), roomID);
                }

                //emit loadFriendInfo(QString::number(friendID), friendShowName);
                //addFriendList(friendID, friendName, count, group);
            }
            if(str == "QUEUE"){
                i++;
                str = buffer.section('$', i, i);
                while(str != ""){
                    QString sender_id = str;
                    i++;
                    str = buffer.section('$', i, i);
                    QString sender = str;
                    i++;
                    str = buffer.section('$', i, i);
                    QString sender_image = str;
                    i++;
                    str = buffer.section('$', i, i);
                    QString send_time = str;
                    i++;
                    int type = buffer.section('$', i, i).toInt();
                    i++;
                    str = buffer.section('$', i, i);
                    QString message = str;
                    i++;
                    str = buffer.section('$', i, i);

                    if(sender_id == 0){
                        qDebug() << "in load message queue error";
                        break;
                    }

                    qDebug() << "QUEUE ==> sender_id" + sender_id + "  sender:" + sender + "  sender_image:" + sender_image + "  send time: " + send_time + "  type: " + QString::number(type) + "  message: " + message;
                    if(sender_id == userID){
                        emit loadRoomUserMsg(sender_image, sender_id, sender, "", send_time, "", message, QString::number(type));
                    }
                    else{
                        emit loadRoomFriendMsg(sender_image, sender_id, sender, message, send_time, "", "", QString::number(type), roomID);
                    }


                    //emit loadFriendInfo(QString::number(friendID), friendShowName);
                    //addFriendList(friendID, friendName, count, group);
                }
            }
            else{
                qDebug() << "load room message queue error!";
            }
        }
        else{
            qDebug() << "load room message record error!";
        }
    }
    else if(str == "RESPONSE"){
        qDebug() << "in response";
        str = buffer.section('$', 1, 1);
        roomID = str;
        str = buffer.section('$', 2, 2);
        userID = str;
        str = buffer.section('$', 3, 3);
        userName = str;
        QString room_name = buffer.section('$', 4, 4);
        str = buffer.section('$', 5, 5);
        QString send_time = str;
        str = buffer.section('$', 6, 6);
        int type = str.toInt();
        str = buffer.section('$', 7, 7);
        QString message = str.section('\n', 0, 0);;
        qDebug() << "roomID: " + roomID + "  userID: " + userID + "  userName:" + userName + "  send time: " + send_time + "  type: " + QString::number(type) + "  message: " + message;


        emit roomNewUserMsg("", userID, userName, "", send_time, "", message, QString::number(type));
    }
    else if(str == "MESSAGE"){
        //會進入"MESSAGE"的只有剛開始載入時的QUEUE以及之後朋友傳訊息進來的RECORD
        qDebug() << "in message";
        int i = 1;

        QString sender = "";
        QString sender_id = "0";
        roomID = "0";
        QString send_time = "";
        QString timeFormat = "";
        int type = 0;
        QString str = "";
        QString determine = "";
        QString message = "";

        str = buffer.section('$', 1, 1);
        qDebug() << "buffer.section('$', 1, 1) = " + str;
        while(str != ""){
            sender = buffer.section('$', i, i).toUtf8();
            i++;
            sender_id = buffer.section('$', i, i);
            i++;
            friendImage = buffer.section('$', i, i).toUtf8();
            i++;
            roomID = buffer.section('$', i, i);
            i++;
            send_time = buffer.section('$', i, i);
            i++;
            timeFormat = buffer.section('$', i, i);
            i++;
            type = buffer.section('$', i, i).toInt();
            i++;
            str = buffer.section('$', i, i).toUtf8();
            i++;
            determine = buffer.section('$', i, i);
            i++;
            message = str.section('\n', 0, 0);

            qDebug() << message;
            qDebug() << "message information: sender=>" + sender + "  sender_id=>" + sender_id + "  sender_image=>" + friendImage + "  roomID=>" + roomID + "  send_time=>" + send_time + "  time_format=>" + timeFormat + "  type=>"+ QString::number(type) + "  message=>" + message + "  determine=>" + determine;
            //QString sendtoServerMsg = "RESPONSE$" + QString::number(roomID) + "$" + QString::number(sender_id) + "$" + QString::number(send_time) + "$" + QString::number(type) + "$" + message + "\n";
            //qDebug() << sendtoServerMsg;
            //socket->write(sendtoServerMsg.toUtf8());
            //socket->flush();

            if(determine == "RECORD\n"){
                //record代表好友和自己在線上，好友傳訊息給自己
                //先塞到loadRoomFriendMsg()裡改變UI，同時也使用loadMainUnreadMsg()改變主頁UI，再回傳給server讓此資料放入Queue
                //確認進入某個chatRoom後再傳訊息給server讓server把資料delete queue, insert record
                //最後要刷新主頁UI


                //sender(abc), sender_id, sendto(friendID), room_id, send_time, type, message
//                QString sendtoServerMsg = "INSERTQUEUE$" + sender + "$" + QString::number(sender_id) + "$" + QString::number(userID) + "$" + QString::number(roomID) + "$" + QString::number(send_time) + "$" + QString::number(type) + "$" + message + "\n";
//                qDebug() << sendtoServerMsg;
//                socket->write(sendtoServerMsg.toUtf8());
//                socket->flush();


                //當朋友在線上，且queue裡沒有資料
                determine = "newMessage";
                emit loadMainUnreadMsg(sender, sender_id, friendImage, userID, roomID, send_time, type, message, determine);
                emit loadRoomFriendMsg(friendImage, sender_id, sender, message, timeFormat, "", "", QString::number(type), roomID);

            }
            //當朋友在線上，但queue裡有資料
            else if(determine == "TEMPQUEUE\n"){
                determine = "tempQueueMessage";
                emit loadMainUnreadMsg(sender, sender_id, friendImage, userID, roomID, send_time, type, message, determine);
            }
            //server的handleQueue傳過來的資料
            else if(determine == "QUEUE" || determine == "QUEUE\n"){
                determine = "unreadMessage";
                emit loadMainUnreadMsg(sender, sender_id, friendImage, userID, roomID, send_time, type, message, determine);
            }

            str = buffer.section('$', i, i).toUtf8();
        }
    }
    else if(str == "CHANGEMSGTYPE"){
        qDebug() << "in change msg type";
        emit reloadChatRoomMsg();
    }
    else if(str == "ADDNOTE"){
        qDebug() << "in add note";
        str = buffer.section('$', 1, 1);
        if(str == "success"){
            qDebug() << "ADDNOTE : success";
            emit callMessageBox("通知", "已將此訊息加到記事本！");
        }
    }
    else if(str == "LOADNOTE"){
        qDebug() << "in load note";
        int i = 1;
        str = buffer.section('$', 1, 1);

        while(str != ""){
            QString friend_id = buffer.section('$', i, i).toUtf8();
            i++;
            QString friend_name = buffer.section('$', i, i).toUtf8();
            i++;
            QString friend_image = buffer.section('$', i, i).toUtf8();
            i++;
            QString message = buffer.section('$', i, i).toUtf8();
            i++;
            str = buffer.section('$', i, i).toUtf8();

            qDebug() << "loadNote information: friend_id=>" + friend_id + "  friend_name=>" + friend_name + "  friend_image=>" + friend_image + "  message=>" + message;
            emit loadMainNote(friend_id, friend_name, friend_image, message);
            emit loadUserNote(friend_id, friend_name, friend_image, message);
        }
    }
    else if(str == "LOADFRIENDNOTE"){
        qDebug() << "in load friend note";
        int i = 1;
        str = buffer.section('$', 1, 1);

        while(str != ""){
            QString friend_id = buffer.section('$', i, i).toUtf8();
            i++;
            QString friend_name = buffer.section('$', i, i).toUtf8();
            i++;
            QString friend_image = buffer.section('$', i, i).toUtf8();
            i++;
            QString message = buffer.section('$', i, i).toUtf8();
            i++;
            str = buffer.section('$', i, i).toUtf8();

            qDebug() << "loadNote information: friend_id=>" + friend_id + "  friend_name=>" + friend_name + "  friend_image=>" + friend_image + "  message=>" + message;
            emit loadUserNote(friend_id, friend_name, friend_image, message);
        }
    }
    else if(str =="DELETENOTE"){
        qDebug() << "in delete note";
        str = buffer.section('$', 1, 1);
        if(str == "success"){
            qDebug() << "DELETENOTE : success";
            emit callMessageBox("通知", "已將此訊息刪除");
        }
    }
}

void Client::loadFriend(QString user_id){
    friendID = "0";
    friendName = "";
    friendShowName = "";
    QString sendtoServerMsg = "LOADFRIEND$" + user_id + "\n";
    socket->write(sendtoServerMsg.toUtf8());
    socket->flush();
}

void Client::loadAddFriend(QString user_id){
    friendID = "0";
    friendName = "";
    friendShowName = "";
    friendImage = "";
    QString sendtoServerMsg = "LOADADDFRIEND$" + user_id + "\n";
    socket->write(sendtoServerMsg.toUtf8());
    socket->flush();
}

void Client::refreshFriendList(){
    loadAddFriend(userID);
    loadFriend(userID);
}

void Client::loadRoom(QString user_id){
    QString sendtoServerMsg = "LOADROOM$" + user_id + "\n";
    socket->write(sendtoServerMsg.toUtf8());
    socket->flush();
}

void Client::loadQueue(QString user_id){
    QString sendtoServerMsg = "LOADQUEUE$" + user_id + "\n";
    qDebug() << sendtoServerMsg;
    socket->write(sendtoServerMsg.toUtf8());
    socket->flush();
}

void Client::loadRoomMessage(QString room_id, QString user_id){
    QString sendtoServerMsg = "LOADROOMMESSAGE$" + room_id + "$" + user_id + "\n";
    qDebug() << sendtoServerMsg;
    socket->write(sendtoServerMsg.toUtf8());
    socket->flush();
}

void Client::loadNote(QString user_id){
    QString sendtoServerMsg = "LOADNOTE$" + user_id + "\n";
    qDebug() << sendtoServerMsg;
    socket->write(sendtoServerMsg.toUtf8());
    socket->flush();
}

void Client::loadFriendNote(QString user_id, QString room_id){
    QString sendtoServerMsg = "LOADFRIENDNOTE$" + user_id + "$" + room_id + "\n";
    qDebug() << sendtoServerMsg;
    socket->write(sendtoServerMsg.toUtf8());
    socket->flush();
}

void Client::responseMessage(QString room_id, QString sender_id, QString send_time, QString type, QString message){
    QString sendtoServerMsg = "RESPONSE$" + room_id + "$" + sender_id + "$" + send_time + "$" + type + "$" + message + "\n";
    qDebug() << sendtoServerMsg;
    socket->write(sendtoServerMsg.toUtf8());
    socket->flush();
}

void Client::changFriendMsgType(QString room_id, QString friend_id){
    QString sendtoServerMsg = "CHANGEMSGTYPE$" + room_id + "$" + friend_id + "\n";
    qDebug() << sendtoServerMsg;
    socket->write(sendtoServerMsg.toUtf8());
    socket->flush();
}

//void Client::getQueueMessage(){
//    QString sendtoServerMsg = "GETQUEUEMESSAGE$" + QString::number(userID) + "\n";
//    socket->write(sendtoServerMsg.toUtf8());
//    socket->flush();
//}

void Client::closeAPP()
{
    qDebug() << userName +" logout";
    socket->write("LOGOUT$");
    socket->flush();
}
