The Opening Weeks of your Project
=================================

When you start work on your project in May, things can feel fairly daunting -- so much to do, and
such a long time to get it done in -- but in fact most people find that the time passes very rapidly
and all too soon the deadline for submitting the thesis starts to feel very close. Usually the first
three or four weeks are spent "ramping up": reading any books or papers that are specific to the
project, gathering or generating the necessary data, assembling the various analytics tools that are
going to be used. One thing that it is very useful to do at the outset is to agree a project plan
with your supervisor, a statement of what you aim to achieve week-by-week, and/or what sequence of
"work-packages" your project will involve, i.e. what subtasks you will complete and when the
deadline for finishing each is; this should include an appropriate risk-assessment and associated
mitigation plan. It is also important to factor in your supervisor's availability: there are likely
to be periods over the summer where the supervisor is either working away from Bristol, or on
vacation, and you should ensure that you plan around those periods of limited or non-availability.
As you will have spent this period doing a fair amount of specialist reading, it can be very useful
to write a first-draft of the opening chapters of your thesis during this period: this gives you
less to write when it comes to the end-game period of assembling your complete thesis. 

The Mid-Zone Weeks of your Project
==================================

This is where the real work gets done. By the time you come to the mid-zone you should know all the
key literature relevant to the work you plan to do, you should know what script or code libraries
you will be using, and what scripts or code you will have to write for yourself, and you should
either already have gathered your data, or you should know for sure that you can either access it or
generate it in sufficient quantities for your needs. You're all set to go, so just go do it. Of
course in this period there can lurk some nasty surprises: try not to be disheartened if things
don't work out as planned; if things go wrong; if you have to change your plans. Remember that the
final thesis has to give a good account of the work that you did, but it does not necessarily have
to "deliver" on everything in your initial plan -- your initial plan is not a contract. The need to
re-plan, to revise aims and goals, is surprisingly common. In military circles there is a common
saying: "no plan survives contact with the enemy" -- remember that, and try to stay positive if
things don't work out as initially hoped. Whatever you do, don't give up; almost always the worst
thing to do is to do nothing.

The End-Game
============

Many people plan to spend the last three weeks of their project time working only on finalising their thesis: editing existing chunks of text, writing new text, creating final diagrams, and running final analyses of data. Because much or all of your working day in this period would be spent on your thesis, you could have some major time-intensive data analytics or machine learning processes running somewhere (e.g. on one or more spare PCs, or on some number of virtual machines in the cloud) to produce some final larger-scale results, but the hope is that by this stage you already know what conclusions you will be drawing, because of the work you did in the mid-phase, and ideally you would not be doing any debugging or writing of new code in this final phase. If you find writing easy, and/or if you have written sizeable chunks of thesis in earlier phases of your project, then maybe you could get away with only spending two weeks in this final phase. If you find writing more of a challenge, then you may need to allocate four or five or more weeks to getting your thesis done. Also, if you are relying on someone else (a family member, a friend, or a professional editor) to proof-read and/or suggest edits to your text, then make sure they are available in this period and agree the dates/times on which you will deliver text to them for review, and when they will give you their feedback.
Final submission is electronic: by uploading a PDF of your thesis, and also (where relevant) by making your data and code available to the examiners -- e.g. by issuing them with access to a password-protected repository such as GitHub.

Thesis Structure
================

Standard UoB templates are available for layout of an MSc thesis in LaTeX. This sets correct values
for the font-type and size, the borders/margins, and the line-spacing and so on, and it also
includes a sample structure, a suggested sequence of chapters. But this is not a fixed or mandatory
structure: if you wish, you can choose your own structure. Nevertheless, almost all theses for
masters degrees (and for doctoral degrees too) have a fairly predictable structure...

There will be $N$ chapters, numbered $1$ to $N$. 

