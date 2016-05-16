function imdump(varargin)
% imdump is not suggested since it use global variable.
% use exDebugger instead.
global db;
    if isempty(db)
       db = exDebugger;
    end

    db.imdumpd(varargin{:});
end