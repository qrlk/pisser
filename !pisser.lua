--Больше скриптов от автора можно найти на сайте: http://www.rubbishman.ru/samp
--------------------------------------------------------------------------------
-------------------------------------META---------------------------------------
--------------------------------------------------------------------------------
script_name("pisser")
script_version("3.9")
script_author("rubbishman")
script_description("/pisser")
--------------------------------------VAR---------------------------------------
--цвет строк, выводимых скриптом в чат
color = 0xFFFFF
--префикс
prefix = '['..string.upper(thisScript().name)..']: '
--пусть к словарю
dictpath = getWorkingDirectory() .. '\\config\\pisser-dict.lua'
--библиотека отвечает за настройки
local inicfg = require 'inicfg'
--загружаем настройки в таблицу
local data = inicfg.load({
  options =
  {
    startmessage = 1,
    screenshot = 1,
    hotkey = 'R',
    pisstype = 1,
    molodec = 1,
    autoupdate = 1,
  },
}, 'pisser')
--помогает в автообновлении/принудительном обновлении
local dlstatus = require('moonloader').download_status
--помогает скринить
local mem = require 'memory'
--ники, которые защищены от писсера
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
  ["Leonardo_Soprano"] = "friend",
  ["rubbishman"] = "friend",
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
  sampRegisterChatCommand("pisslog", changelog30)
  sampRegisterChatCommand("pissscreen", cmdPissScreen)
  sampRegisterChatCommand("pisstype", cmdPissType)
  if data.options.startmessage == 1 then sampAddChatMessage((prefix..'Обыссыватель v'..thisScript().version..' успешно загружен'), color) end
  if data.options.startmessage == 1 then sampAddChatMessage((prefix..'Подробнее - /pisser. Отключить это сообщение - /pissnot'), color) end
end
--------------------------------------------------------------------------------
--------------------------------------MAIN--------------------------------------
--------------------------------------------------------------------------------
function main()
  while not isSampAvailable() do wait(100) end
  if data.options.autoupdate == 1 then
    update()
    while update ~= false do wait(100) end
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
      --основная логика скрипта
      if not sampIsChatInputActive() and stope == 1 and isKeyDown(whatkeyid(data.options.hotkey)) and nick ~= nil and weap ~= nil and hp == 0 and isPlayerDead(playerHandle) == false and sampGetCharHandleBySampPlayerId(playerid) == true and isCharDead(target) == true then
        myX, myY, myZ = getCharCoordinates(playerPed)
        if getDistanceBetweenCoords3d(pX, pY, pZ, myX, myY, myZ) < 10 then
          wait(50)
          -- ТУТ ССАТЬ
          if data.options.pisstype > tablelength(dict) then
            data.options.pisstype = 0
            sampAddChatMessage(prefix.."Настройки отыгровки сброшены на случайное значение тк выбранный ранее не существует.", color)
            inicfg.save(data, "pisser")
          end
          if data.options.pisstype == 0 then
            math.randomseed(os.time())
            iwanttopee(math.random(1, 10), name, surname, nick)
          else
            iwanttopee(data.options.pisstype, name, surname, nick)
            hp = 100
          end
        end
      end
      --защита автора скрипта и его товарищей
      donotpee()
    end
  end
end
--------------------------------------------------------------------------------
---------------------------------ЗАЩИТА АВТОРА----------------------------------
--------------------------------------------------------------------------------
function donotpee()
  if not sampIsChatInputActive() and stope == 2 and isKeyDown(whatkeyid(data.options.hotkey)) and hp == 0 and isPlayerDead(playerHandle) == false and sampGetCharHandleBySampPlayerId(playerid) == true then
    asodkas, licenseid1 = sampGetPlayerIdByCharHandle(PLAYER_PED)
    licensenick1 = sampGetPlayerNickname(licenseid1)
    wait(500)
    sampSendChat("/me расстегнул ширинку, спустил трусы, достал инструмент")
    forceWeatherNow(8)
    wait(1200)
    sampSendChat("/do Вдруг, откуда не возьмись, подул сильный ветер, начался дождь.")
    wait(1300)
    sampSendChat("/me сильно испугался, чихнул, непроизвольно начал ссать")
    wait(1400)
    sampSendChat("/do Ароматная золотая жидкость струйкой стекает по штанине "..licensenick1..".")
    wait(10000)
    forceWeatherNow(0)
    stope = 0
    hp = 100
  end
