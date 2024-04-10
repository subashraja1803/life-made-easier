importScripts("https://www.gstatic.com/firebasejs/8.4.3/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.20.0/firebase-messaging.js");
firebase.initializeApp({
    apiKey: "AIzaSyBxwnzjlG3kAIXtLwOm3OY3mADoaM27YNw",
    authDomain: "lifemadeeasier-4cf1d.firebaseapp.com",
    projectId: "lifemadeeasier-4cf1d",
    storageBucket: "lifemadeeasier-4cf1d.appspot.com",
    messagingSenderId: "379102261052",
    appId: "1:379102261052:web:253b6b6ce722ce30aa3839",
    measurementId: "G-VYLJ1Y5TKW"
});
const messaging = firebase.messaging();
// messaging.setBackgroundMessageHandler(function (payload) {
//     const promiseChain = clients
//         .matchAll({
//             type: "window",
//             includeUncontrolled: true
//         })
//         .then(windowClients => {
//             for (let i = 0; i < windowClients.length; i++) {
//                 const windowClient = windowClients[i];
//                 windowClient.postMessage(payload);
//             }
//         })
//         .then(() => {
//             return registration.showNotification("New Message");
//         });
//     return promiseChain;
// });
// self.addEventListener('notificationclick', function (event) {
//     console.log('notification received: ', event)
// });