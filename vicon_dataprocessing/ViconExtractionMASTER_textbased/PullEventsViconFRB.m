% deviceIDs = [1,2,7,8]; %leftFP, rightFP, LRail, RRail


function Events = PullEventsViconFRB(vicon,subject)

Events.LHS = vicon.GetEvents(subject, 'Left', 'Foot Strike');
Events.LTO = vicon.GetEvents(subject, 'Left', 'Foot Off');
Events.RHS = vicon.GetEvents(subject, 'Right', 'Foot Strike');
Events.RTO = vicon.GetEvents(subject, 'Right', 'Foot Off');

end