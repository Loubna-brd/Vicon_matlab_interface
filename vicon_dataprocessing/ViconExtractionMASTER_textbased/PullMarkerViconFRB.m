function Markers = PullMarkerViconFRB(vicon, subject)
marker = vicon.GetMarkerNames(subject);
for m = 1:numel(marker)
    try
       [x,y,z,e] = vicon.GetTrajectory(subject, marker{m});
       Markers.(marker{m})  = [x', y', z', e'];
    catch
        display(['No Marker Data For ' marker{m}])
    end
end






