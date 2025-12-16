const functions = require("firebase-functions/v2");
const admin = require("firebase-admin");
admin.initializeApp();

// ----------------------------
// Firestore trigger (new service)
// ----------------------------
exports.notifyNewService = functions.firestore.onDocumentCreated(
    "services/{serviceId}",
    async (event) => {
      const data = event.data;
      const serviceName = data.name || "New Service";
      try {
        await admin.messaging().send({
          topic: "services_updates",
          notification: {
            title: "New Service Added!",
            body: `${serviceName} is now available`,
          },
          data: {serviceId: event.id},
        });
        console.log("Notification sent for new service:", serviceName);
      } catch (error) {
        console.error("Error sending notification:", error);
      }
    },
);

// ----------------------------
// Notify a topic via HTTPS callable
// ----------------------------
exports.notifyTopic = functions.https.onCall(async (req) => {
  const {topic, title, body, data} = req.data;

  try {
    await admin.messaging().send({
      topic,
      notification: {title, body},
      data: data || {},
    });
    return {success: true};
  } catch (error) {
    console.error("Error sending topic notification:", error);
    return {success: false, error: error.message};
  }
});

// ----------------------------
// Notify a specific user (all device tokens)
// ----------------------------
exports.notifyUser = functions.https.onCall(async (req) => {
  const {userId, title, body, data} = req.data;

  try {
    const tokensSnap = await admin
        .firestore()
        .collection("users")
        .doc(userId)
        .collection("tokens")
        .get();

    const tokens = tokensSnap.docs.map((d) => d.id);
    if (tokens.length === 0) return {success: false, message: "No tokens"};

    await admin.messaging().sendEachForMulticast({
      tokens,
      notification: {title, body},
      data: data || {},
    });

    return {success: true};
  } catch (error) {
    console.error("Error sending user notification:", error);
    return {success: false, error: error.message};
  }
});
