
Route a call to the SIP line configured above:
regexroute.conf
^100$=line/100;line=test_sip
this rule will match the number called: 100 and will route the call through the gateway
the line parameter is fixed.
line=test_sip will tell Yate on which gateway/account to route the call.

--------

https://docs.yate.ro/wiki/How_to_do_routing_using_javascript
https://docs.yate.ro/wiki/Regular_expressions
https://docs.yate.ro/wiki/Accfile

------------

This is the regexroute.conf file:
; Minimalistic basic regular expressions information
;  ^ matches start of string
;  $ matches end of string
;  . matches any character
;  [list] matches one character in the list
;  [^list] matches one character not in list
;    Lists can be individual characters or ranges char-char. You can insert ]
;    by making it the first character in list and ^ by making it not the first
;    character
;  * matches preceeding expression any number of times (including zero)
;  \+ matches preceeding expression at least one time
;  \? matches preceeding expression zero or one time
;  \{N\} matches preceeding expression exactly N times
;  \{N,\} matches preceeding expression N or more times
;  \{N,M\} matches preceeding expression between N and M times
;  \( \) captures the contained subexpression
; Remember matches are greedy, they will match as much as possible
; You must escape ^ $ . * [ and \ with \ whenever you want them to be normal
;  characters except in lists
; Please see the manual pages for grep and sed for more information

; Functions callable in the right-hand side:
;  $() = a ; character
;  $($) = a $ character
;  $(++N) = N+1
;  $(--N) = N-1
;  $(length,STRING) = length of STRING
;  $(upper,STRING) = STRING converted to upper case
;  $(lower,STRING) = STRING converted to lower case
;  $(chr,N) = character with numeric code N
;  $(hex,N[,LEN]) = little endian hexadecimal value of N with space between octets
;  $(add,VAL1,VAL2[,LEN]) = VAL1+VAL2 left filled to LEN or length of VAL1
;  $(sub,VAL1,VAL2[,LEN]) = VAL1-VAL2 left filled to LEN or length of VAL1
;  $(mul,VAL1,VAL2[,LEN]) = VAL1*VAL2 left filled to LEN or length of VAL1
;  $(div,VAL1,VAL2[,LEN]) = VAL1/VAL2 left filled to LEN or length of VAL1
;  $(mod,VAL1,VAL2[,LEN]) = VAL1%VAL2 left filled to LEN or length of VAL1
;  $(eq,VAL1,VAL2) = "true" if VAL1 = VAL2 (numerically), "false" otherwise
;  $(ne,VAL1,VAL2) = "true" if VAL1 != VAL2 (numerically), "false" otherwise
;  $(lt,VAL1,VAL2) = "true" if VAL1 < VAL2, "false" otherwise
;  $(gt,VAL1,VAL2) = "true" if VAL1 > VAL2, "false" otherwise
;  $(le,VAL1,VAL2) = "true" if VAL1 <= VAL2, "false" otherwise
;  $(ge,VAL1,VAL2) = "true" if VAL1 >= VAL2, "false" otherwise
;  $(streq,VAL1,VAL2) = "true" if VAL1 = VAL2 (string), "false" otherwise
;  $(strne,VAL1,VAL2) = "true" if VAL1 != VAL2 (string), "false" otherwise
;  $(random,STRING) = STRING with each ? character replaced with a random digit
;  $(index,N,ITEM1,ITEM2,...) = N-th (modulo length of list) item in list
;  $(rotate,N,ITEM1,ITEM2,...) = list rotated N (modulo length of list) times
;  $(runid) = the current Engine run identifier
;  $(nodename) = the node name the Engine runs as, may be empty
;  $(threadname) = name of the thread that dispatched the message, may be empty
;  $(dispatching) = the reentry depth, 0 if the message is not generated locally
;  $(transcode,FLAGS,FORMAT1,FORMAT2,...) = list of formats the input can be transcoded into
;       e - exclude initial formats form generated list
;       r - allow rate conversion (for use with wideband)
;       c - allow changing channels number
; Note that functions ++, --, index and rotate will automatically update N
;  if it is a variable in the $varname format.


[priorities]
; Set the priorities for the insertion of the regular expression module in the
;  handler chain; a priority of 0 disables the handler entirely

; preroute: int: Priority of the prerouting message handler
;preroute=100

; route: int: Priority of the routing message handler
;route=100

; extended: bool: Use extended regular expressions
;extended=no

; insensitive: bool: Make the regular expressions case insensitive
;insensitive=no

; prerouteall: bool: Preroute even calls having a context or with empty caller
;prerouteall=no


[$once]
; First-time only global variables initialization.
; It is executed during first initialization before the [$init] section
; Each line must be of the form:
;  varname=value


[$init]
; Reload time global variables initialization
; Each line must be of the form:
;  varname=value


[extra]
; This section allows installing handlers for any message name.
; Each line must be of the form:
;  message.name=priority
; You can only install one handler for any given message name.
; For each handler create a corresponding [message.name] section in which
;  implement handling for that specific message. You will need to match
;  parameters explicitly or set a new match string.


[contexts]
; This section is used by the prerouting handler to classify calls by the
;  caller name; each call is assigned an input context (only if none exists
;  already) that is used later in the routing stage
; Expressions are scanned from top to bottom; the first match returns the value
; Each line must be of the form:
;   regexp=context_name
; To match a message parameter you can use the format:
;   ${paramname}regexp=context_name
; Strings captured with the regular expression construct \(...\) can be
;  inserted in the context name using \1, \2, \3, ... while \0 holds the entire
;  matched regexp even if no capture was used
; Message parameters can be inserted in the context name using ${paramname}
;
; Example:
;^$=empty
;^00=international
;^0=longdistance
;.*=default


[default]
; Sections like this one are used by the routing handler to find the target
;  of calls by the called name
; The [default] context is special, it is used when no context has been set
;  otherwise you have to place the entries in a section with the same name
;  as the context
; Expressions are scanned from top to bottom; the first match returns the value
; Each line must be of the form:
;   regexp=target
; To match a message parameter you can use the format:
;   ${paramname}regexp=target
; To match a function possibly containing parameters you can use the format:
;   $(function,param...)regexp=target
; To act on non-matching expressions add a ^ at end of the regexp. In this
;  case the \0 ... \9 replacements will always be empty
;   regexp^=target
; Strings captured with the regular expression construct \(...\) can be
;  inserted in the target using \1, \2, \3, ...
; Message parameters can be inserted in the target using ${paramname}
; Functions can be inserted using $(function,param,param)
;
; First word of a matched target has a special meaning:
; if - make a new match using the rest of the line up to the = character
; return - returns immediately from the context without routing
; include - calls another context, returns at the next entry if the other
;   context did not return successfully
; jump - jumps another context, does not return to this context
; match - modify the matched string instead of specifying a target
; rename - changes the name of the message
; enqueue - puts a new message in the engine, parameters are taken from the
;   old message but placed in the new one
; dispatch - dispatches a new message in the engine waiting for it to return,
;   parameters are taken from the old message but placed in the new one
; echo - displays that line after making substitutions
;
; It is possible to set message parameters by appending them as name=value
;  while separating them with semicolons (;)
; Placing just the parameter name without the =  sign will clear the parameter
; Using $name=value will instead change the global variable with that name.
; Similarily specifying just $name will clear the global variable
;
; Please note that the match string is not changed together with the message
;  parameter from which it was copied; for example in routing stage using
;  "match 123" and ";called=123" have different effects
;
; Example:
;   route the emergency 112 and 911 numbers to POTS, any channel on an E1,
;   force specific data format too
;^112$=zap/1-31; format=alaw
;^911$=zap/1-31; format=mulaw
;   route international calls over SIP, replace caller name
;^00\(.*\)$=sip/sip:\1@international.gateway ; callername = International call
;   route value added services over IAX, trailing part is sent as IAX extension
;^09\(.*\)$=iax/vap@gateway.for.vap/\1
;   route green calls over IAX with 2 digits used to form an user name,
;   remaining digits are sent as extension
;^08\(..\)\(.*\)$=iax/green-\1@gateway.for.green/\2
;   everything else starting with 0 is routed over H.323
;^0\(.*\)$=h323/\1@long.distance.gateway
;   route short 3digit numbers to SIP using a DNS scheme 123 -> 3.2.1.domain
;^\(.\)\(.\)\(.\)$=sip/sip:\0@\3.\2.\1.domain
;   route only calls from SIP starting with 123 to a H.323 gateway
;${id}^sip/=if ^123.*$=h323/\0@provider.gw
;   is there anything else left? they go on E1 but only 15 channels can be used
;   we also make sure the number is at least 4 characters long
;   and we set a national caller dialplan
;.....*=zap/1-15 ; callerplan = national
;   leftovers... should not happen but let's handle them. we may not route the
;   call at all and let the caller receive a "no route" error
;.*=wave/play/sounds/invalid_number.gsm
;
; The following are for testing purposes
^99991001$=tone/dial
^99991002$=tone/busy
^99991003$=tone/ring
^99991004$=tone/specdial
^99991005$=tone/congestion
^99991006$=tone/outoforder
^99991007$=tone/milliwatt
^99991008$=tone/info

; Example of handling call authorization by caller authentication or ip address
; If the user is not authenticated call the subsection check_addr_auth
;${username}^$=call check_addr_auth
; Optionally, force caller id to authenticated username (if any)
;${username}.=;caller=${username}
;
;[check_addr_auth]
; Here we check for trusted gateways or networks by the "address" parameter
;  that for VoIP protocols is in the format: ip.ad.dr.ess:port
;
; allow trusted gateway 10.0.1.2
;${address}^10\.0\.1\.2:=return
; also trust callers from network 192.168.0.*
;${address}^192\.168\.0\.=return
; all others should be challenged (SIP,IAX) or rejected (other protocols)
;.*=-;error=noauth
Parameters

This is a list of usual parameters found in the call.route message. Arbitrary parameters can be added by any module.
${address} - "address" (e.g. analog/pstn/1 or IP address) from which current incoming call was received.
${callsource} - e.g. fxs/fxo for analog lines
${formats} - list of codecs that the incoming call will accept
${id} - channel ID (e.g. 'sip/1')
${peerid} - peer's channel ID, usually empty during initial routing
${ip_host} - ip address of the transport connection or message
${ip_port} - port of the transport connection or message
${overlapped} - set by overlapped.php to indicated overlapped dialling is happening.
${rtp_forward} - do rtp forwarding, can be no, possible, or yes
${type} - call type (e.g. record)
${username} - username for incoming call, only if authenticated
${caller} - caller ID (e.g. 'user' for a call from 'sip:user@example.com')
${callername} - caller ID name field
${called} - called party


