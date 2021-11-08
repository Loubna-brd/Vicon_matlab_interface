%% Code copied from Kirsty McDonald's youtube video series
% https://www.youtube.com/channel/UCIqZ46GRzFbSYNzMVQ5HD-g
vicon = ViconNexus
vicon.DisplayCommandList()
vicon.DisplayCommandHelp('CommandGoesHere')
%% ------------------ Marker Trajectories ----------------
%%
% Import the subject name
SubjectName = vicon.GetSubjectNames;
%% Import Marker Names for this subject
vicon.GetMarkerNames('Loubna');
%%
% Import RTH1 and RTH3 marker trajectories
% Input = Subject name, marker name
% Output = Trajectory data X, Y, Z & E
[RHEE(:,1),RHEE(:,2),RHEE(:,3),RHEE(:,4)] = vicon.GetTrajectory(SubjectName{1},'RHEE');
[LHEE(:,1),LHEE(:,2),LHEE(:,3),LHEE(:,4)] = vicon.GetTrajectory(SubjectName{1},'LHEE');
%% PLOT
figure()
plot(RHEE)
%%
% Create a virtual marker half way between RTH1 and RTH3
% RTHMid = ((RHEE(:,1:3)+LHEE(:,1:3))/2)';
% exists = logical(min(RHEE(:,4),LHEE(:,4)));
%%
% Put RTHMid virtual marker into the GCS of open trial
% vicon.CreateModelOutput(SubjectName{1},'RTHMid','Modeled Markers',{'X', 'Y', 'Z'}, {'Length', 'Length', 'Length'});
% vicon.SetModelOutput(SubjectName{1},'RTHMid', RTHMid, exists);
%% ---------------- Import model outputs -------------------
%%

% Import model data for right ankle
ModelOutput = {'RAnkleAngles'};

for i = 1:length(ModelOutput)
    [ModelData.Raw.(ModelOutput{i}), ModelData.Exists.(ModelOutput{i})] = vicon.GetModelOutput(SubjectName{1},ModelOutput{i});
end    

% Import event frames
Events.RightFS = vicon.GetEvents(SubjectName{1}, 'Right', 'Foot Strike');
Events.RightFO = vicon.GetEvents(SubjectName{1}, 'Right', 'Foot Off');
%% Plot gait events with trajectory
figure()
plot(RHEE)
hold on
plot(Events.RightFO,RHEE(Events.RightFO,2),'.')
% Crop data to stance phase only
% for i = 1:length(ModelOutput)
%     for j = 1:length(Events.RightFO)
%         ModelData.Cropped.(ModelOutput{i}).(strcat('StancePhase',num2str(j)))= ModelData.Raw.(ModelOutput{i})(:,Events.RightFS(j):Events.RightFO(j))';
%     end
% end
%% -------------- Import Forceplates data -------------------
[sFrame,eFrame] = vicon.GetTrialRegionOfInterest;
Fs = vicon.GetFrameRate;

% Import analog device names
DeviceName = vicon.GetDeviceNames;

% Specify analog device channels
Channels = {'Fx','Fy','Fz','Mx','My','Mz'};
% DeviceOutputID = [1,1,1,2,2,2];

% Pre-allocate space for device information
DeviceID = cell(length(DeviceName),1);
DeviceType = cell(length(DeviceName),1); 
DeviceRate = cell(length(DeviceName),1); 
DeviceOutputID = cell(length(DeviceName),1); 
ChannelID = cell(length(Channels),1); 

% Import device information
for i = 1:length(DeviceName)
    DeviceID{i} = vicon.GetDeviceIDFromName(DeviceName{i});
    [~,DeviceType{i}, DeviceRate{i}, DeviceOutputID{i}] = vicon.GetDeviceDetails(DeviceID{i});
end

for i = 1:length(DeviceName)
    if strcmp(DeviceType{i},'ForcePlate')
        for j = 1:length(Channels)
            ChannelID{j} = vicon.GetDeviceChannelIDFromName(DeviceID{i}, ceil(double(j)/3), Channels{j});
                % 2nd term is Device OutputID (1 = force, 2 = moment, 3 = CoP)           
            ForcePlateRaw.(DeviceName{i}).(Channels{j}) = vicon.GetDeviceChannel(DeviceID{i}, ceil(double(j)/3), ChannelID{j});            
%             ForcePlateCropped.(DeviceName{i}).(Channels{j}) = ForcePlateRaw.(DeviceName{i}).(Channels{j})(sFrame*(DeviceRate{i}/Fs):eFrame*(DeviceRate{i}/Fs));
        end
    end
end
%%
figure()
plot(abs(ForcePlateRaw.RightForcePlate.Fz))
% plot(ForcePlateCropped.Left.Fz);
