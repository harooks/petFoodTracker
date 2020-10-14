const functions = require('firebase-functions');

const admin = require('firebase-admin');
admin.initializeApp();

exports.sendNotificationToTopic = functions.firestore.document('users/{uid}/{didFeedPet}').onWrite(async (change, context) => {

    const newValue = snapshot.data()
    const data = change.after.data();
    //const previousData = change.before.data();

         // uidから通知先のユーザー情報を取得
        const userRef = await admin
        .firestore()
        .collection("users")
        .doc(context.params.userId);
      const userDoc = await userRef.get();

if (userDoc.exists) {
const user = userDoc.data();
const message = {
    notification: {
        title: "ごはんありがとう",
        body: "ペットにごはんが与えられました"
    }
};
      /// プッシュ通知を送信
      if (user.fcmToken) {
        admin.messaging().sendToDevice(user.fcmToken, message);
      } else {
        console.error("No Firebase Cloud Messaging Token.");
      }
    } else {
        console.error("No User.");
      }
      
      return true;

});



