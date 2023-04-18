// personal assistant agent

wakeup :- upcoming(Event) & owner_state(State) & Event == "now" & State == "asleep".
all_good :- upcoming(Event) & owner_state(State) & Event == "now" & State == "awake".

best_wakeup_method("lights") :- wakeup_method("lights") & wakeup_with_artificial_light(X) & wakeup_with_natural_light(Y) & X < Y.
best_wakeup_method("blinds") :- wakeup_method("blinds") & wakeup_with_artificial_light(X) & wakeup_with_natural_light(Y) & X > Y.

/* Initial goals */ 
wakeup_with_natural_light(0).
wakeup_with_artificial_light(1).

// The agent has the goal to start
!start.

/* 
 * Plan for reacting to the addition of the goal !start
 * Triggering event: addition of goal !start
 * Context: true (the plan is always applicable)
 * Body: greets the user
*/
@start_plan
+!start : true <-
    .print("Hello world");
    !setupDweet.

@wakeup_owner_plan
+!wakeupOwner : wakeup <-
    .broadcast(askAll, wakeup_method, Answers);
    !use_answer(Answers)
    .print("wp, ", Answers).

@select_wakeup_method_plan
+!use_answer(Answers) : true <-
    .print("use answer").

@owner_awake_plan
+!ownerAwake : all_good <-
    .print("owner is awake").

@setup_dweet_plan
+!setupDweet : true <- 
    makeArtifact("dweet","room.DweetArtifact",[], DweetId);
    .print("Made artifact").

@send_dweet_plan
+!sendDweet : true <- 
    sendDweet("helloWorld");
    .print("Sent dweet").

/* Import behavior of agents that work in CArtAgO environments */
{ include("$jacamoJar/templates/common-cartago.asl") }