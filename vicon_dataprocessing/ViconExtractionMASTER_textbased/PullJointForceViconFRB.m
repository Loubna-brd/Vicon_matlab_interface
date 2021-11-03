function JointForce = PullJointForceViconFRB(vicon, subject)
outputs = vicon.GetModelOutputNames(subject);
for o = 1:numel(outputs)
   if contains(outputs{o},'Force')
       JointForce.(outputs{o}) = vicon.GetModelOutput(subject, outputs{o})';
   else
       continue
   end
end