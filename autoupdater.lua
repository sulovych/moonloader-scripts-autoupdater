script_version('Put Same Version In This As In Json')

local enable_autoupdate = true
local autoupdate_loaded = false
local Update = nil

if enable_autoupdate then
    local updater_loaded, Updater = pcall(loadstring, [[
        return {
            check = function(a, b, c)
                local d = require('moonloader').download_status
                local e = os.tmpname()
                local f = os.clock()

                local update, updatelink, updateversion, goupdatestatus

                if doesFileExist(e) then
                    os.remove(e)
                end

                downloadUrlToFile(a, e, function(_, g)
                    if g == d.STATUSEX_ENDDOWNLOAD and doesFileExist(e) then
                        local h = io.open(e, 'r')
                        if h then
                            local i = decodeJson(h:read('*a'))
                            h:close()
                            os.remove(e)

                            updatelink    = i.updateurl
                            updateversion = i.latest

                            if updateversion ~= thisScript().version then
                                local j = i.prefix or string.upper(thisScript().name)

                                lua_thread.create(function()
                                    AutoUpdaterMSG(j, "Detected New Version: " .. updateversion .. " | Old Version: " .. thisScript().version)

                                    wait(250)

                                    downloadUrlToFile(updatelink, thisScript().path, function(_, k)
                                        if k == d.STATUS_ENDDOWNLOADDATA then
                                            AutoUpdaterMSG(j, "Script Updated Successfully!")
                                            goupdatestatus = true

                                            lua_thread.create(function()
                                                wait(500)
                                                thisScript():reload()
                                            end)

                                        elseif k == d.STATUSEX_ENDDOWNLOAD and not goupdatestatus then
                                            AutoUpdaterMSG(j, "Script Failed To Update... Launching Old Version")
                                            update = false
                                        end
                                    end)
                                end)
                            else
                                update = false
                            end
                        else
                            update = false
                        end
                    else
                        update = false
                    end
                end)

                while update ~= false and os.clock() - f < 10 do
                    wait(100)
                end
            end
        }
    ]])

    if updater_loaded then
        autoupdate_loaded, Update = pcall(Updater)
        if autoupdate_loaded then
            Update.json_url = "raw link to autopdater.json" .. tostring(os.clock())
            Update.url = "raw link to .lua"
        end
    end
end

function main()
    while not isSampAvailable() do wait(100) end
    if autoupdate_loaded and enable_autoupdate and Update then
        pcall(Update.check, Update.json_url, Update.url)
    end
    wait(-1)
end

function AutoUpdaterMSG(prefix, text)
    color = "FF0000"
    return sampAddChatMessage(string.format('{%s}[%s] {D8D6D8}%s', color, prefix, text), -1)
end
