script_name("������������")
script_version_number(1)
script_version("1.01")
script_author("James_Bond/rubbishman/Coulson")
local LIP = {};
function firstload()
	if not doesDirectoryExist("moonloader\\config") then createDirectory("moonloader\\config") end
	if not doesFileExist("moonloader\\config\\pisser.ini") then
		local data =
		{
			options =
			{
				startmessage = 1,
				hotkey = 'R',
				content1 = '/me ���������� �������, ���������� ������, ������ ������� ����, ������ ����������',
				content3 = '/me �������� ������, �������� � �����������, ��������� �������',
			},
			blacklist =
			{
				"FRANCESCO_GARSIA",
				"ANTON_KISAKOV",
				"TRANSCORPUS_MOLVAYAS",
				"KABINA_DRAGONSOFT",
				"ANTON_KISAKOV",
				"ANDREW_SOPRANO",
				"VITTORE_DELTORO",
				"CHESTER_PHILLIPS",
				"MORGAN_EGOROV",
				"ALAN_MORGAN",
				"ALEX_SAVAGE",
				"MIKE_REIN",
				"CHRISTOPHER_STAR",
				"JESSIE_HARDY",
				"ALEX_REIN",
				"ALEJANDRO_SAUCE",
				"PAVEL_BRATUHA",
			},
		};
		LIP.save('moonloader\\config\\pisser.ini', data);
		sampAddChatMessage(('������ ������ ������������. ��� ������ .ini: moonloader\\config\\pisser.ini'), 0xEFBFB)
		sampAddChatMessage(('�������� ���� �� Samp-Rp! � ���������, ����� Samp-Rp Revolution James_Bond!'), 0xEFBFB)
	end
end

function onload()
	bikernick = sampGetPlayerNickname(0)
	if string.find(bikernick, "(%g+)_(%g+)", 1, true) then
		bikername, bikersurname = string.match(bikernick, "(%g+)_(%g+)")
	end
	result3, bikerrid = sampGetPlayerIdByCharHandle(playerHandle)
	if result3 then
		bikernick = sampGetPlayerNickname(bikerrid)
		if string.find(bikernick, "(%g+)_(%g+)", 1, true) then
			bikername, bikersurname = string.match(bikernick, "(%g+)_(%g+)")
		end
	end
	hp = 100
	data = LIP.load('moonloader\\config\\pisser.ini');
	for i = 1, #data.blacklist do
		if data.blacklist[i] ~= nil then data.blacklist[i] = string.upper(data.blacklist[i]) end
	end
	LIP.save('moonloader\\config\\pisser.ini', data);
	sampRegisterChatCommand("pissadd", cmdPissAdd)
	sampRegisterChatCommand("pissdel", cmdPissDel)
	sampRegisterChatCommand("pissnot", cmdPissInform)
	sampRegisterChatCommand("pisser", cmdPissMenu)
	sampRegisterChatCommand("pisshotkey", cmdPissHotKey)
	sampRegisterChatCommand("pisslist", cmdPissList)
	if data.options.startmessage == 1 and sampGetCurrentServerAddress() ~= '91.134.210.2' and sampGetCurrentServerAddress() ~= '91.134.210.1' then sampAddChatMessage(('������������ �������. ������� ��� ����: James_Bond/rubbishman/Coulson.'), 0xEFBFB) end
	if data.options.startmessage == 1 and sampGetCurrentServerAddress() ~= '91.134.210.2' and sampGetCurrentServerAddress() ~= '91.134.210.1' then sampAddChatMessage(('��������� - /pisser. ��������� ��� ��������� - /pissnot'), 0xEFBFB) end
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

