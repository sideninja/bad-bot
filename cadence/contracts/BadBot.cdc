pub contract BadBot {
    pub var allowanceCount: Int
    pub var challenges: [Challenge]

    pub let AllowanceStoragePath: StoragePath
    pub let AllowancePublicPath: PublicPath

    pub init() {
        self.allowanceCount = 3
        self.challenges = []

        self.AllowanceStoragePath = /storage/allowance
        self.AllowancePublicPath = /public/allowance
    }

    pub struct Challenge {
        pub var ID: Int
        pub var content: String
        pub(set) var solution: String

        pub init(ID: Int, content: String, solution: String) {
            self.ID = ID
            self.content = content
            self.solution = solution
        }

        pub fun validate(solution: String): Bool {
            let encoded = solution.decodeHex()
            let hashed = HashAlgorithm.SHA3_256.hash(encoded)
            return String.encodeHex(hashed) == self.solution
        }
    }

    pub resource Allowance {
        pub var count: Int

        pub fun valid(): Bool {
            self.count = self.count-1
            return self.count > 0
        }

        init(count: Int) {
            self.count = count
        }
    }    

    pub fun solve(solver: AuthAccount, ID: Int, solution: String) {
        let solved = self.challenges[ID].validate(solution: solution)
        if solved == nil || !solved! {
            return
        }

        destroy solver.load<@Allowance>(from: self.AllowanceStoragePath) 
        
        solver.save(<-create Allowance(count: self.allowanceCount), to: self.AllowanceStoragePath)
        solver.link<&Allowance>(self.AllowancePublicPath, target: self.AllowanceStoragePath)
    }

    pub fun addChallenge(content: String, solution: String) {
        self.challenges.append(Challenge(ID: self.challenges.length, content: content, solution: solution))
    }

    pub fun getChallenge(): Challenge {
        let challenge = self.challenges[self.challenges.length-1]!
        challenge.solution = ""
        return challenge
    }

}
