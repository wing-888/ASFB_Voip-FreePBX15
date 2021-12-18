GRAPHQL
note:D
# add extension 
mutation {
    addExtension(
        input: {
            extensionId: 1003
            name: "1003"
            tech: "sip"
            channelName: "1003"
            outboundCid: "1003"
            email: "vudat412@gmailcom"
            umGroups: "1"
            umEnable: true
            umPassword: "vudat412"
            vmPassword: "vudat412"
            vmEnable: false
            callerID: "Tong dai"
            emergencyCid: "1003"
            clientMutationId: "1003"
            maxContacts: "3"
        }
    ) {
        status
        message
    }
}
# delete extension
mutation {
    deleteExtension(
        input: { extensionId: 9090090115 }
    ) {
        status
        message
    }
}

# ######################################## #
/etc/asterisk/sip.conf
[general]
context=internal
allowguest=no
allowoverlap=no
bindport=5060
bindaddr=0.0.0.0
srvlookup=no
disallow=all
allow=ulaw
alwaysauthreject=yes
canreinvite=no
nat=yes
session-timers=refuse
localnet=192.168.1.0/255.255.255.0

[100]
type=friend
host=dynamic
secret=vudat412
context=internal

[101]
type=friend
host=dynamic
secret=vudat412
context=internal
/etc/asterisk/extensions.conf
[internal]
exten => 100,1,Answer()
exten => 100,2,Dial(SIP/100,60)
exten => 100,3,Playback(vm-nobodyavail)
exten => 100,4,VoiceMail(100@main)
exten => 100,5,Hangup()

exten => 101,1,Answer()
exten => 101,2,Dial(SIP/101,60)
exten => 101,3,Playback(vm-nobodyavail)
exten => 101,4,VoiceMail(100@main)
exten => 101,5,Hangup()

exten => 8001,1,VoicemailMain(100@main)
exten => 8001,2,Hangup()

exten => 8002,1,VoicemailMain(101@main)
exten => 8002,2,Hangup()
/etc/asterisk/voicemail.conf
[main]
100 => 100
101 => 101
