import 'package:edupulse/models/proposition.dart';
import 'package:edupulse/models/vote.dart';
import 'package:edupulse/screens/propositions/proposition_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VoteCard extends StatefulWidget {
  Vote vote;
  Icon upVote = Icon(Icons.thumb_up,size: 50,color: Colors.green.shade600,);
  Icon downVote = Icon(Icons.thumb_down, size: 50, color: Colors.red.shade600,);
  VoteCard({
    required this.vote,
      });


  @override
  State<VoteCard> createState() => _VoteCardState();
}

class _VoteCardState extends State<VoteCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async{
        Proposition proposition = await Proposition.getPropositionById(widget.vote.propositionId);
        Navigator.push(
          context,
          MaterialPageRoute(

            builder: (context) => PropositionScreen(proposition: proposition),
          ),
        );
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: widget.vote.vote == 1 ? widget.upVote : widget.downVote,
            ),
            Padding(
              padding: EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.vote.propositionTitle,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'helvetica',
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text("Votée le: ${DateFormat("dd/MM/yyyy").format(widget.vote.date.toDate())}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
