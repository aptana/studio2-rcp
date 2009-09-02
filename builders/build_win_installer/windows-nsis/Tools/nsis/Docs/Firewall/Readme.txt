NSIS Simple Firewall Plugin

This plugin can be used to configurate the windows firewall. 
This plugin contains functions to enable, check, add or remove 
programs or ports to the firewall exception list. It also contains 
functions for checking the firewall status, enable or disable 
the firewall and so on.




== Short Reference ==


SimpleFC::EnableDisableFirewall [status]
SimpleFC::IsFirewallEnabled  
 
SimpleFC::AllowDisallowExceptionsNotAllowed [status]
SimpleFC::AreExceptionsNotAllowed  
 
SimpleFC::EnableDisableNotifications [status]
SimpleFC::AreNotificationsEnabled  
 
SimpleFC::StartStopFirewallService [status]
SimpleFC::IsFirewallServiceRunning  
 
SimpleFC::AddPort [port] [name] [protocol] [scope] [ip_version] [remote_addresses] [status]
SimpleFC::IsPortAdded [port] [protocol]
SimpleFC::RemovePort [port] [protocol]
 
SimpleFC::IsPortEnabled [port] [protocol]
SimpleFC::EnableDisablePort [port] [protocol]
 
SimpleFC::AddApplication [name] [path] [scope] [ip_version] [remote_addresses] [status]
SimpleFC::IsApplicationAdded [path]
SimpleFC::RemoveApplication [path]
 
SimpleFC::IsApplicationEnabled [path]
SimpleFC::EnableDisableApplication [path]

SimpleFC::RestoreDefaults

SimpleFC::AllowDisallowIcmpOutboundDestinationUnreachable [status]
SimpleFC::AllowDisallowIcmpRedirect [status]
SimpleFC::AllowDisallowIcmpInboundEchoRequest [status]
SimpleFC::AllowDisallowIcmpOutboundTimeExceeded [status]
SimpleFC::AllowDisallowIcmpOutboundParameterProblem [status]
SimpleFC::AllowDisallowIcmpOutboundSourceQuench [status]
SimpleFC::AllowDisallowIcmpInboundRouterRequest [status]
SimpleFC::AllowDisallowIcmpInboundTimestampRequest [status]
SimpleFC::AllowDisallowIcmpInboundMaskRequest [status]
SimpleFC::AllowDisallowIcmpOutboundPacketTooBig [status]
SimpleFC::IsIcmpTypeAllowed [ip_version] [local_address] [icmp_type]

SimpleFC::AdvAddRule [name] [description] [protocol] [direction] 
  [status] [profile] [action] [application] [icmp_types_and_codes] 
  [group] [local_ports] [remote_ports] [local_address] [remote_address]
SimpleFC::AdvRemoveRule [name]
SimpleFC::AdvExistsRule [name]


Parameters:

port - tcp/udp port which should be opened/closed
name - the name of the application/port/rule
description - description of the rule
protocol - one of the following protocol
  - 1 - ICMPv4
  - 6 - TCP
  - 17 - UDP
  - 58 - ICMPv6
scope - one of the following scope
  - 0 - All networks
  - 1 - Only local subnets
  - 2 - Custom scope
  - 3 - Max
  NOTE: if you use custom you must define remote_addresses
ip_version
  - 0 - IPv4
  - 1 - IPv6
  - 2 - Any protocol
icmp_type
  - 3 - Outbound Destination Unreachable (ICMPv4)
  - 4 - Outbound Source Quench (ICMPv4)
  - 5 - Redirect (ICMPv4)
  - 8 - Inbound Echo Request (ICMPv4)
  - 9 - Inbound Router Request (ICMPv4)
  - 11 - Outbound Time Exceeded (ICMPv4)
  - 12 - Outbound Parameter Problem (ICMPv4)
  - 13 - Inbound Timespamp Request (ICMPv4)
  - 17 - Inbound Mask Request (ICMPv4)
  - 1 - Outbound Destination Unreachable (ICMPv6)
  - 2 - Outbound Packet Too Big (ICMPv6)
  - 3 - Outbound Time Exceeded (ICMPv6)
  - 4 - Outbound Parameter Problem (ICMPv6)
  - 128 - Inbound Echo Request (ICMPv6)
  - 137 - Redirect (ICMPv6)
direction
  - 1 - In
  - 2 - Out
profile
  - 1 - domain 
  - 2 - private
  - 4 - public
  - 2147483647 - all profiles
action
  - 0 - block
  - 1 - allow
