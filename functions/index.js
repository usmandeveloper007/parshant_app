const {initializeApp} = require("firebase-admin/app");
const admin = require("firebase-admin");
const {onSchedule} = require("firebase-functions/v2/scheduler");
const {FieldValue} = require("firebase-admin/firestore");
const {onCall, HttpsError} = require("firebase-functions/v2/https");
initializeApp();


exports.faridabadUpdate = onSchedule("every day 17:30", async () => {
  await updateDocument("Faridabad");
});

exports.gaziyabadUpdate = onSchedule("every day 20:35", async () => {
  await updateDocument("Gaziyabad");
});

exports.GaliUpdate = onSchedule("every day 23:35", async () => {
  await updateDocument("Gali");
});

exports.DisawarUpdate = onSchedule("every day 04:00", async () => {
  await updateDocument("Disawar");
});

const updateDocument = async (docId) =>{
  try {
    const db = admin.firestore();
    await db.collection("gamesData").doc(docId).update({
      changeSystem: true,
      afterResult: true,
    });
    const changeCollection = db.collection("chnageGamesData"); // Pehli line
    const changeDocRef = changeCollection.doc("UpdateGamesData");
    const changeGamesDataDoc = await changeDocRef.get();

    if (changeGamesDataDoc.exists) {
      const isChange = changeGamesDataDoc.data().isChange;
      await changeDocRef.update({
        isChange: !isChange, // Toggle the value
      });
    } else {
      console.log("Document 'UpdateGamesData' does not exist");
    }
  } catch (error) {
    return null;
  }
};

exports.BetOpenUpdate = onSchedule("every day 11:00", async () => {
  await updateDocument2(); // Corrected function call
});

// Function to update documents
const updateDocument2 = async () => {
  const db = admin.firestore();
  const gamesData = db.collection("gamesData");
  const changeCollection = db.collection("chnageGamesData");
  const changeDocRef = changeCollection.doc("UpdateGamesData");
  try {
    const snapshot = await gamesData.where("afterResult", "==", true).get();
    // Fetch the changeGamesData document
    const changeGamesDataDoc = await changeDocRef.get();
    // If no documents found, log and return
    if (snapshot.empty) {
      console.log("No documents found to update.");
      return;
    }
    // Batch update to set afterResults to false
    const batch = db.batch();
    snapshot.forEach((doc) => {
      batch.update(doc.ref, {afterResult: false});
    });
    // Commit the batch
    await batch.commit();
    console.log("Successfully updated documents.");
    // Toggle isChange field in changeGamesData document
    if (changeGamesDataDoc.exists) {
      const isChange = changeGamesDataDoc.data().isChange;
      await changeDocRef.update({
        isChange: !isChange, // Toggle the value
      });
    } else {
      console.log("Document 'UpdateGamesData' does not exist");
    }
  } catch (error) {
    console.error("Error updating documents:", error);
  }
};

// Schedule the function to run every day at midnight (00:00)
exports.MidnightUpdate = onSchedule("every day 00:00", async () => {
  await updateTimesAndToggleIsChange(); // Call the combined function
});

// Combined function to update times and toggle isChange
const updateTimesAndToggleIsChange = async () => {
  const db = admin.firestore();
  const gamesDataRef = db.collection("gamesData");
  const changeCollection = db.collection("chnageGamesData");
  const changeDocRef = changeCollection.doc("UpdateGamesData");

  try {
    // Fetch all documents from gamesData collection
    const snapshot = await gamesDataRef.get();

    // If no documents found, log and return
    if (snapshot.empty) {
      console.log("No documents found to update in gamesData.");
    } else {
      // Batch update to replace "Tommrow" with "Today"
      const batch = db.batch();
      snapshot.forEach((doc) => {
        const data = doc.data();

        // Function to replace "Tommrow" with "Today"
        const replace = (timeString) => {
          return timeString.replace("Tommrow", "Today");
        };

        // Update fields if they exist
        const updatedData = {};
        if (data["Bet Start Time"]) {
          updatedData["Bet Start Time"] = replace(data["Bet Start Time"]);
        }
        if (data["Bet Close Time"]) {
          updatedData["Bet Close Time"] = replace(data["Bet Close Time"]);
        }
        if (data["Result Time"]) {
          updatedData["Result Time"] = replace(data["Result Time"]);
        }

        // Add update to batch
        if (Object.keys(updatedData).length > 0) {
          batch.update(doc.ref, updatedData);
        }
      });

      // Commit the batch
      await batch.commit();
      console.log("Successfully updated gamesData documents.");
    }

    // Fetch the changeGamesData document
    const changeGamesDataDoc = await changeDocRef.get();

    // Toggle isChange field in changeGamesData document
    if (changeGamesDataDoc.exists) {
      const isChange = changeGamesDataDoc.data().isChange;
      await changeDocRef.update({
        isChange: !isChange, // Toggle the value
      });
      console.log("Successfully toggled changeGamesData.");
    } else {
      console.log("Document 'UpdateGamesData' not exist in changeGamesData.");
    }
  } catch (error) {
    console.error("Error updating documents:", error);
  }
};

// ✅ Place Bet Function
exports.placeBet = onCall(async (request) => {
  const db = admin.firestore();
  const {userId, gameName, totalAmount, numbers, date} = request.data;

  if (!userId || !gameName || !totalAmount || !numbers || !date) {
    throw new HttpsError("invalid-argument", "Missing required fields.");
  }

  const userRef = db.collection("users").doc(userId);
  const balanceRef = userRef.collection("User_totalBalance").doc("balance");

  const gameRef = db.collection("gamesData").doc(gameName);

  return db.runTransaction(async (transaction) => {
    // ✅ 1. Check user balance
    const balanceSnap = await transaction.get(balanceRef);
    if (!balanceSnap.exists) {
      throw new HttpsError("not-found", "User balance not found.");
    }

    const currentBalance = balanceSnap.data().total_balanceValue;
    if (currentBalance < totalAmount) {
      throw new HttpsError("failed-precondition", "Insufficient balance.");
    }

    // ✅ 2. Check if betting is allowed
    const gameSnap = await transaction.get(gameRef);
    if (!gameSnap.exists || gameSnap.data().afterResult === true) {
      throw new HttpsError("failed-precondition", "Betting closed.");
    }

    // ✅ 3. Ensure only one bet is placed at a time
    const activeBetRef = db.collection("activeBets").doc(userId);
    const activeBetSnap = await transaction.get(activeBetRef);
    if (activeBetSnap.exists) {
      throw new HttpsError("already-exists", "A bet is in progress.");
    }

    // ✅ 4. Lock bet for 15s
    transaction.set(activeBetRef, {
      status: "pending",
      expiresAt: Date.now() + 15000,
    });

    // ✅ 5. Place the bet
    const betRef = userRef.collection("myBets").doc();
    transaction.set(betRef, {
      gameName,
      totalAmount,
      numbers,
      date,
      status: "pending", // Add status field
      betDate: FieldValue.serverTimestamp(), // Add server timestamp
    });

    // ✅ 6. Deduct balance
    transaction.update(balanceRef, {
      total_balanceValue: currentBalance - totalAmount,
    });

    // ✅ 7. Unlock the bet after 15s
    setTimeout(async () => {
      await db.collection("activeBets").doc(userId).delete();
    }, 15000);

    return {success: true, message: "Bet placed successfully!"};
  });
});

exports.getServerTime = onCall(async (request) => {
  const serverTime = new Date();
  return {
    serverTime: serverTime.toISOString(),
  };
});

