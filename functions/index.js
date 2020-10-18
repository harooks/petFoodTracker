const functions = require('firebase-functions');

const admin = require('firebase-admin');
admin.initializeApp();

exports.sendNotificationToTopic = functions.firestore.document('users/{userId}').onUpdate(async (change, context) => {

    const previousData = change.before.data();
    const data = change.after.data();

    ///if (userDoc.exists) {
        const user = userDoc.data();
        const message = {
            notification: {
                title: "ごはんありがとう",
                body: "ペットにごはんが与えられました"
            }
        };

        /// Field "didFeedPet" が false から true になった時をトリガーとする
        if (data.didFeedPet === 1 && previousData.didFeedPet === 0) {
            /// プッシュ通知を送信
            if (user.fcmToken) {
                admin.messaging().sendToDevice(user.fcmToken, message);
            } else {
                console.error("No Firebase Cloud Messaging Token.");
            }
      ///  } else {
     ///       console.error("No User.");
      ///  }
      
     ///   return true;
    }
});



