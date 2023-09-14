const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();

exports.checkAndProcess = functions.pubsub.schedule('0 4 * * * *').timeZone('Africa/Casablanca').onRun(async (context) => {
  try {
    // Step 1: Query the 'settings' collection for the first document
    const settingsSnapshot = await db.collection('settings').limit(1).get();
    if (!settingsSnapshot.empty) {
      const settingsDoc = settingsSnapshot.docs[0].data();
      const phaseSwitchDate = settingsDoc.phase_switch.toDate();

      // Step 2: Check if the current date reaches the 'phase_switch' date
      if (new Date() >= phaseSwitchDate) {
        const natVoteQte = settingsDoc.nat_vote_qte;

        // Step 3: Query 'propositions' collection for documents with 'status' equal to "1"
        const propositionsSnapshot = await db.collection('propositions').where('status', '==', '1').get();

        // Step 4: Group and rank documents by the given calculation (upVotes - downVotes)
        const rankedPropositions = propositionsSnapshot.docs.map((doc) => {
          const data = doc.data();
          const score = data.upVotes - data.downVotes;
          return { id: doc.id, data, score };
        });

        rankedPropositions.sort((a, b) => b.score - a.score);

        // Step 5: Update status for the top 'natVoteQte' documents to "8"
        const topPropositions = rankedPropositions.slice(0, natVoteQte);

        const batch = db.batch();
        topPropositions.forEach((prop) => {
          const ref = db.collection('propositions').doc(prop.id);
          batch.update(ref, { status: '8' });
        });

        await batch.commit();

        return `Processed ${topPropositions.length} propositions.`;
      } else {
        return 'Current date has not reached phase_switch date.';
      }
    } else {
      return 'No documents found in the settings collection.';
    }
  } catch (error) {
    console.error('Error:', error);
    return 'An error occurred.';
  }
});
