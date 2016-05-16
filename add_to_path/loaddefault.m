function cfg = loaddefault(cfg, defaultCfg, appendStruct)
% keepStruct: recursive retain the struct
%LOAD DEFAULT CONFIG
% defaultCfg = struct('a',1,'b',2,'c',3);
% cfg = struct('b',0);
% cfg = loaddefault(cfg, defaultCfg)

%     existingfields = isfield(cfg,fieldnames(defaultCfg));
    %if cfg 
    if nargin < 3
        appendStruct = false;
    end
    
    fields = fieldnames(defaultCfg);
    nfields = numel(fields);
    for n = 1:nfields
        if ~isfield(cfg,fields(n))
            cfg.(fields{n}) = defaultCfg.(fields{n});
        else
            if appendStruct && isstruct(defaultCfg.(fields{n}))
                cfg.(fields{n}) = loaddefault(cfg.(fields{n}), ...
                                              defaultCfg.(fields{n}) );
            end
        end
    end
end