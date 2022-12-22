import BadBot

transaction() {
    prepare(signer: AuthAccount) {}

    execute {
        BadBot.addChallenge(content: "123123", solution: "304ffca0c69fd44494ce7678c44fbfc85bee5045883d02e6d024a490c605b882")
    }
}