application - name of the application (can be empty)
icmp_types_and_codes - specified icmp types and codes
group - put the rule in this specified group. The Groupname must the a resource string in a exe/dll e.g. "@C:\Program Files\My Application\myapp.exe,-10000" (can be empty)
local_ports - local ports (can be empty)
remote_ports - remote ports (can be empty)
local_address - local ip address (can be empty)
remote_addresses - remote addresses from which the port can listen for traffic
status - status of the port, application, rule, firewall or service for example enabled/disabled, start/stop or allow/disallow
  - 0 - disabled, stop or disallow
  - 1 - enabled, start, or allow




== The Sample Script ==


; Add the port 37/TCP to the firewall exception list - All Networks - All IP Version - Enabled
  SimpleFC::AddPort 37 "My Application" 6 0 2 "" 1
  Pop $0 ; return error(1)/success(0)

; Check if the port 37/TCP is added to the firewall exception list
  SimpleFC::IsPortAdded 37 6
  Pop $0 ; return error(1)/success(0)
  Pop $1 ; return 1=Added/0=Not added

; Remove the port 37/TCP from the firewall exception list
  SimpleFC::RemovePort 37 6
  Pop $0 ; return error(1)/success(0)

; Check if the port 37/TCP is enabled/disabled
  SimpleFC::IsPortEnabled 37 6
  Pop $0 ; return error(1)/success(0)
  Pop $1 ; return 1=Enabled/0=Not enabled

; Disable the port 37/TCP
  SimpleFC::EnableDisablePort 37 6 0
  Pop $0 ; return error(1)/success(0)

; Enable the port 37/TCP
  SimpleFC::EnableDisablePort 37 6 1
  Pop $0 ; return error(1)/success(0)

; Check if an application is enabled/disabled
  SimpleFC::IsApplicationEnabled "PathToApplication" 
  Pop $0 ; return error(1)/success(0)
  Pop $1 ; return 1=Enabled/0=Not enabled

; Disable the application
  SimpleFC::EnableDisableApplication "PathToApplication" 0
  Pop $0 ; return error(1)/success(0)

; Enable the application
  SimpleFC::EnableDisableApplication "PathToApplication" 1
  Pop $0 ; return error(1)/success(0)

; Add an application to the firewall exception list - All Networks - All IP Version - Enabled
  SimpleFC::AddApplication "My Application" "PathToApplication" 0 2 "" 1
  Pop $0 ; return error(1)/success(0)

; Check if the application is added to the firewall exception list
  SimpleFC::IsApplicationAdded "PathToApplication"
  Pop $0 ; return error(1)/success(0)
  Pop $1 ; return 1=Added/0=Not added

; Remove an application from the firewall exception list
  SimpleFC::RemoveApplication "PathToApplication"
  Pop $0 ; return error(1)/success(0)

; Disable the windows firewall
  SimpleFC::EnableDisableFirewall 0
  Pop $0 ; return error(1)/success(0)

; Enable the windows firewall
  SimpleFC::EnableDisableFirewall 1
  Pop $0 ; return error(1)/success(0)

; Check if the firewall is enabled
  SimpleFC::IsFirewallEnabled 
  Pop $0 ; return error(1)/success(0)
  Pop $1 ; return 1=Enabled/0=Disabled

; Enable exceptions are not allowed on the windows firewall
  SimpleFC::AllowDisallowExceptionsNotAllowed 1
  Pop $0 ; return error(1)/success(0)

; Disable exceptions are not allowed on the windows firewall
  SimpleFC::AllowDisallowExceptionsNotAllowed 0
  Pop $0 ; return error(1)/success(0)

; Check if exceptions are not allowed
  SimpleFC::AreExceptionsNotAllowed
  Pop $0 ; return error(1)/success(0)
  Pop $1 ; return 1=Exceptions are not allowed is activated/0=Exception are not allowed is deactivated

; Enable notifications on the windows firewall
  SimpleFC::EnableDisableNotifications 1

; Disable notifications on the windows firewall
  SimpleFC::EnableDisableNotifications 0
  Pop $0 ; return error(1)/success(0)

; Check if notifications are enabled/disabled
  SimpleFC::AreNotificationsEnabled 
  Pop $0 ; return error(1)/success(0)
  Pop $1 ; return 1=Enabled/0=Disabled

; Starts the windows firewall service
  SimpleFC::StartStopFirewallService 1
  Pop $0 ; return error(1)/success(0)

; Stops the windows firewall service
  SimpleFC::StartStopFirewallService 0
  Pop $0 ; return error(1)/success(0)

; Check if windows firewall service is running
  SimpleFC::IsFirewallServiceRunning
  Pop $0 ; return error(1)/success(0)
  Pop $1 ; return 1=IsRunning/0=Not Running

