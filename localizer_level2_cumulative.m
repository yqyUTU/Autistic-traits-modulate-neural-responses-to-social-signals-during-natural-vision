regressors = {'Running', 'Walking', 'Searching_for_something','Laughing','Playful','Number_of_people','Waving','Dancing','Moving_their_body','Moving_their_feet','Female','Kissing_or_hugging_or_cuddling','Lying_down','Moaning_or_groaning','Feeling_pleasant','Passionate','Nude','Sexual','Focusing_on_bodily_expressions','Feeling_touch','Touching_someone','Sitting','Hungry','Tasting','Eating','Male','Using_an_object','Crying','Pain','Feeling_ill','Aroused','Feeling_unpleasant','Hitting_or_hurting_someone','Violent','Yelling','Aggressive','Having_a_conflict','Hostile','Standing','Looking_at_something','Making_gaze_contact','Human_voice','Listening_to_something','Talking'};

spmT_files = cell(length(regressors), 1);
for j = 1:length(regressors)
    contrast = regressors{j};
    spmT_path = fullfile('path', contrast, '/spmT_0001_positive.nii');%
    spmT_files{j} = spmT_path;
end


sumImg = zeros(91,109,91); 
for I = 1:size(spmT_files)
    currentFile = spmT_files{I};
    if exist(currentFile, 'file') == 2  
        Vimg = spm_vol(currentFile);
        img = spm_read_vols(Vimg);
        img(img > 0) = 1;
        img(isnan(img)) = 0;  
        sumImg = sumImg + img;
        
    else
        fprintf('File not found, skipping: %s\n', currentFile);
    end
end
Vimg.fname = '/cumu_posi.nii'; %
spm_write_vol(Vimg,sumImg);
