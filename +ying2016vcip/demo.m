%% Illumination-Robust Approach for Feature-Based Road Detection
% (Zhenqiang Ying, Ge Li, Guozhen Tan & Siwei Ma) to appear in VCIP 2016
% (IEEE International Conference on Visual Communications and Image
% Processing 2016) conference.
%
% Email: yinzhenqiang # gmail.com
% Website: https://github.com/baidut/openvehiclevision

mkdir('results');

global db;

db = exDebugger(...
    'saveAsEps','true',...
    'nameFunc',@(x)x.Name,...
    'level',1,...
    'path','.\results'...
);

path = ying2016vcip.settings.roma_path;
ext = 'jpg';

path = [path '\'];

roma = { str2files([path 'BDXD54\*.' ext]), ...
		 str2files([path 'BDXN01\*.' ext]), ...
		 str2files([path 'IRC04510\*.' ext]), ...
		 str2files([path 'IRC041500\*.' ext]), ...
		 str2files([path 'LRAlargeur13032003\*.' ext]), ...
		 str2files([path 'LRAlargeur14062002\*.' ext]), ...
		 str2files([path 'LRAlargeur26032003\*.' ext]), ...
		 str2files([path 'RD116\*.' ext]), ...
		 str2files([path 'RouenN8IRC051900\*.' ext]), ...
		 str2files([path 'RouenN8IRC052310\*.' ext]), ...
        };

% Test on : roma{2}, roma{end} [roma{2:3}] [roma{:}]
% figs = foreach_file_do([roma{2:3}], @roadDetection); 
% imdump(1, figs{:});

files = [roma{:}];
N = numel(files);
missL = false(N,1);
missM = false(N,1);
missR = false(N,1);
falseL = false(N,1);
falseM = false(N,1);
falseR = false(N,1);
name = cell(N,1);
situations = cell(N,1);

for n = 1 : N
    fprintf('Processing:%s...\n',files{n});
    [path,name{n},~] = fileparts(files{n});
    C = strsplit(path, '\');
    situations{n} = C{end};
	[fig, missL(n), missM(n), missR(n)]  = ying2016vcip.roadDetection(files{n});
    db.imdumpd(1, fig); 
    close(fig);
end

%% table
t = table(name, missL, missM, missR, falseL, falseM, falseR, situations);
writetable(t, 'eval.csv','Delimiter',',','QuoteStrings',true);
 
%%
text = evalc('ying2016vcip.gentex');
fid = fopen('results/evaluation.tex','w');
fprintf(fid, '%s', text);
fclose(fid);