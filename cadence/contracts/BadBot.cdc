pub contract BadBot {
    pub var allowanceCount: Int
    pub var challenges: {String: Challenge}

    pub let AllowanceStoragePath: StoragePath
    pub let AllowancePublicPath: PublicPath

    pub init() {
        self.allowanceCount = 2
        self.challenges = {}

        self.AllowanceStoragePath = /storage/allowance
        self.AllowancePublicPath = /public/allowance
    }

    pub struct Challenge {
        pub var content: String
        pub var solution: String

        pub init(content: String, solution: String) {
            self.content = content
            self.solution = solution
        }

        pub fun validate(solution: String): Bool {
            let encoded = solution.decodeHex()
            log("ENCODED")
            log(encoded)
            log("ENCODED")
            let hashed = HashAlgorithm.SHA3_256.hash(encoded)
            log("HASHED")
            log(hashed)
            log("SOLUTION SAVED")
            log(self.solution)
            log("SOLUTION PROVIDED")
            log(String.encodeHex(hashed))
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

    pub fun solve(solver: AuthAccount, ID: String, solution: String) {
        let solved = self.challenges[ID]?.validate(solution: solution)
        if solved == nil || !solved! {
            log("SOLVED")
            log(solved)
            return
        }

        destroy solver.load<@BadBot.Allowance?>(from: BadBot.AllowanceStoragePath)

        let allowance <-create Allowance(count: self.allowanceCount)
        solver.save(<-allowance, to: BadBot.AllowanceStoragePath)
        solver.link<&BadBot.Allowance>(BadBot.AllowancePublicPath, target: BadBot.AllowanceStoragePath)
    }

    pub fun addChallenge(content: String, solution: String) {
        self.challenges["1"] = Challenge(content: content, solution: solution)
    }

}
