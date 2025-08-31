local dict = {}
local hash: string = "27%Ry*330!__@)*($*8152"
type Dictionary<K, V> = {[K]: V}

function dict.bind(tbl: Dictionary<K, V>?): Dictionary<K, V>
    local raw = tbl or {} :: Dictionary<K, V>
    local proxy = {}
    raw[proxy] = raw
    local mt = {
        __index = function(_, key: K)
            return raw[key]
        end,
        __newindex = function(_, key: K, value: V)
            if raw[hash] then
                error("frozen dictionary",2)
            end
            raw[key] = value
        end,
    }
    setmetatable(proxy, mt)
    return proxy :: Dictionary<K, V>
end

function dict.find(tbl: Dictionary<K, V>, v:any, key_check: string): string
    for name, key in tbl do
        if key == v then
            return name
        elseif name == key_check then
            return key
        end
    end

    return nil
end

function dict.merge(merge_table_1: Dictionary<K, V>, merge_table_2: Dictionary<K, V>): Dictionary<K, V>
    for i, v in pairs(merge_table_2) do
        merge_table_1[i]  = v
    end
end

function dict.clear(tbl: Dictionary<K, V>): ()
    for i,v in pairs(tbl) do
        v = nil
    end
end

function dict.clone(tbl: Dictionary<K, V>): Dictionary<K, V>
    local copied_tbl = {} :: Dictionary<K, V>

    for i, v in pairs(tbl) do
        copied_tbl[i] = v
    end

    return copied_tbl
end

-- ignore the concat functions, i have to rework these to accept all parameters but they are partially functionable
function dict.concat_key(tbl: Dictionary<K, V>, sep: string, i: number, j: number): string
    local start: string = 1 or i
    local finish: number | nil = nil or j
    local increment: number = 1 
    local concat = {}

    for i, v in pairs(tbl) do
        print(not finish == nil)
        if increment ~= start then
            increment += 1
            continue
        elseif not finish == nil then
            if increment <= finish then
                start += 1
                increment += 1

                table.insert(concat,i)
            else
                break
            end
        elseif finish == nil then
            increment += 1
            start += 1

            table.insert(concat,i)
        end
    end


    return table.concat(concat, sep)
end

function dict.concat_value(tbl: Dictionary<K, V>, sep: string, i: number, j: number): string
    local start: string = 1 or i
    local finish: number | nil = nil or j
    local increment: number = 1
    local concat = {}

    for i, v in pairs(tbl) do
        print(not finish == nil)
        if increment ~= start then
            increment += 1
            continue
        elseif not finish == nil then
            if increment <= finish then
                start += 1
                increment += 1

                table.insert(concat,i)
            else
                break
            end
        elseif finish == nil then
            increment += 1
            start += 1

            table.insert(concat,v)
        end
    end


    return table.concat(concat, sep)
end

function dict.create(count: number, key: string, value: any): {}
    local dictionary: Dictionary<K, V> = {}

    for i = 1, count do
        dictionary[key] = value
    end
end

function dict.insert(tbl: Dictionary<K, V>, key: string, value: any): ()
    tbl[key] = value
    return tbl
end

function dict.maxn(tbl: table): number
    local Highest_Number: number? = nil


    for i, v in pairs(tbl) do
        if type(v) == "number" then
            if Highest_Number == nil or Highest_Number < v then
                Highest_Number = v
            end
        end
    end

    return Highest_Number
end

function dict.min(tbl: table): number
    local Lowest_Number: number? = nil


    for i, v in pairs(tbl) do
        if type(v) == "number" then
            if Lowest_Number == nil or Lowest_Number > v then
                Lowest_Number = v
            end
        end
    end

    return Lowest_Number
end

function dict.move(src: Dictionary<K, V>, keys: table, dst: Dictionary<K, V>): Dictionary<K, V>
    for i, v in pairs(src) do
        if dict.find(keys,i) then
            dst[i] = v
        end
    end
end

function dict.reconcile(src: Dictionary<K, V>, defaults: Dictionary<K, V>): Dictionary<K, V>
    for k, v in pairs(defaults) do
        if src[k] == nil then
            t[k] = v
        end
    end
end

function dict.remove(tbl: Dictionary<K, V>, key: string)
    tbl[key] = nil
end

function dict.freeze(tbl: Dictionary<K, V>)
    tbl[hash] = true
end

function dict.unfreeze(tbl: Dictionary<K, V>)
    tbl[hash] = nil
end

return dict