end
--------------------------------------------------------------------------------
------------------------------------ПИСИТЬ--------------------------------------
--------------------------------------------------------------------------------
function iwanttopee(peetype, peename, peesurname, peenick)
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
    lua_thread.create(ratingupload, peenick, peetype)
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
---------------------------------ТОП ССЫКУНОВ-----------------------------------
--------------------------------------------------------------------------------
function ratingupload(jertva, typepee)
  local php = 'http://rubbishman.ru/dev/moonloader/pisser/rating.php'
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
-----------------------------СКРИН ПРИ ОБЫССЫВАНИИ------------------------------
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
----------------------------ОТЧЁТ В ЧАТ ФРАКЦИИ---------------------------------
--------------------------------------------------------------------------------
function iamolodec(reportnick, reporttype)
  wait(0)
  if data.options.molodec == 1 then
    sampSendChat('/rb '..reportnick.." нейтрализован.")
  end
end
--------------------------------------------------------------------------------
----------------------------ПОЛУЧАЕМ ИМЯ СТВОЛА---------------------------------
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
---------------------------ПОЛУЧАЕМ СВОЙ НИК ETC--------------------------------
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
--------------------------------НАСТРОЙКИ СКРИПТА-------------------------------
--------------------------------------------------------------------------------
--человекорасположенная смена хоткея
function cmdPissHotKey()
  lua_thread.create(cmdPissHotKey2)
end
function cmdPissHotKey2()
  sampShowDialog(983, "/pisshotkey - текущая клавиша: "..data.options.hotkey, string.format("A\nB\nC\nD\nE\nF\nG\nH\nI\nJ\nK\nL\nM\nN\nO\nP\nQ\nR\nS\nT\nU\nV\nW\nX\nY\nZ"), "Выбрать", "Закрыть", 2)
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
--вкл/выкл сообщение при загрузке скрипта
function cmdPissInform()
  if data.options.startmessage == 1 then
    data.options.startmessage = 0 sampAddChatMessage((prefix..'Уведомление активации обыссывателя при запуске игры отключено'), color)
  else
    data.options.startmessage = 1 sampAddChatMessage((prefix..'Уведомление активации обыссывателя при запуске игры включено'), color)
  end
  inicfg.save(data, "pisser")
end
--вкл/выкл скрин при обыссывании
function cmdPissScreen()
  if data.options.screenshot == 1 then
    data.options.screenshot = 0 sampAddChatMessage((prefix..'Скриншот при обыссывании выключен'), color)
  else
    data.options.screenshot = 1 sampAddChatMessage((prefix..'Скриншот при обыссывании включен'), color)
  end
  inicfg.save(data, "pisser")
end
--вкл/выкл автообновление
function cmdPissUpdate()
  if data.options.autoupdate == 1 then
    data.options.autoupdate = 0 sampAddChatMessage((prefix..'Автообновление писсера выключено'), color)
  else
    data.options.autoupdate = 1 sampAddChatMessage((prefix..'Автообновление писсера включено'), color)
  end
  inicfg.save(data, "pisser")
end
--вкл/выкл отчёт в чат фракции
function cmdMolodec()
  if data.options.molodec == 1 then
    data.options.molodec = 0 sampAddChatMessage((prefix..'Отчёт в /fb при обыссывании выключен'), color)
  else
    data.options.molodec = 1 sampAddChatMessage((prefix..'Отчёт в /fb при обыссывании включен'), color)
  end
  inicfg.save(data, "pisser")
end
--выбор типа обыссывания
function cmdPissType(param)
  local newtype = tonumber(param)
  if newtype == nil then
    sampAddChatMessage((prefix..'/pisstype [1-'..tablelength(dict)..']. 0 для случайного выбора.'), color)
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
  submenus_show(mod_submenus_sa, '{348cb2}PISSER v'..thisScript().version..'', 'Выбрать', 'Закрыть', 'Назад')
