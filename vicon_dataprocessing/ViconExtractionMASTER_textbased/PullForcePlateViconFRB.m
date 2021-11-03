%This function pulls raw force plate data from an open Vicon trial
%Emma Reznick 08/25/2021

function ForcePlate = PullForcePlateViconFRB(vicon)
deviceIDs = vicon.GetDeviceIDs; %leftFP, rightFP, LRail, RRail, AMTI1, AMTI2, AMTI3
OutputName = {'Force' 'Moment' 'CoP'};
for i = 1:numel(deviceIDs)
    try
    DeviceName = vicon.GetDeviceDetails(deviceIDs(i));
    if contains(DeviceName, 'AMTI') || isempty(DeviceName) %Currently does not pull data from AMTI force plates
        continue
    elseif  contains(DeviceName, 'Handrail')
        outputIDs = 1; %force only
        ind = strfind(DeviceName, ' ');
        DeviceName(ind) = [];
    elseif contains(DeviceName, 'ForcePlate')
        outputIDs = [1,2,3]; %force, moment, Cop
    end
    
    %Get Data from x,y,z components of applicable output 
    for j = outputIDs
        ForcePlate.(DeviceName).(OutputName{j}) = [vicon.GetDeviceChannel(deviceIDs(i),j,1)',vicon.GetDeviceChannel(deviceIDs(i),j,2)',vicon.GetDeviceChannel(deviceIDs(i),j,3)'];
    end
    catch
        disp(['Error collecting ' DeviceName])
    end
end