function main()
	while not isSampAvailable() do wait(100) end
	firstload()
	onload()
	while true do
		wait(0)
		if sampGetCurrentServerAddress() == '91.134.210.2' or sampGetCurrentServerAddress() == '91.134.210.1' then sampAddChatMessage(('[ERROR]: � ���� ���� �� ������ ��� ����� �������.'), 0xFE1312)
			if cegj > 0 then end
		else
			local result, target = getCharPlayerIsTargeting(playerHandle)
			if result then
				result2, playerid = sampGetPlayerIdByCharHandle(target)
				if result2 then
					nick = sampGetPlayerNickname(playerid)
					name, surname = string.match(nick, "(%g+)_(%g+)")
					hp = sampGetPlayerHealth(playerid)
					if hp == 0 then pX, pY, pZ = getCharCoordinates(target) end
					stope = 1
				end
				for i = 1, #data.blacklist do
					if data.blacklist[i] == string.upper(nick) then stope = 0 end
				end
				if nick == "James_Bond" or nick == "Phil_Coulson" or nick == "Vittore_Deltoro" or nick == "Set_Johnson" or nick == "Riley_Reid" or nick == "Neax_Wayne" or nick == "Mike_Rein" then stope = 2 end
			end
			if not sampIsChatInputActive() and nick ~= nil and hp == 0 and isPlayerDead(playerHandle) == false and sampGetCharHandleBySampPlayerId(playerid) == true and isKeyDown(whatkeyid(data.options.hotkey)) and stope == 1 then
				myX, myY, myZ = getCharCoordinates(playerPed)
				if getDistanceBetweenCoords3d(pX, pY, pZ, myX, myY, myZ) < 10 then
					wait(500)
					if isPlayerDead(playerHandle) == false and data.options.content1 ~= nil then
						sampSendChat(data.options.content1)
						wait(1100)
						if isPlayerDead(playerHandle) == false then
							if name ~= nil and surname ~= nil then
								sampSendChat("/do ��������� ������� �������� �������� ������� �� ����� "..name.."'a "..surname.."'a.")
							else
								sampSendChat("/do ��������� ������� �������� �������� ������� �� ����� "..nick.."'a.")
							end
							wait(1100)
							if isPlayerDead(playerHandle) == false and data.options.content3 ~= nil then
								sampSendChat(data.options.content3)
								wait(1000)
								nick = nil
								name = nil
								surname = nil
							end
						end
					end
				end
			end
			if not sampIsChatInputActive() and hp == 0 and isPlayerDead(playerHandle) == false and sampGetCharHandleBySampPlayerId(playerid) == true and isKeyDown(whatkeyid(data.options.hotkey)) and stope == 2 then
				wait(500)
				sampSendChat("/me ���������� �������, ������� �����, ������ ����������")
				forceWeatherNow(8)
				wait(1100)
				sampSendChat("/do �����, ������ �� ��������, ����� ������� �����, ������� �����.")
				wait(1000)
				sampSendChat("/me ��������� �� �������������, ������")
				wait(1300)
				if bikername ~= nil and bikersurname ~= nil then
					sampSendChat("/do ��������� ������� �������� �������� ������� �� ������� "..bikername.."'a "..bikersurname.."'a.")
				else
					sampSendChat("/do ��������� ������� �������� �������� ������� �� ������� "..bikernick.."'a.")
				end
				wait(10000)
				forceWeatherNow(0)
				stope = 0
			end
		end
	end
end

function LIP.load(fileName)
	assert(type(fileName) == 'string', 'Parameter "fileName" must be a string.');
	local file = assert(io.open(fileName, 'r'), 'Error loading file : ' .. fileName);
	local data = {};
	local section;
	for line in file:lines() do
		local tempSection = line:match('^%[([^%[%]]+)%]$');
		if(tempSection)then
			section = tonumber(tempSection) and tonumber(tempSection) or tempSection;
			data[section] = data[section] or {};
		end
		local param, value = line:match('^([%w|_]+)%s-=%s-(.+)$');
		if(param and value ~= nil)then
			if(tonumber(value))then
				value = tonumber(value);
			elseif(value == 'true')then
				value = true;
			elseif(value == 'false')then
				value = false;
			end
			if(tonumber(param))then
				param = tonumber(param);
			end
			data[section][param] = value;
		end
	end
	file:close();
	return data;
end

function LIP.save(fileName, data)
	assert(type(fileName) == 'string', 'Parameter "fileName" must be a string.');
	assert(type(data) == 'table', 'Parameter "data" must be a table.');
	local file = assert(io.open(fileName, 'w+b'), 'Error loading file :' .. fileName);
	local contents = '';
	for section, param in pairs(data) do
		contents = contents .. ('[%s]\n'):format(section);
		for key, value in pairs(param) do
			contents = contents .. ('%s=%s\n'):format(key, tostring(value));
		end
		contents = contents .. '\n';
	end
	file:write(contents);
	file:close();
end