Before the start of Chapter 1 there will be "frontmatter": an Abstract; a UoB-standard Declaration
("This work was all by me except where clearly stated", that sort of thing); an Acknowledgements
section, Tables of Contents and of Diagrams; lists of abbreviations and mathematical symbols; etc
etc. Chapter 1 will be the Introduction. This should be a short overview of the entire thesis.
Because it describes the entire thesis, Chapter 1 is often the last chapter to be completed. One
interesting and potentially very useful way of summarizing your thesis-work is to produce, as an
Appendix A, a six- or eight- or ten-page paper that summarizes your entire thesis, formatted ready
for submission to an international peer-review conference, using a standard format like IEEE
two-column, or Springer's Lecture Notes in Computer Science (LNCS) format, and to refer the reader
to this in Chapter 1: the text can be the same words and diagrams in Ch1 as in AppendixA, but the
Appendix version will help to demonstrate to the reader what your work looks like when summarized
and formatted as a conference-paper.    

Chapter $N$ will be the Conclusions. This is a summary/reminder of what the thesis set out to
achieve, what was actually achieved, and what remains to be done. This, like Chapter 1, is completed
right at the end of the writing, once you know what the whole thesis says. Chapter $N$ is often very
close in substance, in what it says, to Chapter 1 -- this is deliberate: Chapter 1 tells the reader
what you're about to say; Chapter $N$ tells the reader what you just said.  

Chapter $N-1$ will be Further Work. This is where you talk about what additional things you would
have done if you were given more time/resources to continue the work. The fixed-duration of an MSc
project means that almost always you'll have things to say here, because you're having to stop work
and submit sooner than you would have wished if you were given infinite resources. 

Chapter 2 (and possibly also Chapter 3) will be where you establish why what you are working on is
interesting/relevant/important, and where you show that you are aware of relevant literature. Quite
often Chapter 2 has a title like Context and is where you talk about the real-world relevance of
what you're doing, the application area that you're working in, any major societal or political or
economic trends that are relevant; and then Chapter 3 would have a title like Related Work, where
you review relevant academic work, peer-reviewed publications. Of course not every thesis fits this
pattern. If your work is abstract or theoretical then there may be relatively little to say about
Context and it may be more natural, may give your thesis a better flow, if you have a section on
Context in Chapter 1 and instead move straight onto Related Work for Chapter 2. It's up to you,
there are no hard rules here.

If the starting and ending chapters just described can be thought of as the two slices of bread that
go into making a sandwich, then the remaining chapters, Chapters 3 or 4 to Chapter $N-2$, are the
"filling" in your sandwich. This is where the core content that describes your work will go. There
are no hard-and-fast rules for how many chapters you have in the filling. Here are a couple of
example filling-structures that you might want to consider:

One way of doing this is to have one filling-chapter per major iteration of your project. This makes
sense if your project takes the form of trying something, an initial approach that we'll call
Approach A, and then reflecting on the results from that and deciding to make a second attempt which
we'll call Approach B, and then maybe also subsequent iterations C and maybe even D, and so on. Then
a natural way of documenting this progression would be one chapter per approach: each chapter could
open with why the approach looked sensible at the outset, and how your experience then made you
rethink and switch to the next approach in the sequence. This gives a "narrative arc", a story to
your thesis, of making a progressive sequence of steps. This is a common structure for a thesis
because it commonly reflects the lived experience of the person who wrote the thesis. Another way of
doing this is to have the filling-chapters be accounts of distinct phases of a non-iterative
project, e.g. one in which it is sensible/useful to talk about a Design phase, an Implementation
phase,  a Testing/Validation phase, a Deployment/Usage phase, and then an Evaluation/Reflection
phase -- this would neatly and naturally give you four major chapters for the "filling".

After Chapter $N$ come any number of appendices. As mentioned above, one thing to consider is
preparing a mock conference-paper summary of your thesis work as Appendix A: this could be very
useful if you decide to subsequently submit your work to a peer-reviewed conference. 

Self-Care
=========

The period in which you work on your project is quite definitely a marathon not a sprint. It is
vitally important that you pace yourself appropriately. It is entirely possible to score the highest
possible marks working a standard 40-hour week, five-days per week of eight-hour days. Do take
evenings and weekends away from your project-work. In our experience, people are at their most
creative and their most productive when they are rested and relaxed.

Despite this, it is not uncommon for people to find the final few days (or weeks) before submission
to be a quite intense and stressful period. We recommend to everyone that, if possible, they can
give themselves a few days -- ideally a week -- of rest and relaxation after submitting your thesis.
It's a truly major part of your MSc, and hopefully it will be something that you look back on
fondly. However chilled (or not) you are when you're finishing your thesis, once it's submitted you
definitely deserve a few days off!