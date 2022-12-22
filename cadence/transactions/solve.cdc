import BadBot

transaction() {
    prepare(signer: AuthAccount) {
        BadBot.solve(solver: signer, ID: "1", solution: "74657374")
    }
    execute {}
}