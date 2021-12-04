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
