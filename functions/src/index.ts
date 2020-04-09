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

      //const newValue = snap.data();

      console.log('Message received');

     const payload = {
                      notification: {
                        "title": "",
                        "body": "Check Choice of the day.",
                      }
                    };

      return admin.messaging().sendToTopic("News",payload)
          .then(function(response){
               console.log('Notification sent successfully:',response);
          })
          .catch(function(error){
               console.log('Notification sent failed:',error);
          });
    });