function cmdPissList()
	sampAddChatMessage(('׸���� ������ ������������: '), 0xEFBFB)
	for i = 1, #data.blacklist do
		sampAddChatMessage((i..'. '..data.blacklist[i]), 0xFFFFFF)
	end
end

function cmdPissAdd(newFriend)
	newFriendN = tonumber(newFriend)
	local data = LIP.load('moonloader\\config\\pisser.ini');
	myIndex = 0
	abc = 1
	for i = 1, #data.blacklist do
		if data.blacklist[i] == newFriend then abc = 2 end
	end
	while abc == 1 do
		myIndex = myIndex + 1
		if data.blacklist[myIndex] == nil then abc = 2 end
	end
	data.blacklist[myIndex] = newFriend
	LIP.save('moonloader\\config\\pisser.ini', data);
	local script = thisScript()
	script:reload()
end

function cmdPissDel(delFriend)
	delFriendN = tonumber(delFriend)
	local data = LIP.load('moonloader\\config\\pisser.ini');
	if delFriend ~= nil then delFriend = string.upper(delFriend) end
	for i = 1, #data.blacklist do
		if data.blacklist[i] == delFriend then data.blacklist[i] = nil end
	end
	LIP.save('moonloader\\config\\pisser.ini', data);
	local script = thisScript()
	script:reload()
end
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
			LIP.save('moonloader\\config\\pisser.ini', data);
		end
	end
end
function cmdPissInform()
	if data.options.startmessage == 1 then
		data.options.startmessage = 0 sampAddChatMessage(('����������� ��������� ������������ ��� ������� ���� ���������'), 0xEFBFB)
	else
		data.options.startmessage = 1 sampAddChatMessage(('����������� ��������� ������������ ��� ������� ���� ��������'), 0xEFBFB)
	end
	LIP.save('moonloader\\config\\pisser.ini', data);
	data = LIP.load('moonloader\\config\\pisser.ini');
	for i = 1, #data.blacklist do
		if data.blacklist[i] ~= nil then data.blacklist[i] = string.upper(data.blacklist[i]) end
	end
end

function cmdPissMenu()
	sampShowDialog(2342, "{ffbf00}������������. �����: James_Bond/rubbishman/Coulson.", "{ffcc00}��� ���� ���� ������?\n{ffffff}������ �������, ����� �������������� � ������ ���������� ����������� ������ ����.\n�������� ������ �� ������ - ��� ����� � �� ���������, � ������ ��� �� � ��������� ��������������.\n{ffcc00}������ ���� ��� ��� ���������?\n{ffffff}����� ���������� �� ������ ������, ������� +����, ���������� � ��� ���, ������� � �����������,\n������� �������� ������������ ����������, ����� ��������, ���������� ��� ������� (�����),\n���� ���������� �����������.\n����� �� ��������� ��������, � ��� ��� ��� ��������.\n{FF0000}�� ����� ��������� ����� �� ������ �������.\n{ffcc00}��� ��� �������� ������?\n{ffffff}����� ����-�� ��������, ��� ����� ����� ������ � ����������� � ��������� ����� � ��� (10 ������).\n��� ����� ��������� � ����� � ������ ������� �������. ������� ������� - {00ccff}"..data.options.hotkey.."\n{ffcc00}��������� �������:\n    {00ccff}/pisser {ffffff}- ��� ����\n    {00ccff}/pisshotkey {ffffff}- �������� ������� �������\n   {00ccff} /pissnot{ffffff} - ��������/��������� ��������� ��� ����� � ����\n{ffcc00}���������� ������ ������ ������������, ����� �������� �� �������� �������� ��� ������.\n   {00ccff}/pisslist {ffffff}- ������ ������ ������������ (� ���)\n   {00ccff}/pissadd [NICK_NAME] {ffffff}- �������� ��� � ������ ������ ������������\n   {00ccff}/pissdel [NICK_NAME] {ffffff}- ������� ��� �� ������� ������ ������������\n\n{ffcc00}� .ini (moonloader\\config\\pisser.ini), ������ ������ ��������, ����� �������� ������ � ������ ���������. \n�������� ������ ������. ��� ����.\n{00ccff}    ������: {ffffff} "..data.options.content1..'\n{00ccff}    ������: {ffffff} '..data.options.content3.."", "����")
end
