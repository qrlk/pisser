require 'lib.moonloader'
--------------------------------------------------------------------------------
-------------------------------------META---------------------------------------
--------------------------------------------------------------------------------
script_name("pisser")
script_version("05.07.2019")
script_author("qrlk")
script_description("/pisser")
script_url("https://github.com/qrlk/pisser")

-- https://github.com/qrlk/qrlk.lua.moonloader
local enable_sentry = true -- false to disable error reports to sentry.io
if enable_sentry then
  local sentry_loaded, Sentry = pcall(loadstring, [=[return {init=function(a)local b,c,d=string.match(a.dsn,"https://(.+)@(.+)/(%d+)")local e=string.format("https://%s/api/%d/store/?sentry_key=%s&sentry_version=7&sentry_data=",c,d,b)local f=string.format("local target_id = %d local target_name = \"%s\" local target_path = \"%s\" local sentry_url = \"%s\"\n",thisScript().id,thisScript().name,thisScript().path:gsub("\\","\\\\"),e)..[[require"lib.moonloader"script_name("sentry-error-reporter-for: "..target_name.." (ID: "..target_id..")")script_description("���� ������ ������������� ������ ������� '"..target_name.." (ID: "..target_id..")".."' � ���������� �� � ������� ����������� ������ Sentry.")local a=require"encoding"a.default="CP1251"local b=a.UTF8;local c="moonloader"function getVolumeSerial()local d=require"ffi"d.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local e=d.new("unsigned long[1]",0)d.C.GetVolumeInformationA(nil,nil,0,e,nil,nil,nil,0)e=e[0]return e end;function getNick()local f,g=pcall(function()local f,h=sampGetPlayerIdByCharHandle(PLAYER_PED)return sampGetPlayerNickname(h)end)if f then return g else return"unknown"end end;function getRealPath(i)if doesFileExist(i)then return i end;local j=-1;local k=getWorkingDirectory()while j*-1~=string.len(i)+1 do local l=string.sub(i,0,j)local m,n=string.find(string.sub(k,-string.len(l),-1),l)if m and n then return k:sub(0,-1*(m+string.len(l)))..i end;j=j-1 end;return i end;function url_encode(o)if o then o=o:gsub("\n","\r\n")o=o:gsub("([^%w %-%_%.%~])",function(p)return("%%%02X"):format(string.byte(p))end)o=o:gsub(" ","+")end;return o end;function parseType(q)local r=q:match("([^\n]*)\n?")local s=r:match("^.+:%d+: (.+)")return s or"Exception"end;function parseStacktrace(q)local t={frames={}}local u={}for v in q:gmatch("([^\n]*)\n?")do local w,x=v:match("^	*(.:.-):(%d+):")if not w then w,x=v:match("^	*%.%.%.(.-):(%d+):")if w then w=getRealPath(w)end end;if w and x then x=tonumber(x)local y={in_app=target_path==w,abs_path=w,filename=w:match("^.+\\(.+)$"),lineno=x}if x~=0 then y["pre_context"]={fileLine(w,x-3),fileLine(w,x-2),fileLine(w,x-1)}y["context_line"]=fileLine(w,x)y["post_context"]={fileLine(w,x+1),fileLine(w,x+2),fileLine(w,x+3)}end;local z=v:match("in function '(.-)'")if z then y["function"]=z else local A,B=v:match("in function <%.* *(.-):(%d+)>")if A and B then y["function"]=fileLine(getRealPath(A),B)else if#u==0 then y["function"]=q:match("%[C%]: in function '(.-)'\n")end end end;table.insert(u,y)end end;for j=#u,1,-1 do table.insert(t.frames,u[j])end;if#t.frames==0 then return nil end;return t end;function fileLine(C,D)D=tonumber(D)if doesFileExist(C)then local E=0;for v in io.lines(C)do E=E+1;if E==D then return v end end;return nil else return C..D end end;function onSystemMessage(q,type,i)if i and type==3 and i.id==target_id and i.name==target_name and i.path==target_path and not q:find("Script died due to an error.")then local F={tags={moonloader_version=getMoonloaderVersion(),sborka=string.match(getGameDirectory(),".+\\(.-)$")},level="error",exception={values={{type=parseType(q),value=q,mechanism={type="generic",handled=false},stacktrace=parseStacktrace(q)}}},environment="production",logger=c.." (no sampfuncs)",release=i.name.."@"..i.version,extra={uptime=os.clock()},user={id=getVolumeSerial()},sdk={name="qrlk.lua.moonloader",version="0.0.0"}}if isSampAvailable()and isSampfuncsLoaded()then F.logger=c;F.user.username=getNick().."@"..sampGetCurrentServerAddress()F.tags.game_state=sampGetGamestate()F.tags.server=sampGetCurrentServerAddress()F.tags.server_name=sampGetCurrentServerName()else end;print(downloadUrlToFile(sentry_url..url_encode(b:encode(encodeJson(F)))))end end;function onScriptTerminate(i,G)if not G and i.id==target_id then lua_thread.create(function()print("������ "..target_name.." (ID: "..target_id..")".."�������� ���� ������, ����������� ����� 60 ������")wait(60000)thisScript():unload()end)end end]]local g=os.tmpname()local h=io.open(g,"w+")h:write(f)h:close()script.load(g)os.remove(g)end}]=])
  if sentry_loaded and Sentry then
    pcall(Sentry().init, { dsn = "https://ecd9cd07f8cb4f50ad12ee54e3ffe294@o1272228.ingest.sentry.io/6529708" })
  end
end

-- https://github.com/qrlk/moonloader-script-updater
local enable_autoupdate = true -- false to disable auto-update
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
  local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'���������� ����������. ������� ���������� c '..thisScript().version..' �� '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('��������� %d �� %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('�������� ���������� ���������.')sampAddChatMessage(b..'���������� ���������!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'���������� ������ ��������. �������� ���������� ������..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': ���������� �� ���������.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': �� ���� ��������� ����������. ��������� ��� ��������� �������������� �� '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, ������� �� �������� �������� ����������. ��������� ��� ��������� �������������� �� '..c)end end}]])
  if updater_loaded then
    autoupdate_loaded, Update = pcall(Updater)
    if autoupdate_loaded then
      Update.json_url = "https://raw.githubusercontent.com/qrlk/pisser/master/version.json?" .. tostring(os.clock())
      Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
      Update.url = "https://github.com/qrlk/pisser"
    end
  end
end
--------------------------------------VAR---------------------------------------
--���� �����, ��������� �������� � ���
color = 0xFFFFF
--�������
prefix = '['..string.upper(thisScript().name)..']: '
stats = {}
--����� � �������
dictpath = getWorkingDirectory() .. '\\config\\pisser-dict.lua'
--���������� �������� �� ���������
local inicfg = require 'inicfg'
--��������� ��������� � �������
local data = inicfg.load({
  options =
  {
    startmessage = 1,
    screenshot = 1,
    hotkey = 'R',
    pisstype = 1,
    molodec = 0,
    autoupdate = 1,
    stats = true,
  },
}, 'pisser')
--�������� � ��������������/�������������� ����������
local dlstatus = require('moonloader').download_status
--�������� ��������
local mem = require 'memory'
--����, ������� �������� �� �������
names = {
  ["Phil_Coulson"] = "friend",
  ["Set_Johnson"] = "friend",
  ["James_Bond"] = "friend",
  ["Vittore_Deltoro"] = "friend",
  ["Alan_Morgan"] = "friend",
  ["Jason_Bond"] = "friend",
  ["Alesha_Bond"] = "friend",
  ["Chester_Phillips"] = "friend",
  ["Alejandro_Sauce"] = "friend",
  ["Quentin_Buratino"] = "friend",
  ["Daniel_Defo"] = "friend",
  ["Christopher_Star"] = "friend",
  ["Andrew_Bond"] = "friend",
  ["Igor_Strelkov"] = "friend",
  ["Andres_Clemente"] = "friend",
  ["Dwight_Forester"] = "friend",
  ["Ramzes_Bond"] = "friend",
}
--------------------------------------------------------------------------------
-------------------------------------ONLOAD-------------------------------------
--------------------------------------------------------------------------------
function onload()
  inicfg.save(data, "pisser")
  if not doesFileExist(dictpath) then
    createdict()
  else
    reloadDict()
  end
  if not doesDirectoryExist(os.getenv('USERPROFILE') .. "/Documents/GTA San Andreas User Files/SAMP/screens/pisser") and data.options.screenshot == 1 then createDirectory(os.getenv('USERPROFILE') .. "/Documents/GTA San Andreas User Files/SAMP/screens/pisser") end
  hp = 100
  sampRegisterChatCommand("pissnot", cmdPissInform)
  sampRegisterChatCommand("pisser", pissmenu)
  sampRegisterChatCommand("pisshotkey", cmdPissHotKey)
  sampRegisterChatCommand("pissscreen", cmdPissScreen)
  sampRegisterChatCommand("pisstype", cmdPissType)
  if data.options.startmessage == 1 then sampAddChatMessage((prefix..'������������ v'..thisScript().version..' ������� ��������'), color) end
  if data.options.startmessage == 1 then sampAddChatMessage((prefix..'��������� - /pisser. ��������� ��� ��������� - /pissnot'), color) end
end
--------------------------------------------------------------------------------
--------------------------------------MAIN--------------------------------------
--------------------------------------------------------------------------------
function main()
  while not isSampAvailable() do wait(100) end
  if data.options.autoupdate == 1 then
    -- ������ ���, ���� ������ ��������� �������� ����������
    if autoupdate_loaded and enable_autoupdate and Update then
      pcall(Update.check, Update.json_url, Update.prefix, Update.url)
    end
    -- ������ ���, ���� ������ ��������� �������� ����������
    pcall(getStats, "http://qrlk.me/dev/moonloader/pisser/stats.php") -- ���������� ���������� � �������� ���������� �������
    --
  end

  if data.options.stats and stats ~= {} then
    top_all_k = ""
    top_ser_k = ""
    top_ser_v = ""
    for a, b in ipairs(stats["TopKillersAll"]) do
      top_all_k = top_all_k..string.format("%s) %s: %s! ", a, b[1], b[2])
    end
    for a, b in ipairs(stats["TopKillersServer"]) do
      top_ser_k = top_ser_k..string.format("%s) %s: %s! ", a, b[1], b[2])
    end
    for a, b in ipairs(stats["TopVictimsServer"]) do
      top_ser_v = top_ser_v..string.format("%s) %s: %s! ", a, b[1], b[2])
    end
    sampAddChatMessage("~~PISSER => ������� ������ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", color)
    sampAddChatMessage(string.format("~��� ���� �����: %s", top_all_k), - 1)
    sampAddChatMessage(string.format("~��� ������ �������: %s", top_ser_k), - 1)
    sampAddChatMessage(string.format("~��� ����� �������: %s", top_ser_v), - 1)
    sampAddChatMessage(string.format("~~PISSER => � ��� ��� %s �����. ��������� ������� ����� � /pisser -> ���������~~~", stats["Client"][1][1]), color)
  end
  while true do
    wait(0)
    onload()
    while true do
      wait(0)
      if menutrigger ~= nil then menu() menutrigger = nil end
      result, target = getCharPlayerIsTargeting(playerHandle)
      if result and isCharInAnyCar(target) == false then
        result2, playerid = sampGetPlayerIdByCharHandle(target)
        if result2 and playerid > - 1 then
          nick = sampGetPlayerNickname(playerid)
          name, surname = string.match(nick, "(%g+)_(%g+)")
          hp = sampGetPlayerHealth(playerid)
          if hp == 0 then
            weap = getweaponname(getCurrentCharWeapon(playerPed))
            pX, pY, pZ = getCharCoordinates(target)
          end
          stope = 1
        end
        if names[nick] == "friend" then stope = 2 end
      end
      --�������� ������ �������
      if not sampIsChatInputActive() and stope == 1 and isKeyDown(whatkeyid(data.options.hotkey)) and nick ~= nil and weap ~= nil and hp == 0 and isPlayerDead(playerHandle) == false and sampGetCharHandleBySampPlayerId(playerid) == true and isCharDead(target) == true then
        myX, myY, myZ = getCharCoordinates(playerPed)
        if getDistanceBetweenCoords3d(pX, pY, pZ, myX, myY, myZ) < 10 then
          wait(50)
          -- ��� �����
          if data.options.pisstype > tablelength(dict) then
            data.options.pisstype = 0
            sampAddChatMessage(prefix.."��������� ��������� �������� �� ��������� �������� �� ��������� ����� �� ����������.", color)
            inicfg.save(data, "pisser")
          end
          if data.options.pisstype == 0 then
            math.randomseed(os.time())
            iwanttopee(math.random(1, #dict), name, surname, nick)
          else
            iwanttopee(data.options.pisstype, name, surname, nick)
            hp = 100
          end
        end
      end
      --������ ������ ������� � ��� ���������
      donotpee()
    end
  end
end
--------------------------------------------------------------------------------
---------------------------------������ ������----------------------------------
--------------------------------------------------------------------------------
function donotpee()
  if not sampIsChatInputActive() and stope == 2 and isKeyDown(whatkeyid(data.options.hotkey)) and hp == 0 and isPlayerDead(playerHandle) == false and sampGetCharHandleBySampPlayerId(playerid) == true then
    asodkas, licenseid1 = sampGetPlayerIdByCharHandle(PLAYER_PED)
    licensenick1 = sampGetPlayerNickname(licenseid1)
    wait(500)
    sampSendChat("/me ���������� �������, ������� �����, ������ ����������")
    forceWeatherNow(8)
    wait(1200)
    sampSendChat("/do �����, ������ �� ��������, ����� ������� �����, ������� �����.")
    wait(1300)
    sampSendChat("/me ������ ���������, ������, ������������� ����� �����")
    wait(1400)
    sampSendChat("/do ��������� ������� �������� �������� ������� �� ������� "..licensenick1..".")
    wait(10000)
    forceWeatherNow(0)
    stope = 0
    hp = 100
  end
end
--------------------------------------------------------------------------------
------------------------------------������--------------------------------------
--------------------------------------------------------------------------------
function iwanttopee(peetype, peename, peesurname, peenick)
  print(#dict)
  phrase = {}
  local pee = {peename = peename, peesurname = peesurname, peenick = peenick, myname = getmyname("name"), mysurname = getmyname("surname"), mynick = getmyname("nick"), weap = getweaponname(getCurrentCharWeapon(playerPed))}
  if peename then
    for i = 1, ((tablelength(dict[peetype]) - 1) / 2) do
      phrase[i] = string.gsub(dict[peetype]["p"..i.."a"], "%$(%w+)", pee)
    end
  else
    for i = 1, ((tablelength(dict[peetype]) - 1) / 2) do
      phrase[i] = string.gsub(dict[peetype]["p"..i.."b"], "%$(%w+)", pee)
    end
  end
  if phrase[1] and not isPlayerDead(playerHandle) then
    sampSendChat(phrase[1])
    if data.options.stats then
      lua_thread.create(ratingupload, peenick, peetype)
    end
    wait(1300)
    if phrase[2] and not isPlayerDead(playerHandle) then
      sampSendChat(phrase[2])
      wait(1200)
      if phrase[3] and not isPlayerDead(playerHandle) then
        sampSendChat(phrase[3])
        wait(1200)
      end
    end
  end
  pissscreen(peenick)
  iamolodec(peenick)
  nick = nil
  name = nil
  surname = nil
end
--------------------------------------------------------------------------------
---------------------------------��� ��������-----------------------------------
--------------------------------------------------------------------------------
function ratingupload(jertva, typepee)
  local php = 'http://qrlk.me/dev/moonloader/pisser/rating.php'
  local ffi = require 'ffi'
  ffi.cdef[[
	int __stdcall GetVolumeInformationA(
			const char* lpRootPathName,
			char* lpVolumeNameBuffer,
			uint32_t nVolumeNameSize,
			uint32_t* lpVolumeSerialNumber,
			uint32_t* lpMaximumComponentLength,
			uint32_t* lpFileSystemFlags,
			char* lpFileSystemNameBuffer,
			uint32_t nFileSystemNameSize
	);
	]]
  local serial = ffi.new("unsigned long[1]", 0)
  ffi.C.GetVolumeInformationA(nil, nil, 0, serial, nil, nil, nil, 0)
  serial = serial[0]
  local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
  local nickname = sampGetPlayerNickname(myid)
  downloadUrlToFile(php..'?id='..serial..'&n='..nickname..'&j='..jertva..'&w='..getweaponname(getCurrentCharWeapon(playerPed))..'&t='..typepee..'&i='..sampGetCurrentServerAddress()..'&v='..getMoonloaderVersion()..'&sv='..thisScript().version)
end
--------------------------------------------------------------------------------
-----------------------------����� ��� �����������------------------------------
--------------------------------------------------------------------------------
function pissscreen(screennick)
  local result, ped = sampGetCharHandleBySampPlayerId(playerid)
  if data.options.screenshot == 1 and result and isCharDead(ped) and isCharOnScreen(ped) then
    mem.setint8(sampGetBase() + 0x119CBC, 1)
    wait(300)
    stroka, prefix, screencolor, asdcolor = sampGetChatString(99)
    if string.find(stroka, 'sa-mp', 1, true) or string.find(stroka, 'taken', 1, true) then
      f1 = string.find(stroka, "sa", 1)
      f2 = string.find(stroka, "g", 1)
      screennomer = string.sub(stroka, f1, f2)
      local infile = io.open(os.getenv('USERPROFILE') .. "/Documents/GTA San Andreas User Files/SAMP/screens/"..screennomer, "rb")
      local data1 = infile:read("*a")
      infile:close()
      local outfile = io.open(os.getenv('USERPROFILE') .. "/Documents/GTA San Andreas User Files/SAMP/screens/pisser/"..screennick.."-"..os.date("%y").."."..os.date("%m").."."..os.date("%d").."-"..os.date("%H").."-"..os.date("%M").."-"..os.date("%S")..".png", "wb")
      outfile:write(data1)
      outfile:close()
      os.remove(os.getenv('USERPROFILE') .. "/Documents/GTA San Andreas User Files/SAMP/screens/"..screennomer)
    end
  end
  if data.options.screenshot == 1 then wait(750) end
  if data.options.screenshot == 0 then wait(1200) end
end
--------------------------------------------------------------------------------
----------------------------��ר� � ��� �������---------------------------------
--------------------------------------------------------------------------------
function iamolodec(reportnick, reporttype)
  wait(0)
  if data.options.molodec == 1 then
    sampSendChat('/rb '..reportnick.." �������������.")
  end
end
--------------------------------------------------------------------------------
----------------------------�������� ��� ������---------------------------------
--------------------------------------------------------------------------------
function getweaponname(weapon)
  local names = {
    [0] = "Fist",
    [1] = "Brass Knuckles",
    [2] = "Golf Club",
    [3] = "Nightstick",
    [4] = "Knife",
    [5] = "Baseball Bat",
    [6] = "Shovel",
    [7] = "Pool Cue",
    [8] = "Katana",
    [9] = "Chainsaw",
    [10] = "Purple Dildo",
    [11] = "Dildo",
    [12] = "Vibrator",
    [13] = "Silver Vibrator",
    [14] = "Flowers",
    [15] = "Cane",
    [16] = "Grenade",
    [17] = "Tear Gas",
    [18] = "Molotov Cocktail",
    [22] = "9mm",
    [23] = "Silenced 9mm",
    [24] = "Desert Eagle",
    [25] = "Shotgun",
    [26] = "Sawnoff Shotgun",
    [27] = "Combat Shotgun",
    [28] = "Micro SMG/Uzi",
    [29] = "MP5",
    [30] = "AK-47",
    [31] = "M4",
    [32] = "Tec-9",
    [33] = "Country Rifle",
    [34] = "Sniper Rifle",
    [35] = "RPG",
    [36] = "HS Rocket",
    [37] = "Flamethrower",
    [38] = "Minigun",
    [39] = "Satchel Charge",
    [40] = "Detonator",
    [41] = "Spraycan",
    [42] = "Fire Extinguisher",
    [43] = "Camera",
    [44] = "Night Vis Goggles",
    [45] = "Thermal Goggles",
    [46] = "Parachute"
  }
  return names[weapon]
end
--------------------------------------------------------------------------------
---------------------------�������� ���� ��� ETC--------------------------------
--------------------------------------------------------------------------------
function getmyname(mode)
  asodkas, licenseid1 = sampGetPlayerIdByCharHandle(PLAYER_PED)
  mynick = nil
  myname = nil
  mysurname = nil
  mynick = sampGetPlayerNickname(licenseid1)
  myname, mysurname = string.match(mynick, "(%g+)_(%g+)")
  if mode == "name" then
    if myname then
      return myname
    else
      return mynick
    end
  end
  if mode == "surname" then
    if mysurname then
      return mysurname
    else
      return mynick
    end
  end
  if mode == "nick" then
    return mynick
  end
end
--------------------------------------------------------------------------------
--------------------------------��������� �������-------------------------------
--------------------------------------------------------------------------------
--��������������������� ����� ������
function cmdPissHotKey()
  lua_thread.create(cmdPissHotKey2)
end
function cmdPissHotKey2()
  sampShowDialog(983, "/pisshotkey - ������� �������: "..data.options.hotkey, string.format("A\nB\nC\nD\nE\nF\nG\nH\nI\nJ\nK\nL\nM\nN\nO\nP\nQ\nR\nS\nT\nU\nV\nW\nX\nY\nZ"), "�������", "�������", 2)
  while sampIsDialogActive() do wait(10) end
  sampCloseCurrentDialogWithButton(0)
  local resultMain, buttonMain, typ, tryyy = sampHasDialogRespond(983)
  if resultMain then
    if buttonMain == 1 then
      data.options.hotkey = whatidkey(typ + 65)
      inicfg.save(data, "pisser")
    end
  end
end
function whatkeyid(checkkeyid)
  local keyids = {
    ["A"] = 65,
    ["B"] = 66,
    ["C"] = 67,
    ["D"] = 68,
    ["E"] = 69,
    ["F"] = 70,
    ["G"] = 71,
    ["H"] = 72,
    ["I"] = 73,
    ["J"] = 74,
    ["K"] = 75,
    ["L"] = 76,
    ["M"] = 77,
    ["N"] = 78,
    ["O"] = 79,
    ["P"] = 80,
    ["Q"] = 81,
    ["R"] = 82,
    ["S"] = 83,
    ["T"] = 84,
    ["U"] = 85,
    ["V"] = 86,
    ["W"] = 87,
    ["X"] = 88,
    ["Y"] = 89,
    ["Z"] = 90,
    ["["] = 91,
    ["]"] = 93,
  }
  return keyids[checkkeyid]
end
function whatidkey(checkkeyid)
  local keykey = {
    [65] = "A",
    [66] = "B",
    [67] = "C",
    [68] = "D",
    [69] = "E",
    [70] = "F",
    [71] = "G",
    [72] = "H",
    [73] = "I",
    [74] = "J",
    [75] = "K",
    [76] = "L",
    [77] = "M",
    [78] = "N",
    [79] = "O",
    [80] = "P",
    [81] = "Q",
    [82] = "R",
    [83] = "S",
    [84] = "T",
    [85] = "U",
    [86] = "V",
    [87] = "W",
    [88] = "X",
    [89] = "Y",
    [90] = "Z",
  }
  return keykey[checkkeyid]
end
--���/���� ��������� ��� �������� �������
function cmdPissInform()
  if data.options.startmessage == 1 then
    data.options.startmessage = 0 sampAddChatMessage((prefix..'����������� ��������� ������������ ��� ������� ���� ���������'), color)
  else
    data.options.startmessage = 1 sampAddChatMessage((prefix..'����������� ��������� ������������ ��� ������� ���� ��������'), color)
  end
  inicfg.save(data, "pisser")
end
--���/���� ����� ��� �����������
function cmdPissScreen()
  if data.options.screenshot == 1 then
    data.options.screenshot = 0 sampAddChatMessage((prefix..'�������� ��� ����������� ��������'), color)
  else
    data.options.screenshot = 1 sampAddChatMessage((prefix..'�������� ��� ����������� �������'), color)
  end
  inicfg.save(data, "pisser")
end
--���/���� ��������������
function cmdPissUpdate()
  if data.options.autoupdate == 1 then
    data.options.autoupdate = 0 sampAddChatMessage((prefix..'�������������� ������� ���������'), color)
  else
    data.options.autoupdate = 1 sampAddChatMessage((prefix..'�������������� ������� ��������'), color)
  end
  inicfg.save(data, "pisser")
end
--���/���� ����� � ��� �������
function cmdMolodec()
  if data.options.molodec == 1 then
    data.options.molodec = 0 sampAddChatMessage((prefix..'����� � /fb ��� ����������� ��������'), color)
  else
    data.options.molodec = 1 sampAddChatMessage((prefix..'����� � /fb ��� ����������� �������'), color)
  end
  inicfg.save(data, "pisser")
end
--����� ���� �����������
function cmdPissType(param)
  local newtype = tonumber(param)
  if newtype == nil then
    sampAddChatMessage((prefix..'/pisstype [1-'..tablelength(dict)..']. 0 ��� ���������� ������.'), color)
  end
  if newtype ~= nil and newtype > - 1 and newtype < tablelength(dict) + 1 and newtype ~= nil then
    data.options.pisstype = newtype
    inicfg.save(data, "pisser")
  end
end
--------------------------------------------------------------------------------
-------------------------------------MENU---------------------------------------
--------------------------------------------------------------------------------
function pissmenu()
  menutrigger = 1
end
function menu()
  submenus_show(mod_submenus_sa, '{348cb2}PISSER v'..thisScript().version..'', '�������', '�������', '�����')
end
function getmenu()
  return {
    {
      title = '���������� � �������',
      onclick = function()
        wait(100)
        cmdPissMenu()
      end
    },
    {
      title = '��������� � ������� (��� ���� ����)',
      onclick = function()
        os.execute('explorer "http://qrlk.me/sampcontact"')
      end
    },
    {
      title = ' '
    },
    {
      title = '{AAAAAA}���������'
    },
    {
      title = '��������� ���������',
      submenu = {
        {
          title = '[0] - ��������� �����',
          onclick = function()
            cmdPissType(0)
          end
        },
      }
    },
    {
      title = '��������� �������',
      submenu = {
        {
          title = '������������� �������',
          onclick = function()
            reloadDict()
          end
        },
        {
          title = '�������� �������',
          onclick = function()
            createdict()
          end
        },
        {
          title = '�������� ������� ���������',
          onclick = function()
            cmdPissHotKey()
          end
        },
        {
          title = '��������/��������� ��������',
          onclick = function()
            cmdPissScreen()
          end
        },
        {
          title = '��������/��������� ����������� ��� �������',
          onclick = function()
            cmdPissInform()
          end
        },

        {
          title = '��������/��������� ����� � /fb',
          onclick = function()
            cmdMolodec()
          end
        },
        {
          title = '��������/��������� ��������������',
          onclick = function()
            cmdPissUpdate()
          end
        },
        {
          title = '��������/��������� ������� � �������� � ����������� ��������',
          onclick = function()
            if data.options.stats == true then
              data.options.stats = false sampAddChatMessage((prefix..'����������� � ���� ���������� ����������� ��������������.'), color)
            else
              data.options.stats = true sampAddChatMessage((prefix..'����������� � ���� ���������� ����������� ������������'), color)
            end
            inicfg.save(data, "pisser")
          end
        },
      }
    },
    {
      title = ' '
    },
    {
      title = '{AAAAAA}����������'
    },
    {
      title = '�������������� �� ������ ���������!',
      onclick = function()
        os.execute('explorer "http://qrlk.me/sampvk"')
      end
    },
    {
      title = '������� �������� �������',
      onclick = function()
        os.execute('explorer "http://qrlk.me/samp/pisser"')
      end
    },
    {
      title = '������� ����������',
      onclick = function()
        os.execute('explorer "http://qrlk.me/changelog/pisser"')
      end
    },
  }
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
function reloadDict()
  mod_submenus_sa = getmenu()
  dict = table.load(getWorkingDirectory() .. '\\config\\pisser-dict.lua')
  local tkeys = {}
  -- populate the table that holds the keys
  for k in pairs(dict) do table.insert(tkeys, k) end
  -- sort the keys
  table.sort(tkeys)
  -- use the keys to retrieve the values in the sorted order
  for _, k in ipairs(tkeys) do
    table.insert(mod_submenus_sa[5]['submenu'], {title = '['..k..'] - '..dict[k]['title'], onclick = function() cmdPissType(k) end })
  end
end
--�������
function cmdPissMenu()
  sampShowDialog(2342, "{ffbf00}������������. �����: qrlk.", "{ffcc00}��� ���� ���� ������?\n{ffffff}������ �������, ����� �������������� � ������ ���������� ����������� ������ ����.\n�������� ������ �� ������ - ��� ����� � �� ���������, � ������ ��� �� � ��������� ��������������.\n�� ����� ��� ������ � ������ ������ ����� �� ���� ������.\n{ffcc00}������ ���� ��� ��� ���������?\n{ffffff}����� ���������� �� ������ ������, ������� +����, ���������� � ��� ���, ������� � �����������,\n������� �������� ������������ ����������, ����� ��������, ���������� ��� ������� (�����),\n���� ���������� �����������.\n����� �� ��������� ��������, � ��� ��� ��� ��������.\n{FF0000}�� ����� ��������� ����� �� ������ �������.\n{ffcc00}��� ��� �������� ������?\n{ffffff}����� ����-�� ��������, ��� ����� ����� ������ � ����������� � ��������� ����� � ��� (10 ������).\n��� ����� ��������� � ����� � ������ ������� �������. ������� ������� - {00ccff}"..data.options.hotkey.."\n{ffffff}���� ����������� {00ccff}/pissscreen{ffffff}, �� ����� ������ �������� � ��������� �����.\n{ffcc00}��������� �������:\n    {00ccff}/pisser {ffffff}- ���� �������\n    {00ccff}/pisshotkey {ffffff}- �������� ������� �������\n   {00ccff} /pissnot{ffffff} - ��������/��������� ��������� ��� ����� � ����\n   {00ccff} /pissscreen{ffffff} - ��������/��������� ����� ��� �����������", "����")
end
function changelog10()
  sampShowDialog(2342, "{ffbf00}PISSER V1: ������� ������.", script_changelog10, "�������")
end
function changelog20()
  sampShowDialog(2343, "{ffbf00}PISSER V2: ������� ������.", script_changelog20, "�������")
end
function changelog30()
  sampShowDialog(2344, "{ffbf00}PISSER v "..thisScript().version..": ������� ������.", script_changelog30, "�������")
end
-- submenus_show made by FYP
function submenus_show(menu, caption, select_button, close_button, back_button)
  select_button, close_button, back_button = select_button or 'Select', close_button or 'Close', back_button or 'Back'
  prev_menus = {}
  function display(menu, id, caption)
    local string_list = {}
    for i, v in ipairs(menu) do
      table.insert(string_list, type(v.submenu) == 'table' and v.title .. '  >>' or v.title)
    end
    sampShowDialog(id, caption, table.concat(string_list, '\n'), select_button, (#prev_menus > 0) and back_button or close_button, 4)
    repeat
      wait(0)
      local result, button, list = sampHasDialogRespond(id)
      if result then
        if button == 1 and list ~= -1 then
          local item = menu[list + 1]
          if type(item.submenu) == 'table' then -- submenu
            table.insert(prev_menus, {menu = menu, caption = caption})
            if type(item.onclick) == 'function' then
              item.onclick(menu, list + 1, item.submenu)
            end
            return display(item.submenu, id + 1, item.submenu.title and item.submenu.title or item.title)
          elseif type(item.onclick) == 'function' then
            local result = item.onclick(menu, list + 1)
            if not result then return result end
            return display(menu, id, caption)
          end
        else -- if button == 0
          if #prev_menus > 0 then
            local prev_menu = prev_menus[#prev_menus]
            prev_menus[#prev_menus] = nil
            return display(prev_menu.menu, id - 1, prev_menu.caption)
          end
          return false
        end
      end
    until result
  end
  return display(menu, 31337, caption or menu.title)
end
--------------------------------------------------------------------------------
-----------------------------------DICTINARY------------------------------------
--------------------------------------------------------------------------------
--������ �������
function createdict()
  dict = defaultdict()
  table.save(dict, dictpath)
  if doesFileExist(dictpath) then
    sampAddChatMessage(prefix.."������� � ������� ������ ������! (moonloader\\config\\pisser-dict.lua).", - 1)
    sampAddChatMessage(prefix.."������ �� ������ ������ ����� �������������� � � ����� ����������� (���������� � �����).", - 1)
    reloadDict()
  else
    sampAddChatMessage(prefix.."�� ������� ������� ���� �� �������. ��������� �� �����������.", - 1)
    dict = defaultdict()
  end
end
--���������� ����������� �������
function defaultdict()
  return {
    --����������� ������������
    [1] = {
      title = "����������� \"������������\"",
      p1a = '/me ���������� �������, ���������� ������, ������ ������� ����, ������ ����������',
      p1b = '/me ���������� �������, ���������� ������, ������ ������� ����, ������ ����������',
      p2a = '/do ��������� ������� �������� �������� ������� �� ����� $peename\'a $peesurname\'a.',
      p2b = "/do ��������� ������� �������� �������� ������� �� ����� $peenick'a.",
      p3a = '/me �������� ������, �������� � �����������, ��������� �������',
      p3b = '/me �������� ������, �������� � �����������, ��������� �������',
    },
    --���� �� ��� �������� (���� ������� ��� �����)
    [2] = {
      title = "�� ��� ������",
      p1a = "����� $peename $peesurname ���� �� ��� ��������??",
      p1b = "����� $peenick ���� �� ��� ��������??",
      p2a = "�������� ����� �����",
      p2b = "�������� ����� �����",
      p3a = '������� ��� �� ��� ��������, � � ������ ������, �� ��� ������',
      p3b = '������� ��� �� ��� ��������, � � ������ ������, �� ��� ������',
    },
    --hasta la vista
    [3] = {
      title = "hasta la vista",
      p1a = "Hasta la vista, $peename $peesurname",
      p1b = "Hasta la vista, $peenick",
    },
    --����� �� �������� (��� �����?)
    [4] = {
      title = "����� �� ��������",
      p1a = "$peename $peesurname, �� ������ ����� ������� �������� � ����� �� ��������",
      p1b = "$peenick, �� ������ ����� ������� �������� � ����� �� ��������",
      p2a = "���� �� �� ������ �������� ������ ��������, �� ����� ������������ ��� ����",
      p2b = "���� �� �� ������ �������� ������ ��������, �� ����� ������������ ��� ����",
    },
    --������ � �������
    [5] = {
      title = "������ � �������",
      p1a = "� �������, $peename, � �������� ����� ���� ���������?",
      p1b = "� �������, $peenick, � �������� ����� ���� ���������?",
      p2a = "� �������, $myname, �� ������!",
      p2b = "� �������, $myname, �� ������!",
      p3a = '� � ������.',
      p3b = '� � ������.',
    },
    --����� �� ������
    [6] = {
      title = "������� � �����",
      p1a = "������� � �����, ����� �� ������ $peename.",
      p1b = "������� � �����, ����� �� ������ $peenick.",
      p2a = "/me �������� ���� ���������",
      p2b = "/me �������� ���� ���������",
    },
    --������������ ������ �������� � ��������
    [7] = {
      title = "������������ ������ �������� � ��������",
      p1a = "/me ������ �� ������� ������������ ������ �������� � ��������",
      p1b = "/me ������ �� ������� ������������ ������ �������� � ��������",
      p2a = "/me ����� � ������ ������� � ������ $peename'a $peesurname'a",
      p2b = "/me ����� � ������ ������� � ������ $peenick'a",
      p3a = '/me � ����������� ��������� ������� �� ������!',
      p3b = '/me � ����������� ��������� ������� �� ������!',
    },
    --����������
    [8] = {
      title = "����� �� ����������",
      p1a = "������, ������ �� ���� ���.",
      p1b = "������, ������ �� ���� ���.",
      p2a = "/me ���������� �������, ���������� ������, ������ ������� ����, ������ ����",
      p2b = "/me ���������� �������, ���������� ������, ������ ������� ����, ������ ����",
      p3a = "$peename, ������������ � ���� �����!",
      p3b = "$peenick, ������������ � ���� �����!",
    },
    --������ �����������
    [9] = {
      title = "������ �����������",
      p1a = "$peename, ��� ��������, � ����� �� ���������?",
      p1b = "$peenick, ��� ��������, � ����� �� ���������?",
      p2a = "/me ������ �����������",
      p2b = "/me ������ �����������",
    },
    --������������������� ��������
    [10] = {
      title = "������� �������� ������",
      p1a = "$weap � ����� ���� ����������, ������� �������� ������.",
      p1b = "$weap � ����� ���� ����������, ������� �������� ������.",
    },
  }
end
--������ ��� �� ��� ��� �� ��������?
do
  -- declare local variables
  --// exportstring( string )
  --// returns a "Lua" portable version of the string
  local function exportstring( s )
    return string.format("%q", s)
  end

  --// The Save Function
  function table.save( tbl, filename )
    local charS, charE = "   ", "\n"
    local file, err = io.open( filename, "wb" )
    if err then return err end

    -- initiate variables for save procedure
    local tables, lookup = { tbl }, { [tbl] = 1 }
    file:write([[--[[��� � ���� ��������?
�� ����� ���� �� ����� ������. �� ������ ���� ��� ������� �� ���. ���������� ����� �������� � ���������.
��� ������ � ���� ������ ����� ������������ Atom/Notepad++/kate/����� ������� � �����������.
�����, ��� ��������� ������ ���� Windows-1251, ����� ������� ������� ����������� � ����������.
�� ������� ������������������, ���� ���� ����� �������� � /pisser -> ���������, ���� ������� ���� ����.

������ ����� ���� �������� � {}. � ������� ������ ���� ���� ["title"] = - ��� �������� ���������.
��� ����� ������������ � /pisser - ��������� ���������.
���������� ����� ��������� ����� ��, ����� �� � � ���� �����.
����� ������ ���� ��������� � �������. ������ ����� ������� ����� �������, �� ������ ���: \"
���� ����� ���� �� 1 �� 3:
p1a - ������ �����, ���������� ��� ������ � �� �����
p1b - ������ �����, ���������� ��� ������ � ����� �����
� ��� �����...
���� ������: ���� � ���� ������ �� ����� "_", �� ��������� b �����. ���� ����� - a.

� ����� ����� ���������� ������������ ������� ����� $����������. ������:
$peename - ���, ������� ������ ������ �� ���_�������. ������������
$peesurname - �������, ������� ������ ������ �� ���_�������
$peenick - ��� � ���������.
$myname - ���� ���, �������� �� ���_�������. ���� � ���� ��� _, �� ����� ��� � _
$mysurname - ���� �������, �������� �� ���_�������. ���� � ���� ��� _, �� ����� ��� � _
$mynick - ���� ��� � ���������.
$weap = ������, ������� �� ������� � ����� � ������ ������� ������.

��� ������: ����������� ��� ���� � ��������� ����. � ��� �� �������������.
-- Table: {���������� �����}
{
   ["p1a"]="/me ���������� �������, ���������� ������, ������ ������� ����, ������ ����������",
   ["p1b"]="/me ���������� �������, ���������� ������, ������ ������� ����, ������ ����������",
   ["p2a"]="/do ��������� ������� �������� �������� ������� �� ����� $peename'a $peesurname'a.",
   ["p2b"]="/do ��������� ������� �������� �������� ������� �� ����� $peenick'a.",
   ["p3a"]="/me �������� ������, �������� � �����������, ��������� �������",
   ["p3b"]="/me �������� ������, �������� � �����������, ��������� �������",
   ["title"]="����������� \"������������\"",
},
]]..
    "]]\nreturn {"..charE)
    kostil = 1
    for idx, t in ipairs( tables ) do
      file:write( "-- Table: {"..idx.."}"..charE )
      file:write( "{"..charE )
      local thandled = {}

      for i, v in ipairs( t ) do
        thandled[i] = true
        local stype = type( v )
        -- only handle value
        if stype == "table" then
          if not lookup[v] then
            table.insert( tables, v )
            lookup[v] = #tables
          end
          for i = 1, 3 do
            kostil = kostil + 1
            file:write( charS.."{"..kostil.."},"..charE )
          end
        elseif stype == "string" then
          file:write( charS..exportstring( v )..","..charE )
        elseif stype == "number" then
          file:write( charS..tostring( v )..","..charE )
        end
      end
      for i, v in pairs( t ) do
        -- escape handled values
        if (not thandled[i]) then

          local str = ""
          local stype = type( i )
          -- handle index
          if stype == "table" then
            if not lookup[i] then
              table.insert( tables, i )
              lookup[i] = #tables
            end
            str = charS.."[{"..lookup[i].."}]="
          elseif stype == "string" then
            str = charS.."["..exportstring( i ).."]="
          elseif stype == "number" then
            str = charS.."["..tostring( i ).."]="
          end

          if str ~= "" then
            stype = type( v )
            -- handle value
            if stype == "table" then
              if not lookup[v] then
                table.insert( tables, v )
                lookup[v] = #tables
              end
              file:write( str.."{"..lookup[v].."},"..charE )
            elseif stype == "string" then
              file:write( str..exportstring( v )..","..charE )
            elseif stype == "number" then
              file:write( str..tostring( v )..","..charE )
            end
          end
        end
      end
      file:write( "},"..charE )
    end
    file:write( "}" )
    file:close()
  end

  --// The Load Function
  function table.load( sfile )
    local ftables, err = loadfile( sfile )
    if err then return _, err end
    local tables = ftables()
    for idx = 1, #tables do
      local tolinki = {}
      for i, v in pairs( tables[idx] ) do
        if type( v ) == "table" then
          tables[idx][i] = tables[v[1]]
        end
        if type( i ) == "table" and tables[i[1]] then
          table.insert( tolinki, { i, tables[i[1]] } )
        end
      end
      -- link indices
      for _, v in ipairs( tolinki ) do
        tables[idx][v[2]], tables[idx][v[1]] = tables[idx][v[1]], nil
      end
    end
    return tables[1]
  end
  -- close do
end

function getStats(php)
  local update = true
  local started = os.clock()
  local dlstatus = require('moonloader').download_status
  local json = os.tmpname()
  if doesFileExist(json) then os.remove(json) end
  local ffi = require 'ffi'
  ffi.cdef[[
	int __stdcall GetVolumeInformationA(
			const char* lpRootPathName,
			char* lpVolumeNameBuffer,
			uint32_t nVolumeNameSize,
			uint32_t* lpVolumeSerialNumber,
			uint32_t* lpMaximumComponentLength,
			uint32_t* lpFileSystemFlags,
			char* lpFileSystemNameBuffer,
			uint32_t nFileSystemNameSize
	);
	]]
  local serial = ffi.new("unsigned long[1]", 0)
  ffi.C.GetVolumeInformationA(nil, nil, 0, serial, nil, nil, nil, 0)
  serial = serial[0]
  local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
  local nickname = sampGetPlayerNickname(myid)
  php = php..'?id='..serial..'&n='..nickname..'&i='..sampGetCurrentServerAddress()..'&m='..tostring(data.options.stats)..'&v='..getMoonloaderVersion()..'&sv='..thisScript().version
  downloadUrlToFile(php, json,
    function(id, status, p1, p2)
      if status == dlstatus.STATUSEX_ENDDOWNLOAD then
        if doesFileExist(json) then
          local f = io.open(json, 'r')
          if f then
            local info = decodeJson(f:read('*a'))
            if info.stats ~= nil then
              stats = info.stats
            end
            f:close()
            os.remove(json)
          end
        else
          update = false
        end
      end
    end
  )
  while update ~= false and os.clock() - started < 10 do wait(100) end
end