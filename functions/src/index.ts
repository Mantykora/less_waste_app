// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

// The Cloud Functions for Firebase SDK to create Cloud Functions and setup triggers.
const functions = require('firebase-functions');

// The Firebase Admin SDK to access the Firebase Realtime Database.
const admin = require('firebase-admin');
admin.initializeApp();




export const createPo = functions.firestore.document('posts/{id}')
      .onCreate((snap) => {

      var categories:string[] = ["Żywność", "Środki czystości", "Uroda", "Ubrania", "Inne"];

      const newValue = snap.data();


      console.log('Message received');

     console.log(newValue);

     var data = JSON.parse(JSON.stringify(newValue));


    var category = data.category.toString();
    var body = data.body;

     const payload = {
                      notification: {
                        "title": categories[category],
                        "body": body,
                        "click_action": "FLUTTER_NOTIFICATION_CLICK"
                      },
                      "data": {
                         //"data": "datahehe"
                         "userId": data.userId,
                          "body": body,
                         "id": data.id,
                         "category": category,
                         "count": data.count.toString(),
                         "likesCount": data.likesCount.toString(),
                         "timeStamp": data.timeStamp.toString(),
                         "isEdited": data.isEdited.toString()
                       },
                    };
      return admin.messaging().sendToTopic("News",payload)
          .then(function(response){
               console.log('Notification sent successfully:',response);
          })
          .catch(function(error){
               console.log('Notification sent failed:',error);
          });
    });