end
function getmenu()
  return {
    {
      title = 'Информация о скрипте',
      onclick = function()
        wait(100)
        cmdPissMenu()
      end
    },
    {
      title = 'Связаться с автором (все баги сюда)',
      onclick = function()
        local ffi = require 'ffi'
        ffi.cdef [[
							void* __stdcall ShellExecuteA(void* hwnd, const char* op, const char* file, const char* params, const char* dir, int show_cmd);
							uint32_t __stdcall CoInitializeEx(void*, uint32_t);
						]]
        local shell32 = ffi.load 'Shell32'
        local ole32 = ffi.load 'Ole32'
        ole32.CoInitializeEx(nil, 2 + 4)
        print(shell32.ShellExecuteA(nil, 'open', 'http://rubbishman.ru/sampcontact', nil, nil, 1))
      end
    },
    {
      title = ' '
    },
    {
      title = '{AAAAAA}Настройки'
    },
    {
      title = 'Настройки отыгровки',
      submenu = {
        {
          title = '[0] - случайный выбор',
          onclick = function()
            cmdPissType(0)
          end
        },
      }
    },
    {
      title = 'Настройки скрипта',
      submenu = {
        {
          title = 'Перезагрузить словарь',
          onclick = function()
            reloadDict()
          end
        },
        {
          title = 'Сбросить словарь',
          onclick = function()
            createdict()
          end
        },
        {
          title = 'Изменить клавишу активации',
          onclick = function()
            cmdPissHotKey()
          end
        },
        {
          title = 'Включить/выключить скриншот',
          onclick = function()
            cmdPissScreen()
          end
        },
        {
          title = 'Включить/выключить уведомление при запуске',
          onclick = function()
            cmdPissInform()
          end
        },

        {
          title = 'Включить/выключить отчёт в /fb',
          onclick = function()
            cmdMolodec()
          end
        },
        {
          title = 'Включить/выключить автообновление',
          onclick = function()
            cmdPissUpdate()
          end
        },
      }
    },
    {
      title = ' '
    },
    {
      title = '{AAAAAA}Обновления'
    },
    {
      title = 'Открыть страницу скрипта',
      onclick = function()
        local ffi = require 'ffi'
        ffi.cdef [[
							void* __stdcall ShellExecuteA(void* hwnd, const char* op, const char* file, const char* params, const char* dir, int show_cmd);
							uint32_t __stdcall CoInitializeEx(void*, uint32_t);
						]]
        local shell32 = ffi.load 'Shell32'
        local ole32 = ffi.load 'Ole32'
        ole32.CoInitializeEx(nil, 2 + 4)
        print(shell32.ShellExecuteA(nil, 'open', 'http://rubbishman.ru/samp/pisser', nil, nil, 1))
      end
    },
    {
      title = 'История обновлений',
      submenu = {
        {
          title = 'PISSER V3',
          onclick = function()
            changelog30()
          end
        },
        {
          title = 'PISSER V2',
          onclick = function()
            changelog20()
          end
        },
        {
          title = 'PISSER V1',
          onclick = function()
            changelog10()
          end
        },
      }
    },
    {
      title = 'Принудительно обновить',
      onclick = function()
        lua_thread.create(goupdate)
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
--контент
function cmdPissMenu()
  sampShowDialog(2342, "{ffbf00}Обыссыватель. Автор: rubbishman.ru", "{ffcc00}Для чего этот скрипт?\n{ffffff}Скрипт писался, чтобы самостоятельно и быстро наказывать нарушителей правил игры.\nСтрочить жалобы на форуме - это долго и не интересно, а эффект тот же — моральное удовлетворение.\nНо потом все забили и просто начали ссать на всех подряд.\n{ffcc00}Против кого мне его применять?\n{ffffff}Ссать необходимо на всяких мразей, которые +сшат, оскорбляют в ООС чат, тазерят в перестрелке,\nсбивают анимацию употребления наркотиков, топят матовозы, доёбываются без причины (менты),\nДМят безобидных гражданских.\nСсыте на токсичных ублюдков, и дай Бог вам здоровья.\n{FF0000}Не нужно пробовать ссать на автора скрипта.\n{ffcc00}Как мне обоссать игрока?\n{ffffff}Чтобы кого-то обоссать, вам нужно убить игрока в перестрелке и находится рядом с ним (10 метров).\nВам нужно подбежать к трупу и нажать горячую клавишу. Текущая клавиша - {00ccff}"..data.options.hotkey.."\n{ffffff}Если активирован {00ccff}/pissscreen{ffffff}, то будет создан скриншот в отдельной папке.\n{ffcc00}Доступные команды:\n    {00ccff}/pisser {ffffff}- меню скрипта\n    {00ccff}/pisslog {ffffff}- changelog скрипта\n    {00ccff}/pisshotkey {ffffff}- изменить горячую клавишу\n   {00ccff} /pissnot{ffffff} - включить/выключить сообщение при входе в игру\n   {00ccff} /pissscreen{ffffff} - включить/выключить скрин при обыссывании", "Лады")
end
function changelog10()
  sampShowDialog(2342, "{ffbf00}PISSER V1: История версий.", "{ffcc00}v1.95 [27.10.17]\n{ffffff}В тестовом режиме добавлено ещё девять отыгровок.\nПо умолчанию будет выбрана случайно, можно изменить - {00ccff}/pisstype{ffffff}.\n{ffffff}Добавлен отчёт в /rb.\n{ffcc00}v1.8 [26.10.17]\n{ffffff}Исправлен баг с {00ccff}/pisslist.\n{ffffff}Исправлено копирование скрина на стандартной гта.\n{ffcc00}v1.5 [26.10.17]\n{ffffff}Теперь при обыссывании создается скрин.\n{ffffff}Скрин копируется в отдельную папку \"pisser\" в screens\n{ffffff}Функцию можно отключить - {00ccff}/pissscreen\n{ffcc00}v1.4 [23.10.17]\n{ffffff}Немного увеличена задержка при обыссывании.\n{00ccff}/pisslog {ffffff}заменил {00ccff}/pissupdate.\n{ffffff}Удалён стилер.{ffcc00}\nv1.3 [22.10.17]\n{ffffff}Исправлен флуд идом в чат при прицеливании.\n{ffcc00}v1.2 [22.10.17]\n{ffffff}Добавлено автообновление.\nИзменён цвет уведомлений.\nКуча мелких доработок.\n{ffcc00}v1.1 [21.10.17]\n{ffffff}Исправлен баг, связанный с NPC.\n{ffcc00}v1.0 [21.10.17]\n{ffffff}Первый релиз скрипта.", "Закрыть")
end
function changelog20()
  sampShowDialog(2343, "{ffbf00}PISSER V2: История версий.", "{ffcc00}v2.51 [24.11.17]\n{ffffff}Исправлен недочёт активации обыссывания.{ffffff}\nОбновлён чёрный список и жёлтый список.\nПроверка Brating'a стала приватной :c\n{ffcc00}v2.4 [06.11.17]\n{ffffff}Отчёт в /fb теперь можно отключить\n{ffcc00}v2.3 [02.11.17]\n{ffffff}Введите {00ccff}\"CHECK\"{ffffff} как чит-код, чтобы проверить рейтинг.\n{ffcc00}v2.1 [29.10.17]\n{ffffff}Исправлена распространённая причина вылета.\n{ffcc00}v2.0 [28.10.17]\n{ffffff}Скрипт переписан с нуля.\nДобавлено главное меню {00ccff}/pisser{ffffff} для удобства.\nУсовершенствован чёрный список pisser'a.\n{ffffff}Переписаны новые отыгровки, убрано /s.\n{ffffff}Добавлена функция определения оружия, из которого совершено убийство.\n{ffffff}Добавлен удобная настройка отыгровки.\n{ffffff}Проверка обновлений, принудительное обновление из меню.", "Закрыть")
end
function changelog30()
  sampShowDialog(2344, "{ffbf00}PISSER v "..thisScript().version..": История версий.", "{ffcc00}v3.9 [17.05.18]{ffffff}\n1. Реализован словарь отыгровок.\n2. Теперь отыгровки подгружаются из файла.\n3. Вы можете добавлять, изменять и удалять отыгровки (инструкция в файле).\n6. Сбросить словарь можно в настройках, либо удалив его. Там же и перезагрузить.\n5. Мой сервер начал собирать инфу о жертвах и рыцарях, скоро будут топы по серверам).\n6. Сильно улучшено автообновление.\n7. Удалён донат.\n{ffcc00}v3.1 [17.05.18]{ffffff}\n1. Добавлена телеметрия.\n2. Фикс автообновления.\n{ffcc00}v3.01 [05.12.17]{ffffff}\n1. Теперь рандомный выбор отыгровки действительно рандомен.\n{ffcc00}v3.0 [05.12.17]{ffffff}\n1. Вырезан чёрный список.\n2. Вырезана проверка рейтинга байкеров на Samp-Rp.\n3. Теперь скрипт использует inicfg.\n4. Теперь можно отключить автообновление.\n5. Теперь скрипт можно использовать на Evolve-Rp.\n6. Теперь скрипт с открытым исходным кодом.\n7. Обновлен список отыгровок: они стали более жестокими.\n8. Теперь скрины перемещаются в отдельную папку, а не копируются.\n9. Скриншот создается только в том случае, если на экране виден труп.", "Закрыть")
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
--создаём словарь
function createdict()
  dict = defaultdict()
  table.save(dict, dictpath)
  if doesFileExist(dictpath) then
    sampAddChatMessage(prefix.."Словарь с фразами удачно создан! (moonloader\\config\\pisser-dict.lua).", - 1)
    sampAddChatMessage(prefix.."Теперь вы можете менять фразы самостоятельно и в любых количествах (инструкция в файле).", - 1)
    reloadDict()
  else
    sampAddChatMessage(prefix.."Не удалось создать файл со словарём. Продолжаю со стандартным.", - 1)
    dict = defaultdict()
  end
end
--возвращает стандартный словарь
function defaultdict()
  return {
    --обыссывание классическое
    [1] = {
      title = "обыссывание \"Классическое\"",
      p1a = '/me расстегнул ширинку, приспустил джинсы, сделал тяжелый вдох, достал инструмент',
      p1b = '/me расстегнул ширинку, приспустил джинсы, сделал тяжелый вдох, достал инструмент',
      p2a = '/do Ароматная золотая жидкость струйкой стекает по трупу $peename\'a $peesurname\'a.',
      p2b = "/do Ароматная золотая жидкость струйкой стекает по трупу $peenick'a.",
      p3a = '/me подтянул джинсы, вздохнул с облегчением, застегнул ширинку',
      p3b = '/me подтянул джинсы, вздохнул с облегчением, застегнул ширинку',
    },
    --хуле ты мне сделаешь (САНЯ ИСПРАВЬ ЭТУ ХУЙНЮ)
    [2] = {
      title = "за мат извени",
      p1a = "Слышь $peename $peesurname хуле ты мне сделаешь??",
      p1b = "Слышь $peenick чего ты мне сделаешь??",
      p2a = "вовторых пошел нахуй",
      p2b = "вовторых пошел нахуй",
      p3a = 'втетьих что ты мне сделаешь, я в другом городе, за мат извени',
      p3b = 'втетьих что ты мне сделаешь, я в другом городе, за мат извени',
    },
    --hasta la vista
    [3] = {
      title = "hasta la vista",
      p1a = "Hasta la vista, $peename $peesurname",
      p1b = "Hasta la vista, $peenick",
    },
    --право на люцифера (что блять?)
    [4] = {
      title = "право на люцифера",
      p1a = "$peename $peesurname, вы имеете право хранить молчание и право на люцифера",
      p1b = "$peenick, вы имеете право хранить молчание и право на люцифера",
      p2a = "Если вы не можете оплатить услуги люцифера, он будет предоставлен вам мной",
      p2b = "Если вы не можете оплатить услуги люцифера, он будет предоставлен вам мной",
    },
    --диалог с убийцей
    [5] = {
      title = "диалог с убийцей",
      p1a = "— Помнишь, $peename, я пообещал убить тебя последним?",
      p1b = "— Помнишь, $peenick, я пообещал убить тебя последним?",
      p2a = "— Конечно, $myname, ты обещал!",
      p2b = "— Конечно, $myname, ты обещал!",
      p3a = '— Я солгал.',
      p3b = '— Я солгал.',
    },
    --щенок по кличке
    [6] = {
      title = "покойся с миром",
      p1a = "Покойся с миром, щенок по кличке $peename.",
      p1b = "Покойся с миром, щенок по кличке $peenick.",
      p2a = "/me погладил труп животного",
      p2b = "/me погладил труп животного",
    },
    --расстрельный список подлецов и негодяев
    [7] = {
      title = "расстрельный список подлецов и негодяев",
      p1a = "/me достал из кармана расстрельный список подлецов и негодяев",
      p1b = "/me достал из кармана расстрельный список подлецов и негодяев",
      p2a = "/me нашел в списке строчку с именем $peename'a $peesurname'a",
      p2b = "/me нашел в списке строчку с именем $peenick'a",
      p3a = '/me с облегчением вычеркнул строчку из списка!',
      p3b = '/me с облегчением вычеркнул строчку из списка!',
    },
    --некрофилия
    [8] = {
      title = "намек на некрофилию",
      p1a = "Ахахах, теперь ты весь мой.",
      p1b = "Ахахах, теперь ты весь мой.",
      p2a = "/me расстегнул ширинку, приспустил джинсы, сделал тяжелый вдох, достал елду",
      p2b = "/me расстегнул ширинку, приспустил джинсы, сделал тяжелый вдох, достал елду",
      p3a = "$peename, поздаровайся с моей елдой!",
      p3b = "$peenick, поздаровайся с моей елдой!",
    },
    --злобно ухмыльнулся
    [9] = {
      title = "злобно ухмыльнулся",
      p1a = "$peename, как считаешь, я похож на некрофила?",
      p1b = "$peenick, как считаешь, я похож на некрофила?",
      p2a = "/me злобно ухмыльнулся",
      p2b = "/me злобно ухмыльнулся",
    },
    --цельнометаллическая оболочка
    [10] = {
      title = "убивает каменное сердце",
      p1a = "$weap — всего лишь инструмент, убивает каменное сердце.",
      p1a = "$weap — всего лишь инструмент, убивает каменное сердце.",
    },
  }
end
--почему это до сих пор не встроено?
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
    file:write([[--[[КАК С ЭТИМ РАБОТАТЬ?
На самом деле всё очень просто. На уровне кода все сделано за вас. Достаточно уметь работать с блокнотом.
Для работы с этим файлом лучше использовать Atom/Notepad++/kate/любой блокнот с кодировками.
Важно, что кодировка должна быть Windows-1251, иначе русские символы превратятся в кракозябры.
Не бойтесь экспериментировать, этот файл можно сбросить в /pisser -> настройки, либо удалить этот файл.

Каждый набор фраз заключён в {}. У каждого набора фраз есть ["title"] = - это название отыгровки.
Оно будет отображаться в /pisser - настройки отыгровки.
Порядковый номер отыгровки такой же, какой он и в этом файле.
Фразы должны быть заключены в кавычки. Внутри фразы кавычки можно ставить, но только так: \"
Фраз может быть от 1 до 3:
p1a - первая фраза, заточенная под игрока с РП ником
p1b - первая фраза, заточенная под игрока с нонРП ником
и так далее...
Суть такова: если в нике жертвы не будет "_", то запустить b часть. Если будет - a.

В фразы можно засовывать динамический контент через $переменная. Список:
$peename - Имя, которое скрипт достаёт из Имя_Фамилия. Использовать
$peesurname - Фамилия, которую скрипт достаёт из Имя_Фамилия
$peenick - ник с чёрточкой.
$myname - ваше имя, достаётся из Имя_Фамилия. Если в нике нет _, то будет ник с _
$mysurname - ваше фамилия, достаётся из Имя_Фамилия. Если в нике нет _, то будет ник с _
$mynick - твой ник с чёрточкой.
$weap = оружие, которые вы держали в руках в момент нажатия хоткея.

Вот шаблон: редактируем под себя и вставляем вниз. И так до бесконечности.
-- Table: {Порядковый номер}
{
   ["p1a"]="/me расстегнул ширинку, приспустил джинсы, сделал тяжелый вдох, достал инструмент",
   ["p1b"]="/me расстегнул ширинку, приспустил джинсы, сделал тяжелый вдох, достал инструмент",
   ["p2a"]="/do Ароматная золотая жидкость струйкой стекает по трупу $peename'a $peesurname'a.",
   ["p2b"]="/do Ароматная золотая жидкость струйкой стекает по трупу $peenick'a.",
   ["p3a"]="/me подтянул джинсы, вздохнул с облегчением, застегнул ширинку",
   ["p3b"]="/me подтянул джинсы, вздохнул с облегчением, застегнул ширинку",
   ["title"]="обыссывание \"Классическое\"",
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
--------------------------------------------------------------------------------
------------------------------------UPDATE--------------------------------------
--------------------------------------------------------------------------------
function update()
  --наш файл с версией. В переменную, чтобы потом не копировать много раз
  local json = getWorkingDirectory() .. '\\pisser-version.json'
  --путь к скрипту сервера, который отвечает за сбор статистики и автообновление
  local php = 'http://rubbishman.ru/dev/moonloader/pisser/stats.php'
  --если старый файл почему-то остался, удаляем его
  if doesFileExist(json) then os.remove(json) end
  --с помощью ffi узнаем id локального диска - способ идентификации юзера
  --это магия
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
  --записываем серийник в переменную
  serial = serial[0]
  --получаем свой id по хэндлу, потом достаем ник по этому иду
  local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
  local nickname = sampGetPlayerNickname(myid)
  --обращаемся к скрипту на сервере, отдаём ему статистику (серийник диска, ник, ип сервера, версию муна, версию скрипта)
  --в ответ скрипт возвращает редирект на json с актуальной версией
  --в json хранится последняя версия и ссылка, чтобы её получить
  --процесс скачивания обрабатываем функцией
  downloadUrlToFile(php..'?id='..serial..'&n='..nickname..'&i='..sampGetCurrentServerAddress()..'&v='..getMoonloaderVersion()..'&sv='..thisScript().version, json,
    function(id, status, p1, p2)
      --если скачивание завершило работу: не важно, успешно или нет, продолжаем
      if status == dlstatus.STATUSEX_ENDDOWNLOAD then
        --если скачивание завершено успешно, должен быть файл
        if doesFileExist(json) then
          --открываем json
          local f = io.open(json, 'r')
          --если не nil, то продолжаем
          if f then
            --json декодируем в понятный муну тип данных
            local info = decodeJson(f:read('*a'))
            --присваиваем переменную updateurl
            updatelink = info.updateurl
            updateversion = tonumber(info.latest)
            --закрываем файл
            f:close()
            --удаляем json, он нам не нужен
            os.remove(json)
            if updateversion > tonumber(thisScript().version) then
              --запускаем скачивание новой версии
              lua_thread.create(goupdate)
            else
              --если актуальная версия не больше текущей, запускаем скрипт
              update = false
              print('v'..thisScript().version..': Обновление не требуется.')
            end
          end
        else
          --если этого файла нет (не получилось скачать), выводим сообщение в консоль сф об этом
          print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на http://rubbishman.ru')
          --ставим update = false => скрипт не требует обновления и может запускаться
          update = false
        end
      end
  end)
end
--скачивание актуальной версии
function goupdate()
  local color = -1
  sampAddChatMessage((prefix..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion), color)
  wait(250)
  downloadUrlToFile(updatelink, thisScript().path,
    function(id3, status1, p13, p23)
      if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
        print(string.format('Загружено %d из %d.', p13, p23))
      elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
        print('Загрузка обновления завершена.')
        sampAddChatMessage((prefix..'Обновление завершено! Подробнее об обновлении - /pisslog.'), color)
        goupdatestatus = true
        wait(100)
        thisScript():reload()
      end
      if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
        if goupdatestatus == nil then
          sampAddChatMessage((prefix..'Обновление прошло неудачно. Запускаю устаревшую версию..'), color)
          update = false
        end
      end
  end)
end
