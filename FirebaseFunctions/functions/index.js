const functions = require('firebase-functions');

const admin = require('firebase-admin');
admin.initializeApp();

exports.sendNotificationToTopic = functions.firestore.document('users/{userId}').onUpdate(async (change, context) => {

    const previousData = change.before.data();
    const data = change.after.data();

    ///if (userDoc.exists) {
    const user = userDoc.data();
    
    ///breakfast notification
        const message1 = {
            notification: {
                title: "ごはんありがとう",
                body: "ペットに朝ごはんが与えられました"
            }
        };
    ///dinner notification
        const message2 = {
            notification: {
                title: "ごはんありがとう",
                body: "ペットに夜ごはんが与えられました"
            }
        };

        /// Field "didGiveBreakfast" が false から true になった時をトリガーとする
        if (data.didGiveBreakfast === 1 && previousData.didGiveBreakfast === 0) {
            /// プッシュ通知を送信
            if (user.fcmToken) {
                admin.messaging().sendToDevice(user.fcmToken, message1);
            } else {
                console.error("No Firebase Cloud Messaging Token.");
            }
        }
        /// Field "Dinner" が false から true になった時をトリガーとする
        if (data.didgiveDinner === 1 && previousData.didgiveDinner === 0) {
            /// プッシュ通知を送信
            if (user.fcmToken) {
                admin.messaging().sendToDevice(user.fcmToken, message2);
            } else {
                console.error("No Firebase Cloud Messaging Token.");
            }
        }
    
});



