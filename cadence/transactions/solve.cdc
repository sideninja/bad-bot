import BadBot

transaction(solution: String, ID: Int) {
    prepare(signer: AuthAccount) {
        BadBot.solve(solver: signer, ID: ID, solution: solution)
    }
    execute {}
}