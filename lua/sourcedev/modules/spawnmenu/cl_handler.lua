sourcedev("spawnmenu")


local function coroutine_wait( seconds )

	local endtime = CurTime() + seconds
	while ( true ) do

		if ( endtime < CurTime() ) then return end

		coroutine.yield()

	end
	  
end

MODULE.mt_parsedProp = MODULE.mt_parsedProp or {}

local _match = string.match
local _split = string.Split

local function processPathTable(path, tbl)
    local args = _split(path, "/")
    local last_tbl = tbl
    for k, arg in ipairs(args) do
        if not istable(last_tbl[arg]) then
            last_tbl[arg] = {}
        end
        last_tbl = last_tbl[arg]
    end

    return last_tbl
end

local function parsePath(path, where, matchStr, exists)
    assert(istable(exists), "Exists not is table")
    
    local new_path

    if path[#path] == "/" then new_path = path:sub(1, #path - 1) end

    if #path == 0 then 
        new_path = "*"
    else
        new_path = path .. "/*"
    end

    if new_path[1] == "/" then new_path = new_path:sub(2) end
    print(new_path)


    local files, folders = file.Find(new_path, where)

    if files then
        for _, file_name in pairs(files) do
            -- print(file_name)
            if _match(file_name, matchStr) then
                local last_tbl = processPathTable(path, exists)
                table.insert(last_tbl, file_name)
            end
        end
    end


    if folders then
        for id, folder_name in ipairs(folders) do
            timer.Simple(FrameTime() * id, function()
                parsePath(path .. "/" .. folder_name, where, matchStr, exists)
            end)
        end
    end

    
    return exists
end


function MODULE.hd_parseProp()
    mt_parsedProp.map = {}
    parsePath("", "BSP", ".mdl", mt_parsedProp.map)
    mt_parsedProp.workshop = {}
    parsePath("", "WORKSHOP", ".mdl", mt_parsedProp.workshop)
    mt_parsedProp.thirdparty = {}
    parsePath("", "THIRDPARTY", ".mdl", mt_parsedProp.thirdparty)
    mt_parsedProp.garrysmod = {}
    parsePath("", "MOD", ".mdl", mt_parsedProp.garrysmod)
    mt_parsedProp.download = {}
    parsePath("", "DOWNLOAD", ".mdl", mt_parsedProp.download)
    mt_parsedProp.mounted = {}
    parsePath("", "<mounted folder>", ".mdl", mt_parsedProp.mounted)
    mt_parsedProp.mounted_workshop = {}
    parsePath("", "<mounted Workshop addon title>", ".mdl", mt_parsedProp.mounted_workshop)
end

-- PrintTable(mt_parsedProp)
