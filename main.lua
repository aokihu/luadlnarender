-- Lua DLNA Render

local Socket = require('socket')


-- 1. Device Register
local DNLA_MUTLICAST_ADDRESS = "239.255.255.250"
local DNLA_MUTLICAST_PORT = 1900

udp = assert(Socket.udp())
-- udp:setsockname(DNLA_MUTLICAST_ADDRESS, DNLA_MUTLICAST_PORT)
-- assert(udp:setoption("ip-add-membership", {multiaddr=DNLA_MUTLICAST_ADDRESS,interface="*"}))


function sendRegisterMessage()
	local msg = {}
	msg[0] = "NOTIFY * HTTP/1.1\r\n"
	msg[1] = "Host:239.255.255.250:1900\r\n"
	msg[2] = "Nt:upnp:rootdevice\r\n"
	msg[3] = "Nts:ssdp:alive\r\n"
	msg[4] = "Usn:uuid:de5d6118-bfcb-918e-0000-00001eccef34::upnp:rootdevice\r\n"

	local result = table.concat( msg )
	print(result)
	udp:sendto(result, DNLA_MUTLICAST_ADDRESS, DNLA_MUTLICAST_PORT)
end

while true do 
	sendRegisterMessage()
	Socket.sleep(1)
end
