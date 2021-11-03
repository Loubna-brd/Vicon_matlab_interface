function JointVel = PullJointVelocityViconFRB(vicon, subject)
outputs = vicon.GetModelOutputNames(subject);
for o = 1:numel(outputs)
   if contains(outputs{o},'Angle')
       newName = strcat(outputs{o}(1:end-6), 'Velocity');
       JointVel.(newName) = ddt(vicon.GetModelOutput(subject, outputs{o})', 1/100);
   else
       continue
   end
end






  