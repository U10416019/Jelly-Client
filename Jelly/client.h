#ifndef CLIENT_H
#define CLIENT_H

#include <QObject>
#include <QDebug>
#include <QTcpSocket>
#include "qstring.h"
//#include "sqlite3.h"
#include <QGuiApplication>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlQueryModel>
#include <QSqlError>

class Client : public QObject
{
    Q_OBJECT

public:
    explicit Client(QObject *parent = nullptr);

signals:
    //c++ call qml
    void changeMainPage();
    void callMessageBox(QString msgBoxTitle, QString msgBoxInfo);
    void userInfo(QString user_id, QString user_name, QString user_image);
    void loadMainUnreadMsg(QString sender, QString sender_id, QString sender_image, QString user_id, QString room_id, QString send_time, int type , QString message, QString determine);
    void loadFriendInfo(QString friend_id, QString friend_name, QString friend_image);
    void loadAddFriendInfo(QString friend_id, QString friend_name, QString friend_image);
    void showSearchFriendName(QString friend_id, QString friend_name);
    void getChatRoomID(QString room_id);
    void roomNewUserMsg(QString sender_image, QString sender_id, QString sender, QString friend_message, QString send_time, QString read_type, QString user_message, QString type);
    void loadRoomUserMsg(QString sender_image, QString sender_id, QString sender, QString friend_message, QString send_time, QString read_type, QString user_message, QString type);
    void loadRoomFriendMsg(QString sender_image, QString sender_id, QString sender, QString friend_message, QString send_time, QString read_type, QString user_message, QString type, QString room_id);
    void loadRoomListInfo(QString room_id, QString last_sender_id, QString last_sender_name, QString room_name, QString room_image, QString lastMessage, QString lastSendTime, QString lastTimeFormat, int lastType, int unread_count, QString friend_id, QString friend_name);
    void reloadChatRoomMsg();
    void loadMainNote(QString friend_id, QString friend_name, QString friend_image, QString message);
    void loadUserNote(QString friend_id, QString friend_name, QString friend_image, QString message);

public slots:
    //qml call c++
    void socket_ReadData();
    void button_Signup_clicked(QString account, QString password, QString image);
    void button_Login_clicked(QString account, QString password);
    void button_SearchFriend_clicked(QString friend_name);
    void button_AddFriend_clicked();
    void refreshFriendList();
    void button_ConfirmFriend_clicked(QString newFriendID, QString user_id);
    void button_FriendChat_clicked(QString friend_name, QString friend_id, QString user_name, QString user_id);
    void button_SendMessage_clicked(QString room_id, QString friend_id, QString friend_name, QString user_id, QString user_name, QString message);
    void button_AddMessageToNote_clicked(QString room_id, QString friend_id, QString friend_name, QString user_id, QString user_name, QString message);
    void button_DeleteNoteMessage_clicked(QString friend_id, QString friend_name, QString user_id, QString user_name, QString message);
    //void getQueueMessage();
    void responseMessage(QString room_id, QString sender_id, QString send_time, QString type, QString message);
    void loadQueue(QString user_id);
    void loadRoomMessage(QString room_id, QString user_id);
    void loadRoom(QString user_id);
    void loadNote(QString user_id);
    void loadFriendNote(QString user_id, QString room_id);
    void changFriendMsgType(QString room_id, QString friend_id);
    void closeAPP();

private:
    void connectSocket();
    void loadFriend(QString user_id);
    void loadAddFriend(QString user_id);

private:
    QTcpSocket *socket;
    QString IP = "163.21.245.147";
    int port = 6666;
    QSqlDatabase db;
    //QSqlQueryModel model;

    QString userID;
    QString userName;
    QString userShowName;
    QString userImage;
    QString friendID;
    QString friendName;
    QString friendShowName;
    QString friendImage;
    QString roomID;
    QString roomName;
};

#endif // CLIENT_H