; Sets the windows firewall to default settings
  SimpleFC::RestoreDefaults
  Pop $0 ; return error(1)/success(0)

; Enable ICMP outbound destination unreachable state
  SimpleFC::AllowDisallowIcmpOutboundDestinationUnreachable 1
  Pop $0 ; return error(1)/success(0)

; Enable ICMP redirect state
  SimpleFC::AllowDisallowIcmpRedirect 1
  Pop $0 ; return error(1)/success(0)

; Enable ICMP inbound echo request 
  SimpleFC::AllowDisallowIcmpInboundEchoRequest 1
  Pop $0 ; return error(1)/success(0)

; Enable ICMP outbound time exceeded
  SimpleFC::AllowDisallowIcmpOutboundTimeExceeded 1
  Pop $0 ; return error(1)/success(0)

; Enable ICMP outbound parameter problem
  SimpleFC::AllowDisallowIcmpOutboundParameterProblem 1
  Pop $0 ; return error(1)/success(0)

; Enable ICMP outbound source quench
  SimpleFC::AllowDisallowIcmpOutboundSourceQuench 1
  Pop $0 ; return error(1)/success(0)

; Enable ICMP inbound router request
  SimpleFC::AllowDisallowIcmpInboundRouterRequest 1
  Pop $0 ; return error(1)/success(0)

; Enable ICMP inbound timestamp request
  SimpleFC::AllowDisallowIcmpInboundTimestampRequest 1
  Pop $0 ; return error(1)/success(0)

; Enable ICMP inbound mask request
  SimpleFC::AllowDisallowIcmpInboundMaskRequest 1
  Pop $0 ; return error(1)/success(0)

; Enable ICMP outbound packet too big
  SimpleFC::AllowDisallowIcmpOutboundPacketTooBig 1
  Pop $0 ; return error(1)/success(0)

; Check if ICMPv4 echo request is allowed
  SimpleFC::IsIcmpTypeAllowed "0" "" "8"
  Pop $0 ; return error(1)/success(0)
  Pop $1 ; return 1=Restricted/0=Not restricted
  Pop $2 ; return 1=Allowed/0=Not allowed 


; Some example rules for the windows firewall with advanced security.
; Please note this functions are very powerful, so for a detailed 
; description please read the windows firewall with advanced 
; security api reference:
; http://msdn2.microsoft.com/en-us/library/aa365309.aspx

; Adds an ICMPv4 rule to allow incoming echo reply messages (IcmpCodeAndType = 0:0)
  SimpleFC::AdvAddRule "Echo-Reply (ICMPv4 incoming)" "Allows incoming Echo Replies messages." "1" "1" "1" "7" "1" "" "0:0" "@PathToApplication,-10000" "" "" "" ""
  Pop $0 ; return error(1)/success(0)

; Adds an ICMPv4 rule to allow incoming echo request messages (IcmpCodeAndType = 8:0)
  SimpleFC::AdvAddRule "Echo-Request (ICMPv4 incoming)" "Allows incoming ICMP Echo messages." "1" "1" "1" "7" "1" "" "8:0" "@PathToApplication,-10000" "" "" "" ""
  Pop $0 ; return error(1)/success(0)

; Add an application rule to allow incoming TCP access on this application
  SimpleFC::AdvAddRule "Incoming requests (TCP incoming)" "Allows incoming requests." "6" "1" "1" "7" "1" "PathToApplication" "" "@$INSTDIR\PathToApplication,-10000" "" "" "" ""
  Pop $0 ; return error(1)/success(0)

; Add an application rule to allow incoming UDP access on this application
  SimpleFC::AdvAddRule "Incoming requests (UDP incoming)" "Allows incoming requests." "17" "1" "1" "7" "1" "PathToApplication" "" "@$INSTDIR\PathToApplication,-10000" "" "" "" ""
  Pop $0 ; return error(1)/success(0)

; Removes a firewall rule
  SimpleFC::AdvRemoveRule "Incoming requests (UDP incoming)"
  Pop $0 ; return error(1)/success(0)

; Check if the firewall exists
  SimpleFC::AdvExistsRule "Incoming requests (UDP incoming)"
  Pop $0 ; return error(1)/success(0)
  Pop $1 ; return 1=Exists/0=Doesn�t exists




== Important Note ==

- This plugin is running with Windows XP SP2, Windows 2003 and Windows Vista. 
- It is recommend to check for windows firewall service is running (SimpleFC::IsFirewallServiceRunning).
- All functions with the prefix "Adv" are only for Windows Firewall with Advanced Security (Windows Vista).