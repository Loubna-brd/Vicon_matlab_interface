function JointAngles = PullJointAngleViconFRB(vicon, subject)
outputs = vicon.GetModelOutputNames(subject);
for o = 1:numel(outputs)
   if contains(outputs{o},'Angle')
       JointAngles.(outputs{o}) = vicon.GetModelOutput(subject, outputs{o})';
   else
       continue
   end
end






