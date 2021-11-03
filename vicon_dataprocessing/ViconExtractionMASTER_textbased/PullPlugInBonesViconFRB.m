function PlugInBones = PullPlugInBonesViconFRB(vicon, subject)
outputs = vicon.GetModelOutputNames(subject);
for o = 1:numel(outputs)
   if contains(outputs{o},'PEL')
       PlugInBones.(outputs{o}) = vicon.GetModelOutput(subject, outputs{o})';
   elseif contains(outputs{o},'LFE')
       PlugInBones.(outputs{o}) = vicon.GetModelOutput(subject, outputs{o})';
   elseif contains(outputs{o},'LTI')
       PlugInBones.(outputs{o}) = vicon.GetModelOutput(subject, outputs{o})';
   elseif contains(outputs{o},'LFO')
       PlugInBones.(outputs{o}) = vicon.GetModelOutput(subject, outputs{o})';
   elseif contains(outputs{o},'LTO')
       PlugInBones.(outputs{o}) = vicon.GetModelOutput(subject, outputs{o})';
   elseif contains(outputs{o},'RFE')
       PlugInBones.(outputs{o}) = vicon.GetModelOutput(subject, outputs{o})';
   elseif contains(outputs{o},'RTI')
       PlugInBones.(outputs{o}) = vicon.GetModelOutput(subject, outputs{o})';
   elseif contains(outputs{o},'RFO')
       PlugInBones.(outputs{o}) = vicon.GetModelOutput(subject, outputs{o})';
   elseif contains(outputs{o},'RTO')
       PlugInBones.(outputs{o}) = vicon.GetModelOutput(subject, outputs{o})';
   else
       continue
   end
end
end

